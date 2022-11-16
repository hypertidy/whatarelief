#' Get coastline data
#'
#' Get a coatline for any region on Earth.
#'
#' This uses the [elevation()] function to get a coastline by contouring elevation data at 0. (This might return nothing.)
#'
#' For 'extent' not provided it will be derived from a plot extent if one exists. It's the user's job to ensure the
#' projection is appropriate (we don't have a graphics mechanism to record a current projection string.)
#'
#' If no device is open and no extent given, a coastline for longlat is given.
#' @param extent extent xmin, xmax, ymin, ymax
#' @param ... argumetns passed to [elevation()]
#' @param dimension optional size of matrix to contour (a default is used)
#' @param projection provide this for custom extents in a given projection
#'
#' @return
#' @export
#'
#' @examples
#' plot(coastline(extent = c(-180, 180, -90, 90)), type = "l")
coastline <- function(extent = NULL, ..., dimension = c(1024, 1024), projection = NULL) {
  if (is.null(extent)) {
    if (dev.cur() > 1) {
          extent <- par("usr")

    }
  }
  ele <- elevation(extent, dimension = dimension, projection = projection)
  #vaster::x_centre
  xl <- extent[1:2]; yl <- extent[3:4]
  resx <- diff(xl)/dimension[1]; resy <- diff(yl)/dimension[2]
  xx <- seq(xl[1L] + resx/2, xl[2L] - resx/2, length.out = dimension[1L])
  yy <- seq(yl[1L] + resy/2, yl[2L] - resy/2, length.out = dimension[2L])

  cl <- contourLines(xx, yy, t(ele[nrow(ele):1, ]), levels = 0)
  #bl <- lapply(cl, lines)
  if (is.null(cl)) {
    warning("no coastline available for this extent/projection")
    return(NULL)
  }
  head(do.call(rbind, lapply(cl, function(.x) rbind(cbind(.x$x, .x$y), NA))), -1)
}
