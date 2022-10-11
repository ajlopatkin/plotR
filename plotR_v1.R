#install.packages("shiny")
#install.packages("ggplot2")
#install.packages("forcats")
#install.packages("colourpicker")
#install.packages("ggpmisc")
#install.packages("raster")
#install.packages("ggplotify")
#install.packages("pheatmap")
library(shiny)
library(shinyWidgets)
library(ggplot2)
library(forcats)
library(readxl)
library(colourpicker)
library(ggpmisc)
library(raster)
#library("RColorBrewer")
library(plyr)
library(ggplotify)
library(pheatmap)
library(gplots)
library(grid)


ui <- fluidPage(

  navbarPage("plotR", 
             tabPanel("Upload",
                      fileInput("files", "Upload files", multiple=TRUE)),
             tabPanel("Bar Plot",
                      titlePanel(title=h4("Bar Plot", align="center")),
                      sidebarLayout(
                        sidebarPanel(
                          textInput("title", "Plot Title", ""),
                          selectInput("X_axis1",
                                      "Select x variable",
                                      NULL),
                          textInput("xlabel", "X Axis Label", ""),
                          numericInput("xTickSlant", "X tick direction", 0.0, min=0.0, max=180.0),
                          
                          selectInput("Y_axis1",
                                      "Select y variable",
                                      NULL),
                          textInput("ylabel", "Y Axis Label", ""),
                          numericInput("yTickSlant", "Y tick direction", 0.0, min=0.0, max=180.0),
                          
                          numericInput("barWidthb", "Bar width", 1, min=0.9, max=10),
                          
                          numericInput("axisLineSize", "Axis Thickness", 0.0, min=0.0, max=180.0),
                          colourInput("axisColor", "Axis Color", "black", allowTransparent = TRUE),
                        
                          
                          checkboxInput("doFill", "Add Fill?", value = FALSE),
                          conditionalPanel(condition="input.doFill==1",
                                           selectInput("fill_var11",
                                                       "Select grouping variable",
                                                       NULL),
                                           selectInput("barStyle", "Bar Style",
                                                       choices=c("Grouped"="dodge", "Stacked"="stack", "Precent"="fill")),
                                           textInput("legendLabel", "Legend Label", ""),
                                           selectInput("barColor", "Bar Color Theme",
                                                       choices=c("Default"= "default", "YlOrRd(9)"="YlOrRd", "YlOrBr(9)"= "YlOrBr", "YlGnBu(9)"="YlGnBu",
                                                                 "YlGn(9)"="YlGn", "Reds(9)"="Reds", "RdPu(9)"="RdPu", "Purples(9)"="Purples",
                                                                 "PuRd(9)"="PuRd", "PuBuGn(9)"="PuBuGn", "PuBu(9)"="PuBu", "OrRd(9)"="OrRd",
                                                                 "Organges(9)"="Oranges", "Greys(9)"="Greys", "Greens(9)"="Greens",
                                                                 "GnBu(9)"="GnBu","BuPu(9)"="BuPu", "BuGn(9)"="BuGn", "Blues(9)"="Blues",
                                                                 "Set3(12)"="Set3", "Set2(8)"="Set2", "Set1(9)"="Set1", "Pastel2(8)"="Pastel2",
                                                                 "Pastel1(9)"="Pastel1", "Paired(12)"="Paired", "Dark2(8)"="Dark2","Accent(8)"="Accent",
                                                                 "Spectral(11)"="Spectral","RdYlGn(11)"="RdYlGn", "RdYlBu(11)"="RdYlBu", "RdGy(11)"="RdGy",
                                                                 "RdBu(11)"="RdBu","PuOr(11)"="PuOr", "PRGn(11)"="PRGn", "PiYG(11)"="PiYG","BrBG(11)"="BrBG")),
                                           selectInput("legendLocation", "LegendLocation",
                                                       choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none")),
                          ),
                          
                          # checkboxInput("barLabel", "Add Bar Label?", value = FALSE),
                          # conditionalPanel(condition="input.barLabel==1",
                          #                  selectInput("barLabelLocation", "Bar Label Position",
                          #                              choices=c("Above Bar"= -0.3, "Inside Bar"=1.6)),
                          #                  colourInput("barLabelColor", "Bar Label Color", "black", allowTransparent = TRUE),
                          #                  numericInput("barLabelSize", "Bar Label Size", 3.5, min=1.0, max=10.0)
                          # ),
                          
                          
                          
                          helpText("Additional Customizations"),
                          checkboxInput("flipCoord", "Horizontal Plot?", value = FALSE),
                          checkboxInput("xText", "X Axis Text?", value = TRUE),
                          checkboxInput("yText", "Y Axis Text?", value = TRUE),
                          checkboxInput("backroundGrey", "Grey Backround?", value = FALSE),
                          checkboxInput("gridLines", "Grid Lines?", value = FALSE),
                          
                          
                          actionButton("plotBar", "Plot")
                        ),
                        mainPanel(
                          plotOutput("bar"),
                          downloadButton(outputId = "saveBar", label = "Download plot")
                        )
                      )),
             
             
             tabPanel("Heatmap",
                      titlePanel(title=h4("Heatmap", align="center")),
                      sidebarLayout(
                        sidebarPanel(
                          textInput("titlep", "Plot Title", ""),
                          textInput("xlabelp", "X Axis Label",""),
                          fluidRow(
                            column(4, numericInput("horizX", "Horizontal X adjustments",0, min=-100, max=10000)),
                            column(4, numericInput("vertX", "Vertical X adjustments",0, min=-100, max=10000)),
                          ),
                          textInput("ylabelp", "Y Axis Label",""),
                          fluidRow(
                            column(4, numericInput("horizY", "Horizontal Y adjustments",0, min=-100, max=10000)),
                            column(4, numericInput("vertY", "Vertical Y adjustments",0, min=-100, max=10000)),
                          ),
                          
                          
                          helpText("Range of column numbers for X axis"),
                          fluidRow(
                            column(4, numericInput("leftX", "Left column",NULL, min=0, max=10000)),
                            column(4, numericInput("rightX", "Right column",NULL, min=0, max=10000)),
                          ),
                          
                          selectInput("Y_axis2", "Select y variable", NULL),
                          
                          selectInput("hmColor", "Heatmap color",
                                      choices=c("Default" = "default","Theme"="theme", "Custom gradient"="gradient")),
                          conditionalPanel(condition="input.hmColor=='theme'",
                                           selectInput("hmTheme", "Heatmap Theme Color",
                                                       choices=c("YlOrRd(9)"="YlOrRd", "YlOrBr(9)"= "YlOrBr", "YlGnBu(9)"="YlGnBu",
                                                                 "YlGn(9)"="YlGn", "Reds(9)"="Reds", "RdPu(9)"="RdPu", "Purples(9)"="Purples",
                                                                 "PuRd(9)"="PuRd", "PuBuGn(9)"="PuBuGn", "PuBu(9)"="PuBu", "OrRd(9)"="OrRd",
                                                                 "Organges(9)"="Oranges", "Greys(9)"="Greys", "Greens(9)"="Greens",
                                                                 "GnBu(9)"="GnBu","BuPu(9)"="BuPu", "BuGn(9)"="BuGn", "Blues(9)"="Blues",
                                                                 "Set3(12)"="Set3", "Set2(8)"="Set2", "Set1(9)"="Set1", "Pastel2(8)"="Pastel2",
                                                                 "Pastel1(9)"="Pastel1", "Paired(12)"="Paired", "Dark2(8)"="Dark2","Accent(8)"="Accent",
                                                                 "Spectral(11)"="Spectral","RdYlGn(11)"="RdYlGn", "RdYlBu(11)"="RdYlBu", "RdGy(11)"="RdGy",
                                                                 "RdBu(11)"="RdBu","PuOr(11)"="PuOr", "PRGn(11)"="PRGn", "PiYG(11)"="PiYG","BrBG(11)"="BrBG"))
                                           ),
                          conditionalPanel(condition="input.hmColor=='gradient'",
                                           colourInput("startColor", "Axis Color", "black", allowTransparent = TRUE),
                                           colourInput("midColor", "Axis Color", "black", allowTransparent = TRUE),
                                           colourInput("endColor", "Axis Color", "black", allowTransparent = TRUE)
                                           ),
                        
                          
                          checkboxInput("rowAnno","Add row annotation", value=FALSE),
                          conditionalPanel(condition="input.rowAnno==1",
                                           textInput("annoLabel", "Row annotation label", ""),
                                           selectInput("anno1", "Row annotation variable", NULL)
                                           ),
                          
                          # selectInput("annoRow",
                          #             "Row annotations",
                          #             NULL, multiple=TRUE),
                          
                          
                          checkboxInput("scale", "Scale columns", value=FALSE),
                          checkboxInput("clusterCols", "Cluster columns", value = FALSE),
                          conditionalPanel(condition= "input.clusterCols==1",
                                           numericInput("numCols", "Facet: number of columns", 1, min=1, max=1000)),
                          
                          checkboxInput("clusterRows", "Cluster rows", value = FALSE),
                          conditionalPanel(condition = "input.clusterRows==1",
                                           numericInput("numRows", "Facet: number of rows", 1, min=1, max=1000)),
                          
                          checkboxInput("cellLab", "Label cells by value", value=FALSE),
                          conditionalPanel(condition="input.cellLab==1",
                                          # numericInput("decimals", "Decimal places", NULL, min=0, max=10),
                                           colourInput("cellTColor", "Text color", "black", allowTransparent = TRUE),
                                           numericInput("cellTSize", "Text size", 5.0, min=0.0, max=50.0)),
                          
                          checkboxInput("rowNames","Show row names", value=TRUE),
                          conditionalPanel(condition="input.rowNames==1",
                                           numericInput("rowFontSize", "Text size", 10, min=0.0, max=50.0)
                                           ),
                          checkboxInput("colNames", "Show column names", value=TRUE),
                          conditionalPanel(condition = "input.colNames==1",
                                           selectInput("colAngle", "Column label slant",
                                                       choices=c(0, 45, 90, 270, 315)),
                                           numericInput("colFontSize", "Text size", 10, min=0.0, max=50.0)),
                          
                          
                          # selectInput("X_axis2", 
                          #             "Select x variable",
                          #             NULL),
                          # textInput("xlabel", "X Axis Label", ""),
                          # 
                          # selectInput("Y_axis2", 
                          #             "Select y variable",
                          #             NULL),
                          # textInput("ylabel", "Y Axis Label", ""),
                          # 
                          # selectInput("fill_var12", "Select fill variable", NULL),
                          # 
                          # selectInput("color", "Select color theme",
                          #             choices=c("YlOrRd"="YlOrRd", "YlOrBr"="YlOrBr", "YlGnBu"="YlGnBu", "YlGn"="YlGn")),
                          # 
                          # checkboxInput("doFacet", "Facet?", value = FALSE),
                          # conditionalPanel(condition="input.doFacet==1",
                          #                  selectInput("facetVarX2", 
                          #                              "Select X facet variable",
                          #                              NULL),
                          #                  selectInput("facetVarY2", 
                          #                              "Select Y facet variable",
                          #                              NULL))
                          # ,
                          # textInput("legendLabel", "Legend Label", ""),
                          # 
                          # # selectInput("legendLocation", "LegendLocation",
                          # #             choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none")),
                          # # numericInput("axisLabelSize", "Axis Label Font Size", 12, min=1, max=50),
                          # 
                          # 
                          # 
                          # 
                          # 
                          # 
                          # helpText("Additional Customizations"),
                          # 
                          # checkboxInput("xText", "X Axis Text?", value = TRUE),
                          # checkboxInput("yText", "Y Axis Text?", value = TRUE),
                          # checkboxInput("clusterRow", "Cluster Rows?", value = FALSE),
                          # checkboxInput("clusterCol", "Cluster Col?", value = FALSE),
                          actionButton("plotHM", "Plot")
                        ),
                        
                        mainPanel(
                          plotOutput("heatmap"),
                        
                        )
                        
                      )
             ),
             
             tabPanel("Histogram",
                      titlePanel(title=h4("Histogram", align="center")),
                      sidebarLayout(
                        sidebarPanel(
                          cat("test6\n"),
                          textInput("title", "Plot Title", ""),
                          selectInput("X_axis3", 
                                      "Select x variable",
                                      NULL),
                          textInput("xlabel", "X Axis Label", ""),
                          selectInput("fill_var13", "Select grouping variable", NULL),
                          
                          # checkboxInput("doFill", "Add Fill?", value = FALSE),
                          # conditionalPanel(condition="input.doFill==1",
                          #                  selectInput("fill_var13", 
                          #                              "Select grouping variable",
                          #                              NULL),
                          #                  textInput("legendLabel", "Legend Label", ""),
                          #                  selectInput("legendLocation", "LegendLocation",
                          #                              choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none")),
                          # ),
                          
                          checkboxInput("barLabel", "Add Bar Label?", value = FALSE),
                          conditionalPanel(condition="input.barLabel==1",
                                           selectInput("barLabelLocation", "Bar Label Position",
                                                       choices=c("Above Bar"= -0.3, "Inside Bar"=1.6)),
                                           #colourInput("barLabelColor", "Bar Label Color", "black", allowTransparent = TRUE),
                                           numericInput("barLabelSize", "Bar Label Size", 3.5, min=1.0, max=10.0)
                          ),
                          
                          numericInput("binSize", "Bin width", 1, min=0.0, max=100),
                          
                          helpText("Additional Customizations"),
                          checkboxInput("facetHist", "Facet?", value = FALSE),
                          checkboxInput("flipCoord", "Horizontal Plot?", value = FALSE),
                          checkboxInput("backroundGrey", "Grey Backround?", value = FALSE),
                          checkboxInput("gridLines", "Grid Lines?", value = FALSE),
                          
                          
                          actionButton("plotHist", "Plot")
                          
                        ),
                        mainPanel(
                          plotOutput("hist")
                        )
                      )),
             
             tabPanel("Scatterplot", 
                      titlePanel( title = h4("Scatter Plot", align="center")),
                      sidebarLayout(
                        sidebarPanel(
                          textInput("titles", "Plot Title", ""),
                          selectInput("X_axis4", 
                                      "Select x variable",
                                      NULL),
                          textInput("xlabels", "X Axis Label", ""),
                          selectInput("xTransform", "X Axis Transformatiom",
                                      choices = c("None"="none", "Log2"='log2', "Log10"='log10', "Sqrt"='sqrt')),
                          numericInput("xTickSlants", "X text direction", 0.0, min=0.0, max=180.0),
                          numericInput("xTextHeight", "X text height adjustment", 0.0, min=-10.0, max=10.0),
                          fluidRow(
                            column(4, numericInput("xMin", "X Minimum",NULL, min=0, max=10000)),
                            column(4, numericInput("xMax", "X Maximum",NULL, min=0, max=10000)),
                          ),
                          selectInput("Y_axis4", 
                                      "Select y variable",
                                      NULL),
                          textInput("ylabels", "Y Axis Label", ""),
                          selectInput("yTransform", "y Axis Transformation",
                                      choices = c("None"="none", "Log2"='log2', "Log10"='log10', "Sqrt"='sqrt')),
                          numericInput("yTickSlants", "Y text direction", 0.0, min=0.0, max=180.0),
                          numericInput("yTextHeight", "Y text height adjustment", 0.0, min=-10, max=10),
                          fluidRow(
                            column(4, numericInput("yMin", "Y Minimum",NULL, min=0, max=10000)),
                            column(4, numericInput("yMax", "Y Maximum",NULL, min=0, max=10000)),
                          ),
                          
                          checkboxInput("doFills", "Add Fill?", value = FALSE),
                          conditionalPanel(condition="input.doFills==1",
                                           selectInput("fill_var14", 
                                                       "Select grouping variable",
                                                       NULL),
                                           textInput("legendLabels", "Legend Label", ""),
                                           selectInput("legendLocations", "LegendLocation",
                                                       choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none"))),
                          radioButtons("plotType", "Plot Type",
                                       choices=c("Scatter Plot"="sp", "Box Plot"="bp")),
                          conditionalPanel(condition = "input.plotType=='bp",
                                           helpText("Box plot customization"),
                                           checkboxInput("doNotch", "Noched", value=FALSE),
                                           checkboxInput("addJitter", "Jitter", value=FALSE)
                                           #checkboxInput("bpMean", "Add mean points", value=FALSE)
                                           ),
                          conditionalPanel(condition="input.addJitter==1",
                                           colourInput("jitterColor", "Jitter point color","black", allowTransparent = TRUE)),
                          
                          # conditionalPanel(condition="bpMean==1",
                          #                  selectInput("meanShape","Point shape",
                          #                              choices=c("Circle"=21, "Square"=22, "Diamond"=23, "Triangle"=24)),
                          #                  numericInput("meanSize", "Point size", 1, min=1, max=10),
                          #                  colourInput("meanColor", "Point color", "black", allowTransparent = TRUE)
                          #                  ),
                          
                          radioButtons("facetOptions", "Facet Options",
                                       choices=c("No Facet"="noFacet", "One Variable"="doFacet1",
                                                 "Two Variables" = "doFacet2"),
                                       selected = character(0)),
                          conditionalPanel(condition="input.facetOptions=='doFacet1'",
                                           selectInput("facetVarX4",
                                                       "Select facet variable",
                                                       NULL)),
                          conditionalPanel(condition = "input.facetOptions=='doFacet2'",
                                           selectInput("facetVarX42",
                                                       "Select X facet variable",
                                                       NULL),
                                           selectInput("facetVarY4",
                                                       "Select Y facet variable",
                                                       NULL),
                                           radioButtons("facetStyle2", "Facet Style",
                                                        choices=c("Show all faceted graphs"="grid2",
                                                                  "Show only graphs with points"="wrap2"),
                                                        selected= character(0))),
                          
                          
                        
                          numericInput("axisLabelSize", "Axis Label Font Size", 12, min=1, max=50),
                          selectInput("shape", "Point Shape",
                                      choices=c("Circle"=21, "Square"=22, "Diamond"=23, "Triangle"=24)),
                          
                          
                          selectInput("fillTheme", "Fill Theme Color",
                                      choices=c("Default"= "default", "YlOrRd(9)"="YlOrRd", "YlOrBr(9)"= "YlOrBr", "YlGnBu(9)"="YlGnBu",
                                                "YlGn(9)"="YlGn", "Reds(9)"="Reds", "RdPu(9)"="RdPu", "Purples(9)"="Purples",
                                                "PuRd(9)"="PuRd", "PuBuGn(9)"="PuBuGn", "PuBu(9)"="PuBu", "OrRd(9)"="OrRd",
                                                "Organges(9)"="Oranges", "Greys(9)"="Greys", "Greens(9)"="Greens",
                                                "GnBu(9)"="GnBu","BuPu(9)"="BuPu", "BuGn(9)"="BuGn", "Blues(9)"="Blues",
                                                "Set3(12)"="Set3", "Set2(8)"="Set2", "Set1(9)"="Set1", "Pastel2(8)"="Pastel2",
                                                "Pastel1(9)"="Pastel1", "Paired(12)"="Paired", "Dark2(8)"="Dark2","Accent(8)"="Accent",
                                                "Spectral(11)"="Spectral","RdYlGn(11)"="RdYlGn", "RdYlBu(11)"="RdYlBu", "RdGy(11)"="RdGy",
                                                "RdBu(11)"="RdBu","PuOr(11)"="PuOr", "PRGn(11)"="PRGn", "PiYG(11)"="PiYG","BrBG(11)"="BrBG")),

                          # colourInput("outlineColor", "Point Outline Color", "black", allowTransparent = TRUE),
                          # colourInput("fillColor", "Point Fill Color", "black", allowTransparent = TRUE),
                          # # 
                          
                          numericInput("pointSize", "Point Size", 1, min=1, max=10),
                          selectInput("lineStyle", "Line Style",
                                      choices=c("Solid"="solid", "Dotted"="dotted", "Dashed"="dashed")),
                          
                          colourInput("linearColor", "Linear Regrssion Line Color", "black", allowTransparent = TRUE),
                          
                          helpText("Additional Customizations"),
                          checkboxInput("linearReg", "Show Linear Regression?", value = FALSE),
                          checkboxInput("linearSE", "Show Confidence Interval?", value = FALSE),
                          checkboxInput("showR2", "Show R2?", value = FALSE),
                          checkboxInput("showSD", "Standard Deviation?", value = FALSE),
                          checkboxInput("summarize", "Summarize data?", value = FALSE),
                          conditionalPanel(condition="input.summarize==1",
                                           selectInput("discreteGroup", 
                                                       "Discrete group(s) to summarize",
                                                       NULL, multiple=TRUE),
                                           selectInput("avgGroup", 
                                                       "Continuous group(s) to find mean and sd for",
                                                       NULL, multiple=TRUE),
                                           ),
                          
                          
                          checkboxInput("xTexts", "X Axis Text?", value = TRUE),
                          checkboxInput("yTexts", "Y Axis Text?", value = TRUE),
                          checkboxInput("backroundGreys", "Grey Backround?", value = FALSE),
                          checkboxInput("gridLiness", "Grid Lines?", value = FALSE),
                          actionButton("plotScat", "Plot")
                        ),
                        
                        mainPanel(
                          plotOutput("scatter"),
                          verbatimTextOutput("sd"),
                          verbatimTextOutput("avgs")
                        )
                        
                      )
             )
             
             
          
             
  )
)

server <- function(input, output,session) {

  #reads file
  # data<- reactive({
  #   inFile<-input$file
  #   if(!is.null(inFile)){
  #     read_xlsx(inFile$datapath )
  #   }
  # })
  data<- reactive({
    inFile <- input$files
  })
  cat("work")
  
  #### AJL ####
  # updates the select input drop down
  observeEvent(data(),{
    updateSelectInput(session, "X_axis1", choices=colnames(read_xlsx(data()$datapath[1])))
    updateSelectInput(session, "Y_axis1", choices=colnames(read_xlsx(data()$datapath[1])))
    updateSelectInput(session, "fill_var11", choices=colnames(read_xlsx(data()$datapath[1])))
    updateSelectInput(session, "facetVarX1", choices=colnames(read_xlsx(data()$datapath[1])))
    updateSelectInput(session, "facetVarY1", choices=colnames(read_xlsx(data()$datapath[1])))
    
    updateSelectInput(session, "X_axis2", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "Y_axis2", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "fill_var12", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "facetVarX2", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "facetVarY2", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "annoRow", choices=colnames(read_xlsx(data()$datapath[2])))
    updateSelectInput(session, "anno1", choices=colnames(read_xlsx(data()$datapath[2])))
    
    updateSelectInput(session, "X_axis3", choices=colnames(read_xlsx(data()$datapath[3])))
    updateSelectInput(session, "Y_axis3", choices=colnames(read_xlsx(data()$datapath[3])))
    updateSelectInput(session, "fill_var13", choices=colnames(read_xlsx(data()$datapath[3])))
    updateSelectInput(session, "facetVarX3", choices=colnames(read_xlsx(data()$datapath[3])))
    updateSelectInput(session, "facetVarY3", choices=colnames(read_xlsx(data()$datapath[3])))
    
    updateSelectInput(session, "X_axis4", choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "Y_axis4",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "fill_var14",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "facetVarX4",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "facetVarX42",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "facetVarY4",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "discreteGroup",  choices=colnames(read_xlsx(data()$datapath[4])))
    updateSelectInput(session, "avgGroup",  choices=colnames(read_xlsx(data()$datapath[4])))
  })
  
  
  
  
  #plot Bar
  observeEvent(input$plotBar,{
    # inFile<- input$files
    # df<- read_xlsx(inFile$datapath[1])
    
    #read file
    df<- read_xlsx(data()[[1, 'datapath']])

    #global variables in method
    myBar <-ggplot(NULL)
    bkr<- NULL
    grid<-NULL
    axisSize<-NULL
    test1<- NULL
    legendPos<-NULL
    xTex<- NULL
    yTex<- NULL
    pointColor<- NULL
    addFacet <- NULL
    fillVar<- NULL
    horiz<- NULL
    barLab<- NULL
    xTickDir <-NULL
    yTickDir <- NULL
    lineCustom <- NULL 
    plottedBar<- NULL
    barTheme <-NULL
   
    
    #check for Fill
    if(input$doFill==1){
      fillVar = input$fill_var11
    }
    
    
    
    output$bar<-renderPlot({
      #simple plot
      myBar <- ggplot(df, aes_string(x=input$X_axis1, y=input$Y_axis1, fill=fillVar), show.l1gend=TRUE) +
        geom_bar(
          stat="identity", position=input$barStyle, width=input$barWidthb
        ) +
        labs(fill=input$legendLabel) + ggtitle(input$title)+ xlab(input$xlabel)+ ylab(input$ylabel) +
        scale_y_continuous(expand=c(0,0)) 
       
     
      if(input$barColor != "default"){
        cat("color change")
        cat(input$barColor)
        barTheme <- scale_fill_brewer(palette=input$barColor)
      }
      #axis font size
      if(as.integer(input$axisLabelSize)>0){
        axisSize<- theme(axis.text.x=element_blank(), text= element_text(size=as.integer(input$axisLabelSize)))
      }

      #legend location
      if(!is.null(input$legendLocation)){
        legendPos <- theme(legend.position=input$legendLocation)
      }

      #x text
      if(input$xText==0){
        xTex<-theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
      }

      #y text
      if(input$yText==0){
        yTex<-theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())
      }

      #coord flip
      if(input$flipCoord==1){
        horiz<- coord_flip()
      }

      #backround
      if(input$backroundGrey==0){
        bkr<- theme_bw()
      }
      if(input$gridLines==0){
        grid<- theme(panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank()
        )
      }

      # #bar label
      # if(input$barLabel==1){
      #   barLab<- geom_text(aes_string(label=input$Y_axis1), vjust=as.double(input$barLabelLocation),
      #                                                               color=input$barLabelColor,
      #                                                               size=as.double(input$barLabelSize))
      # }
      
      #axis text slant
      if(as.double(input$xTickSlant)> -1 & input$xText==1){
        xTickDir <- theme(axis.text.x = element_text(angle = as.double(input$xTickSlant)))
      }

      if(as.double(input$yTickSlant)> -1 & input$yText==1){
        yTickDir <- theme(axis.text.y = element_text(angle = as.double(input$yTickSlant)))
      }

      #axis thickness, color
      if(as.double(input$axisLineSize)>-1){
        lineCustom <- theme(axis.line = element_line(size=as.double(input$axisLineSize), color=(input$axisColor)))
      }
      
      #plot graph
      plottedBar<- myBar + horiz + barLab  + bkr +grid+ axisSize + legendPos + xTex + yTex + pointColor + xTickDir +yTickDir + lineCustom + barTheme
      plottedBar
      })
    
    plottedBar
    #####ISSUE MIGHT BE HERE####
    output$saveBar <- downloadHandler(
      filename=function(){
        paste("test2.pdf", sep="")
      },
      content = function(file){
        pdf(file, width=5, height=5)
        print(plottedBar)
        dev.off()
      }
      # filename = function() {
      #   paste("data-",  ".csv", sep="")
      # },
      # content = function(file) {
      #   write.csv(tempdata, file)
      # }
    )

    
  })
  
  
  
  
  #plotScater when button clicked, can edit plot after
  observeEvent(input$plotScat,{
    # inFile<- input$files
    # df<- read_xlsx(inFile$datapath[2])
    df1<- read_xlsx(data()$datapath[4])
    
    if(input$showSD ==1){
      output$sd <- renderPrint({
        apply(read_xlsx(data()$datapath[4]), 2, sd)
      })
    }
    
    if(input$summarize ==1){
      output$avgs <- renderPrint({
        cdata <- aggregate(df1[c(as.character(input$avgGroup))],
                                 by=df1[c(as.character(input$discreteGroup))], function(x) c(mean=mean(x), sd=sd(x)))
        
       cdata
      })
    }
    #global variables in method
    myScat <-ggplot(NULL)
    linReg<-NULL
    bkr<- NULL
    grid<-NULL
    axisSize<-NULL
    R2<-NULL
    test1<- NULL
    legendPos<-NULL
    xTex<- NULL
    yTex<- NULL
    pointColor<- NULL
    addFacet <- NULL
    fillVar <- NULL
    xTickDir <- NULL
    yTickDir <- NULL
    logTransformX <-NULL
    logTransformY <- NULL
    colorTheme <- NULL
    bpAvg<- NULL
    jitColor<-NULL
    jit<- NULL
    yaxis <- input$Y_axis4
    
    if(input$doFills==1){
      fillVar = input$fill_var14
      cat("filled")
    }
    
    output$scatter<-renderPlot({
      #simple plot
      df<- read_xlsx(data()$datapath[4])
      my.formula<- data()$get(input$X_axis4) ~ data()$get(input$Y_axis4) 
     
      

      
     if(input$plotType=="sp"){
      myScat <- ggplot(df, aes_string(x=input$X_axis4, y=input$Y_axis4, fill=fillVar), show.legend=TRUE) +
        ################################################################################
      geom_point(
        # color= input$outlineColor,
        # fill= "Dark2",
        size= as.integer(input$pointSize),
        shape=as.integer(input$shape)) +
        labs(title=input$titles, x=input$xlabels, y=input$ylabels, fill=input$legendLabels)+
        xlim(as.double(input$xMin), as.integer(input$xMax)) +
        ylim(as.double(input$yMin), as.integer(input$yMax))
     }
      
      if(input$plotType=="bp"){
        myScat<- ggplot(df, aes_string(x=input$X_axis4, y=input$Y_axis4, fill=fillVar), show.legend=TRUE)+
          geom_point(mapping = aes(color = fillVar),
                     position = position_jitterdodge(jitter.height=0.1, 
                                                     jitter.width=0.1), 
                     dodge.width = 0.1) +
          geom_boxplot(notch=input$doNotch, outlier.size=0)
      }
      
      #jitter
      if(input$addJitter == 1){
        jit<- geom_point(mapping = aes(color = fillVar),
                         position = position_jitterdodge(jitter.height=0.1, 
                                                         jitter.width=0.1), 
                         dodge.width = 0.1)
        jitColor <- scale_color_brewer(input$jitterColor)
      }
      
      #fill color theme
      if(input$fillTheme != "default"){
        if(input$plotType=="sp"){
          colorTheme<-scale_color_brewer(palette = input$fillTheme)
        }
        else{
          colorTheme <- scale_fill_brewer(c(palette = input$fillTheme))
        }
      }
      
      # #bp avg point
      # if(input$bpMean == 1){
      #   bpAvg <- stat_summary(fun=mean, geom="point", shape=as.integer(input$meanShape),
      #                         size=as.integer(input$meanSize), color=input$meanColor)
      # }

      #linear regression
      if(input$linearReg == 1){
        linReg<- geom_smooth(method=lm, linetype=input$lineStyle, se=input$linearSE, col=input$linearColor)
      }
      #R2
      if(input$showR2 ==1){
        # R2<-stat_poly_eq(formula = my.formula,
        #                  #..eq.label.., not working
        #                  aes(label = paste( ..rr.label.., sep = "~~~")),
        #                  parse = TRUE)
      }

      #backround
      if(input$backroundGreys==0){
        bkr<- theme_bw()
      }
      if(input$gridLiness==0){
        grid<- theme(panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank()
        )
      }

      #axis font size
      if(as.integer(input$axisLabelSize)>0){
        axisSize<- theme(text= element_text(size=as.integer(input$axisLabelSize)))
      }

      #legend location
      if(!is.null(input$legendLocations)){
        legendPos <- theme(legend.position=input$legendLocations)
      }

      #x text
      if(input$xTexts==0){
        xTex<-theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
      }

      #y text
      if(input$yTexts==0){
        yTex<-theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())
      }

      #slant
      if(as.double(input$xTickSlants)> -1 & input$xTexts==1){
        xTickDir <- theme(axis.text.x = element_text(angle = as.double(input$xTickSlants), hjust=as.double(input$xTextHeight)))
      }

      if(as.double(input$yTickSlants)> -1 & input$yTexts==1){
        yTickDir <- theme(axis.text.y = element_text(angle = as.double(input$yTickSlants), hjust=as.double(input$yTextHeight)))
      }

      #color theme
      # if(input$colorOptions == "theme"){
      #   pointColor <-scale_color_brewer(palette = "Dark2")
      #}

      # #color multi
      # if(input$colorOptions == "multi"){
      #   pointColor <-
      # }

      #facet
      if(input$facetOptions == "doFacet1"){

        addFacet <- facet_wrap(~get(input$facetVarX4))

      }

      if(input$facetOptions == "doFacet2"){
        if(input$facetStyle2 == "grid2"){
          addFacet <- facet_grid(get(input$facetVarX42)~get(input$facetVarY4))
        }
        else{
          addFacet <- facet_wrap(get(input$facetVarX42)~get(input$facetVarY4))
        }

      }

      #log, sqrt axis
      if(input$xTransform!="none"){
        logTransformX <- scale_x_continuous(trans= as.character(input$xTransform))
      }
      if(input$yTransform!="none"){
        logTransformY <- scale_y_continuous(trans= as.character(input$yTransform))
      }

      #plot graph
      myScat + linReg +bkr +grid+ axisSize + R2 + legendPos + xTex + yTex + pointColor+ addFacet + xTickDir + yTickDir+
        logTransformX +logTransformY + colorTheme +bpAvg + jitColor +jit
    })
  })
  
  
  #plotHist
  observeEvent(input$plotHist,{
    # inFile<- input$files
    # df<- read_xlsx(inFile$datapath[3])
    #df<- read_xlsx(data()[[3, 'datapath']])
    #df<- read_xlsx(data()$datapath[3])
    
    #global variables in method
    myHist <-ggplot(NULL)
    bkr<- NULL
    grid<-NULL
    axisSize<-NULL
    test1<- NULL
    legendPos<-NULL
    xTex<- NULL
    yTex<- NULL
    pointColor<- NULL
    addFacet <- NULL
    fillVar<- NULL
    horiz<- NULL
    barLab<- NULL
    stak<- NULL
    mline<-NULL
    fct<-NULL
    
  

    # mu<- ddply(data(), input$legendLabel, summarise, grp.mean=mean(input$X_axis))
    # head(mu)
    
    output$hist<-renderPlot({
      #simple plot
      df<- read_xlsx(data()$datapath[3])
      
      
      myHist <- ggplot(df, aes_string(x=input$X_axis3, color=input$fill_var13, fill=input$fill_var13), show.legend=TRUE) +
        geom_histogram(bins=30, binwidth = input$binSize)
      
    
      if(input$facetHist==TRUE){
        fct <-facet_wrap(~input$fill_var13)
      } 
      
      
      #axis font size
      if(as.integer(input$axisLabelSize)>0){
        axisSize<- theme(text= element_text(size=as.integer(input$axisLabelSize)))
      }
      
      #legend location
      if(!is.null(input$legendLocation)){
        legendPos <- theme(legend.position=input$legendLocation)
      }
      
      #x text
      if(input$xText==0){
        xTex<-theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
      }
      
      #y text
      if(input$yText==0){
        yTex<-theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())
      }
      
      #coord flip
      if(input$flipCoord==1){
        horiz<- coord_flip()
      }
      
      #backround
      if(input$backroundGrey==0){
        bkr<- theme_bw()
      }
      if(input$gridLines==0){
        grid<- theme(panel.grid.major = element_blank(),
                     panel.grid.minor = element_blank()
        )
      }
      
      if(input$barLabel==1){
        barLab<- geom_text(aes(label=input$Y_axis3), vjust=as.double(input$barLabelLocation,
                                                                    color=input$barLabelColor,
                                                                    size=as.double(input$barLabelSize)))
      }
      
      #mean line
      #mLine<- geom_vline(data=mu, aes(xintercept=grp.mean, color=fillVar), linetype="dashed")
      #plot graph
      
      myHist + horiz + barLab  + bkr +grid+ axisSize + legendPos + xTex + yTex + fct
    })
    
  })
  
  #plot Heatmap
  observeEvent(input$plotHM,{
    # inFile<- input$files
    df<- read_xlsx(data()$datapath[2])
    
    #global variables in method
    anoVar<-NULL
    col.pal<-RColorBrewer::brewer.pal(9, "RdYlBu")
   
    
    output$heatmap <- renderPlot({
      df_num = as.matrix(df[,as.integer(input$leftX):as.integer(input$rightX)])
      
      
      yaxis<- (as.matrix(df[,as.character(input$Y_axis2)]))
      rownames(df_num)=sapply(yaxis, function(x)
       strsplit(as.character(x), split="\\\\")[[1]][1])

      #scale
      if(input$scale ==1){
        df_num = scale(df_num)
      }

     # coV <- c(input$annoRow)
     #datalist = list()
     # counter = 1
     # #df_total = data.frame()
     # 
     #for(i in coV){
     # 
     #   print(i)
      # var_df = data.frame("t" =df[,i])
     #  
     #   rownames(var_df)=rownames(df_num)
     #    
     #  
     #  datalist[[counter]] <- var_df
     #  counter = counter +1
     #    # toAdd <- data.frame(var_df)
     #    # print("pre")
     #    # print(rownames(df_total))
     #    # 
     #    # rownames(df_total)= rownames(var_df)
     #    # print("post")
     #    # print(rownames(df_total))
     #    # 
     #    # df_total<-rbind(df_total,toAdd)
     # }
     df_total<- data.table::rbindlist(datalist)
      
      if(input$rowAnno==1){
        test<-as.character(input$anno1)
        temp=data.frame(test=df[,as.character(input$anno1)])
        rownames(temp)=rownames(df_num)
        anoVar<-temp
        
      }
      
      if(input$hmColor == "theme"){
        if(input$hmTheme=="YlOrRd"||input$hmTheme=="YlOrBr"||input$hmTheme=="YlGnBu"||input$hmTheme=="YlGn"||input$hmTheme=="Reds"||
           input$hmTheme=="RdPu"||input$hmTheme=="Purples"||input$hmTheme=="PuRd"||input$hmTheme=="PuBuGn"||input$hmTheme=="PuBu"||
           input$hmTheme=="OrRd"||input$hmTheme=="Oranges"||input$hmTheme=="Greys"||input$hmTheme=="Greens"||input$hmTheme=="GnBu"||
           input$hmTheme=="BuPu"||input$hmTheme=="BuGn"||input$hmTheme=="Blues"||input$hmTheme=="Set1"||input$hmTheme=="Pastel1"){
          col.pal <- RColorBrewer::brewer.pal(9, input$hmTheme)
        }
        else if(input$hmTheme=="Set3"||input$hmTheme=="Paired"){
          col.pal <- RColorBrewer::brewer.pal(12, input$hmTheme)
        }
        else if( input$hmTheme=="Set2"||input$hmTheme=="Pastel2"|| input$hmTheme=="Dark2"||input$hmTheme=="Accent"){
          col.pal <- RColorBrewer::brewer.pal(8, input$hmTheme)
        }
        else{
          col.pal <- RColorBrewer::brewer.pal(11, input$hmTheme)
        }
      }
      
      if(input$hmColor=="gradient"){
        col.pal <-colorRampPalette(c(input$startColor, input$midColor,input$endColor))(100)
      }
      
      # #cool = rainbow(4, s=1, v=1, start=.7, end=.1, gamm=1)
      # cool =rainbow(5, s = 1, v = 1, start = 4/6, end = max(1, 5 - 1)/5, alpha = 1)
      # # cool = rainbow(5, start=rgb2hsv(col2rgb('slateblue1'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
      # cols = c(rev(cool))
      # col.pal <- colorRampPalette(cols)(255)

# 
#       pos_df2=data.frame("pos"=df$temperature)
#       rownames(pos_df2)=rownames(df_num)
      
      #print(data.frame(c(pos_df,pos_df2)))

      setHook("grid.newpage", function() pushViewport(viewport(x=1,y=1,width=0.9, height=0.9, name="vp", just=c("right","top"))), action="prepend")
      
      pheatmap(df_num, 
               cluster_cols=input$clusterCols,cluster_rows=input$clusterRows, 
               annotation_row = anoVar,
               #annotation_row = data.frame(df_total),
               cutree_rows = input$numRows,
               cutree_cols = input$numCols,
               main=as.character(input$titlep),
               color= col.pal,
               display_numbers=input$cellLab,
               number_color = input$cellTColor,
               fontsize_number = input$cellTSize,
               show_colnames = input$colNames,
               show_rownames = input$rowNames,
               angle_col= as.integer(input$colAngle),
               fontsize_col = input$colFontSize,
               fontsize_row = input$rowFontSize)
       
      setHook("grid.newpage", NULL, "replace")
      grid.text(input$xlabelp, x=input$horizX, y=input$vertX, gp=gpar(fontsize=16))
      grid.text(input$ylabelp, x=input$vertY, y=input$horizY, rot=90, gp=gpar(fontsize=16))

    })
    
   # output$heatmap<-renderPlot({
      #simple plot
     # df<- read_xlsx(data()$datapath[2])
     # df_used <- df
     # df_num <- as.matrix(df_used[,2:ncol(df_used)])
      #rownames(df_num) <- df_used$input$X_axis2
      #rownames(df_num) <- df_used$Accession
      #hc <- hclust(as.dist(1 - cor(df_num)), "ward.D")
      #num_clust = 2
      #Phylotype <- cutree(hc, k = num_clust)
      #cool = rainbow(50, start=rgb2hsv(col2rgb('slateblue1'))[1], end=rgb2hsv(col2rgb('yellow'))[1])
      #cols = c(rev(cool))
      #col.pal <- colorRampPalette(cols)(255)
     # col.pal <- RColorBrewer::brewer.pal(9, input$color)

     # myHM<- pheatmap(df_num, main = input$title,
                      #clustering_method = "ward.D",
                      #annotation_row = input$Y_axis,
                      #cutree_rows = 11,
                      #cutree_cols = 2,
                      #color = col.pal,
                      #cluster_rows= input$clusterRow, cluster_cols=input$clusterCol,
                      #clustering_distance_rows = "euclidean",
                      #clustering_distance_cols = "euclidean",
                      #show_rownames = input$yText, show_colnames = input$xText

      #)
      #cat("test6\n")

      #plot graph
      #plotHm<-as.grob(myHM )
      #plotHm
   # })
    

    
  })
  
  
  
}

shinyApp(ui=ui, server=server)



