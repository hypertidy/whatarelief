#' GEBCO source dsn
#' 
#' A data source name to the GEBCO  elevation 'COG' GeoTIFF. 
#'
#' GEBCO 2022 is created and hosted by Philippe Massicotte. 
#' 
#' GEBCO 2019 and 2021 created and hosted by the Australian Antarctic Division. 
#' 
#' @param vsi include the 'vsicurl' prefix (`TRUE` is default)
#'
#' @returns character string, URL to online GeoTIFF
#' @export
#'
#' @aliases gebco22 gebco21 gebco19
#' @examples
#' gebco()
gebco <- function(vsi = TRUE) {
  gebco22(vsi = vsi)
}

#' @name gebco
#' @export
gebco21 <- function(vsi = TRUE) {
  url <- "https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco22 <- function(vsi = TRUE) {
  url <- "https://gebco2022.s3.valeria.science/gebco_2022_complete_cog.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
}

#' @name gebco
#' @export
gebco19 <- function(vsi = TRUE) {
  url <- "https://public.services.aad.gov.au/datasets/science/GEBCO_2019_GEOTIFF/GEBCO_2019.tif"
  if (vsi) url <- file.path("/vsicurl", url)
  url
} 
