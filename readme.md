ENMwizard
======================
### Advanced tecniques for ecological niche models made easy

This package provides tools to facilitate the use of advanced techiques related to Ecological Niche Modelling (ENM) and the automation of repetitive tasks (when modeling several species). This package has functions to enable easier: 1. preparation of occurence and environmental data, 2. model tunning (thanks to the package ENMeval), 3. model fitting and projection. ENMwizard also implements methods described in Gutiérrez & Heming in prep.

-----

# Installation
ENMwizard is downloadable from https://github.com/HemingNM/ENMwizard. You can download it using devtools to install from GitHub.

### Installing from GitHub using devtools
Run the following code from your R console:


```r
install.packages("devtools")
library(devtools)
install_github("HemingNM/ENMwizard")
library(ENMwizard)
```

### Install from zip file
You can also download a zip file containing the package and install it from R.

Download from https://github.com/HemingNM/ENMwizard/archive/master.zip and run the following code (where PATH is the path to the zip file)

```r
install.packages("devtools")
library(devtools)
install_local("PATH")
library(ENMwizard)
```



-----


# Using ENMwizard's magic wand

## ------- 1. Prepare environmental data

### ------- 1.1 Load occurence data

First, lets use occ data available in dismo package
```r
Bvarieg.occ <- read.table(paste(system.file(package="dismo"), "/ex/bradypus.csv", sep=""), header=TRUE, sep=",")
colnames(Bvarieg.occ) <- c("SPEC", "LONG", "LAT")
```

Now we make it a named list, where names correspond to species names
```r
spp.occ.list <- list(Bvarieg = Bvarieg.occ)
```

### ------- 1.2 create occ polygon to crop rasters prior to modelling

The occurence points in the named list are used to create polygons ...
```r
occ_polys <- poly.c.batch(spp.occ.list, o.path="occ_poly")
```

### ------- 1.2.1 creating buffer

... and the occurrence polygons are buffered 1.5 degrees wider.
```r
occ_b <- bffr.b(occ_polys, bffr.width = 1.5)
```

### ------- 1.3. Cut enviromental layers with occ_b and save in hardrive.
Specify the path to the environmental variables
it usually is the path on your machine. E.g. "/path/to/variables/WorldClim/2_5min/bio_2-5m_bil"
here we will use variables available in dismo package
```r
path.env <- paste(system.file(package="dismo"), "/ex", sep="")
biovars <- paste0("bio", 1:17)
pattern.env <- 'grd'
```

Get uncut variables
```r
env_uncut <- list.files(path.env, full.names=TRUE)
env_uncut <- env_uncut[grep(paste(paste0(biovars, ".", pattern.env), collapse = "|"), env_uncut)]
env_uncut <- stack(env_uncut)
```

If the variables were already saved in a raster brick, you just need to read them
```r
env_uncut <- brick(paste(path.env, "bio.grd", sep="/"))
```

Finally, crop environmental variables for each species (and plot them for visual inspection)
```r
occ_b_env <- env.cut(occ_b, env_uncut)

for(i in 1:length(occ_b_env)){
  plot(occ_b_env[[i]][[1]])
  plot(occ_polys[[i]], border = "red", add = T)
  plot(occ_b[[i]], add = T)
}
```


## ------- 2. Prepare occurence data
### ------- 2.1 Filtering original dataset
Now we want to remove localities that are too close apart. We will do it for all species listed in "spp.occ.list".
```r
thinned_dataset_batch <- thin.batch(loc.data.lst = spp.occ.list)
```

After thinning, we choose one of dataset for each species for modelling.
```r
occ_locs <- loadTocc(thinned_dataset_batch)
```

### Great! Now we are ready for tunning species' ENMs


