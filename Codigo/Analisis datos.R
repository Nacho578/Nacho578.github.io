library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)


datos_EURJPY <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos EUR_JPY (1).csv")
datos_GBPUSD <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos GBP_USD.csv")




datos_EURJPY$Fecha <- as.Date(datos_EURJPY$Fecha, format = "%d.%m.%Y")
datos_GBPUSD$Fecha <- as.Date(datos_GBPUSD$Fecha, format = "%d.%m.%Y")


datos_EURJPY$Vol. <- NULL
datos_GBPUSD$Vol. <- NULL


datos_EURJPY$Último <- datos_EURJPY$Último/100
datos_EURJPY$Apertura <- datos_EURJPY$Apertura/100
datos_EURJPY$Máximo <- datos_EURJPY$Máximo/100
datos_EURJPY$Mínimo <- datos_EURJPY$Mínimo/100

datos_GBPUSD$Último <- datos_GBPUSD$Último/10000
datos_GBPUSD$Apertura <- datos_GBPUSD$Apertura/10000
datos_GBPUSD$Máximo <- datos_GBPUSD$Máximo/10000
datos_GBPUSD$Mínimo <- datos_GBPUSD$Mínimo/10000

datos_EURJPY$`% var.` <- str_sub(datos_EURJPY$`% var.`, 1, nchar(datos_EURJPY$`% var.`)-1 )
datos_EURJPY$`% var.` <- str_replace(datos_EURJPY$`% var.`, ",", ".")
datos_EURJPY$`% var.` <- as.numeric(datos_EURJPY$`% var.`)

datos_GBPUSD$`% var.` <- str_sub(datos_GBPUSD$`% var.`, 1, nchar(datos_GBPUSD$`% var.`)-1 )
datos_GBPUSD$`% var.` <- str_replace(datos_GBPUSD$`% var.`, ",", ".")
datos_GBPUSD$`% var.` <- as.numeric(datos_GBPUSD$`% var.`)



write.csv(datos_EURJPY, "C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos EUR_JPY (1).csv")
write.csv(datos_GBPUSD, "C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos GBP_USD.csv")


