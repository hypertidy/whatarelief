# roads <- function(extent, ...,  projection = NULL, value = c("motorway"), qonly = FALSE) {
#  
#   .ll <- "+proj=longlat"
#   do_reproj <- TRUE
#    if (missing(extent)) {
#     extent <- c(146, 148, -43, -41)
#     projection <- .ll
#     do_reproj <- FALSE
#   }
#   if (!is.null(projection)) {
#     extent <- reproj::reproj_extent(extent, .ll, source = projection)
#   }
#   
#   d <- osmdata::opq (extent[c(1, 3, 2, 4)], ...) |> 
#     osmdata::add_osm_feature (key = "highway", value = value)
#   if (qonly) return(d)
#   d <-  osmdata::osmdata_sf(d)$osm_lines
#   # d$meta <- d$meta[1, ]
#   # d$meta$ctime <- Sys.time()
#   # d$meta$proj <- .ll
#   if (do_reproj && !is.null(projection) && !is.null(d)) d <- sf::st_transform(d, projection)
#   d
# }
