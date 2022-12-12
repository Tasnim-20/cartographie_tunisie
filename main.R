install.packages("terra")
library(dplyr)
library(maptools)
library(sp)
library(shapefiles)
library(raster)
library(leaflet)
library(raster)
library(htmlwidgets)
library(maptools)
donnees <- read.csv("E:\\Tasnim chiba\\ing1\\analyse de donnees\\cartographie\\data.csv", header = TRUE, sep = ",", encoding = "latin1")
dim(donnees)
tun <- getData("GADM", country="TUN", level=1)
tun$nb <- donnees$nb
pal <- colorQuantile("red", NULL, n = 5)
polygon_popup <- paste0("<strong>Name: </strong>", donnees$city, "<br>",
                        "<strong>Indicator: </strong>", round(donnees$nb,2))


pal<-colorNumeric(
  palette = c("#ffff00","#ff0000"),
  domain = tun$nb
)
title_ = "<div style='text-align: center; font-weight: bold;'>Nombre de naissance en Tunisie (2021)</div>"

map = leaflet() %>% 
  setView(9.5, 34,zoom = 6) %>% 
  addControl(title_, position = "topleft") %>%
  addPolygons(data = tun,fillColor= ~pal(nb),fillOpacity = 0.4,weight = 2,color = "white",popup = polygon_popup)%>%
addLegend("bottomright", pal=pal, values=donnees$nb, title="Nombre de naissances selon lieu d'accouchement", opacity = 1)

map
