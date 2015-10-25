# Home dir
main.dir <- "G:/_R/Image Classification/shiny"

Results <- reactive({
        results.file <- "Results.RData"
        Results <- readRDS("Results.RData")
})

Perf <- reactive({
        perf.file <- "Perf.RData"
        Perf <- readRDS("Perf.RData")
})


library(shiny)
library(ggplot2)
library(dplyr)

shinyServer(
        function(input, output) {
                output$Accuracy <- renderPrint({round(Results()$accuracy.test[input$itr], 4)})
                output$TP <- renderPrint({Results()$TP[input$itr]})
                output$FP <- renderPrint({Results()$FP[input$itr]})
                output$FN <- renderPrint({Results()$FN[input$itr]})
                output$TN <- renderPrint({Results()$TN[input$itr]})
                output$Precision <- renderPrint({round(Results()$precision[input$itr], 4)})
                output$Recall <- renderPrint({round(Results()$recall[input$itr], 4)})
                output$F1 <- renderPrint({round(Results()$F1[input$itr], 4)})
                output$learn_curves <- renderPlot({
                        g <- ggplot(Results(), aes(x=N))
                        g <- g + geom_line(aes(y=accuracy.test), size = 0.5, color = "blue")
                        g <- g + geom_line(aes(y=accuracy.train), size = 0.5, color = "blue")
                        g <- g + geom_smooth(aes(y=accuracy.test), size = 1, method = "lm",  color = "blue")
                        g <- g + geom_point(aes(y=accuracy.train), color = "blue")
                        g <- g + geom_point(aes(y=accuracy.test), color = "blue")
                        g <- g + geom_vline(xintercept = input$itr, size = 1, color = "red")
                        g <- g + theme_bw()
                        g <- g + theme(plot.title = element_text(size = rel(3)))
                        g <- g + theme(axis.text = element_text(size = rel(1)))
                        g <- g + theme(axis.title = element_text(size = rel(2)))
                        g <- g + xlab("Size of the Training set")
                        g <- g + ylab("Accuracy")
                        g <- g + ggtitle("Learning Curves")
                        g
                })
                output$prob <- renderPlot({
                        g <- ggplot(filter(Perf(), iter == input$itr), aes(x = as.factor(img.num), y = Diff))
                        g <- g + geom_bar(aes(fill = Type), stat = 'identity', colour = 'black')
                        g <- g + scale_fill_manual(values=c("maroon", "red", "green", "lightgreen"))
                        g <- g + scale_y_sqrt()
                        g <- g + theme_bw()
                        g <- g + theme(plot.title = element_text(size = rel(3)))
                        g <- g + theme(axis.text = element_text(size = rel(1)))
                        g <- g + theme(axis.title = element_text(size = rel(2)))
                        g <- g + xlab("Images from the Testing set")
                        g <- g + ylab("Difference = Absolute(Prob Good - Prob Bad)")
                        g <- g + ggtitle("Show image difference")
                        g
                })
                output$Table <- renderTable({filter(Perf(), iter == input$itr)})
        }
)