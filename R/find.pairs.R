#### 2026-Mar-25

### Function created by Neil Brocklehurst (https://neilbrocklehurst.weebly.com/analysis-of-constraint.html) and reproduced here with permission.
### For assembling taxon pairs from dissimilarity distance matrix and patristic distances for
### analyses of constraint through character state exhaustion.

### Citations: Original code derived from Brocklehurst N, Panciroli E, Benevento GL, Benson RB. Mammaliaform extinctions as a driver of the morphological radiation of Cenozoic mammals. Current Biology. 2021 Jul 12;31(13):2955-63.
###            See also: Brocklehurst N, Ford DP, Benson RB. Early origins of divergent patterns of morphological evolution on the mammal and reptile stem-lineages. Systematic Biology. 2022 Sep 1;71(5):1195-209.
###            Brocklehurst N, Benson RJ. Multiple paths to morphological diversification during the origin of amniotes. Nature Ecology & Evolution. 2021 Sep;5(9):1243-9.              

find.pairs<-function(morph.dist, groups, pat.dist)
{

	taxes.1<-vector(length=0)
	taxes.2<-vector(length=0)
	group.1<-vector(length=0)
	group.2<-vector(length=0)
	pair.morph<-vector(length=0)
	pair.pat<-vector(length=0)

	for(i in 1:nrow(morph.dist))
	{
		for(j in i:ncol(morph.dist))
		{
			if(i!=j)
			{
				tax.1<-rownames(morph.dist)[i]
				tax.2<-colnames(morph.dist)[j]

				taxes.1<-c(taxes.1,tax.1)
				taxes.2<-c(taxes.2,tax.2)

				group.1<-c(group.1,groups[which(groups[,1]==tax.1),2])
				group.2<-c(group.2,groups[which(groups[,1]==tax.2),2])	

				pair.morph<-c(pair.morph,morph.dist[tax.1,tax.2])
				pair.pat<-c(pair.pat,pat.dist[tax.1,tax.2])
			}
		}
	}
	
	results<-data.frame(taxes.1,taxes.2,group.1,group.2,pair.morph,pair.pat)
	colnames(results)<-c("Taxon 1","Taxon 2","Group 1","Group 2","Morphological distance","Patristic distance")

	return(results)
}	

# From https://neilbrocklehurst.weebly.com/uploads/1/2/2/3/122345875/constraint_functions.r
# https://neilbrocklehurst.weebly.com/analysis-of-constraint.html
