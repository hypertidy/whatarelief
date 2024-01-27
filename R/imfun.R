
#' @importFrom stats na.omit
#' @importFrom graphics lines
imfun <- function(X, coastline = TRUE) {
  if (!requireNamespace("ximage")) stop("{ximage} package required for imfun()")
  if (is.character(X[[1]])) {
    if (grepl("^#", na.omit(X[[1]])[1])) {
      ## we have image data
    } else {
      X[[1]] <- as.vector(t(elevation(source = X[[1]], extent = attr(X, "extent"), dimension = attr(X, "dimension"), projection = attr(X, "projection"))))
    }
  }
  ximage::ximage(matrix(X[[1]], attr(X, "dimension")[2L], byrow = TRUE), 
                 extent = attr(X, "extent"), asp = 1)
  if (coastline) graphics::lines(coastline(attr(X, "extent"), projection = attr(X, "projection"), dimension = c(512, 512)))
  
  ## return the materialized data
  invisible(X)
}
