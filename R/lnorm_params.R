### 2026-Mar-25

### lnorm_params V1.0

### A function to estimate character state transition rates (using 'fitDiscrete' from geiger) per characters, and estimate
### parameters from log normally distributed rates (mean log and sd log) ready for input in whole-matrix simulation using 'sim.morpho' from dispRity.

### Arguments:
### 'matrix' must be a morphological matrix. Ambiguities are automatically excluded from estimations.
### 'tree' must have branch lengths and be fully bifurcating.

### Outputs:
### A list containing mean log and sd log values, and automatically outputs plots showing how transition rates fit the lognormal distribution.

### Notes: at present, function cannot handle polymorphic scorings or zero-length branches.

#' Log-normal parameters of character transition rates
#'
#' Fits an equal-rates model to each character and estimates the mean and
#' standard deviation of the log-normal distribution of transition rates, for
#' use in whole-matrix simulation with `dispRity::sim.morpho()`. Requires the
#' \pkg{geiger}, \pkg{fitdistrplus} and \pkg{TreeTools} packages. Polymorphic
#' scores and zero-length branches are not supported.
#'
#' @param matrix Character matrix; ambiguities (`?`) are excluded per character.
#' @param tree A fully bifurcating `phylo` tree with branch lengths.
#' @return A list with `mean_log` and `sd_log`. Also plots the fit.
#' @section AI use:
#' The function code was written by the package author. The roxygen
#' documentation and the snake_case name were produced with GitHub Copilot
#' (Claude Sonnet 5.5); see `AI_USE.md`.
#' @export
lnorm_params <- function(matrix, tree){

tips <- TreeTools::TipLabels(tree)
data <- matrix

#
#Omit the ambiguities "?" from each character so that the rates can be estimated appropriately.
omit_amb <- c()

for(i in 1:ncol(data)){
	omit_amb[[i]] <- data[,i][data[,i] !="?"]
}

#Estimate transition rates for each character

rates <- c()
for(j in 1:length(omit_amb)){
	rates[[j]] <- geiger::fitDiscrete(tree, omit_amb[[j]], model="ER") 
}

Qmatrices <- list()
for(i in 1:length(rates)){
	Qmatrices[[i]] <- geiger::as.Qmatrix(rates[[i]])
}

#Make a vector of the transition rates for one state change in each character
Qrates <- vector()
for(i in 1:length(Qmatrices)){
	Qrates[[i]] <- Qmatrices[[i]][2]
	}

logn <- fitdistrplus::fitdist(Qrates, "lnorm")
plot(logn)
summary(logn) #meanlog -4.811394 sdlog    1.055575

#save the shape and rate params
meanlog <- summary(logn)$estimate[[1]]
sdlog <- summary(logn)$estimate[[2]]
return(list("mean_log" = meanlog, "sd_log" = sdlog)) }
