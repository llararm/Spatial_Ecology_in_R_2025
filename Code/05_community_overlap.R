# Code to estimate the temporal overlap between species

install.packages("overlap")

library(overlap)

data(kerinci)

# Exercise: show the first 6 rows of kerinci
head(kerinci)

kerinci

summary(kerinci)

circtime <- kerinci$Time * 2 * pi

kerinci$circtime  <- kerinci$Time * 2 * pi
head(kerinci)

# tiger data
tiger <- kerinci[kerinci$Sps == "tiger",]
densityPlot

tigertime <- tiger$Timecirc

densityPlot(tigertime)

# macaque
# Exercise: select the data for the macaque and assign them to a new ojbect 
macaque <- kerinci[kerinci$Sps=="macaque",]

# Exercise: select the time for the macaque data and make a density plot
macaquetime <- macaque$Timecirc

densityPlot(macaquetime)

overlapPlot(tigertime, macaquetime)


#----- SQL
macaque <- kerinci[kerinci$Sps=="macaque",]
summary(macaque)

nomacaque <- kerinci[kerinci$Sps!="macaque",]
summary(nomacaque)
