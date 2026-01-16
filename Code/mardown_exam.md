---
title: "Spatial Distribution and Density of _Chrysocyon brachyurus_ in Brazil"
author: "Lara Ribeiro Maia"
date: "`21.01.2026`"
output: html_document
---

# Introduction

Understanding the spatial distribution of species is a fundamental topic in ecology, as it provides information on population density, dispersal patterns, and potential environmental preferences, allowing us to understand how a species relates to its environment.

Spatial analyses based on occurrence records use geographic information to map where species are found, enabling the identification of distribution patterns and areas of concentration. These analyses are widely applied in biodiversity monitoring and conservation planning, as they help identify ecologically important regions and support decision-making processes.

The objective of this project is to analyze the spatial distribution and density of the species _Chrysocyon brachyurus_, commonly known as the Maned Wolf/Lobo-Guará, a canid specie from South America, using occurrence data obtained from the Global Biodiversity Information System (GBIF).

<img width="1300" height="768" alt="image" src="https://github.com/user-attachments/assets/b546325e-bad3-4f11-bd38-003952daeca2" />

The analysis focuses on visualizing occurrence points across Brazil and estimating spatial density patterns.

---

# Data and Methods

## Data source

Occurrence data were obtained from the GBIF database using the taxon key `2434450`.  
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

The occurrence map shows that the species is not uniformly distributed across Brazil, with records concentrated in specific regions, mainly in the Cerrado biome. Points outside the map indicate the species' location outside the country in other South American countries, such as Argentina.

This pattern reveals the species' characteristic of being fully adapted to the characteristics of the open environments of the South American savannas.

The density map complements this interpretation, highlighting areas with higher concentrations of records, allowing for a clearer visualization of spatial intensity.

Colorblind-friendly color palettes were used to ensure accessibility and accurate interpretation of the visualizations.

# Conclusion

This project demonstrates how GBIF occurrence data can be used to analyze spatial distribution and density patterns in ecology.
By combining point occurrence maps with density estimation, it is possible to clearly visualize species distribution patterns using reproducible and accessible visualization approaches in R.

These approaches are valuable tools for ecological research, biodiversity monitoring, and conservation planning.
