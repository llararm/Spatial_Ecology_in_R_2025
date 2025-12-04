# Example Markdown code for the exam

## How to import external date in R

The packages needed in this script are the following:

```
library(terra) # managing raster and vector data
library(imageRy) # analysing RS data
```

First of all. it's important to set the working directory by:
```
setwd("C://yourpath")
```

To check if the working directory has been properly set, you can make use of:
```
getwd()
```

Once the data to be used has been put in the working directory, we can upload it o R by:
```
group <- rast("image.JPG") # essa imagem ta no virtuale
```

## Visualizing the data

In order to visualize data we will use the RGB scheme:
```
im.plotRGB(group, r=1, g=2, b=3)
```

The image is flipped, so I can solve the problem by the flip() function:
```
group <- flip(group)
im.plotRGB(group, r=1, g=2, b=3)
```

Exporting the result of the previous code is done by:
```
png("group_photo.png")
im.plotRGB(group, r=1, g=2, b=3)
dev.off()
```

The output is then:
inserir a imagem aqui

Changing the layers inside the RGB scheme is done by:
```
png("group_photo_new.png")
im.plotRGB(group, r=2, g=1, b=3)
dev.off()
```

The false color image is something like:
inserir a imagem aqui
