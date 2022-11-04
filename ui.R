

#Load Packages
library(readxl)
library(DT)
library(ggplot2)
library(colourpicker)

#Sources
#Plot Type
source('static/Bar.R')
source('static/Box.R')
source('static/Heatmap.R')
source('static/Line.R')
#source('static/Histogram.R')
source('static/ScatterPlot.R')

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
        #Heatmap = "heatmap"
        choices = c("Choose One", Bar = "bar", Box = "box", Line = "line", Scatter = "scatter")
      ),
      
      Bar,
      
      Box, 
      
      Heatmap,
      
      Line,
      
      #Histogram,
      
      Scatter,
      
      # textInput("xaxis", "Label the X-Axis", "X-Axis"),
      # #verbatimTextOutput("value")
      # 
      # textInput("yaxis", "Label the Y-Axis", "Y-Axis"),
      # #verbatimTextOutput("histyvalue")
      # 
      # colourInput("pcolor", NULL, "grey"),
      
      p("Made by", a("Lopatkin Lab", href = "http://lopatkinlab.com/"), "."),
      #img(
        #src = "http://lopatkinlab.com/img/profile.png",
        #width = "70px", height = "70px"
      #)
      
    ),
    
    mainPanel(
      
      #Display Table Upon Upload
      column(
        DTOutput(outputId = "table"), width = 5
      ),
      column(
        plotOutput("plot"), width = 7
      )
    )
    
  )
  
)
