.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
"##############################
GUESS THE COUNTRY OR TERRITORY
##############################

INSTRUCTIONS:
1. Run the geoGuess() function to begin the game.
2. Guess the name of the country or territory by typing your guess in the console.
3. Not all countries in the world are represented in the dataset, and not all entries represented in the dataset are countries.
   Run the ctList() function to view the list of countries and territories in the dataset.
4. To end the game (or the round of the game) without correctly guessing the country or territory, press escape.
4. If you want to continue a previous game, use the country's CT Code for the ct_code argument.
5. You have unlimited guesses. Your guesses are tallied on on the image of the country or territory.

CREDITS:
Country data adapted from: https://developers.google.com/public-data/docs/canonical/countries_csv (CC BY 4.0)
Country images from https://github.com/teuteuf/worldle/ (MIT License)"
  )
}
