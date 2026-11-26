#' Deprecated function names
#'
#' These names are kept so that existing scripts still work. Each one calls the
#' function with the new snake_case name and gives a deprecation warning.
#'
#' @param ... Arguments passed to the new function.
#' @return The same value as the new function.
#' @name phylodisc-deprecated
#' @keywords internal
NULL

#' @rdname phylodisc-deprecated
#' @export
get.states <- function(...) {
  .Deprecated("get_states", package = "phylodisc")
  get_states(...)
}

#' @rdname phylodisc-deprecated
#' @export
statef <- function(...) {
  .Deprecated("state_f", package = "phylodisc")
  state_f(...)
}

#' @rdname phylodisc-deprecated
#' @export
cost.matrix <- function(...) {
  .Deprecated("cost_matrix", package = "phylodisc")
  cost_matrix(...)
}

#' @rdname phylodisc-deprecated
#' @export
contrast.matrix <- function(...) {
  .Deprecated("contrast_matrix", package = "phylodisc")
  contrast_matrix(...)
}

#' @rdname phylodisc-deprecated
#' @export
morph.phydat <- function(...) {
  .Deprecated("morph_phydat", package = "phylodisc")
  morph_phydat(...)
}

#' @rdname phylodisc-deprecated
#' @export
adjust.ord <- function(...) {
  .Deprecated("adjust_ord", package = "phylodisc")
  adjust_ord(...)
}

#' @rdname phylodisc-deprecated
#' @export
remove.invar <- function(...) {
  .Deprecated("remove_invar", package = "phylodisc")
  remove_invar(...)
}

#' @rdname phylodisc-deprecated
#' @export
prep.subset <- function(...) {
  .Deprecated("prep_subset", package = "phylodisc")
  prep_subset(...)
}

#' @rdname phylodisc-deprecated
#' @export
poly.to.amb <- function(...) {
  .Deprecated("poly_to_amb", package = "phylodisc")
  poly_to_amb(...)
}

#' @rdname phylodisc-deprecated
#' @export
uncert.to.amb <- function(...) {
  .Deprecated("uncert_to_amb", package = "phylodisc")
  uncert_to_amb(...)
}

#' @rdname phylodisc-deprecated
#' @export
uncert.to.poly <- function(...) {
  .Deprecated("uncert_to_poly", package = "phylodisc")
  uncert_to_poly(...)
}

#' @rdname phylodisc-deprecated
#' @export
RHI <- function(...) {
  .Deprecated("rhi", package = "phylodisc")
  rhi(...)
}

#' @rdname phylodisc-deprecated
#' @export
HER <- function(...) {
  .Deprecated("her", package = "phylodisc")
  her(...)
}

#' @rdname phylodisc-deprecated
#' @export
HSR <- function(...) {
  .Deprecated("hsr", package = "phylodisc")
  hsr(...)
}

#' @rdname phylodisc-deprecated
#' @export
anc.discrete <- function(...) {
  .Deprecated("anc_discrete", package = "phylodisc")
  anc_discrete(...)
}

#' @rdname phylodisc-deprecated
#' @export
amb.filter <- function(...) {
  .Deprecated("amb_filter", package = "phylodisc")
  amb_filter(...)
}

#' @rdname phylodisc-deprecated
#' @export
find.pairs <- function(...) {
  .Deprecated("find_pairs", package = "phylodisc")
  find_pairs(...)
}

#' @rdname phylodisc-deprecated
#' @export
homoplasy.bin <- function(...) {
  .Deprecated("homoplasy_bin", package = "phylodisc")
  homoplasy_bin(...)
}

#' @rdname phylodisc-deprecated
#' @export
lnorm.params <- function(...) {
  .Deprecated("lnorm_params", package = "phylodisc")
  lnorm_params(...)
}

#' @rdname phylodisc-deprecated
#' @export mean.pairwise.dist
mean.pairwise.dist <- function(...) {
  .Deprecated("mean_pairwise_dist", package = "phylodisc")
  mean_pairwise_dist(...)
}

#' @rdname phylodisc-deprecated
#' @export
mrbayes.partition.block <- function(...) {
  .Deprecated("mrbayes_partition_block", package = "phylodisc")
  mrbayes_partition_block(...)
}

#' @rdname phylodisc-deprecated
#' @export
phylo.gdist <- function(...) {
  .Deprecated("phylo_gdist", package = "phylodisc")
  phylo_gdist(...)
}

#' @rdname phylodisc-deprecated
#' @export
rate.index <- function(...) {
  .Deprecated("rate_index", package = "phylodisc")
  rate_index(...)
}
