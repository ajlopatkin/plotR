
#Server
server <- function(input, output, session){

  data <- reactive({
    inFile <- input$dataFile
    req(inFile)
    #req(input$dataFile)
    #read_excel(input$dataFile$datapath)
  })

  #data2 <- reactive({
   # read_excel(input$dataFile$datapath)
  #})
  
 #output$table <- renderDT(data2())
  
  #Customization Settings
    # changing the color
    # changing the line width
    # x and y labels and titles
    # legends
    # Log-transform x or y axes
  


  observeEvent(data(),{

    updateSelectInput(session, "x_axis1", choices=colnames(read_excel(data()$datapath[1])))
    updateSelectInput(session, "y_axis1", choices=colnames(read_excel(data()$datapath[1])))
    #updateSelectInput(session, "fill_var11", choices=colnames(read_excel(data()$datapath[1])))
    #updateSelectInput(session, "facetVarX1", choices=colnames(read_excel(data()$datapath[1])))
    #updateSelectInput(session, "facetVarY1", choices=colnames(read_excel(data()$datapath[1])))

  })

  # Bar Graphs

  observeEvent(input$plotBar,{
    p <- data()
    dF <- read_excel(p[[1, 'datapath']])

    myBar <- ggplot(NULL)
    # Fill
    fillVar <- NULL
    if (input$doFill == 1){
      fillVar = input$fill_var11
    }
    bkg <- NULL
    grid <- NULL
    axisSize <- NULL
    legendPos <- NULL
    xT <- NULL
    yT <- NULL
    pointColor <- NULL
    horiz <- NULL
    barLab <- NULL
    xTickDir <- NULL
    yTickDir <- NULL
    lineCustom <- NULL
    plottedBar <- NULL
    bTheme <- NULL





    output$bar <- renderPlot({

      if (input$plotType == "bar"){

        myBar <- ggplot(dF, aes_string(x = input$x_axis1, y = input$y_axis1, fill = fillVar), show.legend = TRUE) +
        geom_bar(stat = "identity", position = input$barStyle, width = input$barWidth) +
        labs(fill = input$legendLabel) +
        ggtitle(input$title) + xlab(input$xlabel) + ylab(input$ylabel) + scale_y_continuous(expand = c(0,0))
  
        #barplot(p$x, p$y, col = input$scolor, main = input$stitle, xlab = input$sxaxis, ylab = input$syaxis, lwd = input$bFlinewidth)

        # Bar Color
        if(input$barColor != "default"){
          bTheme <- scale_fill_brewer(palette = input$bColor)
        }

        # Axis Font Size
        #if(as.integer(input$axisLabelSize) > 0){
         # axisSize <- theme(axis.text.x = element_blank(), text = element_text(size = as.integer(input$axisLabelSize)))
        #}

        # Legend Location
        if(!is.null(input$legendLocation)){
          legendPos <- theme(legend.position = input$legendLocation)
        }

        # X Text
        if(input$xText == 0){
          xT <- theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
        }

        # Y Text
        if(input$yText == 0){
          yT <- theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
        }

        # Horizontal
        if(input$flipCoord == 1){
          horiz <- coord_flip()
        }

        # Background
        if(input$backroundGrey == 0){
          bkg <- theme_bw()
        }
        
        if(input$gridLines == 0){
          grid <- theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
        }

        # Axis Text Slant
        #if(as.double(input$xTickSlant) > -1 & input$xText == 1){
         # xTickDir <- theme(axis.text.x = element_text(angle = as.double(input$xTickSlant)))
        #}

        #if(as.double(input$yTickSlant )> -1 & input$yText == 1){
         # yTickDir <- theme(axis.text.y = element_text(angle = as.double(input$yTickSlant)))
        #}

        #axis thickness, color
        if(as.double(input$axisLineSize) > -1){
          lineCustom <- theme(axis.line = element_line(size=as.double(input$axisLineSize), color=(input$axisColor)))
        }
        
        # Plot
        plottedBar <- myBar + horiz + barLab  + bkg +grid+ axisSize + legendPos + xT + yT + pointColor + xTickDir + yTickDir + lineCustom + bTheme
        plottedBar


      }
    
    })


  })

  
  
  
}
