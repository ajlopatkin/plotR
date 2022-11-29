#Scatter Plot UI Side

Scatter <- conditionalPanel(
  
  condition = "input.plotType == 'scatter'",
  
  textInput("titles", "Plot Title", ""),
  selectInput("x_axis1", "Select x variable", NULL),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  selectInput("xTransform", "X Axis Transformatiom",
  choices = c("None"="none", "Log2"='log2', "Log10"='log10', "Sqrt"='sqrt')),
  numericInput("xTickSlants", "X text direction", 0.0, min=0.0, max=180.0),
  numericInput("xTextHeight", "X text height adjustment", 0.0, min=-10.0, max=10.0),
  fluidRow(
    column(4, numericInput("xMin", "X Minimum",NULL, min=0, max=10000)),
    column(4, numericInput("xMax", "X Maximum",NULL, min=0, max=10000)),
  ),

  selectInput("y_axis1", "Select Y Variable", NULL),
  textInput("syaxis", "Label the Y-Axis", "Y-Axis"),                 
  selectInput("yTransform", "y Axis Transformation",
  choices = c("None"="none", "Log2"='log2', "Log10"='log10', "Sqrt"='sqrt')),
  numericInput("yTickSlants", "Y text direction", 0.0, min=0.0, max=180.0),
  numericInput("yTextHeight", "Y text height adjustment", 0.0, min=-10, max=10),
  fluidRow(
    column(4, numericInput("yMin", "Y Minimum",NULL, min=0, max=10000)),
    column(4, numericInput("yMax", "Y Maximum",NULL, min=0, max=10000)),
  ),

  checkboxInput("doFills", "Add Fill?", value = FALSE),
  conditionalPanel(
    condition="input.doFills==1",
    selectInput("fill_var11", "Select grouping variable", NULL),
    textInput("legendLabels", "Legend Label", ""),
    selectInput("legendLocations", "LegendLocation",
    choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none"))
  ),
  radioButtons("plotType", "Plot Type", choices=c("Scatter Plot"="sp", "Box Plot"="bp")),
  
  conditionalPanel(
    condition = "input.plotType=='bp",
    helpText("Box plot customization"),
    checkboxInput("doNotch", "Noched", value=FALSE),
    checkboxInput("addJitter", "Jitter", value=FALSE)
  ),

  conditionalPanel(
    condition="input.addJitter==1",
    colourInput("jitterColor", "Jitter point color","black", allowTransparent = TRUE)
  ),

  radioButtons(
    "facetOptions", "Facet Options",
    choices=c("No Facet"="noFacet", "One Variable"="doFacet1", "Two Variables" = "doFacet2"), selected = character(0)
  ),

  conditionalPanel(
    condition="input.facetOptions=='doFacet1'",
    selectInput("facetVarX4", "Select facet variable", NULL)
  ),


  conditionalPanel(
    condition = "input.facetOptions=='doFacet2'",
    selectInput("facetVarX42", "Select X facet variable", NULL),
    selectInput("facetVarY4", "Select Y facet variable", NULL),
    radioButtons("facetStyle2", "Facet Style",
      choices=c("Show all faceted graphs"="grid2", "Show only graphs with points"="wrap2"), selected= character(0))
  ),

  numericInput("axisLabelSize", "Axis Label Font Size", 12, min=1, max=50),
  selectInput("shape", "Point Shape", choices=c("Circle"=21, "Square"=22, "Diamond"=23, "Triangle"=24)),

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

  numericInput("pointSize", "Point Size", 1, min=1, max=10),
  selectInput("lineStyle", "Line Style", choices=c("Solid"="solid", "Dotted"="dotted", "Dashed"="dashed")),

  colourInput("linearColor", "Linear Regrssion Line Color", "black", allowTransparent = TRUE),
                          
  helpText("Additional Customizations"),

  checkboxInput("linearReg", "Show Linear Regression?", value = FALSE),
  checkboxInput("linearSE", "Show Confidence Interval?", value = FALSE),
  checkboxInput("showR2", "Show R2?", value = FALSE),
  checkboxInput("showSD", "Standard Deviation?", value = FALSE),
  checkboxInput("summarize", "Summarize data?", value = FALSE),

  conditionalPanel(
    condition="input.summarize==1",
    selectInput("discreteGroup", 
    "Discrete group(s) to summarize", NULL, multiple=TRUE),
    selectInput("avgGroup", "Continuous group(s) to find mean and sd for", NULL, multiple=TRUE),
  ),

  checkboxInput("xTexts", "X Axis Text?", value = TRUE),
  checkboxInput("yTexts", "Y Axis Text?", value = TRUE),
  checkboxInput("backroundGreys", "Grey Backround?", value = FALSE),
  checkboxInput("gridLiness", "Grid Lines?", value = FALSE),
  actionButton("plotScat", "Plot")


)
