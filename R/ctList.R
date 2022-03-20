#' Country and Territory List
#'
#' Generate a list of all the countries and territories in the list.
#'
#' @usage ctList()
#'
#' @author Joel Le Forestier (joel.leforestier@@mail.utoronto.ca)
#'
#' @export

ctList <- function(ct_code = 0) {
  #Load in the data and prepare arguments
  countrydat <- read.delim("https://github.com/joelleforestier/geoGuess/raw/main/countrydata.txt")

  return(countrydat$name)
}
