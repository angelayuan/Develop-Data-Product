library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Predict percentage of body fat"),
        sidebarPanel(
                helpText("Please fill in your information and then press the submit button."),
                helpText("Note: most information have a default value except weight and height.",
                        "At least, you need to fill in weight and height to get a prediction.",
                        "The more accurate your data, the more accurate the prediction."),
                
                sliderInput('age', 'Choose your age (years)',value = 30, min = 18, max = 81, step = 1,),
                
                selectInput("gender", "Gender", choices = c("Male","Female")),
                
                textInput(inputId='wt', label="Enter your Weight (lbs)"),
                textInput(inputId='ht', label="Enter your Height (inches)"),
                
                sliderInput('ct', 'Choose Chest Circumference (cm)',value = 100, min = 75, max = 140, step = 1,),
                sliderInput('abd', 'Choose Abdomen Circumference (cm)',value = 90, min = 65, max = 150, step = 1,),
                sliderInput('th', 'Choose Thigh Circumference(cm)',value = 55, min = 45, max = 90, step = 1,),
                sliderInput('fore', 'Choose Forearm  Circumference(cm)',value = 26, min = 20, max = 40, step = 1,),
                sliderInput('wrist', 'Choose Wrist Circumference(cm)',value = 18, min = 14, max = 22, step = 1,),
                
                submitButton('Submit')
        ),
        mainPanel(
               h3('In order to calculate the following indexes, you should enter your body measurements and submit the data.'),
               h4('Your BMI'),
               textOutput('bmiValue'),
               
               h4('Estimated Fat Free Weight (lbs)'),
               textOutput('ffwValue'),
               
               h4('Estimated Percent Body Fat (%)'),
               textOutput('bfValue'),
               
               h4('The following histogram provides the distribution of body fat of 252 males (for females, the prediction may not be as accurate as males are). 
                  After you submit your information, there will be a red line indicating your body fat. 
                  Check out whether you have too many body fat compared with the provided population.'),
               plotOutput('newHist')
              
        )
))