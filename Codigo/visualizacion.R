
library(readr)
library(dplyr)
library(ggplot2)
library(forcats) 
library(tidyverse) 
library(stringr)   
library(rebus) 
library(gt)
library(gtsummary)
library(stats)
library(zoo)
library(pracma)



datos_EURJPY <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos EUR_JPY (1).csv")
datos_GBPUSD <- read_csv("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Datos/Datos históricos GBP_USD.csv")


var(datos_EURJPY$`% var.`)
var(datos_GBPUSD$`% var.`)

###Ganancias Maximas----

max_winEURJPY <- ((datos_EURJPY$Máximo - datos_EURJPY$Mínimo)/datos_EURJPY$Máximo)*datos_EURJPY$...1
datos_EURJPY$acumuladaEURJPY <- rev(cumsum(max_winEURJPY))

max_winGBPUSD <- ((datos_GBPUSD$Máximo - datos_GBPUSD$Mínimo)/datos_GBPUSD$Máximo)*datos_EURJPY$...1
datos_GBPUSD$acumuladaGBPUSD <- rev(cumsum(max_winGBPUSD))

ggplot(datos_GBPUSD, aes(x = Fecha, acumuladaGBPUSD))+
  geom_line(size = 1, color = '#1fb791') +
  theme_minimal()+ 
  labs(title = 'Ganancia Maxima GBPUSD',
       y = 'Multiplicador de dinero')

ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/MAXgbp.png", width = 10, height = 7)

ggplot(datos_EURJPY, aes(x = Fecha, acumuladaEURJPY))+
  geom_line(size = 1, color = '#1fb791') +
  theme_minimal() + 
  labs(title = 'Ganancia MaximaEURJPY',
       y = 'Multiplicador de dinero')
ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/MAXeur.png", width = 10, height = 7)


###Estrategia Trading----
sma <- function(x,n){
  rollmean(x, n, fill = NA, align = "right")
}

EMA <- function(x, nn){
  movavg(x, n = nn, type = "e")
}

myRSI <- function (price,n){
  N <- length(price)
  U <- rep(0,N)
  D <- rep(0,N)
  rsi <- rep(NA,N)
  Lprice <- lag(price,1)
  for (i in 2:N){
    if (price[i]>=Lprice[i]){
      U[i] <- 1
    } else {
      D[i] <- 1
    }
    if (i>n){
      AvgUp <- mean(U[(i-n+1):i])
      AvgDn <- mean(D[(i-n+1):i])
      rsi[i] <- AvgUp/(AvgUp+AvgDn)*100 
    }
  }

  return(rsi)
}

rsi <-myRSI(datos_EURJPY$Último, 14)

length(datos_EURJPY)

datos_EURJPY$EMA_50EURJPY <- EMA(datos_EURJPY$Apertura, 50)

datos_EURJPY$EMA_200EURJPY <- EMA(datos_EURJPY$Apertura, 200)

datos_GBPUSD$EMA_50GBPUSD <- EMA(datos_GBPUSD$Apertura, 50)

datos_GBPUSD$EMA_200GBPUSD <- EMA(datos_GBPUSD$Apertura, 200)









plot(datos_EURJPY$Fecha, datos_EURJPY$EMA_50EURJPY, type = 'l', xlab = 'Fecha', ylab = 'EMA', main = 'Trading Cruces de EMA EURJPY', col = 'BLue', lwd = 2)
lines(datos_EURJPY$Fecha, datos_EURJPY$EMA_200EURJPY, col = 'green', lwd=3)
legend("bottom", legend = c("EMA50", "EMA200"), col = c(2, 3))


ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/EMAEURJPY.png", width = 10, height = 7)

plot(datos_GBPUSD$Fecha, datos_GBPUSD$EMA_50GBPUSD, type = 'l', xlab = 'Fecha', ylab = 'EMA', main = 'Trading Cruces de EMA GBPUSD', col = 'BLue', lwd = 2)
lines(datos_GBPUSD$Fecha, datos_GBPUSD$EMA_200GBPUSD, col = 'green', lwd=3)
legend("bottom", legend = c("EMA50", "EMA200"), col = c(2, 3))


ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/EMAGBPUSD.png", width = 10, height = 7)




###Estrategia Value investing----

promedioEURJPY <- cumsum(rev(datos_EURJPY$Apertura))/(datos_EURJPY$...1)
ajuste_gananciasEURJPY <- ((rev(datos_EURJPY$Apertura)-promedioEURJPY)*datos_EURJPY$...1)

datos_EURJPY$graficoEURJPY <- rev(ajuste_gananciasEURJPY/promedioEURJPY)




promedioGBPUSD <- cumsum(rev(datos_GBPUSD$Apertura))/(datos_GBPUSD$...1)
ajuste_gananciasGBPUSD <- ((rev(datos_GBPUSD$Apertura)-promedioGBPUSD)*datos_GBPUSD$...1)

datos_GBPUSD$graficoGBPUSD <- rev(ajuste_gananciasGBPUSD/promedioGBPUSD)


ggplot(datos_GBPUSD, aes(x = Fecha, graficoGBPUSD))+
  geom_line(size = 1, color = '#63B8FF') +
  theme_minimal()+ 
  labs(title = 'Dollar cost Averaging GBPUSD',
       y = 'Multiplicador de dinero')

ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/dcagbp.png", width = 10, height = 7)

ggplot(datos_EURJPY, aes(x = Fecha, graficoEURJPY))+
  geom_line(size = 1, color = '#63B8FF') +
  theme_minimal() + 
  labs(title = 'Dollar cost Averaging EURJPY',
       y = 'Multiplicador de dinero')

ggsave("C:/Users/nachi/OneDrive/Desktop/Programacion/R/Let/Habilidades_Comunicativas/Figuras/dcaeur.png", width = 10, height = 7)
