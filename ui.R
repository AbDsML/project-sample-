library(shiny)
myresults=read.table("e:/nycds/shiny project/myresults.csv",sep = ',',header = T)

# # Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("NYC non-profit web trafic analysis"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        #selectInput("month", "Month:", 
         #           choices=order(unique(by_month_clean$month))),
        #hr(),
        helpText("Data is obtained from Goolge Analytics API")
      ),
    
      # Create a spot for the barplot
      mainPanel(
        tabsetPanel(
          tabPanel("By Month",selectInput("month", "Month:", 
                                          choices=order(unique(by_month_clean$month))), plotOutput("monthplot")),
          tabPanel("World Map", htmlOutput("worldmap")),
          tabPanel("State Map", htmlOutput("statemap"))
          
        )
        #leafletOutput("mymap")
      )
    )
  )
)

