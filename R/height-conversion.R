# Height converter
#
# Since not everyone knows their height in cm and all the calculations will use cm this function will
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


height.cm <- function(x,y) {
    #x foot
    #y inches
    foot_in <- x *12
    inch <- foot_in + y
    return(inch*2.54)
}

