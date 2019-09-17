GSEA.Gct2Frame <-
function(filename = "NULL") {
 ds <- read.table(filename, sep = "\t", comment.char = "", quote = "", stringsAsFactors = FALSE,
  fill = TRUE, header = F)
 return(ds)
}
