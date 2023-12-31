# init ---------------------------------------------------------------------------------

library(sf)
library(CDSE)


# Getting collection doesn't require authentication ------------------------------------

collections <- GetCollections()
collections


# Authenticate -------------------------------------------------------------------------

id <- Sys.getenv("CDSE_ID")
secret <- Sys.getenv("CDSE_SECRET")
OAuthClient <- GetOAuthClient(id = id, secret = secret)


# Search catalog -----------------------------------------------------------------------

# search for available Sentinel 2 L2A imagery of New York Central Park in July 2023
# get the New York City Central Park shape as area of interest
dsn <- system.file("extdata", "centralpark.geojson", package = "CDSE")
aoi <- sf::read_sf(dsn, as_tibble = FALSE)
# search by area of interest
images <- SearchCatalog(aoi = aoi, from = "2023-07-01", to = "2023-07-31", collection = "sentinel-2-l2a",
                        with_geometry = TRUE, client = OAuthClient)
images


# search for available Sentinel 1 GRD imagery of Luxembourg in January 2019
# get the Luxembourg country shape as area of interest
dsn <- system.file("extdata", "luxembourg.geojson", package = "CDSE")
aoi <- sf::read_sf(dsn, as_tibble = FALSE)
# search by bounding box
bbox <- as.numeric(sf::st_bbox(aoi))
images <- SearchCatalog(bbox = bbox, from = "2019-01-01", to = "2019-01-30", collection = "sentinel-1-grd",
                        with_geometry = TRUE, client = OAuthClient)
images
