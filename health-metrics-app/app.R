library(shiny)
library(shinydashboard)
library(MyFitnessFriend)
library(plotly)  # Adding the plotly library
library(ggplot2)
library(openintro)

ui <- dashboardPage(

  dashboardHeader(title = "MyFitnessFriend"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Measurements", tabName = "measurements", icon = icon("dashboard")),
      menuItem("Total Daily Energy Expenditure", tabName = "TDEE", icon = icon("person-walking")),
      menuItem("Macronutrients", tabName = "macro", icon=icon("utensils")),
      menuItem("Meal Plan", tabName = "gpt")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              h2("Welcome to the Home Page!"),
              p("This Shiny dashboard will use what I've learned throughout my masters program. Its main purpose is for health-conscious individuals and fitness enthusiasts, tailored to meet the analytical needs using R.\n"),
              grid_card(
                area = "area42",
                card_body(
                  markdown(
                    mds = c(
                      "Before we get started I want to say .. these are **generalized** guidelines and should be adjusted based on individual needs and goals. Consulting a nutritionist or dietitian could provide personalized recommendations.",
                      "",
                      "",
                      "Key Terms:",
                      "**Basic Metabolic Rate (BMR)**",
                      "",
                      "This is the amount of energy (measured in calories) that your body needs to function at rest, maintaining basic physiological functions like breathing, circulating blood, regulating body temperature, and supporting organ functions. It's the minimum number of calories your body requires to sustain itself while at rest.",
                      "",
                      "",
                      "You can calculate yours by going to the 'Measurements' tab! We calculate this by using the [Mifflin-St. Jeor equation](https://pubmed.ncbi.nlm.nih.gov/2305711/)",
                      "",
                      "",
                      "**Total Daily Energy Expenditure [TDEE](https://www.forbes.com/health/body/tdee-calculator/)**",
                      "",
                      "estimates the amount of energy (or number of calories) your body burns over a 24-hour period, factoring in how much energy it uses while at rest, your typical level of physical activity and the thermic effect of food metabolism."
                    )
                  )
                )
              )

      ),
      tabItem(
        tabName = "measurements",
        h2("Enter your measurements"),
        fluidRow(
          column(width = 3,
                 grid_card(
                   area = "area1",
                   card_body(
                     textInput(
                       inputId = "currentW",
                       label = "Enter your current weight",
                       value = "",
                       placeholder = "Enter your weight in lbs"
                     )
                     ,
                   )
                 )
          ),
          column(width = 3,
                 grid_card(
                   area = "area2",
                   card_body(
                     numericInput(
                       inputId = "heightFeet",
                       label = "Feet",
                       value = 5,
                       min = 5
                     ),
                     numericInput(
                       inputId = "heightInches",
                       label = "Inches",
                       value = ""
                     )
                   )
                 )
          ),
          column(width = 3,
                 grid_card(
                   area = "area4",
                   card_body(
                     textInput(
                       inputId = "age",
                       label = "Age",
                       value = "",
                       placeholder = "Enter your age"
                     ),
                   )
                 )
          ),
        ),
        column(width = 3,
               actionButton("calcMale", "Calculate BMR Male"),
               actionButton("calcFemale", "Calculate BMR Female")
        ),
        column(width = 6,
               plotlyOutput("userComparisonPlot")
        )
      ),
      tabItem(tabName = "TDEE",
              h2("TDEE"),
              grid_card(
                area = "area4",
                card_body(
                  markdown(
                    mds = c(
                      "Estimate of how many calories you burn in a day, considering your activity level.",
                      "",
                      ""
                    )
                  )
                )
              ),
              grid_card(
                area = "area3",
                card_body(
                  textInput(
                    inputId = "myTextInput",
                    label = "Enter BMR ",
                    value = "",
                    placeholder = "BMR from first tab"
                  ),
                  radioButtons(
                    inputId = "workout",
                    label = "Activity Level",
                    choices = list(
                      "Sedentary (little to no exercise):" = "1",
                      "Lightly active (1-3 days a week)" = "2",
                      "Moderately active (sports 3-5 days a week): " = "3",
                      "Very active (sports 6-7 days a week): " = "4",
                      "Extra active (training twice a day)" = "5"
                    ),
                    selected = NULL
                  ),
                  column(width = 3,
                         actionButton("calculateButtonTDEE", "Calculate Weight Loss")),
                  column(width = 7,
                         verbatimTextOutput("caloriesOutput")),
                  fluidRow(
                    column(width = 3,
                           tableOutput("weightLossTable")),
                    column(width = 6,
                           plotOutput("weightLossPlot")),),
                )
              ),


      ),
      tabItem(tabName = "macro",
              h2("Macronutrients"),
              grid_card(
                area = "area11",
                card_body(
                  textInput(
                    inputId = "myCaloriesInput",
                    label = "Enter Goal Calories ",
                    value = "",
                    placeholder = "Calories from second tab"
                  ),

                ),
                column(width = 6,
                       height=2,
                       actionButton("findMacros", "Find my macros!")
                ),
                column(
                  width = 12,
                  dataTableOutput("macrosTable"),
                  conditionalPanel(
                    condition = "input.findMacros > 0",
                    radioButtons(
                      inputId = "food",
                      label = "Food Options",
                      choices = list(
                        "Fast Food:" = "1",
                        "Individual Options" = "2"
                      ),
                      selected = NULL
                    ),
                    actionButton("new", "Lets Eat")
                  ),

                )
              )

      ),
      tabItem(tabName = "gpt",

              grid_card(
                area = "area11",
                card_body(
                  textInput(
                    inputId = "myCaloriesInputNew",
                    label = "Enter Goal Calories ",
                    value = "",
                    placeholder = "Calories from 3rd tab"
                  ),

                ),
                card_body(
                  textInput(
                    inputId = "myProtienInput",
                    label = "Enter Goal Protien ",
                    value = "",
                    placeholder = "Protien from 3rd tab"
                  ),

                ),
                card_body(
                  textInput(
                    inputId = "myFatInput",
                    label = "Enter Goal Fats ",
                    value = "",
                    placeholder = "Fat from 3rd tab"
                  ),

                ),
                column(width = 6,
                       height=2,
                       actionButton("chatGPT", "PLS WORK")
                ),
                dataTableOutput("gptTable")

              )

      )
    )
  )
)
# Server logic
server <- function(input, output, session) {

  data <- read.csv("./../500_Person_Gender_Height_Weight_Index.csv")
  food <- read.csv("food_data.csv")

  observeEvent(input$calcMale, {
    weight_kg <- weight.kg(as.numeric(input$currentW))
    height_cm <- (as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInches) * 2.54)  # feet/inches to cm
    age <- as.numeric(input$age)

    bmr_male <- BMR_male.Mifflin(weight_kg, height_cm, age)
    bmr_male_rounded <- round(bmr_male, 2)

    showModal(modalDialog(
      title = "BMR Calculation (Male)",
      paste("Your BMR (Male) based on Mifflin-St Jeor equation is:", bmr_male_rounded),
      paste(".....This means that if you were to rest all day and **not** engage in any physical activity, your body would require approximately: ",bmr_male_rounded," calories per day to maintain essential functions like breathing, circulating blood, regulating body temperature, and supporting organ function.")

    ))

    gender <- "Male"
    user_data <- data[data$Gender == gender, c("Weight", "Height")]
    plot <- plot_ly(data = user_data, x = ~Weight, y = ~Height, type = 'scatter', mode = 'markers',
                    marker = list(size = 10, opacity = 0.8)) %>%
      add_trace(x = weight_kg, y = height_cm, type = 'scatter', mode = 'markers',
                marker = list(size = 12, color = 'red', symbol = 'star'),
                name = 'Your Data')

    output$userComparisonPlot <- renderPlotly({
      plot
    })

    updateTextInput(session, "myTextInput", value = as.character(bmr_male_rounded))


  })

  observeEvent(input$calcFemale, {
    weight_kg <- weight.kg(as.numeric(input$currentW))
    height_cm <- (as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInches) * 2.54)  # feet/inches to cm
    age <- as.numeric(input$age)

    bmr_female <- BMR_female.Mifflin(weight_kg, height_cm, age)
    bmr_female_rounded <- round(bmr_female, 2)

    showModal(modalDialog(
      title = "BMR Calculation (Female)",
      paste("Your BMR (Female) based on Mifflin-St Jeor equation is:", bmr_female_rounded),
      paste(".....This means that if you were to rest all day and **not** engage in any physical activity, your body would require approximately: ",bmr_female_rounded," calories per day to maintain essential functions like breathing, circulating blood, regulating body temperature, and supporting organ function.")
    ))
    gender <- "Female"
    user_data <- data[data$Gender == gender, c("Weight", "Height")]
    plot <- plot_ly(data = user_data, x = ~Weight, y = ~Height, type = 'scatter', mode = 'markers',name = "Sample Data",
                    marker = list(size = 10, opacity = 0.8)) %>%
      add_trace(x = weight_kg, y = height_cm, type = 'scatter', mode = 'markers',
                marker = list(size = 12, color = 'red', symbol = 'star'),
                name = 'Your Data')

    output$userComparisonPlot <- renderPlotly({
      plot
    })

    updateTextInput(session, "myTextInput", value = as.character(bmr_female_rounded))

  })



  observeEvent(input$calculateButtonTDEE, {


    bmr <<- as.numeric(input$myTextInput)
    activity_multiplier <- as.numeric(input$workout)
    activity_multiplier <<- switch(input$workout,
                                   "1" = 1.2,
                                   "2" = 1.375,
                                   "3" = 1.55,
                                   "4" = 1.725,
                                   "5" = 1.9)
    # Calculate TDEE (Total Daily Energy Expenditure) based on activity level

    tdee <- bmr * activity_multiplier

    # Calculate weight loss projections
    num_weeks <<- 20  # Default number of weeks
    weight_loss_data <- (calculate_weight_loss(bmr, activity_multiplier, num_weeks))$table
    remaining_calories_per_week <- calculate_weight_loss(bmr, activity_multiplier, num_weeks)$calories

    showModal(modalDialog(
      title = "Calories",
      paste("To lose weight at the displayed rate you need to burn", remaining_calories_per_week," per week"),

    ))

    solution<<-calculate_weight_loss(bmr, activity_multiplier, num_weeks)

    output$weightLossTable <- renderTable({
      calculate_weight_loss(bmr, activity_multiplier, num_weeks)$table
    })
    output$weightLossPlot <- renderPlot({
      calculate_weight_loss(bmr, activity_multiplier, num_weeks)$plot
    })


    updateTextInput(session, "myCaloriesInput", value = as.character(solution$recommendedCalories))
    updateTextInput(session, "myCaloriesInputNew", value = as.character(solution$recommendedCalories))



  })

  observeEvent(input$findMacros, {


    df <- data.frame(
      Calories = solution$recommendedCalories,
      Fat = solution$recommendedFat,
      Protein = solution$recommendedProtein
    )

    output$macrosTable <- renderDataTable({
      df
    })



    observeEvent(input$new, {
      if (input$new > 0) {
        if (input$food == "1") {
          fastfood <- openintro::fastfood
          df <- data.frame(
            Calories = solution$recommendedCalories,
            Fat = solution$recommendedFat,
            Protein = solution$recommendedProtein
          )
          protein_threshold <- as.numeric(df$Protein)

          # Filter fast_food dataset based on protein threshold
          filtered_fast_food <- fastfood[fastfood$protein <= protein_threshold, ]

          # Filter and display at least 5 options from each restaurant that meet the protein condition
          output$macrosTable <- renderDataTable({
            restaurant_options <- by(filtered_fast_food, filtered_fast_food$restaurant, function(subset) {
              subset[subset$protein <= protein_threshold, ][1:min(5, nrow(subset)), ]
            })
            do.call(rbind, restaurant_options)
          })
        }
        else if(input$food == "2"){
          output$macrosTable <- renderDataTable({
            food
          })
        }else {
          df <- data.frame(
            Calories = solution$recommendedCalories,
            Fat = solution$recommendedFat,
            Protein = solution$recommendedProtein
          )

          output$macrosTable <- renderDataTable({
            df
          })
        }
      }
    })
    updateTextInput(session, "myProtienInput", value = as.character(solution$recommendedProtein))
    updateTextInput(session, "myFatInput", value = as.character(solution$recommendedFat))
  })
  observeEvent(input$chatGPT, {
    if (input$chatGPT > 0) {

      showModal(modalDialog(
        title = "Good things come to those who wait",
        paste("Coming up with a custom meal plan based on caloreis:",solution$recommendedCalories ," Protien: ",solution$recommendedProtein, "Fats",solution$recommendedFat),

      ))

      mealPlan <- generateMealPlan(solution$recommendedCalories, solution$recommendedProtein, solution$recommendedFat)

      mealContent <- sapply(mealPlan$choices, function(choice) {
        choice$message$content
      })

      # Creating a data frame with the concatenated content
      mealPlanDF <- data.frame(Food = unlist(strsplit(mealContent, "\n\n")))

      output$gptTable <- renderDataTable({
        mealPlanDF
      })
    }

  })
}

shinyApp(ui = ui, server = server)
