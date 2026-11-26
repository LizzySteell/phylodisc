# 2026-Sep-09

### amb_filter(): Function to filter taxa and/or characters from a phylogenetic character
### matrix based on a missing-data ('?') threshold. Can filter taxa (rows), characters
### (columns), or both (taxa filtered first, then characters on the resulting matrix).
### Excluded taxa/characters and their proportion of missing data are printed and returned.

#' Filter taxa and/or characters by proportion of missing data
#'
#' Removes taxa (rows) and/or characters (columns) whose proportion of missing
#' data exceeds a threshold. When `filter = "both"`, taxa are filtered first.
#'
#' @param matrix Character matrix with taxon names as row names.
#' @param filter One of `"taxa"`, `"characters"` or `"both"`.
#' @param taxon_threshold,char_threshold Maximum proportion of missing data
#'   allowed per taxon / per character.
#' @param missing_char Symbol for missing data.
#' @param verbose Logical. Print filtering summaries.
#' @return A list with the filtered `matrix`, data frames `excluded_taxa` and
#'   `excluded_chars` (with proportion missing), and `retained_taxa` and
#'   `retained_chars`.
#' @export
amb_filter <- function(matrix, filter = c("taxa", "characters", "both"),
                        taxon_threshold = 0.5, char_threshold = 0.5,
                        missing_char = "?", verbose = TRUE){

	# matrix - phylogenetic character taxon matrix
	# filter - one of "taxa", "characters", or "both"; which dimension(s) to filter
	# taxon_threshold - max proportion of missing data allowed per taxon (used if filter is "taxa" or "both")
	# char_threshold - max proportion of missing data allowed per character (used if filter is "characters" or "both")
	# missing_char - character denoting missing data, default "?"
	# verbose - logical (T/F); print filtering summaries

	filter <- match.arg(filter)

	if(is.null(rownames(matrix))){
		stop("matrix must have rownames (taxon names)")
	}

	excluded_taxa_df <- NULL
	excluded_chars_df <- NULL
	current_matrix <- matrix

	# ---- Taxon filtering ----
	if(filter %in% c("taxa", "both")){

		prop_missing_taxa <- apply(current_matrix, 1, function(row){
			sum(row == missing_char | is.na(row)) / length(row)
		})

		keep_taxa <- prop_missing_taxa < taxon_threshold
		excluded_taxa_names <- rownames(current_matrix)[!keep_taxa]

		excluded_taxa_df <- data.frame(
			Taxon = excluded_taxa_names,
			Proportion_missing = prop_missing_taxa[!keep_taxa],
			stringsAsFactors = FALSE
		)
		excluded_taxa_df <- excluded_taxa_df[order(-excluded_taxa_df$Proportion_missing), ]
		rownames(excluded_taxa_df) <- NULL

		current_matrix <- current_matrix[keep_taxa, , drop = FALSE]

		if(isTRUE(verbose)){
			if(nrow(excluded_taxa_df) > 0){
				print(sprintf("[Taxa] Excluded %d taxa with >= %.0f%% missing data:", nrow(excluded_taxa_df), taxon_threshold * 100))
				print(excluded_taxa_df)
			} else {
				print(paste0("[Taxa] No taxa excluded; all below ", taxon_threshold * 100, "% missing data."))
			}
			print(sprintf("[Taxa] Retained %d of %d taxa.", sum(keep_taxa), nrow(matrix)))
		}
	}

	# ---- Character filtering ----
	if(filter %in% c("characters", "both")){

		char_ids <- if(!is.null(colnames(current_matrix))) colnames(current_matrix) else seq_len(ncol(current_matrix))

		prop_missing_chars <- apply(current_matrix, 2, function(col){
			sum(col == missing_char | is.na(col)) / length(col)
		})

		keep_chars <- prop_missing_chars < char_threshold
		excluded_char_ids <- char_ids[!keep_chars]

		excluded_chars_df <- data.frame(
			Character = excluded_char_ids,
			Proportion_missing = prop_missing_chars[!keep_chars],
			stringsAsFactors = FALSE
		)
		excluded_chars_df <- excluded_chars_df[order(-excluded_chars_df$Proportion_missing), ]
		rownames(excluded_chars_df) <- NULL

		current_matrix <- current_matrix[, keep_chars, drop = FALSE]

		if(isTRUE(verbose)){
			if(nrow(excluded_chars_df) > 0){
				print(sprintf("[Characters] Excluded %d characters with >= %.0f%% missing data:", nrow(excluded_chars_df), char_threshold * 100))
				print(excluded_chars_df)
			} else {
				print(paste0("[Characters] No characters excluded; all below ", char_threshold * 100, "% missing data."))
			}
			print(sprintf("[Characters] Retained %d of %d characters.", sum(keep_chars), ncol(matrix)))
		}
	}

	return(list(
		matrix = current_matrix,
		excluded_taxa = excluded_taxa_df,
		excluded_chars = excluded_chars_df,
		retained_taxa = rownames(current_matrix),
		retained_chars = if(!is.null(colnames(current_matrix))) colnames(current_matrix) else seq_len(ncol(current_matrix))
	))
}
