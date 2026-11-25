### 2025-10-21
### uncert.to.amb(): convert uncertainties (curly braces {}) to ambiguities '?' but keep polymorphisms (round parentheses)
#
# This function scans a character matrix (or data.frame) and replaces any cell
# containing uncertainty notation using curly braces (e.g. "{01}", "{0 1}") with
# the ambiguity symbol '?' while leaving polymorphisms in round parentheses such
# as "(01)" intact.
#
# Input:
# - mat: matrix or data.frame with character scorings (taxa x characters)
# Output:
# - matrix (character) with curly-brace uncertainties replaced by '?'
#
uncert.to.amb <- function(mat){
  # Accept data.frame or matrix
  if (is.data.frame(mat)) {
    mat <- as.matrix(mat)
  }
  if (!is.matrix(mat)) stop("'mat' must be a matrix or data.frame of character scorings.")
  # Ensure character storage (avoid factor issues)
  mat[] <- as.character(mat)

  # Pattern for curly-brace uncertainty notation: { ... }
  pat_uncert <- "\\{[^}]*\\}"

  # Identify entries that match the uncertainty pattern and replace with '?'
  to_replace <- grepl(pat_uncert, mat, perl = TRUE)
  if (any(to_replace, na.rm = TRUE)) {
    mat[to_replace] <- "?"
  }

  return(mat)
}
