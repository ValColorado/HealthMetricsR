# Weight converter
#
# Since not everyone knows their weight in kilograms and all the calculations will use KG this function will
# convert their weight for them
#
# Calculating your macros involves determining the appropriate proportions of macronutrients
#(protein, carbohydrates, and fats) based on your goals.
#To calculate macros for weight loss or gain based on your current height, weight, and goal weight,

# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


#' Weight Conversion Pounds to Kilograms
#'
#' @param x your weight in pounds
#'
#' @return inputted weight in kilograms
#' @export
#'
#' @examples weight.kg(125) should return 56.69
weight.kg <- function(x) {
  # input weight in pounds to return in kg
  return(x / 2.20462)
}

#' Weight Conversion Kilograms to Pounds
#'
#' @param x weight in kilogram
#'
#' @return weight in pounds
#' @export
#'
#' @examples weight.lb(56.69) should return 125
weight.lb <-function(x){
  # input weight in kg to return in lb
  return(x * 2.20462)
}
