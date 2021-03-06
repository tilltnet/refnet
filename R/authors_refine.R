##################################################
##################################################
## 	BEGIN: authors_refine():
#' Refines the authors code output from authors_clean()
#'
#' \code{authors_refine} This function takes the author list output after the output has been synthesized for incorrect author matches. It contains a similarity score cutoff like read_authors. This however is to further constrain the list. New values ARE NOT created, instead it filters by the sim_score column in the output file. An output file is created using the 'root' argument that specifies the folder/file prefix for the output. The final file will be appended with '_final.csv'.
#'
#' @param review the `review` element from the list outputted by `authors_clean()`
#' @param prelim the `prelim` element from the list outputted by `authors_clean()`
#' @param  sim_score similarity score cut off point. Number between 0-1.
#' @param filename_root the filename root, can include relative or absolute
#'   path, to which "_authors.csv" and "_authors_references.csv" will be appended and the
## so what you need to do is take the authors file and change the names (no au and af), with addresses, title, and authors
#' @export authors_refine

authors_refine <- function(review, prelim, sim_score = NULL, filename_root = "") {
  ##########################################
  # Beginning Checks
  ##########################################
  if(length(review)==0 || is.null(review) || nrow(review)==0){  print('Authors data.frame is empty. This likely means there are no authors that need to be handchecked, outputting the prelim file.')
    output<-prelim
    return(output)}
  
    if (is.null(sim_score)) {
    sim_score <- min(review$similarity, na.rm = T)
  }

  ##########################################
  review$groupID[!is.na(review$similarity) & review$similarity < sim_score] <- review$authorID[!is.na(review$similarity) & review$similarity < sim_score]

  for (i in unique(review$authorID)) {
    # i<-unique(review$authorID)[2]

    if (length(review$authorID[review$authorID == i]) > 1) {
      print(paste0("Author ID: ", i, " is duplicated please change in the author file and re run"))
      break
    }

    prelim$groupID[prelim$authorID == i] <- review$groupID[review$authorID == i]
  }

  for (p in unique(prelim$groupID)) {
    prelim$AF[prelim$groupID == p] <- prelim$AF[sort(prelim$authorID[prelim$groupID == p])[1]]
  }
  colnames(prelim)
  data1 <- prelim[, c("authorID", "groupID", "AF", "author_order", "address", "university", "department", "postal_code",'city','state', "country", "RP_address", "RI", "OI", "UT", "refID", "PT", "PY", "PU")]
  colnames(data1)[colnames(data1) == "AF"] <- "author_name"

  # write it out
  if (filename_root != "") {
    utils::write.csv(data1,
      file = paste0(filename_root, "_authors_refined.csv"),
      row.names = FALSE
    )
  }
  #
  return(data1)
}
