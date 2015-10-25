library(shiny)

shinyUI(fluidPage(
        titlePanel("Image classification"),
        sidebarLayout(
                sidebarPanel(
                        helpText("Analysis of Model performance"),
                        sliderInput('itr', 'Train set size:', value=405, min=1, max=405, step=1),
                        h4('Accuracy:'),
                        verbatimTextOutput("Accuracy"),
                        h4('True Positives:'),
                        verbatimTextOutput("TP"),
                        h4('False Positives:'),
                        verbatimTextOutput("FP"),
                        h4('False Negatives:'),
                        verbatimTextOutput("FN"),
                        h4('True Negatives:'),
                        verbatimTextOutput("TN"),
                        h6('* - Positive Class = Bad (B)'),
                        h4('Precision:'),
                        verbatimTextOutput("Precision"),
                        h4('Recall:'),
                        verbatimTextOutput("Recall"),
                        h4('F1 Score:'),
                        verbatimTextOutput("F1")
                ),
                
                mainPanel(
                        h4('Image classification project'),
                        h6('Classification model was created to classify images - bad/good automatically. This application helps to assess model performance. It contains results of 405 models. First result is based on 2 images in training set and next results gets by incrementing number of images by 1. Final model result based on 406 images in training set.'),
                        h6('By moving slides we can see performance metrics for each model.'),                        
                        tabsetPanel(
                                tabPanel("Learning Curves", 
                                         h6('By plotting learning curves we can assess how does the accuracy of a learning method change as a function of the training set size'),
                                         plotOutput('learn_curves', width = 1200, height = 600)), 
                                tabPanel("Summary",
                                         h6('One of the result of working Radial Basis Network algorithm is probability of each outcome class (we have got only two - Good and Bad). This plot is showing absolute difference Good and Bad probabilities. If it small them we can conclude that model not sure about whcih class should be for that image.'),
                                         h6('Additionally we can see which images was classified incorrectly as False Positives (FP) and False Negatives (FN)'),
                                         plotOutput('prob', width = 1200, height = 600)), 
                                tabPanel("Table", 
                                         h6('Detail Cross-Validation (CV) set information including probabilities of each class.'),
                                         tableOutput("Table"))
                        )
                )
        )
))