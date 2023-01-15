
token_url <- function(api = "mapbox") {
  switch(api, mapbox = "https://account.mapbox.com/access-tokens/", stop("api not known"))
}
instruct_on_key_creation <- function(api = "mapbox") {
  if (api == "mapbox") {
    out <- paste(sprintf("To set your Mapbox API key obtain a key from %s\n", token_url()),
    sprintf("1) Run this to set for the session 'Sys.setenv(MAPBOX_API_KEY=<yourkey>)'\n\nOR,\n\n2) To set permanently store 'MAPBOX_API_KEY=<yourkey>' in ~/.Renviron\n\nSee 'help(ceramic::get_api_key)'"), sep = "\n")
  } else {
    message(sprintf("don't know if key is needed for %s", api))
  }
  out
}

#' Get API key for Mapbox service
#'
#' Mapbox tile providers require an API key. Other providers may not need a key and so this is ignored.
#'
#' The \href{https://CRAN.r-project.org/package=mapdeck/}{mapdeck package} has a more comprehensive tool for
#' setting the Mapbox API key, if this is in use ceramic will find it first and use it.
#'
#' To set your Mapbox API key obtain a key from \url{https://account.mapbox.com/access-tokens/}
#' \preformatted{
#' 1) Run this to set for the session 'Sys.setenv(MAPBOX_API_KEY=<yourkey>)'
#'
#' OR,
#'
#' 2) To set permanently store 'MAPBOX_API_KEY=<yourkey>' in '~/.Renviron'.
#' }
#'
#' There is a fairly liberal allowance for the actual name of the environment variable, any of
#' 'MAPBOX_API_KEY', 'MAPBOX_API_TOKEN', 'MAPBOX_KEY', 'MAPBOX_TOKEN', or 'MAPBOX' will work (and they are
#' sought in that order).
#'
#' If no key is available, `NULL` is returned, with a warning.
#' @param api character string denoting which service ("mapbox" only)
#' @param ... currently ignored
#' @return The stored API key value, see Details.
#' @noRd
#' @examples
#' get_api_key()
get_api_key <- function(api = "mapbox", ...) {
  key <- NULL
  if (api == "mapbox") {
    ## Try mapdeck first (why not)
    key <- getOption("mapdeck")[['mapdeck']][[api]]
    key_candidates <- c("MAPBOX_API_KEY", "MAPBOX_API_TOKEN", "MAPBOX_KEY", "MAPBOX_TOKEN", "MAPBOX")
    if(is.na(key) || is.null(key) || nchar(key) < 1) {
       key <- unlist(lapply(key_candidates, function(label) Sys.getenv(label)))[1L]
    }
    if (is.na(key) || is.null(key) || nchar(key) < 1) {
      mess <- instruct_on_key_creation()
      warning(sprintf("no mapbox key found\n\n%s", mess))
      key <- NULL
    }
  }
  key
}

#' @name imagery
#' @export
#' 
satbox <- function(extent = c(-180, 180, -90, 90), ..., dimension = NULL, projection = "OGC:CRS84", resample = "near", source = NULL) {

  xraster <- extent ## in the case of terra or raster
  x <- format_out(list(extent = extent, dimension = dimension, projection = projection))

  
  
   src <- "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://api.mapbox.com/v4/mapbox.satellite/${z}/${x}/${y}.jpg?access_token=%s</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>22</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>"

  if (is.null(source)) {
    rso <- sprintf(src, 
                   get_api_key())
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
