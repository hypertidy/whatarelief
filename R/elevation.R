## from https://gist.github.com/mdsumner/b6d210a2974726151c5d206ebef1a7f2
terra_out <-
  function(x) {
    ## stopifnot(requireNamespace("terra"))
    if (isS4(x) && inherits(x, "SpatRaster")) {
      x <- try(list(extent = c(terra::xmin(x), terra::xmax(x), terra::ymin(x), terra::ymax(x)),
                    dimension = dim(x)[2:1],
                    projection = terra::crs(x),
                    lonlat = terra::is.lonlat(x), terra = TRUE), silent = TRUE)
      if (inherits(x, "try-error")) stop("cannot use terra grid")
    }
    x
  }

raster_out <- function(x) {
  if (isS4(x) && inherits(x, "BasicRaster")) {
       ## stopifnot(requireNamespace("raster"))
    ## we have a {raster}
    x <- list(extent = c(x@extent@xmin, x@extent@xmax, x@extent@ymin, x@extent@ymax),
              dimension = c(x@ncols, x@nrows),
              projection = x@crs@projargs,
              lonlat = raster::couldBeLonLat(x))

  }
  x
}


format_out <- function(x) {
  dimension <- x$dimension
  projection <- x$projection
  x <- x$extent
  if (inherits(x, "SpatRaster")) {
    if (! requireNamespace("terra")) stop("terra package required but not available, please install it")
    x <- terra_out(x)
    if (is.na(x$projection) && x$lonlat) x$projection <- "OGC:CRS84"
    x$type <- "terra"
  }
  if (inherits(x, "BasicRaster")) {
    if (!requireNamespace("raster")) stop("raster package required but not available, please install it")
    x <- raster_out(x)
    if (is.na(x$projection) && x$lonlat) x$projection <- "OGC:CRS84"
    x$type <- "raster"
  }
  if (inherits(x, "numeric")) {

    if (is.null(projection)) projection <- "OGC:CRS84"
    if (is.null(dimension)) dimension <- as.integer(256 * sort(c(1, diff(x[1:2])/diff(x[3:4])), decreasing = FALSE) )
    lonlat <- grepl("lonlat", projection) || grepl("4326", projection) || grepl("4269", projection) || grepl("OGC:CRS84", projection)
    x <- list(extent = x, dimension = dimension, projection = projection, lonlat = lonlat, type = "matrix")
  }

  x
}
#' Get digital elevation data
#'
#' Read elevation data for any region on Earth.
#'
#' Originally using GEBCO 2019 as a background, and SRTM 30m resolution for
#' regions that fit approximately within the size of an SRTM tile (these are 1 degree wide).
#'
#' Note that data is streamed into memory, so don't make the dimensions of the 'x' target raster too big.
#'
#' To use these data, please attribute the use of GEBCO to the  GEBCO Compilation Group (2021) GEBCO 2021
#'  Grid (doi:10.5285/c6612cbe-50b3-0cff-e053-6c86abc09f8f), and the use of Copernicus GLO30 to
#' European Space Agency, Sinergise (2021). Copernicus Global Digital Elevation Model.
#' Distributed by OpenTopography. https://doi.org/10.5069/G9028PQB.
#'
#' @param extent a numeric vector of xmin,xmax,ymin,ymax or a terra or raster rast object
#' @param ... arguments passed to 'vapour::vapour_warp_raster'
#' @param source a GDAL raster source, to override the inbuild GEBCO + SRTM (in future we might patch in local source)
#' @param threshold a size in degrees above which no SRTM data is queried (about )
#' @param dimension optional output size in ncol,nrow (x,y)
#' @param projection optional coordinate reference system to use (map projection), longlat is assumed
#' @param resample resampling algorithm for the GDAL warper, "bilinear" by default
#'
#' @return a matrix, or depending on format of 'extent' a terra rast or raster object with elevation data
#' @export
#'
#' @examples
#'
#' image(elevation(), useRaster = TRUE)
#' image(elevation(c(100, 150, -60, -20)), useRaster = TRUE)
#' elevation(terra::rast())
#' elevation(raster::raster())
#'
#' elevation(raster::raster(raster::extent(80, 120, -60, -40), res = 0.25, crs = "OGC:CRS84"))
#' \donttest{
#' elevation(raster::raster(raster::extent(c(-1, 1, -1, 1) * 15e3), nrows = 1024, ncols = 1024,
#'    crs = "+proj=laea +lat_0=44.6371 +lon_0=-63.5923"))
#' }
elevation <- function(extent = c(-180, 180, -90, 90), ..., dimension = NULL, projection = NULL, resample = "bilinear", source = NULL, threshold = 0.5) {

  xraster <- extent ## in the case of terra or raster
  x <- format_out(list(extent = extent, dimension = dimension, projection = projection))

  wh <- c(diff(x$extent[1:2]), diff(x$extent[3:4]))
  no_srtm <- FALSE
  no_srtm30 <- FALSE
  if (x$lonlat) {
    if (max(wh) > threshold) {
      no_srtm <- TRUE
    }
  } else {
    ## assuming metres ...
    if (max(wh) > (threshold * 111111.12)) {
      no_srtm <- TRUE
    }
    if (max(wh) > (threshold/3 * 111111.12)) {
      no_srtm30 <- TRUE
    }

  }

  if (is.null(source)) {
    rso <- c("/vsicurl/https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif",
             "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP90/COP90_hh.vrt",
             "/vsicurl/https://opentopography.s3.sdsc.edu/raster/COP30/COP30_hh.vrt" )
            # "/vsicurl/https://opentopography.s3.sdsc.edu/raster/NASADEM/NASADEM_be.vrt")
    if (no_srtm30) rso <- rso[1:2] else rso <- rso[c(1, 3)]
    if (no_srtm) rso <- rso[1L]
    if (!no_srtm) print("SRTM in use, in addition to GEBCO")
    print(rso)
  } else {
    rso <- source
  }

  if (is.na(x$projection)) {
    message("no projection specified, calling warper without a target projection: results not guaranteed")
    x$projection <- ""
  }
  vals <- vapour::vapour_warp_raster_dbl(rso, extent = x$extent, dimension = x$dimension, projection = x$projection, resample = resample, ...)

  switch (x$type,
  terra =   terra::setValues(xraster, vals),
  raster =  raster::setValues(xraster, vals),
  matrix = matrix(vals, x$dimension[2L], byrow = TRUE))#[,x$dimension[2L]:1])

}


dimrat <- function(nativedim, maxd = 512) {
     ord <- order(nativedim)
     nativedim <- sort(nativedim)
     rat <- c(nativedim[1]/nativedim[2], 1)
     dimension <- as.integer(round(maxd * rat))
     dimension[ord]
}
rasterdata <- function(source, dimension = NULL, extent = NULL, ..., projection = NULL, resample = "bilinear",native = FALSE) {
  info <- vapour::vapour_raster_info(source)
  #print(info$dimension)
  if (!native) {
    print(sprintf("native dimension is: %sx%s", info$dimension[1], info$dimension[2]))
  if (length(dimension) == 1) {
    dimension <- dimrat(info$dimension, dimension)
  } else {
    if (is.null(dimension)) {
      dimension <- dimrat(info$dimension)
    }
    print(sprintf("output dimension is: %sx%s", dimension[1], dimension[2]))

  }
  } else {
    dimension <- info$dimension
  }
  #print(dimension)
  elevation(source = source, dimension = dimension, extent = info$extent, projection = info$projection, resample = resample, ...)
}

# .getrasterdata <- function(x) {
#   if (is.na(x$projection)) {
#     message("no projection specified, calling warper without a target projection: results not guaranteed")
#     x$projection <- ""
#   }
#   vals <- vapour::vapour_warp_raster_dbl(rso, extent = x$extent, dimension = x$dimension, projection = x$projection, resample = resample, ...)
# 
#   switch (x$type,
#   terra =   terra::setValues(xraster, vals),
#   raster =  raster::setValues(xraster, vals),
#   matrix = matrix(vals, x$dimension[2L], byrow = TRUE))#[,x$dimension[2L]:1])
# 
# }
