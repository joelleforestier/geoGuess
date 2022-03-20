#' Guess the Country or Territory
#'
#' Generate a random image of a country or territory, guess its name, receive feedback, profit.
#'
#' @usage geoGuess()
#'
#' @param ct_code To pick up where you left off with a specific country or territory at some other time, optinally provide the CT Code corresponding to the country or territory you were guessing. The CT Code is provided at the start of each new round of the game.
#'
#' @author Joel Le Forestier (joel.leforestier@@mail.utoronto.ca)
#'
#' @export

geoGuess <- function(ct_code = 0) {
  #Load in the data and prepare arguments
  countrydat <- read.delim("https://github.com/joelleforestier/geoGuess/raw/main/countrydata.txt")
  attempt <- 0

  #Generate random or selected country
  if(ct_code == 0) {
    #Select a country
    country <- sample(countrydat$name, 1)

    #Generate country code
    ct_code <- c(sample(c(1:9), 3, replace = TRUE), which(countrydat$name == country), sample(c(1:9), 3, replace = TRUE))
  } else {
    #Select user-selected country
    country <- countrydat$name[as.numeric(substr(ct_code, 4, nchar(ct_code) - 3))]
  }

  #Display country and code
  plot(magick::image_read(paste0("https://raw.githubusercontent.com/teuteuf/worldle/37fd8f9c7cf44f7c05a8fac29384f507771145a7/public/images/countries/", tolower(countrydat$country[countrydat$name == country]), "/vector.svg")))
  message(paste0("Country Code: "), ct_code)

  #Ask for user guess
  guess <- readline(prompt = "Guess a country: ")

  #Gve user feedback and another chance to guess
  if(guess != country) {
    while(guess != country) {

      if(!guess %in% countrydat$name) {
        while(!guess %in% countrydat$name) {
          message("That country is not in the dataset. Double check your spelling or try another country.")
          guess <- readline(prompt = "Guess a country: ")
        }
      }

      #Calculate distance from correct country
      latdiff <- countrydat$latitude[countrydat$name == guess] - countrydat$latitude[countrydat$name == country]
      longdiff <- countrydat$longitude[countrydat$name == guess] - countrydat$longitude[countrydat$name == country]

      #Prepare feedback
      if(latdiff > 0) {
        latdir <- "north"
      } else if(latdiff < 0) {
        latdir <- "south"
      } else if(latdiff == 0) {
        latdir <- "north or south"
      }

      if(longdiff > 0 & longdiff < 180) {
        longdir <- "east"
      } else if(longdiff >= 180) {
        longdiff <- 360 - longdiff
        longdir <- "west"
      } else if(longdiff < 0 & longdiff > -180) {
        longdir <- "west"
      } else if(longdiff <= -180) {
        longdiff <- 360 + longdiff
        longdir <- "east"
      } else if(longdiff == 0) {
        longdir <- "east or west"
      }

      attempt <- attempt + 1

      #Provide feedback and solicit new guess
      mtext(text = "×", side = 2, adj = 1, col="red", line = 1 - attempt, cex = 2)

      guess <- readline(prompt = paste0("Your guess was ", round(abs(latdiff), 2), "° too far ", latdir, " and ", round(abs(longdiff), 2), "° too far ", longdir, ". Guess again: "))
    }
  }

  #Provide feebdack
  message("Great job!")
}