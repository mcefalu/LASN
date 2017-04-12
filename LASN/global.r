############################################
## Global Information for LASN Statistics ##
#
# author: matt cefalu

library(shiny)
library(data.table)
library(ggplot2)
library(plotly)

# read data
dta = read.csv("data/westLA_saturday_season12.csv",as.is=T)
dta = rbind( dta , read.csv("data/westLA_sunday_season3.csv",as.is=T) )
dta = rbind( dta , read.csv("data/westLA_saturday_career.csv",as.is=T) )
setDT(dta)
dta[ ,label:= paste("Player:", Player)]
