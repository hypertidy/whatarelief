.ideal_dimension <- function(dimension = 1024, extent = NULL) {
  if (dev.cur() > 1L) {
    px <- ceiling(dev.size("px") * par("pin")/dev.size())
  } else {
    dimension <- rep(dimension, length.out = 2L)
    if (is.null(extent)) extent <- c(0, dimension[1L], 0, dimension[2L])
    px <- ceiling(dimension * sort(c(1, diff(extent[1:2])/diff(extent[3:4])), decreasing = FALSE))
  }
  px
}
