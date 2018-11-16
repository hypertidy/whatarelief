#' bowerbird cache for whatarelief
#'
#'
#' @return file path to bowerbird goodies
#' @export
#'
#' @examples
#' whatarelief_bb_cache()
whatarelief_bb_cache <- function() {
  file.path(rappdirs::user_cache_dir(),
            "whatarelief")
}
#' whatarelief cache for project tiles
#'
#' @return file path to project home
#' @export
#'
#' @examples
#' whatarelief_cache()
whatarelief_cache <- function() {
  path <- file.path(rappdirs::user_cache_dir(),
            "whatarelief/bb")
  if (!file.exists(path)) dir.create(path, recursive = TRUE)
  path
}

#' Get a bowerbird source
#'
#' This is very raw, see https://ropensci.org/blog/2018/11/13/antarctic/
#' This could house a set of sources of known topography, and hide the bowerbird/blueant stuff.
#' @param src bowerbird source (assumed to be a topo source)
#' @param local_file_root where to put the bowerbird loot
#'
#' @return
#' @export
#'
get_relief <- function(src, local_file_root = NULL) {
  if (is.null(local_file_root)) local_file_root <- whatarelief_cache()
  bowerbird::bb_get(src, local_file_root = local_file_root, confirm_downloads_larger_than = -1)
}

#' Find files (not functional, just a stub)
#'
#' @param pattern
#'
#' @return
#' @export
#'
#' @examples
find_relief <- function(pattern = "etopo2.*nc$") {
  list.files(whatarelief_cache(), pattern = pattern, full.names = TRUE, recursive = TRUE, ignore.case = TRUE)
}
#' Random project name
#'
#' @return
#' @export
#'
#' @examples
project_name <- function() {
  sprintf("fs0_%s", paste(sample(letters, 10), collapse = ""))
}
#' Crop raster data to each polygon
#'
#' @param polygons Spatial Polygons
#' @param relief topo raster
#' @param pname project name
#'
#' @return list of rasters (GeoTIFFs on disk)
#' @export
#'
relief_patcher <- function(polygons, relief, pname = NULL) {
  #if (inherits(polygons, "sf")) polygons <- spbabel::sp(spbabel::sptable(polygons))
  relief <- raster::crop(relief, raster::extent(polygons))
  if (is.null(pname)) pname <- project_name()
  ## assume longlat for now
  topolist <- vector("list", nrow(polygons))
  outdir <- file.path(whatarelief_cache(), pname)
  dir.create(outdir, showWarnings = FALSE, recursive = TRUE)
  polygons$ff <- "a"
  for (i in seq_len(nrow(polygons))) {
    e <- raster::extent(spex::spex(polygons[i, ]))
    #msk <- raster::rasterize(polygons[i, ], raster::crop(relief, e), field = 1)
    result <- try(raster::mask(raster::crop(relief, e), polygons[i, ]))
    if (!inherits(result, "try-error")) {
      result <- raster::writeRaster(raster::trim(result),
                                        filename = file.path(outdir, sprintf("topo%04i.tif", i)))

      topolist[[i]] <- result

    }

  }
  topolist
}

