
### 20-Oct-2025'

### Function to adjust character numbers in a vector of ordered characters when characters have been excluded from the matrix, e.g. with 'remove_invar()'

# Created with help from Copilot (GPT-5 mini)

# Simple function: drop one or more global indices and return the adjusted vector without NAs.
# - ord: integer vector of original positions
# - exclude: integer vector of indices to remove from the global numbering (can include values not present)
# Returns: adjusted integer vector (same order as input, with excluded values removed and later values shifted down)

#' Adjust ordered-character numbers after removing characters
#'
#' Renumbers a vector of ordered characters after other characters have been
#' excluded from the matrix, e.g. by [remove_invar()].
#'
#' @param ord Integer vector of original positions of ordered characters.
#' @param exclude Integer vector of excluded original character positions.
#' @return Integer vector of ordered characters with excluded ones dropped and
#'   the remainder shifted to the new numbering.
#' @examples
#' adjust_ord(c(2, 5, 8), exclude = c(1, 5))
#' @export
adjust_ord <- function(ord, exclude = integer(0)) {
  ord <- as.integer(ord)
  exclude <- sort(unique(as.integer(exclude)))
  if (length(exclude) == 0) return(ord)

  # Remove any elements that are exactly excluded
  ord_kept <- ord[!ord %in% exclude]
  if (length(ord_kept) == 0) return(integer(0))

  # For each kept value v subtract the number of excluded indices <= v.
  # findInterval is fast and works because 'exclude' is sorted.
  shift_counts <- findInterval(ord_kept, exclude)
  new_vals <- ord_kept - shift_counts

  return(as.integer(new_vals))
}
