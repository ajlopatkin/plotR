#Install Packages

#install.packages("shiny")
#install.packages("shinyWidgets")
#install.packages("readxl")
#install.packages("DT")
#install.packages("ggplot2")



#Load Packages
library(shiny)
library(shinyWidgets)
library(readxl)
library(DT)
library(ggplot2)


#User Interface Object
ui <- fluidPage(
  
  titlePanel(p("PlotR", style = "color: #3474A7")),
  
  sidebarLayout(
    
    sidebarPanel(
      
      fileInput(
        inputId = "dataFile",
        label = "Upload data. Choose excel file.",
        accept = c(".xls", ".xlsx")
      ),
      
      selectInput(
        inputId = "plotType",
        label = "Select Plot Type",
        choices = c("Choose One", Bar = "barplot", Histogram = "hist", Scatter = "scatter", Pie = "pie", Line = "lines", Heatmap = "heatmap")
      ),
      
      #Histogram Option
      conditionalPanel(
        condition = "input.plotType == 'hist'",
        selectInput(
          "breaks", "Breaks", c("Sturges", "Scott", "Freedman-Diaconis", "Custom" = "custom")
        ),
        #Custom Option
        conditionalPanel(
          condition = "input.breaks == 'custom'",
          sliderInput("breakCount", "Break Count", min = 1, max = 50, value = 10)
        )
      ),
      
      #Scatter Plot Option
      conditionalPanel(
        condition = "input.plotType == 'scatter'",
        checkboxInput("fitLine", "Line of Best Fit", value = FALSE)
      ),
      
      #Line Graph Option
      conditionalPanel(
        condition = "input.plotType == 'lines'",
        checkboxInput("addPlot", "Compare With Another Dataset?", value = FALSE),
      ),
  
      p("Made by", a("Lopatkin Lab", href = "http://lopatkinlab.com/"), "."),
      img(
        src = "http://lopatkinlab.com/img/profile.png",
        width = "70px", height = "70px"
      )
      
    ),
    
    mainPanel(
      column(
        DTOutput(outputId = "table"), width = 5
      ),
      column(
        plotOutput("plot"), width = 7
      )
    )
    
  )
  
)


#Server
server <- function(input, output){
  data <- reactive({
    req(input$dataFile)
    read_excel(input$dataFile$datapath)
  })
  
  output$table <- renderDT(data())

  
  output$plot <- renderPlot({
    p <- data()
    
    if (input$plotType == "scatter"){
      plot(p$x, p$y, col='blue', main = "Scatter Plot", xlab = "x", ylab = "y")
      if (input$fitLine == TRUE){
        abline(lm(p$y ~ p$x), col='red', lty = 'dashed')
      }
    }
    
    if (input$plotType == "hist"){
      breaks <- input$breaks

      if (breaks == "custom"){
        breaks <- input$breakCount
      }

      hist(p$x, main = "Histogram", xlab = "x", ylab = "y", breaks = breaks, col='lightblue')
    }
    
    if (input$plotType == "lines"){
      plot(p$x, p$y, col='blue', type = "o", main = "Line Graph", xlab = "x", ylab = "y")
    }
    
  })
  
}


#Shiny App
shinyApp(ui = ui, server = server)




