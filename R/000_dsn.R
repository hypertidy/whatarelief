

.imagery_sources <- c(wms_arcgis_mapserver_ESRI.WorldImagery_tms = spatial.datasources::wms_arcgis_mapserver_ESRI.WorldImagery_tms(), 
                     wms_bluemarble_s3_tms = spatial.datasources::wms_bluemarble_s3_tms(), 
                     wms_googlehybrid_tms = spatial.datasources::wms_googlehybrid_tms(), 
                     wms_virtualearth = spatial.datasources::wms_virtualearth(), 
                     wms_ESA_worldcover_2020_tms = spatial.datasources::wms_ESA_worldcover_2020_tms(), 
                     wms_mapbox_satellite = spatial.datasources::wms_mapbox_satellite())




.elevation_sources <- c(wms_amazon_elevation = spatial.datasources::wms_amazon_elevation(), 
                        wms_amazon_elevation = spatial.datasources::wms_amazon_elevation(), 
                        gebco = spatial.datasources::gebco()) 

.streemap_sources <- c(wms_openstreetmap_tms = spatial.datasources::wms_openstreetmap_tms(), 
                       wms_openstreetmap_tms=  spatial.datasources::wms_openstreetmap_tms(), 
                      wms_virtualearth_street =  spatial.datasources::wms_virtualearth_street(), 
                       wms_arcgis_mapserver_tms = spatial.datasources::wms_arcgis_mapserver_tms())



#' @importFrom spatial.datasources gebco
#' @export
#' @name gebco
"gebco"

#' @importFrom spatial.datasources gebco21
#' @export
#' @name gebco21
"gebco21"
