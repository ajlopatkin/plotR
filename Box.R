#Box Plot UI Side

Box <- conditionalPanel(
  condition = "input.plotType == 'box'",
  textInput("stitle", "Label the Graph", "Title"),
  textInput("sxaxis", "Label the X-Axis", "X-Axis"),
  textInput("syaxis", "Label the Y-Axis", "Y-Axis"),

  #colourInput("scolor", label = "Select Color", "grey")

  sliderInput("bFlinewidth", "Line Width", min = 1, max = 10, value = 1)

)