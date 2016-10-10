# Great Positive 
#install.packages("devtools")
library(devtools)
#install_github("rga", "skardhamar")
library(rga)
#install.packages("httr")
library("httr")
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
rga.open(instance="ga")
#code for google analytics '4/iIUIC0Kplur1_Cw7dKm6JxP84e9EPNdZrGtJm3CgmhQ'

#get the profile ID 
#ga$getProfiles() # first column


#or on your Google Analytics Admin page, go to View Settings and you'll see the ID under "View ID."
id<-"86433623"

#If you want to see all available methods for your ga object, run:
#ga$getRefClass()

#to see the overall number of visits without breaking it down by source,
myresults <- ga$getData(id, start.date="2015-01-01", end.date="2016-02-10",
                        metrics = "ga:users, ga:visits, ga:pageviews, ga:sessionDuration",
                        dimensions="ga:year,ga:month,ga:country,ga:region,ga:longitude,
                        ga:latitude,ga:deviceCategory", batch = T)
write.csv(myresults,file="e:/nycds/shiny project/myresults.csv")

#install.packages("ggthemes")
library(ggthemes)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(leaflet)
#install.packages("maps")
#install.packages("mapproj")
library(mapproj)
library(maps)
library(shiny)
runExample("01_hello")
runExample("02_text")
runExample("03_reactivity")
runExample("04_mpg")
runExample("05_sliders")
runExample("06_tabsets")
runExample("07_widgets")



??maps
display.brewer.all()
str(myresults)
summary(myresults)
nrow(myresults[myresults$latitude==0,])
nrow(myresults[myresults$longitude==0,])
nrow(myresults[myresults$country=="(not set)",])
myresults$country=as.factor(myresults$country)
myresults$region=as.factor(myresults$region)
myresults$deviceCategory=as.factor(myresults$deviceCategory)


#by country
by_country=group_by(myresults, country)%>% arrange(desc(visits))
head(by_country)

by_country_clean=by_country %>% summarise(visit=sum(visits))%>% arrange(desc(visit))
ggplot(data=by_country_clean[1:10,])+geom_bar(aes(country, visit), stat='identity')
by_c=by_country%>%summarise(visits)%>% arrange(desc(visits))

#by state (region)
by_region=group_by(myresults,region)
by_regionus=subset(by_region,country=="United States")
dim(by_regionus)
length(by_regionus$region=="(not set)")


by_region_clean=by_region %>% summarise(visit=sum(visits)) %>% arrange(desc(visit))
ggplot(data = by_region_clean[1:10,])+geom_bar(aes(region,visit),stat='identity')

#by month 
by_month=group_by(myresults,month)
by_month_clean=by_month %>% summarise(visit=sum(visits))%>% arrange(desc(visit))
ggplot(data=by_month_clean)+geom_bar(aes(month,visit),stat = 'identity')
class(by_month_clean$month)

#device category by country
by_device=group_by(myresults,deviceCategory)
class(myresults$deviceCategory)
myresults$deviceCategory=as.factor(myresults$deviceCategory)
by_device_clean=by_device%>% summarise(deviceCategory)%>% arrange(desc(device))
ggplot(data=by_device[1:10,])+geom_bar(aes(country, fill=deviceCategory))



#device category by state


#device category by month 
names(myresults)
qplot(month, data=by_country, fill=deviceCategory,position="stack")
by_session=group_by(myresults,sessionDuration)
by_session_clean=by_session%>% summarise(visit=sum(visits))%>%arrange

#session duration by country 
by_session=group_by(myresults,sessionDuration)

#session duration by state

#session duration by month 




myresults$socialInteractions=NULL
summary(myresults$dataSource)
head(myresults,10)
distribution(myresults$dataSource)
myresults$dataSource=NULL
tail(myresults,10)

table(myresults$country)
table(myresults$region)

#keep first 5 columns
myresults=myresults[,1:5]
summary(myresults)
str(myresults)

hist(myresults$pageviews,myresults$week)
grpbywkvzt=myresults %>% group_by(week) %>% summarise(visit=sum(visits))
length(myresults$week)
ggplot(data=data.frame(grpbywkvzt))+geom_bar(aes(week, visit))


ggplot(myresults,aes(x=visits,fill=factor(week)))+
  geom_histogram(width=0.5)

summary(myresults$week)
plot(week)
week

ggplot(data=data.frame(grpbywkvzt))+geom_histogram(aes(week, visit), stat='identity')
myresults$deviceCategory=factor(myresults$deviceCategory)
summary(myresults$deviceCategory)
ggplot(data=data.frame(myresults))+geom_histogram(aes(deviceCategory))
ggplot(data=data.frame(by_country))+geom_bar(aes(week, fill=deviceCategory), position='dodge')
ggplot(data=data.frame(myresults))+geom_bar(aes(week, fill=deviceCategory))


temp = group_by(myresults, country) %>% summarise(count=sum(visits)) %>% top_n(10, count)
temp1 = inner_join(temp, myresults, by="country")
ggplot(data=myresults)+geom_bar(aes(country, visits, fill = deviceCategory), stat= 'identity', position = 'dodge')

table(myresults$visits)
summary(myresults$visits)
barplot(myresults$visits)
#barplot(myresults$pageviews
barplot(myresults[1:10,]$pageviews)
ggplot(myresults)+geom_bar(aes(pageviews), binwidth=50)

#install.packages("leaflet")

#install.packages("map")

summary(myresults)
View(myresults)

install.packages("googleVis")
library(googleVis)
#google vis

#by country 
by_countryplot=gvisGeoChart(by_country_clean, locationvar = "country", colorvar = "visit")
plot(by_countryplot)


leaflet(myresults) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions(polygonOptions(data=us, weight = 2))
  
)

#by_state
#states <- data.frame(state.name, state.x77)
by_regionplot <- gvisGeoChart(by_region_clean, "region", "visit",
                   options=list(region="US", displayMode="regions",
                                resolution="provinces",
                                width=600, height=400))
plot(by_regionplot)

leaflet(data = myresults) %>% addTiles() %>%
  addCircles(~longitude, ~latitude)

mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)
