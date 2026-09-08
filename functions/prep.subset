### prep.subset() v1.2
### 2026-Sep-08

### Helper function to subset a phylogenetic character matrix by taxon, remove invariant characters,
### adjust the ordered-character vector to match (if supplied), generate a cost matrix (only if ordered
### characters are supplied), and (optionally) subset a matching phylogenetic tree to the same taxa -
### all in one step. Useful for running the same pipeline across multiple matrices (e.g. full, cranial,
### postcranial) and multiple taxonomic subsets without repeating the same lines of code each time.

### Dependencies: remove.invar(), adjust.ord(), cost.matrix() (all from phylodisc); keep.tip() (from ape, only if tree is supplied)

prep.subset <- function(matrix, taxa, ord = NULL, tree = NULL){

	# matrix - phylogenetic character matrix (rows = taxa, columns = characters)
	# taxa   - character vector of taxon names (row names) to subset to, e.g. Lagomorpha
	# ord    - optional vector of ordered characters (as used by adjust.ord); default NULL (no ordered characters).
	#          If NULL, ord adjustment is skipped, $ord will be NULL, and $cost will also be NULL
	#          (a cost matrix is only meaningful when ordered characters are present).
	# tree   - optional phylogenetic tree (object of class 'phylo'); if supplied, the tree is
	#          pruned to the same taxa using ape::keep.tip. If NULL, $tree will be NULL

	# 1. Subset matrix to the taxa of interest
	matrix_sub <- matrix[row.names(matrix) %in% taxa, , drop = FALSE]

	# 2. Remove invariant characters, keeping track of which columns were removed
	removed_list <- remove.invar(matrix_sub, return_removed = TRUE)
	matrix_new <- removed_list$matrix
	removed <- removed_list$removed

	# 3. Adjust the ordered character vector to match the new column numbering, only if ordered
	#    characters were supplied AND characters were actually removed
	ord_new <- ord
	if (!is.null(ord) && length(removed) > 0) {
		ord_new <- adjust.ord(ord, exclude = removed)
	}

	# 4. Generate a cost matrix from the trimmed matrix, only if ordered characters are supplied
	cost_new <- NULL
	if (!is.null(ord)) {
		cost_new <- cost.matrix(matrix_new)
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
