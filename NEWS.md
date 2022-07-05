# whatarelief dev


* Add `imagery()`, currently getting Virtual Earth sat image, can't yet deal with raster/terra objects. Internal function '.imagery_sources()' has more options (goog, bluemarble, esri). 

* Potentially breaking change, to move to GDAL/raster topleft->right->down order for the data returned
by 'elevation()'. This is WIP and may yet change again, hoping to have some visualization helpers better than
'image()'. The original 0.0.1 orientation is tagged in the sources at https://github.com/mdsumner/whatarelief/releases/tag/v0.0.1. 


# whatarelief 0.0.1

* Start raad_sources, for NSIDC sea ice. 

* Recast package as an `elevation()` getter from online sources. 
