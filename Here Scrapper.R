# Import Libraries
# install.packages('curl')
# install.packages('jsonlite')
library(jsonlite)

# Set Variables
time_limit <- '1800'
departure_time <- '2017-09-19T07:00:00-'
city_names =  c('Vancouver','Calgary','Edmonton','Winnipeg','Toronto','Mississauga','Ottawa','Montreal','Quebec City','Halifax')
time_zones = c('07:00','06:00','06:00','05:00','04:00','04:00','04:00','04:00','04:00','03:00')
city_centers = c('49.284454,-123.121127','51.045737,-114.070382','53.540940,-113.493783','49.895491,-97.138462','43.648649,-79.380261','43.593663,-79.635041','45.419617,-75.702900','45.501880,-73.567427','46.770575,-71.281839','44.649200,-63.574995')
pedestrian_transit <- 'fastest;pedestrian;traffic:enabled'
car_transit <- "fastest;car;traffic:enabled"
json_r <- c()
appid <- "lI6m3V4mxHGGx0oZgiXa"
appcode <- "8XbgEYV29kplyJLKBQKOkg"

i <- 1
while(i < 11){
  url = paste("https://isoline.route.cit.api.here.com/routing/7.2/calculateisoline.json?app_id=",appid,"&app_code=",appcode,"&mode=",car_transit,"&rangetype=time&destination=geo!",city_centers[[i]],"&range=",time_limit,"&arrival=",departure_time,time_zones[[i]], sep="")
  json_r[[i]]<- fromJSON(url)
  json_r[[i]]<- lapply(json_r[[i]], function(x) {
    x[sapply(x, is.null)] <- NA
    unlist(x)
  })
  #isolate fields that contain the polygon
  json_r[[i]] <- json_r[[i]]$response[grepl("isoline.component.shape", names(json_r[[i]]$response))]
  i <- i + 1
}