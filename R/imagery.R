# gotta figure out how to handle this
.imagery_sources <- c(wms_arcgis_mapserver_ESRI.WorldImagery_tms = "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${z}/${y}/${x}</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>17</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>10</MaxConnections><Cache /></GDAL_WMS>",
                      wms_bluemarble_s3_tms = "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://s3.amazonaws.com/com.modestmaps.bluemarble/${z}-r${y}-c${x}.jpg</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>9</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><Cache/></GDAL_WMS>",
                      wms_googlehybrid_tms = "<GDAL_WMS><!-- Data is subject to term of use detailed at http://code.google.com/intl/nl/apis/maps/terms.html andhttp://www.google.com/intl/en_ALL/help/terms_maps.html --><Service name=\"TMS\"><!-- ServerUrl>http://mt.google.com/vt/lyrs=m&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --><!-- Map --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=s&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Satellite --><ServerUrl>http://mt.google.com/vt/lyrs=y&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> <!-- Hybrid --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=t&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=p&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain, Streets and Water  --></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>20</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>5</MaxConnections><Cache /></GDAL_WMS>",
                      wms_virtualearth = "<GDAL_WMS><Service name=\"VirtualEarth\"><ServerUrl>http://a${server_num}.ortho.tiles.virtualearth.net/tiles/a${quadkey}.jpeg?g=90</ServerUrl></Service><MaxConnections>4</MaxConnections><Cache/></GDAL_WMS>",
                      wms_ESA_worldcover_2020_tms = "<GDAL_WMS><Service name=\"WMS\"><Version>1.1.1</Version><ServerUrl>https://services.terrascope.be/wms/v2?SERVICE=WMS</ServerUrl><Layers>WORLDCOVER_2020_MAP</Layers><SRS>EPSG:3857</SRS><ImageFormat>image/jpeg</ImageFormat><Transparent>FALSE</Transparent><BBoxOrder>xyXY</BBoxOrder></Service><DataWindow><UpperLeftX>-2.003750834E7</UpperLeftX><UpperLeftY>2.003750834E7</UpperLeftY><LowerRightX>2.003750834E7</LowerRightX><LowerRightY>-2.003750834E7</LowerRightY><SizeX>1073741824</SizeX><SizeY>1073741824</SizeY></DataWindow><BandsCount>3</BandsCount><BlockSizeX>1024</BlockSizeX><BlockSizeY>1024</BlockSizeY><OverviewCount>20</OverviewCount></GDAL_WMS>"
)


.streetmap_sources <- c(wms_openstreetmap_tms = "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>https://tile.openstreetmap.org/${z}/${x}/${y}.png</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>18</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:3857</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><!--<UserAgent>Please add a specific user agent text, to avoid the default one being used, and potentially blocked by OSM servers in case a too big usage of it would be seen</UserAgent>--><Cache /></GDAL_WMS>",
                        wms_googleterrainstreets_tms = "<GDAL_WMS><!-- Data is subject to term of use detailed at http://code.google.com/intl/nl/apis/maps/terms.html andhttp://www.google.com/intl/en_ALL/help/terms_maps.html --><Service name=\"TMS\"><!-- <ServerUrl>http://mt.google.com/vt/lyrs=m&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --><!-- Map --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=s&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Satellite --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=y&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Hybrid --><!-- <ServerUrl>http://mt.google.com/vt/lyrs=t&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> --> <!-- Terrain --><ServerUrl>http://mt.google.com/vt/lyrs=p&amp;x=${x}&amp;y=${y}&amp;z=${z}</ServerUrl> <!-- Terrain, Streets and Water  --></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>20</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>5</MaxConnections><Cache /></GDAL_WMS>",
                         wms_virtualearth_street = "<GDAL_WMS><Service name=\"VirtualEarth\"><ServerUrl>http://r${server_num}.ortho.tiles.virtualearth.net/tiles/r${quadkey}.jpeg?g=90</ServerUrl></Service><MaxConnections>4</MaxConnections><Cache/></GDAL_WMS>",
                        wms_arcgis_mapserver_tms = "<GDAL_WMS><Service name=\"TMS\"><ServerUrl>http://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/${z}/${y}/${x}</ServerUrl></Service><DataWindow><UpperLeftX>-20037508.34</UpperLeftX><UpperLeftY>20037508.34</UpperLeftY><LowerRightX>20037508.34</LowerRightX><LowerRightY>-20037508.34</LowerRightY><TileLevel>17</TileLevel><TileCountX>1</TileCountX><TileCountY>1</TileCountY><YOrigin>top</YOrigin></DataWindow><Projection>EPSG:900913</Projection><BlockSizeX>256</BlockSizeX><BlockSizeY>256</BlockSizeY><BandsCount>3</BandsCount><MaxConnections>10</MaxConnections><Cache /></GDAL_WMS>"
)

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
