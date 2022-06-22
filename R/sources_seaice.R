#' Data sources raadtools knows about
#'
#' Currently just 'nsidc_25km_seaice' is available.
#'
#' Obtains a listing of GDAL-read URLs indexed by raadtools.
#'
#' I think the early URLs are wrong ... but later ones work, see the README
#' @param id raadtools id of data sourced
#' @param ...  unused
#'
#' @return data frame of dates and vrt dsn (names vary, this is WIP)
#' @export
#'
#' @examples
#' raad_source("nsidc_25km_seaice")
raad_source <- function(id = "nsidc_25km_seaice", ...) {
  readr::read_csv("https://raw.githubusercontent.com/hypertidy/gdalwebsrv/master/inst/bundle/raad_nsidc_25km_seaice.csv.gz",
                       col_types = readr::cols(
                         date = readr::col_datetime(format = ""),
                         north_vrt_dsn = readr::col_character(),
                         south_vrt_dsn = readr::col_character()
                       ))
}
