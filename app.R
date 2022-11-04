#Updates to make:
# - Update to welcome more complex data
# - Add error in the x and y direction
# - Split up the plot according to different categorical variables.
# - Customization Settings
  # - Changing the color
  # - Changing the line width
  # - X and y labels and titles
# - Legends
# - Log-transform x or y axes


#Install Packages

#install.packages("shiny")
#install.packages("shinyWidgets")
#install.packages("readxl")
#install.packages("DT")
#install.packages("ggplot2")
#install.packages("colourpicker")
# install.packages("forcats")
# install.packages("ggpmisc")
# install.packages("raster")
# install.packages("ggplotify")
#install.packages("pheatmap")

#Load Packages
library(shiny)
library(shinyWidgets)
#library(readxl)
#library(DT)
library(ggplot2)


library(forcats)
library(colourpicker)
library(ggpmisc)
library(raster)
#library("RColorBrewer")
library(plyr)
library(ggplotify)
#library(pheatmap)
library(gplots)
library(grid)






#Sources
source('ui.R', local = TRUE)
source('server.R')

#Shiny App
shinyApp(ui = ui, server = server)
