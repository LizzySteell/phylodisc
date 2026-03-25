### 2026-Mar-25

### lnorm.params V1.0

### A function to estimate character state transition rates (using 'fitDiscrete' from geiger) per characters, and estimate
### parameters from log normally distributed rates (mean log and sd log) ready for input in whole-matrix simulation using 'sim.morpho' from dispRity.

### Arguments:
### 'matrix' must be a morphological matrix. Ambiguities are automatically excluded from estimations.
### 'tree' must have branch lengths and be fully bifurcating.

### Outputs:
### A list containing mean log and sd log values, and automatically outputs plots showing how transition rates fit the lognormal distribution.

### Notes: at present, function cannot handle polymorphic scorings or zero-length branches.

lnorm.params <- function(matrix, tree){

tips <- TipLabels(tree)
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
	rates[[j]] <- fitDiscrete(tree, omit_amb[[j]], model="ER") 
}

Qmatrices <- list()
for(i in 1:length(rates)){
	Qmatrices[[i]] <- as.Qmatrix(rates[[i]])
}

#Make a vector of the transition rates for one state change in each character
Qrates <- vector()
for(i in 1:length(Qmatrices)){
	Qrates[[i]] <- Qmatrices[[i]][2]
	}

logn <- fitdist(Qrates, "lnorm")
plot(logn)
summary(logn) #meanlog -4.811394 sdlog    1.055575

#save the shape and rate params
meanlog <- summary(logn)$estimate[[1]]
sdlog <- summary(logn)$estimate[[2]]
return(list("mean_log" = meanlog, "sd_log" = sdlog)) }
