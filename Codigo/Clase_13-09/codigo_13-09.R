
#Paquetes
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(string)

datos_paises <- read_excel("Datos/Clase 13-09/datos-paises.xlsx", sheet = "ES")

esperanza_vida <- read_csv("Datos/Clase 13-09/esperanza-de-vida.csv", skip = 4)

pib <- read_csv("Datos/Clase 13-09/pib.csv", skip = 4)

poblacion <- read_csv("Datos/Clase 13-09/poblacion.csv", skip = 4)

############333

esperanza_vida <- esperanza_vida |>
    pivot_longer(cols = "1960":"2020",
                 names_to = "anio",
                 values_to = "esperanza_de_vida",
                 names_transform = list(anio = as.integer))

pib <- pib |>
    pivot_longer(cols = "1960":"2020",
                 names_to = "anio",
                 values_to = "pib",
                 names_transform = list(anio = as.integer))

poblacion <- poblacion |>
    pivot_longer(cols = "1960":"2020",
                 names_to = "anio",
                 values_to = "poblacion",
                 names_transform = list(anio = as.integer)) |>
    mutate(poblacion = case_when(
        str_detect(poblacion, "M") ~
        as.numeric(str_remove(poblacion, "M")) * 10^6,
        str_detect(poblacion, "B") ~
        as.numeric(str_remove(poblacion, "B")) * 10^9,
        str_detect(poblacion, "k") ~
        as.numeric(str_remove(poblacion, "k")) * 10^3,
        TRUE ~ as.numeric(poblacion)
    ))

datos_finales <- esperanza_vida |>
    left_join(pib) |>
    left_join(poblacion) |>
    left_join(datos_paises)

View(datos_finales)
write_csv(datos_finales, "Datos/Clase 13-09/datos-finales.csv")