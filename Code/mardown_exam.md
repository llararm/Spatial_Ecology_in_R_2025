---
title: "Spatial Distribution and Density of a Species in Brazil"
author: "Your Name"
date: "`r Sys.Date()`"
output: html_document
---

# Introduction

Understanding the spatial distribution of species is a fundamental topic in ecology, as it provides insights into population density, dispersal patterns, and potential environmental preferences.  
Spatial analyses based on occurrence records are widely used in biodiversity monitoring and conservation planning.

The objective of this project is to analyze the spatial distribution and density of a species using occurrence data obtained from the Global Biodiversity Information Facility (GBIF).  
The analysis focuses on visualizing occurrence points across Brazil and estimating spatial density patterns.

Compreender a distribuição espacial das espécies é um tema fundamental em ecologia, pois fornece informações sobre densidade populacional, padrões de dispersão e potenciais preferências ambientais, na qual podemos entender como a espécie se relaciona com o ambiente.

Análises espaciais baseadas em registros de ocorrência utilizam informações geográficas para mapear onde as espécies são encontradas, permitindo a identificação de padrões de distribuição e áreas de concentração. Essas análises são amplamente aplicadas no monitoramento da biodiversidade e no planejamento da conservação, pois ajudam a identificar regiões ecologicamente importantes e apoiam os processos de tomada de decisão.

O objetivo deste projeto é analisar a distribuição espacial e a densidade da espécie _Chrysocyon brachyurus_, nome popular: Lobo-Guará, uma espécie de canídeo da América do Sul, utilizando dados de ocorrência obtidos do Sistema Global de Informação sobre Biodiversidade (GBIF).

A análise concentra-se na visualização de pontos de ocorrência em todo o Brasil e na estimativa de padrões de densidade espacial.
---

# Data and Methods

## Data source

Occurrence data were obtained from the **GBIF database** using the taxon key `2434450`.  
Only records with valid geographic coordinates were included in the analysis.

## R packages

The following R packages were used:

```
library(rgbif)        # Access GBIF data
library(spatstat)     # Spatial point pattern analysis
library(ggplot2)      # Data visualization
library(viridis)      # Colorblind-friendly color scales
library(patchwork)    # Combine plots
library(rnaturalearth)# Country maps
library(sf)           # Spatial vector data
```

## Data Collection and preprocessing

```
taxonKey <- 2434450

dados_gbif <- occ_search(
  taxonKey = taxonKey,
  limit = 500,
  hasCoordinate = TRUE
)

df <- dados_gbif$data[, c("decimalLongitude", "decimalLatitude", "country", "year")]

df <- df[!is.na(df$decimalLongitude) & !is.na(df$decimalLatitude), ]
df <- df[!duplicated(df[, c("decimalLongitude", "decimalLatitude")]), ]
```

## Spatial objects

```
# Load map of Brazil
brasil <- ne_countries(country = "Brazil", scale = "medium", returnclass = "sf")

# Create point pattern object
window <- owin(
  xrange = range(df$decimalLongitude),
  yrange = range(df$decimalLatitude)
)

pontos <- ppp(
  x = df$decimalLongitude,
  y = df$decimalLatitude,
  window = window
)

# Estimate spatial density
densidade <- density(pontos, sigma = 0.5)

dens_raster <- as.data.frame(as.im(densidade))
colnames(dens_raster) <- c("lon", "lat", "densidade")
```

# Results

## Spatial density and occurrence maps

Two complementary visualizations were produced:
- A spatial density map, showing the intensity of occurrence records
- A map of occurrence points, showing the geographic distribution of records across Brazil

```
# Density map
p1 <- ggplot(dens_raster, aes(x = lon, y = lat, fill = densidade)) +
  geom_tile(alpha = 0.9) +
  scale_fill_viridis(option = "viridis", direction = -1) +
  coord_equal() +
  theme_minimal() +
  labs(
    title = "Spatial density of the species",
    x = "Longitude",
    y = "Latitude",
    fill = "Density"
  )

# Occurrence points over Brazil
p2 <- ggplot() +
  geom_sf(data = brasil, fill = "#C1FFC1", color = "#698B69") +
  geom_point(
    data = df,
    aes(x = decimalLongitude, y = decimalLatitude),
    color = "#E69F00",
    size = 2
  ) +
  coord_sf(xlim = c(-75, -35), ylim = c(-35, 5)) +
  theme_minimal() +
  labs(
    title = "Occurrence points in Brazil",
    x = "Longitude",
    y = "Latitude"
  )

# Combine plots
p1 + p2
```
<img width="1920" height="992" alt="image" src="https://github.com/user-attachments/assets/b01b2f67-86f1-45dc-b594-c1eefccf2e12" />

# Discussion

The occurrence map shows that the species is not evenly distributed across Brazil, with records concentrated in specific regions.
This pattern suggests spatial aggregation, which may reflect environmental suitability, sampling effort, or ecological constraints.

The density map complements this interpretation by highlighting areas with higher concentrations of records, allowing a clearer visualization of spatial intensity.
Presenting the density map separately avoids visual distortions caused by irregular geographic boundaries.

Colorblind-friendly palettes (viridis and Okabe–Ito colors) were used to ensure accessibility and accurate interpretation of the visualizations.

# Conclusion

This project demonstrates how GBIF occurrence data can be used to analyze spatial distribution and density patterns in ecology.
The combination of point occurrence maps and density estimation provides a clear and interpretable overview of species distribution, using reproducible and accessible visualization methods in R.

Such approaches are valuable tools for ecological research, biodiversity monitoring, and conservation planning.
