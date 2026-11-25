### remove.invar() v2.0
### 2026-Sep-08

### Function to remove invariant characters (sites) from a phylogenetic character taxon matrix. Output is a new matrix with columns removed that
### contain no variance in state. Removed characters are printed. This version removes the two-pass sd()-based detection (which relied on
### numeric coercion and could misbehave with multi-character state tokens, e.g. polymorphisms coded as "(01)") in favour of a single,
### more robust pass that checks the number of unique non-missing (non-'?') states per character. This correctly handles:
###   - fully invariant characters (only one state used across all taxa)
###   - characters coded entirely with ambiguities ('?')
###   - characters with only one state scored and the remainder scored as ambiguities ('?')
### (This resolves the previous TO-DO item about removing characters with one state + '?' for the rest.)
###
### NEW: optional 'return_removed' argument (default FALSE). If TRUE, the function returns a list with elements
### 'matrix' (the new matrix with invariant characters removed) and 'removed' (integer vector of the original column
### indices that were removed). This is intended to be used together with phylodisc::adjust.ord, e.g.:
###
###   result <- remove.invar(matrix, return_removed = TRUE)
###   new_matrix <- result$matrix
###   new_ord <- adjust.ord(ord, exclude = result$removed)
###
### If no invariant characters are found, the unchanged matrix is returned (or a list with an empty 'removed' vector
### when return_removed = TRUE), so the function remains compatible for use with apply functions.

remove.invar <- function(matrix, return_removed = FALSE){
	
	# matrix - phylogenetic character matrix
	# return_removed - logical (T/F); if TRUE, also returns the vector of removed character indices
	#                  (original column positions), for use with phylodisc::adjust.ord

	# A character is invariant if, ignoring '?' (ambiguities), it has zero or one unique state.
	is_invariant <- function(col){
		vals <- col[!is.na(col) & col != '?']
		length(vals) == 0 || length(unique(vals)) == 1
	}

	chars_to_drop <- which(apply(matrix, 2, is_invariant))

	# ---- Handle case with nothing to drop ----
	if (length(chars_to_drop) == 0) {
		print("No invariant characters found; no characters removed.")
		if (isTRUE(return_removed)) {
			return(list(matrix = matrix, removed = integer(0)))
		}
		return(matrix)
	}
	# -------------------------------------------

	matrix_new <- matrix[, -chars_to_drop, drop = FALSE]

	print("Following invariant characters removed:")
	print(chars_to_drop)

	if (isTRUE(return_removed)) {
		return(list(matrix = matrix_new, removed = chars_to_drop))
	}

	return(matrix_new)
}
