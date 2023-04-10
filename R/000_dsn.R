

.imagery_sources <- c(wms_arcgis_mapserver_ESRI.WorldImagery_tms = dsn::wms_arcgis_mapserver_ESRI.WorldImagery_tms(), 
                     wms_bluemarble_s3_tms = dsn::wms_bluemarble_s3_tms(), 
                     wms_googlehybrid_tms = dsn::wms_googlehybrid_tms(), 
                     wms_virtualearth = dsn::wms_virtualearth(), 
                     wms_ESA_worldcover_2020_tms = dsn::wms_ESA_worldcover_2020_tms(), 
                     wms_mapbox_satellite = dsn::wms_mapbox_satellite())




.elevation_sources <- c(wms_amazon_elevation = dsn::wms_amazon_elevation(), 
                        wms_amazon_elevation = dsn::wms_amazon_elevation(), 
                        gebco = dsn::gebco()) 

.streemap_sources <- c(wms_openstreetmap_tms = dsn::wms_openstreetmap_tms(), 
                       wms_openstreetmap_tms=  dsn::wms_openstreetmap_tms(), 
                      wms_virtualearth_street =  dsn::wms_virtualearth_street(), 
                       wms_arcgis_mapserver_tms = dsn::wms_arcgis_mapserver_tms())



#' @importFrom dsn gebco
#' @export
#' @name gebco
"gebco"

#' @importFrom dsn gebco21
#' @export
#' @name gebco21
"gebco21"
