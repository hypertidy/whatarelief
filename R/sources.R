#' GEBCO 2021 source dsn
#' 
#' A data source name to the GEBCO 2021 elevation 'COG' GeoTIFF. 
#'
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#'
#' @return character string, URL to online GeoTIFF
#' @export
#'
#' @examples
#' gebco21()
gebco21 <- function(vsi = TRUE) {
  url <- "https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}
