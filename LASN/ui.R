########################################
## User Interface for LASN Statistics ##
#
# author: matt cefalu

# columns
cols = c( "PA" ,   "PC"  ,  "PCT" ,  "PTD" ,  "PXP" , 
          "I"    , "RAtt" , "RTD" ,  "RXP" ,  "Rc"   ,
          "RcTD" , "RcXP" , "Sacks", "DI"  ,  "DTD"  ,
          "DXP"  , "RtTD" , "FPs"  )


names(cols) = c("Pass Attempts","Pass Completions","Completion Percentage","Pass TD" , "Pass XP", 
                "Pass Interceptions" , "Rush Attempts" , "Rush TD" , "Rush XP" , "Receptions" , 
                "Receiving TD" , "Receiving XP" , "Sacks" , "Defensive Interceptions" , "Defensive TD",
                "Defensive XP", "Return TD" , "Flag Pulls")

cols = as.list(cols)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("LASN West LA"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       fluidRow( column(12,selectInput("league", 
                                      label = "League",
                                      choices = list("West LA Saturday","West LA Sunday"),
                                      selected = "West LA Saturday"))),
       fluidRow( column(12,uiOutput("Season"))),
       fluidRow(
         column(6,selectInput("var1", 
                   label = "Choose a statistic to display",
                   choices = cols,
                   selected = "Rc")) ,
         column(6,selectInput("var2", 
                   label = "Choose a statistic to display",
                   choices = cols,
                   selected = "RcTD"))) , 
       fluidRow( column(12,uiOutput("slider1"))  ) ,
       fluidRow( column(12,uiOutput("Player"))) 
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("Plot")
    )
  )
))
