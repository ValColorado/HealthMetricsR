library(shiny)
library(shinydashboard)
library(SciCompPackage)
library(plotly)  # Adding the plotly library


ui <- dashboardPage(

  dashboardHeader(title = "Health-MetricsR"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Measurements", tabName = "measurements", icon = icon("dashboard")),
      menuItem("Total Daily Energy Expenditure", tabName = "TDEE", icon = icon("gear"))
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
                      "Before we get started lets go over some key terms:",
                      "",
                      "",
                      "**Basic Metabolic Rate (BMR)**",
                      "",
                      "You burn calories even when resting through basic life-sustaining functions like breathing, circulation, nutrient processing, and cell production. This is known as basal metabolic rate (BMR).",
                      "",
                      "",
                      "You can calculate yours by going to the 'Measurements' tab! We calculate this by using the [Mifflin-St. Jeor equation](https://pubmed.ncbi.nlm.nih.gov/2305711/)"
                    )
                  )
                )
              )

      ),
      tabItem(tabName = "measurements",
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
                             value = 4
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
                     plotlyOutput("userComparisonPlot")  # Placeholder for the comparison plot
              )
      ),
      tabItem(tabName = "TDEE",
              h2("Welcome to the Settings Page!"),
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
      checkboxGroupInput(
        inputId = "workout",
        label = "Activity Level",
        choices = list(
          "Sedentary (little to no exercise):" = "1",
          "Lightly active (1-3 days a week)" = "2",
          "Moderately active (sports 3-5 days a week): " = "3",
          "Very active (sports 6-7 days a week): " = "4",
          "Extra active (training twice a day" = "5"
        )
      )
    )
  ),


              )

    )
  )
)

# Server logic
# Server logic
server <- function(input, output, session) {

  data <- read.csv("./../500_Person_Gender_Height_Weight_Index.csv")  # Replace this with your actual dataset file path

  observeEvent(input$calcMale, {
    weight_kg <- weight.kg(as.numeric(input$currentW))
    height_cm <- (as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInches) * 2.54)  # feet/inches to cm
    age <- as.numeric(input$age)

    bmr_male <- BMR_male.Mifflin(weight_kg, height_cm, age)
    bmr_male_rounded <- round(bmr_male, 2)

    print(bmr_male_rounded)
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
  })

  observeEvent(input$calcFemale, {
    weight_kg <- weight.kg(as.numeric(input$currentW))
    height_cm <- (as.numeric(input$heightFeet) * 30.48) + (as.numeric(input$heightInches) * 2.54)  # feet/inches to cm
    age <- as.numeric(input$age)
    print("here")
    print(weight_kg)
    print(height_cm)
    print(age)
    bmr_female <- BMR_female.Mifflin(weight_kg, height_cm, age)
    bmr_female_rounded <- round(bmr_female, 2)

    print(bmr_female_rounded)
    showModal(modalDialog(
      title = "BMR Calculation (Female)",
      paste("Your BMR (Female) based on Mifflin-St Jeor equation is:", bmr_female_rounded),
      paste(".....This means that if you were to rest all day and **not** engage in any physical activity, your body would require approximately: ",bmr_female_rounded," calories per day to maintain essential functions like breathing, circulating blood, regulating body temperature, and supporting organ function.")
    ))
    gender <- "Female"
    user_data <- data[data$Gender == gender, c("Weight", "Height")]
    plot <- plot_ly(data = user_data, x = ~Weight, y = ~Height, type = 'scatter', mode = 'markers',
                    marker = list(size = 10, opacity = 0.8)) %>%
      add_trace(x = weight_kg, y = height_cm, type = 'scatter', mode = 'markers',
                marker = list(size = 12, color = 'red', symbol = 'star'),
                name = 'Your Data')

    output$userComparisonPlot <- renderPlotly({
      plot
    })
  })
}

shinyApp(ui = ui, server = server)
