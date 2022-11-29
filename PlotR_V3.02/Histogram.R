#Histogram UI Side

Histogram <- conditionalPanel(
  condition = "input.plotType == 'hist'",

  textInput("title", "Plot Title", ""),
  selectInput("x_axis1", "Select x variable", NULL),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  selectInput("fill_var11", "Select grouping variable", NULL),
  checkboxInput("barLabel", "Add Bar Label?", value = FALSE),
  conditionalPanel(condition="input.barLabel==1",
    selectInput("barLabelLocation", "Bar Label Position",
    choices=c("Above Bar"= -0.3, "Inside Bar"=1.6)),
    numericInput("barLabelSize", "Bar Label Size", 3.5, min=1.0, max=10.0)
  ),
  numericInput("binSize", "Bin width", 1, min=0.0, max=100),
  helpText("Additional Customizations"),
  checkboxInput("facetHist", "Facet?", value = FALSE),
  checkboxInput("flipCoord", "Horizontal Plot?", value = FALSE),
  checkboxInput("backroundGrey", "Grey Backround?", value = FALSE),
  checkboxInput("gridLines", "Grid Lines?", value = FALSE),

  actionButton("plotHist", "Plot")

)