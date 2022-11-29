#Bar Graph UI Side

Bar <- conditionalPanel(
  condition = "input.plotType == 'bar'",

  textInput("stitle", "Label the Graph", "Title"),
  selectInput("x_axis1", "Select X Variable", NULL),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  numericInput("xticks", "Direction of X Tick", 0.0, min = 0.0, max = 180.0),
  selectInput("y_axis1", "Select Y Variable", NULL),
  textInput("syaxis", "Label the Y-Axis", "Y-Axis"),

  numericInput("yTickSlant", "Y tick direction", 0.0, min=0.0, max=180.0),                        
  numericInput("barWidthb", "Bar width", 1, min=0.9, max=10),                     
  numericInput("axisLineSize", "Axis Thickness", 0.0, min=0.0, max=180.0),
  colourInput("axisColor", "Axis Color", "black", allowTransparent = TRUE),
  checkboxInput("doFill", "Add Fill?", value = FALSE),
  conditionalPanel(condition="input.doFill==1",
    selectInput("fill_var11","Select grouping variable", NULL),
    selectInput("barStyle", "Bar Style", choices=c("Grouped"="dodge", "Stacked"="stack", "Precent"="fill")),
    textInput("legendLabel", "Legend Label", "Label the Legend"),
    selectInput("barColor", "Bar Color Theme", choices=c("Default"= "default", "YlOrRd(9)"="YlOrRd", "YlOrBr(9)"= "YlOrBr", "YlGnBu(9)"="YlGnBu",
                                                                 "YlGn(9)"="YlGn", "Reds(9)"="Reds", "RdPu(9)"="RdPu", "Purples(9)"="Purples",
                                                                 "PuRd(9)"="PuRd", "PuBuGn(9)"="PuBuGn", "PuBu(9)"="PuBu", "OrRd(9)"="OrRd",
                                                                 "Organges(9)"="Oranges", "Greys(9)"="Greys", "Greens(9)"="Greens",
                                                                 "GnBu(9)"="GnBu","BuPu(9)"="BuPu", "BuGn(9)"="BuGn", "Blues(9)"="Blues",
                                                                 "Set3(12)"="Set3", "Set2(8)"="Set2", "Set1(9)"="Set1", "Pastel2(8)"="Pastel2",
                                                                 "Pastel1(9)"="Pastel1", "Paired(12)"="Paired", "Dark2(8)"="Dark2","Accent(8)"="Accent",
                                                                 "Spectral(11)"="Spectral","RdYlGn(11)"="RdYlGn", "RdYlBu(11)"="RdYlBu", "RdGy(11)"="RdGy",
                                                                 "RdBu(11)"="RdBu","PuOr(11)"="PuOr", "PRGn(11)"="PRGn", "PiYG(11)"="PiYG","BrBG(11)"="BrBG")),
      selectInput("legendLocation", "LegendLocation", choices=c("Top"="top", "Left"="left", "Right"="right", "Bottom"="bottom", "None"="none")),
    ),
  helpText("Additional Customizations"),
  checkboxInput("flipCoord", "Horizontal Plot?", value = FALSE),
  checkboxInput("xText", "X Axis Text?", value = TRUE),
  checkboxInput("yText", "Y Axis Text?", value = TRUE),
  checkboxInput("backroundGrey", "Grey Backround?", value = FALSE),
  checkboxInput("gridLines", "Grid Lines?", value = FALSE),

  actionButton("plotBar", "Plot")
                        
    
)

