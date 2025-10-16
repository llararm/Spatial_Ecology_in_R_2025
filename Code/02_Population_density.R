# code for estimating population density
# install.packages - use for download packages
install.packages("spatstat")
library(spatstat)


# let's use the bei data:
# data description:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data
plot(bei)

# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# all the colors in R: https://r-charts.com/colors/

# additional datasets
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
plot(bei.extra$elev)  #$ is used to linked different objects
plot(bei.extra[[1]])

el <- bei.extra[[1]]
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements
elevation2 <- bei.extra[[1]]
plot(elevation2)

# passing from points to a countinuous surface
beidens <- density(bei) #density of organisms
plot(beidens)
points(bei, cex=.2)

# density map
dmap <- density(bei)
plot(dmap)
points(bei)

########## DAY 2
# Plotting the maps one beside the other
par(mfrow=c(1,2)) # 1 porque é uma 1 linha (uma do lado da outra) e 2 pelo numero de colunas
plot(dmap)
plot(el)

# Exercise: make a multiframe with maps one on top of the other
par(mfrow=c(2,1)) # 2 porque é uma 2 linhas (um em cima da outra) e 1 pelo numero de colunas
plot(dmap)
plot(el)

# one frined to clear graphs
dev.off() # function to close the graph
plot(elevation2)

# Changin colors to maps
colorRampPalette # evitar sempre a usar o uso de escala rainbow por acessibilidade
cl <- colorRampPalette(c("black", "red", "yellow"))
plot(dmap, col=cl)

cl <- colorRampPalette(c("black", "red", "yellow"))(10) # o numero de foraindica o numero de cores intermediarias entre as escolhidas
plot(dmap, col=cl)

cln <- colorRampPalette(c("#27408B", "#551A8B", "#473C8B", "#2E8B57"))
plot(dmap, col=cl)

# search your browser for "colors in RR"
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf # or https://r-charts.com/colors/

# Exercise: change the color ramp palette using different colors

cln <- colorRampPalette(c("#27408B", "#551A8B", "#473C8B", "#2E8B57"))
plot(dmap, col=cln)

# Exercise: build a multiframe and plot the densitymap with two different color ramp palettes one beside the other

par(mfrow=c(1,2))

cln <- colorRampPalette(c("#27408B", "#551A8B", "#473C8B", "#2E8B57"))(100)
plot(dmap, col=cln)

cl <- colorRampPalette(c("black", "red", "yellow"))(10)
plot(dmap, col=cl)

dev.off()

# Exercise: make a final graph with the points, the elevations, the dmap with two different colors schemes
par(mfrow=c(2,2))
plot(bei)
plot(el)
plot(dmap, col=cl)
plot(dmap, col=cln)
