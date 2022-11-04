
#Server
server <- function(input, output){

  data <- reactive({
    req(input$dataFile)
    read_excel(input$dataFile$datapath)
  })
  
  output$table <- renderDT(data())
  
  #Customization Settings
    # changing the color
    # changing the line width
    # x and y labels and titles
    # legends
    # Log-transform x or y axes
  
  
  output$plot <- renderPlot({
    
    p <- data()
    
    
    #Bar Graphs
    if (input$plotType == "bar"){
      plotVH = input$plotVH

      # Line Width not working in correct area.

      if (plotVH == "vert"){
        barplot(p$x, p$y, col = input$scolor, main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis, lwd = input$bFlinewidth)
      }
      else if (plotVH == "horz"){
        barplot(p$x, p$y, col = input$scolor, main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis, horiz = TRUE, lwd = input$bFlinewidth)
      }

      legend("topright", legend=c(input$syaxis), 
             fill = c(input$scolor)
      )  
          
      
    }
    
    #Box Graphs  
    if (input$plotType == "box"){
      boxplot(p$x, p$y, col = input$scolor, main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis, lwd = input$bFlinewidth)
    
      legend("topright", legend=c(input$syaxis), 
             fill = c(input$scolor)
      )  

    }
  
    #Heatmap
    #if (input$plotType == "heatmap"){
      
      #colnames(data) <- p$y
      #rownames(data) <- p$x
      #heatmap(data)
    #}

    #Line Graphs
    if (input$plotType == "line"){
      plot(p$x, p$y, col = input$scolor, type = "o", main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis)
    
      legend("topright", legend=c(input$syaxis), 
             fill = c(input$scolor)
      )  
      
    }

    #Scatter Plots
    
    #output$value <- renderText({ input$xaxis })
    #output$histyvalue <- renderText({ input$yaxis })
    
    if (input$plotType == "scatter"){
      plot(p$x, p$y, col = input$scolor, main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis)
      # plot(p$x, p$y, col = "red", main = "Scatter Plot", xlab = input$xaxis, ylab = input$yaxis)
      # lines(p$x, p&z, lwd=2, col="red")
      # plot(p$x, p$z, col = "red", main = "Scatter Plot", xlab = input$xaxis, ylab = input$yaxis)
      
      #X Error Bars
      #arrows(x0=p$x+x_error), y0=y)

      #Y Error Bars
      #arrows(x0=x, y0=p$y+y_error)
      
      if (input$fitLine == TRUE){
        abline(lm(p$y ~ p$x), col = input$scolor, lty = input$slt, lwd = input$bFlinewidth)
      }
      
      # if (input$sEB == TRUE){
      #   abline(lm(p$y ~ p$x), col = input$scolor, lty = input$slt, lwd = input$bFlinewidth)
      # }
      
      legend("topright", legend=c(input$syaxis), 
             fill = c(input$scolor)
      )
      
    }
    
    
    #Histograms
    
#    if (input$plotType == "hist"){
#      breaks <- input$breaks
      
#      if (breaks == "custom"){
#        breaks <- input$breakCount
#      }
      
#      hist(p$x, main = input$htitle, xlab = input$hxaxis, ylab = input$hyaxis, breaks = breaks, col = input$hcolor)
# 
#       if (input$hEB == TRUE){
#         # # Vertical arrow
#         # arrows(x0=p$x_ste, y0=-p$y_ste, x1=p$x_ste, y1=+p$y_ste, code=3, col= input$hcolor, lwd=2)
#         # # Horizontal arrow
#         # arrows(x0=x-3, y0=y, x1=x+3, y1=y, code=3, col="red", lwd=2)
#       }
      
#      legend("topright", legend=c(input$hyaxis), 
#             fill = c(input$hcolor)
#      )
      
#    }
    
    
  })
  
  
  
}
