
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
    updateSelectInput(session, "fill_var11", choices=colnames(read_excel(data()$datapath[1])))
    updateSelectInput(session, "facetVarX1", choices=colnames(read_excel(data()$datapath[1])))
    updateSelectInput(session, "facetVarY1", choices=colnames(read_excel(data()$datapath[1])))

  })

  # Bar Graphs

  observeEvent(input$plotBar,{

     df<- read_excel(data()[[1, 'datapath']])

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


    output$bar <- renderPlot({

      if (input$plotType == "bar"){

        myBar <- ggplot(df, aes_string(x=input$x_axis1, y=input$y_axis1, fill=fillVar), show.legend=TRUE) +
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
        #if(as.integer(input$axisLabelSize)>0){
        #  axisSize<- theme(axis.text.x=element_blank(), text= element_text(size=as.integer(input$axisLabelSize)))
        #}

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

        #axis text slant
        #if(as.double(input$xTickSlant)> -1 & input$xText==1){
         # xTickDir <- theme(axis.text.x = element_text(angle = as.double(input$xTickSlant)))
        #}

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

      }
    
    })


  })


  observeEvent(input$plotHist,{

    df<- read_excel(data()[[1, 'datapath']])

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


    output$hist<-renderPlot({

       if (input$plotType == "hist"){
        myHist <- ggplot(df, aes_string(x=input$x_axis1, color=input$fill_var11, fill=input$fill_var11), show.legend=TRUE) + geom_histogram(bins=30, binwidth = input$binSize)

        if(input$facetHist==TRUE){
          fct <-facet_wrap(~input$fill_var11)
        } 

        if(!is.null(input$legendLocation)){
          legendPos <- theme(legend.position=input$legendLocation)
        }

        if(input$xText==0){
          xTex<-theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
        }

        if(input$yText==0){
          yTex<-theme(axis.text.y=element_blank(), axis.ticks.y=element_blank())
        }

        if(input$flipCoord==1){
          horiz<- coord_flip()
        }

        if(input$backroundGrey==0){
          bkr<- theme_bw()
        }

        if(input$gridLines==0){
          grid<- theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
        }

        if(input$barLabel==1){
          barLab<- geom_text(aes(label=input$Y_axis1), vjust=as.double(input$barLabelLocation,
          color=input$barLabelColor, size=as.double(input$barLabelSize)))
        }

        myHist + horiz + barLab  + bkr +grid+ axisSize + legendPos + xTex + yTex + fct
      }
    })


  })

  observeEvent(input$plotScat, {

    df<- read_excel(data()[[1, 'datapath']])

    if(input$summarize ==1){
      output$avgs <- renderPrint({
        cdata <- aggregate(df1[c(as.character(input$avgGroup))],
        by=df1[c(as.character(input$discreteGroup))], function(x) c(mean=mean(x), sd=sd(x)))
        cdata
      })
    }

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
    yaxis <- input$y_axis1
    
    if(input$doFills==1){
      fillVar = input$fill_var11
    }

  output$scatter <- renderPlot({

    if (input$plotType == "scatter"){

      my.formula <- data()$get(input$x_axis1) ~ data()$get(input$y_axis1)

      if(input$plotType=="sp"){
        myScat <- ggplot(df, aes_string(x=input$x_axis1, y=input$y_axis1, fill=fillVar), show.legend=TRUE) +
        geom_point(size= as.integer(input$pointSize), shape=as.integer(input$shape)) +
        labs(title=input$titles, x=input$xlabels, y=input$ylabels, fill=input$legendLabels)+
        xlim(as.double(input$xMin), as.integer(input$xMax)) +
        ylim(as.double(input$yMin), as.integer(input$yMax))
      }

      if(input$plotType=="bp"){
          myScat<- ggplot(df, aes_string(x=input$x_axis1, y=input$y_axis1, fill=fillVar), show.legend=TRUE)+
          geom_point(mapping = aes(color = fillVar),
          position = position_jitterdodge(jitter.height=0.1, jitter.width=0.1), dodge.width = 0.1) +
          geom_boxplot(notch=input$doNotch, outlier.size=0)
      }

      if(input$addJitter == 1){
        jit<- geom_point(mapping = aes(color = fillVar),
        position = position_jitterdodge(jitter.height=0.1, 
        jitter.width=0.1), dodge.width = 0.1)
        jitColor <- scale_color_brewer(input$jitterColor)
      }

      if(input$fillTheme != "default"){
        if(input$plotType=="sp"){
          colorTheme<-scale_color_brewer(palette = input$fillTheme)
        }
        else{
          colorTheme <- scale_fill_brewer(c(palette = input$fillTheme))
        }
      }

      if(input$linearReg == 1){
        linReg<- geom_smooth(method=lm, linetype=input$lineStyle, se=input$linearSE, col=input$linearColor)
      }

      if(input$backroundGreys==0){
          bkr<- theme_bw()
      }
      
      if(input$gridLiness==0){
        grid<- theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
      }

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
        
      #log, sqrt axis
      if(input$xTransform!="none"){
        logTransformX <- scale_x_continuous(trans= as.character(input$xTransform))
      }
      if(input$yTransform!="none"){
        logTransformY <- scale_y_continuous(trans= as.character(input$yTransform))
      }
        
      #plot graph
      myScat + linReg +bkr +grid+ axisSize + R2 + legendPos + xTex + yTex +
      pointColor+ addFacet + xTickDir + yTickDir + logTransformX +logTransformY + colorTheme +bpAvg + jitColor +jit


    }
  })


  })
  
  
}

