##### 29-Oct-2025 rate.matrix() V1.0

### Rate index matrix builder for use in corHMM functions when a matrix for the rate category needs to be specified. This uses the phylodisc::get.states function.
### char: a single discrete character from a character taxon matrix, in matrix format.
### model: either the equal rates ("ER") or symmetric ("SYM") models of multistate character evolution.
### Notes: This function is intended to create rate matrices that specify the nature of character state transitions in an ordered multistate character.
###        The ER option constrains transitions between adjacent states to the same rate for all states, and transitions between non-adjacent states are not allowed.
###        The SYM option allows different but symmetrical rates between different pairs of adjacent states.
###        The output is matrix with rows and columns representing states (renumbered to follow formatting of corHMM).
###        This matrix does NOT contain or estimate the actual rate of change between character states within a character. It just specifies what is allowed in downstream calls (i.e., indicates what parameters are to be estimated in the corHMM analysis).

rate.index <- function(char, model="ER"){
states <- get.states(char)
names(states) <- c(1:length(states))
n <- length(states)

# Helper to create the rate matrix - function creation assisted by copilot
make.trans.matrix <- function(n, model) {
  mat <- matrix(NA, nrow = n, ncol = n)
  
  if (model == "ER") {
    for (i in 1:n) {
      for (j in 1:n) {
        if (abs(i - j) == 1) {
          mat[i, j] <- 1
        }
      }
    }
  } else if (model == "SYM") {
    for (i in 1:(n-1)) {
      mat[i, i+1] <- i
      mat[i+1, i] <- i
    }
  } else {
    stop("Unknown model type. Use 'ER' or 'SYM'.")
  }
  
  rownames(mat) <- paste0("(", 1:n, ")")
  colnames(mat) <- paste0("(", 1:n, ")")
  mat
}

rate_matrix <- make.trans.matrix(n, model)
return(rate_matrix)
}
