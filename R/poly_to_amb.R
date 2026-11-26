### 2024-02-08

### poly_to_amb(): A function to change polymorphisms to ambiguities '?' in a matrix

#' Convert polymorphisms to ambiguities
#'
#' Replaces polymorphisms (round brackets) and uncertainties (curly brackets)
#' with `?`.
#'
#' @param matrix Character matrix.
#' @return The matrix with polymorphic scores replaced by `?`.
#' @examples
#' poly_to_amb(matrix(c("0", "(01)", "{12}", "1"), ncol = 1))
#' @section AI use:
#' The function code was written by the package author. The roxygen
#' documentation and the snake_case name were produced with GitHub Copilot
#' (Claude Sonnet 5.5); see `AI_USE.md`.
#' @export
poly_to_amb <- function(matrix){
	
	# matrix: Phylogenetic character matrix of class matrix array
	
	# First change uncertainties (curly brackets) to polymorphisms
	
	matrix <- uncert_to_poly(matrix)
	
#Make a subfunction to extract polymorphisms from parentheses - round brackets
	 	paren_extract <- function(x) {
    # Find characters within round brackets
     extracted <- gsub("[()]", "", x)
    return(extracted)}
		
		scores <- rownames(table(matrix))
		
		# Extract polies
		
		poly <- unlist(lapply(scores, paren_extract))

			
			if(length(poly) != 0){ #If polies present:
				
				## Puts the polies into a vector with brackets
				round_bracket <- parenthesize(poly)
				
				#Change polies to ambiguities
				for(i in 1:length(round_bracket)){
					matrix[matrix == round_bracket[i]] <- "?"
				}
				
				
				
			}
			return(matrix)
				}
