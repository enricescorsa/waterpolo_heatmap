#aquest programa recull els resultats dels partits de waterpolo de la federacio catalana de natacio i els representa en un heatmap interactiu

install.packages("d3heatmap")
install.packages("rvest")
install.packages("XML")


library(rvest)
classificacio_waterpolo <- html("http://aquatics.cat/competicio/informacioCompeticio/2016/9/49/0")

#recupero la segona taula que apareix en aquesta pagina amb .[[2]]
classificacio_waterpolo %>%
  html_nodes("table") %>%
  .[[2]] %>%
  html_table()

#també ho puc fer amb XML (amb "which =2" selecciono la segona taula) i transformarla en un df amb readHTMLTable
library(XML)
url <- "http://aquatics.cat/competicio/informacioCompeticio/2016/9/49/0"
classificacio_waterpolodf <- readHTMLTable (url, which = 2)
classificacio_waterpolodf

#me la puc descarregar com a csv i després llegir-la
write.csv(classificacio_waterpolodf, file = "classificacio_waterpolo.csv")


#llegeixo el csv de resultats partits de waterpolo des del directori on m'he l'he descarregat
waterpolo_heatmap <- read.csv("classificacio_waterpolo.csv", row.names = 3)
library(d3heatmap) #paquet per generar heatmaps interactius en D3.js javascript dins R
d3heatmap(waterpolo_heatmap, scale = "column")
