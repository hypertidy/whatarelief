# whatarelief dev

* Convenience source functions `gebco21()` returns the COG url. 

* New `satbox()` function for Mapbox satellite/aerial imagery. 

* New 'coastline()' function. 

* imagerY() detects case on one (less than 3) bands in the source. 

* Fix dimension. 

* Add `streetmap()` currently getting OSM image, same support as 'imagery()'.  Internal object `.streetmap_sources` has
openstreetmap, google, virtual earth, esri. 

* Add `imagery()`, currently getting Virtual Earth sat image, can't yet deal with raster/terra objects. Internal object '.imagery_sources' has more options (goog, bluemarble, esri, virtualearth, ESA_worldcover_2020). 

* Potentially breaking change, to move to GDAL/raster topleft->right->down order for the data returned
by 'elevation()'. This is WIP and may yet change again, hoping to have some visualization helpers better than
'image()'. The original 0.0.1 orientation is tagged in the sources at https://github.com/mdsumner/whatarelief/releases/tag/v0.0.1. 


# whatarelief 0.0.1

* Start raad_sources, for NSIDC sea ice. 

* Recast package as an `elevation()` getter from online sources. 
