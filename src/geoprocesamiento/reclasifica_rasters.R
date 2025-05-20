library(raster)
library(terra)

### Define directorios
REPO_PATH <- "/home/milo/Documents/egtp/clases/2025/ccm/ltp/analisis_decisiones_bajo_incertidumbre"
CHIAPAS_PROB_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "chiapas", "outputs", "probability_1.tif")
CHIHUAHUA_PROB_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "chihuahua", "outputs", "probability_1.tif")
SONORA_PROB_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "sonora", "outputs", "probability_1.tif")

### Cargamos los mapas de probabilidad
chiapas <- raster(CHIAPAS_PROB_FP)
chihuahua <- raster(CHIHUAHUA_PROB_FP)
sonora <- raster(SONORA_PROB_FP)


### Preparation for the reclassification into categories
## Source : https://doi90.github.io/EE_Intro_Spatial_Workshop/raster-data.html

# populate each row of the matrix with reclassification information for 
### Chiapas
tcat_chiapas <- matrix(0, nrow = 5, ncol = 3)
quantiles_chiapas <- quantile(chiapas)

tcat_chiapas[ , 1] <- c(quantiles_chiapas[1], quantiles_chiapas[2], quantiles_chiapas[3], quantiles_chiapas[4], quantiles_chiapas[5]) # fill in here the start of the categories 
tcat_chiapas[ , 2] <- c(quantiles_chiapas[2], quantiles_chiapas[3], quantiles_chiapas[4], quantiles_chiapas[5], 1.0) # fill in here the endpoint of the categories
tcat_chiapas[ , 3] <- c(1:5) # fill in here the number for the categories (1-5)

### Chihuahua
tcat_chihuahua <- matrix(0, nrow = 5, ncol = 3)
quantiles_chihuahua <- quantile(chihuahua)

tcat_chihuahua[ , 1] <- c(quantiles_chihuahua[1], quantiles_chihuahua[2], quantiles_chihuahua[3], quantiles_chihuahua[4], quantiles_chihuahua[5]) # fill in here the start of the categories 
tcat_chihuahua[ , 2] <- c(quantiles_chihuahua[2], quantiles_chihuahua[3], quantiles_chihuahua[4], quantiles_chihuahua[5], 1.0) # fill in here the endpoint of the categories
tcat_chihuahua[ , 3] <- c(1:5) # fill in here the number for the categories (1-5)

### Sonora
tcat_sonora <- matrix(0, nrow = 5, ncol = 3)
quantiles_sonora <- quantile(sonora)

tcat_sonora[ , 1] <- c(quantiles_sonora[1], quantiles_sonora[2], quantiles_sonora[3], quantiles_sonora[4], quantiles_sonora[5]) # fill in here the start of the categories 
tcat_sonora[ , 2] <- c(quantiles_sonora[2], quantiles_sonora[3], quantiles_sonora[4], quantiles_sonora[5], 1.0) # fill in here the endpoint of the categories
tcat_sonora[ , 3] <- c(1:5)
#### Reclasificamos Chiapas
chiapas_reclasificado <- reclassify(chiapas, 
                      rcl = tcat_chiapas, 
                      right = FALSE, 
                      overwrite = TRUE)

#### Reclasificamos Chihuahua
chihuahua_reclasificado <- reclassify(chihuahua, 
                      rcl = tcat_chihuahua, 
                      right = FALSE, 
                      overwrite = TRUE)

#### Reclasificamos Chiapas
sonora_reclasificado <- reclassify(sonora, 
                      rcl = tcat_sonora, 
                      right = FALSE, 
                      overwrite = TRUE)

#### Guardamos los raster reclasificados
CHIAPAS_PROB_RECLA_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "chiapas", "outputs", "probability_1_reclasificado.tif")
CHIHUAHUA_PROB_RECLA_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "chihuahua", "outputs", "probability_1_reclasificado.tif")
SONORA_PROB_RECLA_FP <- file.path(REPO_PATH, "data", "reto", "casos_estudio", "sonora", "outputs", "probability_1_reclasificado.tif")

writeRaster(chiapas_reclasificado, CHIAPAS_PROB_RECLA_FP)
writeRaster(sonora_reclasificado, SONORA_PROB_RECLA_FP)
writeRaster(chihuahua_reclasificado, CHIHUAHUA_PROB_RECLA_FP)

