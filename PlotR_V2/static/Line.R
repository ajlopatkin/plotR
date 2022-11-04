#Line Graph UI Side

Line <- conditionalPanel(
  condition = "input.plotType == 'line'",

  textInput("stitle", "Label the Graph", "Title"),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  textInput("syaxis", "Label the Y-Axis", "Y-Axis"),
  
  #colourInput("scolor", label = "Select Color", "grey"),
  
  selectInput(
    "slt", "Line Type", c(Solid = "solid", Dashed = "dashed", Dotted = "dotted", DotDash = "dotdash", LongDash = "longdash", TwoSDash = "twodash")
  ),
  sliderInput("bFlinewidth", "Line Width", min = 1, max = 10, value = 1)
  
)