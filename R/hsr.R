### 2024-06-24

#### Homoplasy Slope Ratio 

# Migrated from https://github.com/LizzySteell/Homoplasy/blob/main/Functions/HSR()
# Steell EM, Hsiang AY, Field DJ. Revealing patterns of homoplasy in discrete phylogenetic datasets with a cross-comparable index. Zoological Journal of the Linnean Society. 2025 May;204(1):zlaf024.

### Reference: Meier R, Kores P, Darwin S. Homoplasy slope ratio: a better measurement of observed homoplasy in cladistic analyses. Systematic Zoology. 1991 Mar 1;40(1):74-88.

### Note: Mendler et al created a function for this, however formatting of that function was not compatible with others in this package.

#' Homoplasy slope ratio (HSR)
#'
#' Calculates the homoplasy slope ratio of Meier et al. (1991), or the
#' modified version (HSRm) described in Steell et al. (2025).
#'
#' @param data A `phyDat` object, e.g. from [morph_phydat()].
#' @param tree A tree of class `phylo`.
#' @param n Number of randomised matrices.
#' @param modified Logical. If `TRUE`, random matrices retain the missing data
#'   and other non-state scores ("noise") of the empirical matrix; if `FALSE`
#'   these are excluded.
#' @return A single numeric value, the HSR.
#' @references Meier R, Kores P, Darwin S (1991) Homoplasy slope ratio: a
#'   better measurement of observed homoplasy in cladistic analyses.
#'   Systematic Zoology 40(1):74-88.
#'
#'   Steell EM, Hsiang AY, Field DJ (2025) Revealing patterns of homoplasy in
#'   discrete phylogenetic datasets with a cross-comparable index. Zoological
#'   Journal of the Linnean Society 204(1):zlaf024.
#'
#'   Schliep KP (2011) phangorn: phylogenetic analysis in R. Bioinformatics
#'   27(4):592-593.
#' @section AI use:
#' The function code was written by the package author. The roxygen
#' documentation and the snake_case name were produced with GitHub Copilot
#' (Claude Sonnet 5.5); see `AI_USE.md`.
#' @export
hsr <- function(data, tree, n, modified=TRUE){
	
	# data - matrix of morphological data in phydat format (using morph_phydat)
	# tree - a phylogenetic tree of class 'phylo'
	# n - number of permutations of the matrix
	# modified - modified = TRUE indicates that the modified homoplasy slope ratio (HSRm; refer to manuscript) should be calculated or not. It refers to whether the 'noise' of an empirical matrix should be retained for the randomised matrices, which would include polymorphic states and missing data. If set to FALSE, the randomised matrices are generated 'without noise' so that they comprise only the actual character states for each character (no missing data, no polymorphisms), and are calculated in the way that the original HSR metric was designed for.
	
	# Calculate number of taxa
	t <- length(tree$tip.label)
	
	# Subfunction to do calculation for extra steps (necessary for later):
	extra_steps <- function(data, tree){
		(1/CI(tree, data)) - 1
	}
	
	# Calculate extra steps (ES) for empirical data
	ES <- extra_steps(data, tree)
	
	# Calculate homoplasy slope for empirical data
	HS <- ES/(t-3)
	
	
	# Change format of phydat to matrix
	matrix <- t(as.data.frame(data))
	
	if(modified == TRUE){
	
	# Generate random data with same number of taxa and characters. Each character state has equal probabilities, and each scoring (character state for specific character and taxon) is independent from any other scoring. This version of the function uses the exact scorings in the matrix, including polymorphisms and missing data.
	random_matrices <- replicate(n, apply(matrix, 2, sample, replace=TRUE), simplify=FALSE)
	
	}else{
		
		#If modified=FALSE then function excludes missing data and other non-state scorings (polymorphisms) (hereby called 'noise')
	
	#Get states per character
	states <- apply(matrix, 2, get_states, simplify=FALSE)
	
	# Generate random matrices
	
	random_matrices <- replicate(n, matrix(nrow=dim(matrix)[1], ncol=dim(matrix)[2]), simplify=FALSE)
	
	# subfunction to populate the matrices with states per character
		populate <- function(matrix, states){	
	for(k in 1:length(states)){
		matrix[,k] <- sample(states[[k]], size=dim(matrix)[1], 			replace=TRUE)
	}
	return(matrix)
	}
	
	# populate each random matrix
	
	random_matrices <- lapply(random_matrices, populate, states)
	
	}
	
	# Add row names
	rows <- c(tree$tip.label)
	for(i in 1:length(random_matrices)){
		row.names(random_matrices[[i]]) <- rows
	}
	
	# Create morphological phydats for each random matrix
	random_phydats <- lapply(random_matrices, morph_phydat)
	
	# Calculate ES for random matrices
	ES_random <- unlist(lapply(random_phydats, extra_steps, tree))
	
	# Calculate homoplasy slope for random datasets and calculate mean
	HS_random_mean <- mean(ES_random/(t-3))
	
	# Calculate homoplasy slope ratio
	hsr <- HS/HS_random_mean
	
	return(hsr)
	
	
}

################
