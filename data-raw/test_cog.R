## code to prepare `DATASET` dataset goes here

## run in gdal 3.7
system(sprintf("gdalwarp %s inst/extdata/world_cog_test.tif -overwrite -nomd -co COMPRESS=DEFLATE -co COMPRESS_OVERVIEW=DEFLATE -ot Int16 -te -180 -90 180 90 -ts 720 360 -t_srs 'OGC:CRS84' -of COG -co OVERVIEWS=IGNORE_EXISTING", 
               #whatarelief::gebco21()), 
               "/vsicurl/https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"))
#system("gdaladdo inst/extdata/world_cog_test.tif 2 4 8 --config COMPRESS_OVERVIEW DEFLATE")
