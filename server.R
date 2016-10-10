#shiny project 
library(ggplot2)
library(shiny)
library(dplyr)
library(googleVis)


# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  month_data <- reactive({
    df <- filter(by_month_clean, month == input$month)
    return (df)
  })
    
  output$worldmap <- renderGvis({
        print (head(by_country_clean))
        gvisGeoChart(by_country_clean, locationvar = "country", colorvar = "visit",
                                 options=list(width=500, height=400))
    })
  output$statemap <- renderGvis({
    print(head(by_region_clean))
    gvisGeoChart(by_region_clean, "region", "visit",
                 options=list(region="US", displayMode="regions",
                              resolution="provinces",
                              options=list(width="1000px")))
  })
#   output$mymap <- renderLeaflet({
#     
#     popup <- paste0(by_region_clean$region,
#                     by_region_clean$visit)
#     
#     by_countryplot=gvisGeoChart(by_country_clean, locationvar = "country", colorvar = "visit")
#     plot(by_countryplot)
    
    #leaflet(myresults) %>%
     # addTiles() %>% 
      #addPolygons(data=us, weight = 2, fillColor = "yellow", popup=popup)
  #})
  
  
  # Fill in the spot we created for a plot
  output$monthplot <- renderPlot({
    
     #Render a barplot
    #ggplot(data=by_month_clean)+geom_bar(aes(month,visit),stat = 'identity')
    qplot(month, data=by_country, fill=deviceCategory,position="stack")
  })
  
})