### 2024-02-08

### uncert_to_poly: A function to change uncertainties, denoted with curly brackets, to polymorphisms in a phylogenetic matrix

#' Convert uncertainties to polymorphisms
#'
#' Replaces uncertainties in curly braces (e.g. `{01}`) with polymorphisms in
#' round brackets (e.g. `(01)`).
#'
#' @param matrix Character matrix.
#' @return The matrix with curly-brace scores converted.
#' @examples
#' uncert_to_poly(matrix(c("0", "{01}"), ncol = 1))
#' @section AI use:
#' The function code was written by the package author. The roxygen
#' documentation and the snake_case name were produced with GitHub Copilot
#' (Claude Sonnet 5.5); see `AI_USE.md`.
#' @export
uncert_to_poly <- function(matrix) {
  # Define curly_extract function
  curly_extract <- function(x) {
    # Find characters within curly braces
    extracted <- gsub("[{}]", "", x)
    return(extracted)
  }
  
  scores <- rownames(table(matrix))
  
  # Extract uncertainties
  curly <- unlist(lapply(scores, curly_extract))
  
  if (length(curly) != 0) { # If uncertainties present
    for (i in curly) {
      round_value <- paste0("(", i, ")")
      matrix[matrix == paste0("{", i, "}")] <- round_value
    }
  }
  
  return(matrix)
}
