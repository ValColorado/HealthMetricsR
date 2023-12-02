library(httr)
library(jsonlite)

generateMealPlan <- function(calories, protein, fats) {
  apiKey <- "API-KEY"
  prompt <- paste("If I eat", calories, "calories per day with", protein, "grams of protein and", fats, "grams of fats, give me 5 food options and list their macros")

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

