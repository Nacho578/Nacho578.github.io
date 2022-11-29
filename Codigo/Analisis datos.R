library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)


datos_oro <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos Futuros oro.csv")
datos_TSLA <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos TSLA (1).csv")
datos_sp500 <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos S&P 500.csv")
tail(datos_sp500)
tail(datos_TSLA)
tail(datos_oro)



names(datos_oro)

datos_oro$Fecha <- as.Date(datos_oro$Fecha, format = "%d.%m.%Y")
datos_TSLA$Fecha <- as.Date(datos_TSLA$Fecha, format = "%d.%m.%Y")
datos_sp500$Fecha <- as.Date(datos_sp500$Fecha, format = "%d.%m.%Y")

datos_oro$Vol. <- NULL
datos_sp500$Vol. <- NULL
datos_TSLA$Vol. <- NULL



write_csv(datos_oro, "C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos Futuros oro.csv")
write_csv(datos_sp500,"C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos S&P 500.csv")
write_csv(datos_TSLA,"C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos TSLA (1).csv")
