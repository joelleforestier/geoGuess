#' Guess the Country or Territory
#'
#' Generate a random image of a country or territory, guess its name, receive feedback, profit.
#'
#' @usage geoGuess()
#'
#' @param ct_code To pick up where you left off with a specific country or territory at some other time, optionally provide the CT Code corresponding to the country or territory you were guessing. The CT Code is provided at the start of each new round of the game.
#'
#' @author Joel Le Forestier (joel.leforestier@@mail.utoronto.ca)
#'
#' @export

geoGuess <- function(ct_code = 0) {
  #Load in the data and prepare arguments
  countrydat <- read.delim("https://github.com/joelleforestier/geoGuess/raw/main/countrydata.txt", na.strings = "xxxxx")
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
  message(paste0("CT Code: "), ct_code)

  #Ask for user guess
  guess <- readline(prompt = "Guess a country or territory: ")

  #Gve user feedback and another chance to guess
    while(tolower(guess) != tolower(country) & tolower(guess) != "i give up") {

        if(!tolower(guess) %in% tolower(countrydat$name)) {
          message("That country or territory is not in the dataset (many aren't!). Double check your spelling or try another country or territory.")
          guess <- readline(prompt = "Guess a country or territory: ")
        } else {

      #Calculate distance from correct country
      latdiff <- countrydat$latitude[tolower(countrydat$name) == tolower(guess)] - countrydat$latitude[tolower(countrydat$name) == tolower(country)]
      longdiff <- countrydat$longitude[tolower(countrydat$name) == tolower(guess)] - countrydat$longitude[tolower(countrydat$name) == tolower(country)]

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

      attempt <- attempt + .5

      #Provide feedback and solicit new guess
      mtext(text = "×", side = 2, adj = 1, col="red", line = 1 - attempt, cex = 2)
      guess <- readline(prompt = paste0("Your guess was ", round(abs(latdiff), 2), "° too far ", latdir, " and ", round(abs(longdiff), 2), "° too far ", longdir, ". Guess again: "))
        }
    }

  #Check if they gave up
  if (tolower(guess) == "i give up") {
    message(paste0("The answer was: ", country))
  } else {

    #Provide feebdack if they got it right
    message("🎉🎉🎉 Great job! 🎉🎉🎉")
  }
  }

