#aquest programa recull els resultats dels partits de waterpolo de la federacio catalana de natacio i els representa en un heatmap interactiu

install.packages("d3heatmap")
install.packages("rvest")

library(rvest)
classificacio_waterpolo <- html("http://aquatics.cat/competicio/informacioCompeticio/2016/9/49/0")

#recupero la segona taula que apareix en aquesta pagina amb ".[[2]]" que és la que m'interessa i la transformo en un dataframe amb html_table
classificacio_waterpolo %>%
  html_nodes("table") %>%
  .[[2]] %>%
  html_table()

#me la puc descarregar com a csv i després llegir-la
#llegeixo el csv de resultats partits de waterpolo des del directori on m'he l'he descarregat
waterpolo_heatmap <- read.csv("classificacio_waterpolo.csv", row.names = 1)
library(d3heatmap) #d3heatmap és un paquet per generar heatmaps interactius en D3.js javascript dins R
d3heatmap(waterpolo_heatmap, scale = "column")
