### prep_subset() v1.2
### 2026-Sep-08

### Helper function to subset a phylogenetic character matrix by taxon, remove invariant characters,
### adjust the ordered-character vector to match (if supplied), generate a cost matrix (only if ordered
### characters are supplied), and (optionally) subset a matching phylogenetic tree to the same taxa -
### all in one step. Useful for running the same pipeline across multiple matrices (e.g. full, cranial,
### postcranial) and multiple taxonomic subsets without repeating the same lines of code each time.

### Dependencies: remove_invar(), adjust_ord(), cost_matrix() (all from phylodisc); keep.tip() (from ape, only if tree is supplied)

#' Prepare a taxon subset of a matrix in one step
#'
#' Subsets a matrix to chosen taxa, removes invariant characters, adjusts the
#' ordered-character vector, builds a cost matrix (only if ordered characters
#' are supplied) and optionally prunes a matching tree.
#'
#' @param matrix Character matrix with taxa as rows.
#' @param taxa Character vector of taxon names to keep.
#' @param ord Optional vector of ordered characters.
#' @param tree Optional `phylo` tree, pruned to `taxa`.
#' @return A list with `matrix`, `ord`, `cost`, `tree` (the last three `NULL`
#'   when not applicable) and `removed` (original indices of removed
#'   characters).
#' @references Paradis E, Schliep K (2019) ape 5.0: an environment for modern
#'   phylogenetics and evolutionary analyses in R. Bioinformatics 35:526-528.
#' @section AI use:
#' The function code was written by the package author. The roxygen
#' documentation and the snake_case name were produced with GitHub Copilot
#' (Claude Sonnet 5.5); see `AI_USE.md`.
#' @export
prep_subset <- function(matrix, taxa, ord = NULL, tree = NULL){

	# matrix - phylogenetic character matrix (rows = taxa, columns = characters)
	# taxa   - character vector of taxon names (row names) to subset to, e.g. Lagomorpha
	# ord    - optional vector of ordered characters (as used by adjust_ord); default NULL (no ordered characters).
	#          If NULL, ord adjustment is skipped, $ord will be NULL, and $cost will also be NULL
	#          (a cost matrix is only meaningful when ordered characters are present).
	# tree   - optional phylogenetic tree (object of class 'phylo'); if supplied, the tree is
	#          pruned to the same taxa using ape::keep.tip. If NULL, $tree will be NULL

	# 1. Subset matrix to the taxa of interest
	matrix_sub <- matrix[row.names(matrix) %in% taxa, , drop = FALSE]

	# 2. Remove invariant characters, keeping track of which columns were removed
	removed_list <- remove_invar(matrix_sub, return_removed = TRUE)
	matrix_new <- removed_list$matrix
	removed <- removed_list$removed

	# 3. Adjust the ordered character vector to match the new column numbering, only if ordered
	#    characters were supplied AND characters were actually removed
	ord_new <- ord
	if (!is.null(ord) && length(removed) > 0) {
		ord_new <- adjust_ord(ord, exclude = removed)
	}

	# 4. Generate a cost matrix from the trimmed matrix, only if ordered characters are supplied
	cost_new <- NULL
	if (!is.null(ord)) {
		cost_new <- cost_matrix(matrix_new)
	}

	# 5. Prune the tree to the same taxa, if supplied
	tree_new <- NULL
	if (!is.null(tree)) {
		if (!requireNamespace("ape", quietly = TRUE)) stop("ape package required to subset tree.")
		if (!inherits(tree, "phylo")) stop("tree must be an object of class 'phylo'.")
		tree_new <- ape::keep.tip(tree, taxa)
	}

	return(list(
		matrix = matrix_new,
		ord = ord_new,
		cost = cost_new,
		tree = tree_new,
		removed = removed
	))
}
