calculate_nutrition_needs <- function(age, bmr, tdee) {
  # Calculate recommended calories per day (assuming slight calorie deficit for weight loss)
  recommended_calories <- tdee - 500  # Adjust as needed for specific goals
  recommended_calories <- switch(activity_multiplier,
                                    "1.2" = 500,   # Sedentary
                                    "1.375" = 750, # Lightly active
                                    "1.55" = 1000, # Moderately active
                                    "1.725" = 1250, # Very active
                                    "1.9" = 1500   # Extra active
  )
  # Calculate recommended fat intake (assuming 25% of total calories from fats)
  fat_calories <- 0.25 * recommended_calories
  recommended_fat_grams <- fat_calories / 9  # 1 gram of fat has 9 calories

  # Calculate recommended protein intake (assuming 20% of total calories from protein)
  protein_calories <- 0.20 * recommended_calories
  recommended_protein_grams <- protein_calories / 4  # 1 gram of protein has 4 calories

  # Return the calculated values
  return(list(
    Recommended_Calories = round(recommended_calories),
    Recommended_Fat_Grams = round(recommended_fat_grams),
    Recommended_Protein_Grams = round(recommended_protein_grams)
  ))
}
