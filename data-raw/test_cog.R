## code to prepare `DATASET` dataset goes here

## run in gdal 3.7

system(sprintf("gdal_translate %s world_cog_test1.tif   -ot Int16 -projwin -180 90 180 -90 -outsize 720 360 -of COG -co OVERVIEWS=NONE -co TILED=NO", 
             
               "/vsicurl/https://public.services.aad.gov.au/datasets/science/GEBCO_2021_GEOTIFF/GEBCO_2021.tif"))
              
system("gdalwarp world_cog_test1.tif world_cog_test.tif -overwrite -nomd -co PREDICTOR=2 -co COMPRESS=LZW")
system("gdaladdo world_cog_test.tif 2 4 8 --config COMPRESS_OVERVIEW LZW")
