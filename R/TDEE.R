calculate_weight_loss <- function(bmr, activity_multiplier, num_weeks = 20) {
  # Calculate calorie deficit based on activity level
  calorie_deficit_per_day <- switch(activity_multiplier,
                                    "1.2" = 500,   # Sedentary
                                    "1.375" = 750, # Lightly active
                                    "1.55" = 1000, # Moderately active
                                    "1.725" = 1250, # Very active
                                    "1.9" = 1500   # Extra active
  )

  # Calculate Total Daily Energy Expenditure (TDEE)
  tdee <- bmr * activity_multiplier

  # Calculate weekly calorie deficit and weight loss
  calorie_deficit_per_week <- calorie_deficit_per_day * 7
  weight_loss_per_week <- calorie_deficit_per_week / 3500  # 3500 calories = 1 pound of weight





  # Create a data frame to store the projected weight loss
  weeks <- seq(1, num_weeks)
  weight_loss <- cumsum(rep(weight_loss_per_week, num_weeks))
  weight_loss_data <- data.frame(Weeks = weeks, Weight_Loss = weight_loss)

  # Create a line plot
  plot_data <- plot(weight_loss_data$Weeks, weight_loss_data$Weight_Loss, type = 'o',
                    xlab = 'Weeks', ylab = 'Weight Loss', main = 'Weight Loss Over Time')


  #macros
  recommended_calories <- tdee - calorie_deficit_per_day

  # Calculate recommended fat intake (assuming 25% of total calories from fats)
  fat_calories <- 0.25 * recommended_calories
  recommended_fat_grams <- fat_calories / 9  # 1 gram of fat has 9 calories

  # Calculate recommended protein intake (assuming 20% of total calories from protein)
  protein_calories <- 0.20 * recommended_calories
  recommended_protein_grams <- protein_calories / 4  # 1 gram of protein has 4 calories


  return(list(table = weight_loss_data,
              plot = plot_data,
              calories=calorie_deficit_per_week,
              recommendedCalories = recommended_calories,
              recommendedFat = recommended_fat_grams,
              recommendedProtein = recommended_protein_grams
              ))
}
