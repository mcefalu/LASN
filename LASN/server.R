############################################
## Server Information for LASN Statistics ##
#
# author: matt cefalu

# columns
cols1 = c("Pass Attempts","Pass Completions","Completion Percentage","Pass TD" , "Pass XP", 
         "Pass Interceptions" , "Rush Attempts" , "Rush TD" , "Rush XP" , "Receptions" , 
         "Receiving TD" , "Receiving XP" , "Sacks" , "Defensive Interceptions" , "Defensive TD",
         "Defensive XP", "Return TD" , "Flag Pulls")

names(cols1) = c( "PA" ,   "PC"  ,  "PCT" ,  "PTD" ,  "PXP" , 
                 "I"    , "RAtt" , "RTD" ,  "RXP" ,  "Rc"   ,
                 "RcTD" , "RcXP" , "Sacks", "DI"  ,  "DTD"  ,
                 "DXP"  , "RtTD" , "FPs"  )

cols1 = as.list(cols1)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$Plot <- renderPlotly({
     
   if (!is.null(input$min_att)){  
      index <- dta$PA>=input$min_att & dta$Season==input$season & dta$League==input$league
   }else{
      index <- dta$PA>=0 & dta$Season==input$season & dta$League==input$league
   }
     
   # create initial 
   g <- ggplot( dta[index ,] , aes_string(x=input$var1 , y=input$var2 , fill="Team" , text="label") ) + geom_point(shape=21 , size=2 , stroke=0.3) + 
      scale_fill_manual(values=setNames(dta$Color, dta$Team)) + 
      theme(panel.background = element_rect(fill = "grey90")) + coord_equal(ratio=1) +
      xlab(cols1[[input$var1]]) + ylab(cols1[[input$var2]])# +
      #geom_point(data=dta[ind,],aes_string(x=input$var1 , y=input$var2),text=paste("Player:", dta[ind,]$Player) , color='red')

   # Convert ggplot object to plotly
   #g <- plotly_build(g)
   if (class(input$player)=="character"){
   if (nchar(input$player)>0){  
      ind <- grepl(input$player,dta$Player) & dta$Season==input$season & dta$League==input$league
      g <- g + geom_point(data=dta[ind,],color="red")
   }}
   
   g 
    
  })
  
  output$slider1 <- renderUI({
     if (any(grepl("PA|PC|PCT|PTD|PXP|^I",c(input$var1 , input$var2) )) ){
         return(sliderInput("min_att", "Minimum number of attempts",
                        min = 0, max = 100, value = 0))
     }else{ return(NULL)}
  })
  
  output$Season <- renderUI({
     selectInput("season", 
                 label = "Season",
                 choices = dta[League==input$league,sort(unique(Season))],
                 selected = NULL)
  })
  
  output$Player <- renderUI({
     if (length(input$season)>0){
     if (input$season=="Career"){
        return(textInput("player", 
                    label = "Player name",
                    value = ""))
     }else{return(NULL)}
     }
  })
  
})


