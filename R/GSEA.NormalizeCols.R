GSEA.NormalizeCols <-
function(V) {
 # Standardize columns of a gene expression matrix

 col.mean <- apply(V, MARGIN = 2, FUN = mean)
 col.sd <- apply(V, MARGIN = 2, FUN = sd)
 col.n <- length(V[1, ])
 for (i in 1:col.n) {
  if (col.sd[i] == 0) {
   V[, i] <- 0
  } else {
   V[, i] <- (V[, i] - col.mean[i])/col.sd[i]
  }
 }
 return(V)
}
