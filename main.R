#Les library qu'on aura besoin 
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
#lecture des données à partir d'un fichier csv
donnees <- read.csv("data.csv", header = TRUE, sep = ",", encoding = "latin1")

#verification des dimensions de notre données
dim(donnees)

#chagement des emplacements de chaque gouvernorat
tun <- getData("GADM", country="TUN", level=1)

#projection des données sur notre map
tun$nb <- donnees$nb

#déterminer le nom et le nombre selon chaque gouvernorate en cliquant sur la gouvernorat
polygon_popup <- paste0("<strong>gouvernorat: </strong>", donnees$city, "<br>",
                        "<strong>Nombre: </strong>", round(donnees$nb,2))

#choit des couleur de la carte pour mettre en valeur la variation
pal<-colorNumeric(
  palette = c("#ffff00","#ff0000"),
  domain = tun$nb
)

#détérminaison du titre
title_ = "<div style='text-align: center; font-weight: bold;'>Nombre de naissance en Tunisie (2021)</div>"

map = leaflet() %>% 
  setView(9.5, 34,zoom = 6) %>% 
  addControl(title_, position = "topleft") %>%
  addPolygons(data = tun,fillColor= ~pal(nb),fillOpacity = 0.4,weight = 2,color = "white",popup = polygon_popup)%>%
  #ajout de la légende
addLegend("bottomright", pal=pal, values=donnees$nb, title="Nombre de naissances selon lieu d'accouchement", opacity = 1)

#affichage de la map
map
