#' cut methods for stars objects
#' 
#' cut methods for stars objects
#' @name cut_stars
#' @param x see \link[base]{cut}
#' @param breaks see \link[base]{cut}
#' @param ... see \link[base]{cut}
#' @return an array or matrix with a \code{levels} attribute; see details
#' @details R's \code{factor} only works for vectors, not for arrays or matrices. This is a work-around (or hack?) to keep the factor levels generated by \code{cut} and use them in plots.
#' @export
#' @examples
#' tif = system.file("tif/L7_ETMs.tif", package = "stars")
#' x = read_stars(tif)
#' cut(x, c(0, 50, 100, 255))
#' cut(x[,,,1], c(0, 50, 100, 255))
#' plot(cut(x[,,,1], c(0, 50, 100, 255)))
cut.array = function(x, breaks, ...) { 
	d = dim(x)
	x = cut(as.vector(x), breaks, ...)
	structure(array(as.integer(x), dim = d), levels = levels(x))
}

#' @name cut_stars
#' @export
cut.matrix = cut.array

#' @name cut_stars
#' @export
#' @examples
#' tif = system.file("tif/L7_ETMs.tif", package = "stars")
#' x1 = read_stars(tif)
#' (x1_cut = cut(x1, breaks = c(0, 50, 100, Inf)))  # shows factor in summary
#' plot(x1_cut[,,,c(3,6)]) # propagates through [ and plot
cut.stars = function(x, breaks, ...) {
	ret = lapply(x, cut, breaks = breaks, ...)
	st_stars(ret, st_dimensions(x))
}
