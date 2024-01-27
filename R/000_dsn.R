

.imagery_sources <- c(wms_arcgis_mapserver_ESRI.WorldImagery_tms = sds::wms_arcgis_mapserver_ESRI.WorldImagery_tms(), 
                     wms_bluemarble_s3_tms = sds::wms_bluemarble_s3_tms(), 
                     wms_googlehybrid_tms = sds::wms_googlehybrid_tms(), 
                     wms_virtualearth = sds::wms_virtualearth(), 
                     wms_ESA_worldcover_2020_tms = sds::wms_ESA_worldcover_2020_tms(), 
                     wms_mapbox_satellite = sds::wms_mapbox_satellite())




.elevation_sources <- c(wms_amazon_elevation = sds::wms_amazon_elevation(), 
                        wms_amazon_elevation = sds::wms_amazon_elevation(), 
                        gebco = sds::gebco()) 

.streemap_sources <- c(wms_openstreetmap_tms = sds::wms_openstreetmap_tms(), 
                       wms_openstreetmap_tms=  sds::wms_openstreetmap_tms(), 
                      wms_virtualearth_street =  sds::wms_virtualearth_street(), 
                       wms_arcgis_mapserver_tms = sds::wms_arcgis_mapserver_tms())

