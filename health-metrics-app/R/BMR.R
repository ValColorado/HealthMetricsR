# BMR Calculator https://www.calculator.net/bmr-calculator.html

# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


#' Calculate your Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation
#'
#' @param weight  in kg
#' @param height in cm
#' @param age  age
#'
#' @return Your BMR calculation for male using Mifflin-St Jeor equation
#' @export
#'
#' @examples BMR_male.Mifflin(64,162.56,25)
#' @description
#' BMR is the estimated amount of energy the body burns at rest to maintain normal bodily functions such as breathing, digestion, and heart rate.
#' BMR is often used as a starting point for determining a person’s total daily energy expenditure, which takes into account a person’s physical activity level in addition to their BMR.
#'
#'
#'
BMR_male.Mifflin <- function(x,y,z) {


  #future idea add check to see if weight or height entered in wrong units

  return(10*x + 6.25*y - 5*z + 5)
}

#' Calculate your Basal Metabolic Rate (BMR) using the Mifflin-St Jeor equation
#'
#' @param weight in kg
#' @param height in cm
#' @param age  age
#'
#' @return Your BMR calculation for female using Mifflin-St Jeor equation
#' @export
#'
#' @examples BMR_female.Mifflin(64,162.56,25)
#' @description
#' BMR is the estimated amount of energy the body burns at rest to maintain normal bodily functions such as breathing, digestion, and heart rate.
#' BMR is often used as a starting point for determining a person’s total daily energy expenditure, which takes into account a person’s physical activity level in addition to their BMR.
#'
#'
#'
BMR_female.Mifflin <- function(x,y,z) {

  #future idea add check to see if weight or height entered in wrong units

 return(10*x + 6.25*y - 5*z - 161)

}

#' Calculate your Basal Metabolic Rate (BMR) using the Harris-Benedict Equation
#'
#' @param weight in kg
#' @param height in cm
#' @param age  age
#'
#' @return Your BMR calculation for male using the Harris-Benedict Equation
#' @export
#'
#' @examples BMR_male.Harris(64,162.56,25)
#' @description
#' BMR is the estimated amount of energy the body burns at rest to maintain normal bodily functions such as breathing, digestion, and heart rate.
#' BMR is often used as a starting point for determining a person’s total daily energy expenditure, which takes into account a person’s physical activity level in addition to their BMR.
#'
BMR_male.Harris <- function(x,y,z) {

  #future idea add check to see if weight or height entered in wrong units

  return(13.397*x + 4.799*y - 5.677*z + 88.362)


}

#' Calculate your Basal Metabolic Rate (BMR) using the Harris-Benedict Equation
#'
#' @param weight in kg
#' @param height in cm
#' @param age  age
#'
#' @return Your BMR calculation for male using the Harris-Benedict Equation
#' @export
#'
#' @examples BMR_female.Harris(64,162.56,25)
#' @description
#' BMR is the estimated amount of energy the body burns at rest to maintain normal bodily functions such as breathing, digestion, and heart rate.
#' BMR is often used as a starting point for determining a person’s total daily energy expenditure, which takes into account a person’s physical activity level in addition to their BMR.
#'
BMR_female.Harris <- function(x,y,z) {

  #future idea add check to see if weight or height entered in wrong units

  return(9.247*x + 3.098*y- 4.330*z + 447.593)



}
