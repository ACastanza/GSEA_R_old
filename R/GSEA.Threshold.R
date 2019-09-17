GSEA.Threshold <-
function(V, thres, ceil) {
 # Threshold and ceiling pre-processing for gene expression matrix

 V[V < thres] <- thres
 V[V > ceil] <- ceil
 return(V)
}
