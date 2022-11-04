#Histogram UI Side

Histogram <- conditionalPanel(
  condition = "input.plotType == 'hist'",
  selectInput(
    "breaks", "Breaks", c("Sturges", "Scott", "Freedman-Diaconis", "Custom" = "custom")
  ),
  #Custom Option
  conditionalPanel(
    condition = "input.breaks == 'custom'",
    sliderInput("breakCount", "Break Count", min = 1, max = 50, value = 10)
  ),
  
  textInput("htitle", "Label the Graph", "Title"),
  
  textInput("hxaxis", "Label the X-Axis", "X-Axis"),
  #verbatimTextOutput("value")
  
  textInput("hyaxis", "Label the Y-Axis", "Y-Axis"),
  #verbatimTextOutput("histyvalue")
  
  colourInput("hcolor", label = "Select Color", "grey"),
  
  # checkboxInput("hEB", "Error Bars", value = FALSE)
  # 
   
)