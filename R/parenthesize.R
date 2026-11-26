### 2024-06-18

### Small function to add curly brackets to an object in R and output a string. E.g. x = '01', returns '(01)'.
# Required for several functions including contrast.matrix()
# Replaces dependency on assertive or assertive.base package which are no longer available for recent versions of R.


#' Add round brackets to a string
#'
#' @param x Character vector.
#' @return `x` wrapped in round brackets.
#' @examples
#' parenthesize("01")
#' @export
parenthesize <- function(x){
	
	return(paste0("(",x,")"))
	
}
