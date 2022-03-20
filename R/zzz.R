.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
"##############################
GUESS THE COUNTRY OR TERRITORY
##############################

INSTRUCTIONS:
1. Run the geoGuess() function to begin the game. Guess the name of the country or territory that appears in the plot viewer by typing your guess in the console.
2. Be mindful of spelling and capitalization. If you are unsure of how a country or territory is spelled in the dataset, or whether a country or territory is included in the dataset (as not all countries in the world are represented in the data and not all the entries in the dataset are countries), run the ctList() function to view the complete list of countries and territories as they are recorded in the dataset.
3. To end the game (or the round of the game) without correctly guessing the country or territory, press escape.
4. If you want to end the game and continue guessing the same country or territory at another time, record the CT Code provided to you at the start of the game and add it to the ct_code argument when you run the geoGuess function.
5. You have unlimited guesses. The number of incorrect guesses are recorded on on the image of the country or territory.

CREDITS:
Country data adapted from: https://developers.google.com/public-data/docs/canonical/countries_csv (CC BY 4.0)
Country images from https://github.com/teuteuf/worldle/ (MIT License)"
  )
}
