### 2024-01-29

# Cost matrix function

### This function builds a standard cost matrix for ordered morphological characters whereby one character state change between two character states that are adjacent in value 'costs' one step, but a change between states that are sequentially higher or lower in value cost an increasing number of steps.

#' Cost matrix for ordered characters
#'
#' Builds a cost matrix in which a change between adjacent states costs one
#' step and a change between non-adjacent states costs the number of steps
#' between them. Gaps are treated as missing data.
#'
#' @param data Character matrix with taxa as rows and characters as columns.
#' @return A square numeric matrix of state-change costs.
#' @examples
#' m <- matrix(c("0", "1", "2", "1"), ncol = 1)
#' cost_matrix(m)
#' @export
cost_matrix <- function(data)

# data - Phylogenetic matrix (in simple matrix array format) where row names are taxa and columns are characters. Gaps ('-') are treated as ambiguities ('?')

	{
		#Change all '-' values to '?'
	 	data[data == '-'] <- '?'
	 	
	 	#get character states
	 	
	 	states <- get_states(data)
	 	
	 	matrix <- matrix(nrow=length(states), ncol=length(states))
	 	
	 	dimnames(matrix) <- list(states, states)
	 	
	 	#fill in matrix
	 	
	 	for(i in 1:length(states)){
	 		
	 		for(j in 1:length(matrix[i,])){
	 			
	 			matrix[i,][j] <- j-i
	 		}
	 	}
	 	
	 	#Make values all positive
	 	
	 	matrix <- abs(matrix)
	 	
	}
