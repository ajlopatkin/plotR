#Scatter Plot UI Side

Scatter <- conditionalPanel(
  
  condition = "input.plotType == 'scatter'",
  
  textInput("stitle", "Label the Graph", "Title"),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  textInput("syaxis", "Label the Y-Axis", "Y-Axis"),
  
  colourInput("scolor", label = "Select Color", "grey"),

  checkboxInput("fitLine", "Line of Best Fit", value = FALSE),
  
  selectInput(
    "slt", "Line Type", c(Solid = "solid", Dashed = "dashed", Dotted = "dotted", DotDash = "dotdash", LongDash = "longdash", TwoSDash = "twodash")
  ),
  
  conditionalPanel(
    condition = "input$fitLine == 'TRUE'",
    sliderInput("bFlinewidth", "Line Width", min = 1, max = 10, value = 1)
  ),
  
  # checkboxInput("sEB", "Error Bars", value = FALSE)

)
