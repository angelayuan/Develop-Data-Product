library(shiny)
#library(UsingR)
data(fat)

bmi <- function(ht, wt) (wt*0.4535)/(ht*0.0254)^2

ffw <- function(wt,bmi,ct,abd,th,fore,wrist) {
        fit <- lm(ffweight ~ weight + BMI + chest + abdomen + 
                          thigh + forearm + wrist, data = fat)
        x <- data.frame(weight=as.numeric(wt),BMI=as.numeric(bmi),
                        chest=as.numeric(ct),abdomen=as.numeric(abd),
                        thigh=as.numeric(th),forearm=as.numeric(fore),
                        wrist=as.numeric(wrist))
        predict(fit,newdata = x)
}

bfat <- function(wt,bmi,ffw,ct,abd,th,fore,wrist) {
        fit <- lm(body.fat ~ weight + BMI + ffweight + chest + abdomen + 
                          thigh + forearm + wrist, data = fat)
        x <- data.frame(weight=as.numeric(wt),BMI=as.numeric(bmi),
                        ffweight=as.numeric(ffw),chest=as.numeric(ct),
                        abdomen=as.numeric(abd),thigh=as.numeric(th),
                        forearm=as.numeric(fore),wrist=as.numeric(wrist))
        predict(fit,newdata = x)
}



shinyServer(
        function(input, output) {
                b <- reactive({bmi(as.numeric(input$ht),as.numeric(input$wt))}) 
                f <- reactive({ffw(as.numeric(input$wt),as.numeric(b()),
                         as.numeric(input$ct),as.numeric(input$abd),
                         as.numeric(input$th),as.numeric(input$fore),
                         as.numeric(input$wrist))})
                bf <- reactive({bfat(as.numeric(input$wt),as.numeric(b()),as.numeric(f()),
                     as.numeric(input$ct),as.numeric(input$abd),
                     as.numeric(input$th),as.numeric(input$fore),
                     as.numeric(input$wrist))})
                
                output$bmiValue <- renderPrint({b()})
                
                output$ffwValue <- renderPrint({
                        input$Submit
                        f()[[1]]
                })
                
                output$bfValue <- renderPrint({
                        input$Submit
                        bf()[[1]]
                })

                output$newHist <- renderPlot({
                       #input$Submit
                       hist(fat$body.fat, xlab='body fat', col='lightblue',main='Histogram')
                       lines(c(bf(), bf()), c(0, 200),col="red",lwd=5)
                })
                
        }
)