
#' Get imagery data
#'
#' Read imagery data for any region on Earth.
#'
#' Note that data is streamed into memory, so don't make the dimensions of the 'x' target raster too big.
#'
#' By default we're expecting 3 bands of bytes, but if only one is available that is used instead.
#'
#' To use these data, please attribute the image provider, or otherwise use your own sources.
#'
#' `imagery()` defaults to Virtual Earth, `streetmap()` to OSM, and `satbox()` to Mapbox Satellite. 
#' 
#' To use `satbox()` you must set an environment variable such as 'MAPBOX_API_KEY' to your Mabox token. 
#' 
#' @param extent a numeric vector of xmin,xmax,ymin,ymax or a terra or raster rast object
#' @param ... arguments passed to 'vapour::vapour_warp_raster'
#' @param source a GDAL raster source, to override the inbuilt source/s
#' @param dimension optional output size in ncol,nrow (x,y)
#' @param projection optional coordinate reference system to use (map projection), longlat is assumed
#' @param resample resampling algorithm for the GDAL warper, "near" by default
#'
#' @return a matrix, or depending on format of 'extent' a terra rast or raster object with elevation data
#' @export
#' @aliases streetmap satbox
#' @examples
#'
#' plt <- function(x) {
#' nr <- nrow(x)
#' nc <- ncol(x)
#' plot(NA, xlim = c(0, nc), ylim = c(0, nr), asp = 1);
#'  rasterImage(x, 0, 0, nc, nr)
#'  }
#'
#' plt(imagery())
#' plt(imagery(c(100, 150, -60, -20), projection = "OGC:CRS84"))
#' ## can't do yet
#' #plt(imagery(terra::rast())
#' #imagery(raster::raster())
#'
imagery <- function(extent = c(-180, 180, -90, 90), ..., dimension = NULL, projection = "OGC:CRS84", resample = "near", source = NULL) {

  xraster <- extent ## in the case of terra or raster
  x <- format_out(list(extent = extent, dimension = dimension, projection = projection))

  if (is.null(source)) {
    rso <- .imagery_sources["wms_virtualearth"]
  } else {
    rso <- source
  }

  if (is.na(x$projection)) {
    message("no projection specified, calling warper without a target projection: results not guaranteed")
    x$projection <- ""
  }
  ## check bands
  info <- vapour::vapour_raster_info(rso[1])
  if (info$bands < 3) {
  vals <- vapour::vapour_warp_raster_hex(rso, extent = x$extent, dimension = x$dimension, projection = x$projection, resample = resample, ..., bands = 1)
  } else {


  vals <- vapour::vapour_warp_raster_hex(rso, extent = x$extent, dimension = x$dimension, projection = x$projection, resample = resample, ..., bands = 1:3)
}
  switch (x$type,
          terra =   terra::setValues(xraster, vals),
          raster =  raster::setValues(xraster, vals),
          matrix = matrix(vals, x$dimension[2L], byrow = TRUE))#[,x$dimension[2L]:1])

}


#' @export
#' @name imagery
streetmap <- function(extent = c(-180, 180, -90, 90), ..., dimension = NULL, projection = "OGC:CRS84", resample = "cubic", source = NULL) {

  xraster <- extent ## in the case of terra or raster
  x <- format_out(list(extent = extent, dimension = dimension, projection = projection))

  if (is.null(source)) {
    rso <- .streetmap_sources["wms_openstreetmap_tms"]
  } else {
    rso <- source
  }

  if (is.na(x$projection)) {
    message("no projection specified, calling warper without a target projection: results not guaranteed")
    x$projection <- ""
  }
  vals <- vapour::vapour_warp_raster_hex(rso, extent = x$extent, dimension = x$dimension, projection = x$projection, resample = resample, ..., bands = 1:3)

  switch (x$type,
          terra =   terra::setValues(xraster, vals),
          raster =  raster::setValues(xraster, vals),
          matrix = matrix(vals, x$dimension[2L], byrow = TRUE))#[,x$dimension[2L]:1])

}
