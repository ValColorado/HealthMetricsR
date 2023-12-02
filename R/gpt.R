#' ChatGPT Generated Meal Plan
#'
#' @param calories
#' @param protein
#' @param fats
#'
#' @return Uses ChatGPT API to create a custom meal plan based on a users desired calories, protien, and fats
#' @export
#'
#' @examples
#' generateMealPlan(1654, 90, 45)
#'
#'

library(shiny)
library(httr)
library(jsonlite)
generateMealPlan <- function(calories, protein, fats) {
  apiKey <- "API-KEY" #UPDATE THIS WITH YOUR API KEY
  prompt <- paste("If I eat", calories, "calories per day with", protein, "grams of protein and", fats, "grams of fats, give me food options and list their macros and a food recipes ideas next to each item")

  response <- POST(
    url = "https://api.openai.com/v1/chat/completions",
    add_headers(Authorization = paste("Bearer", apiKey)),
    content_type_json(),
    encode = "json",
    body = list(
      model = "gpt-3.5-turbo",
      temperature = 1,
      messages = list(list(
        role = "user",
        content = prompt
      ))
    )
  )

  content(response)
}

