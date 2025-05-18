library(biomod2)
library(terra) # library(remotes) ; install_version("terra", version = "1.8.10", repos = "http://cran.us.r-project.org")
library(raster)
library(dplyr)

# Lat = Y Long = X

REPO_PATH <- "/home/milo/Documents/egtp/clases/2025/ccm/ltp/analisis_decisiones_bajo_incertidumbre"
RASTER_PATH <- file.path(REPO_PATH, "data", "reto", "rasters")
BIOCLIM_PATH <- file.path(RASTER_PATH, "WorldClim", "BioClim")
CLIM_PATH <- file.path(RASTER_PATH, "WorldClim", "Climate")
SRAD_CLIM_PATH <- file.path(CLIM_PATH, "srad")
WIND_CLIM_PATH <- file.path(CLIM_PATH, "wind")

## Cargamos los datos de presencia de Plantas de Poder
POWER_PLANTS_FP <- file.path(REPO_PATH, "data", "reto", "global_power_plants", "global_power_plant_database.csv")
power <- read.csv(POWER_PLANTS_FP)


## Nos quedamos con las plantas solares
energia_solar <- "Solar"
energia_viento <- "Wind"

## Coordenadas de los puntos
coord_solar <- power[power$primary_fuel==energia_solar, c("longitude", "latitude")]
coord_viento <- power[power$primary_fuel==energia_viento, c("longitude", "latitude")]

# Environmental variables extracted from Worldclim
# BIO1 = Annual Mean Temperature
# BIO3 = Isothermality (BIO2/BIO7) (×100)
# BIO5 = Max Temperature of Warmest Month
# BIO6 = Min Temperature of Coldest Month
# BIO12 = Annual Precipitation
# Wind
# Srad

covariables <- raster::stack( 
    file.path(BIOCLIM_PATH, "wc2.1_10m_bio_1.tif"),
    file.path(BIOCLIM_PATH, "wc2.1_10m_bio_3.tif"),
    file.path(BIOCLIM_PATH, "wc2.1_10m_bio_4.tif"),
    file.path(BIOCLIM_PATH, "wc2.1_10m_bio_5.tif"),
    file.path(BIOCLIM_PATH, "wc2.1_10m_bio_12.tif"),
    file.path(SRAD_CLIM_PATH, "wc2.1_10m_srad_08.tif"),
    file.path(WIND_CLIM_PATH, "wc2.1_10m_wind_08.tif")
 )


### Calcula pseudo-ausencias
pseudo_solar <- BIOMOD_FormatingData(resp.var = rep(1, nrow(coord_solar)),
                                     expl.var = covariables,
                                     resp.xy = coord_solar,
                                     resp.name = "solar",
                                     PA.nb.rep = 4,
                                     PA.strategy = "random",
                                     filter.raster = TRUE)

pseudo_viento <- BIOMOD_FormatingData(resp.var = rep(1, nrow(coord_viento)),
                                     expl.var = covariables,
                                     resp.xy = coord_viento,
                                     resp.name = "viento",
                                     PA.nb.rep = 4,
                                     PA.strategy = "random",
                                     filter.raster = TRUE)

### Extract presences, absences and pseudo-absences tables

## function to get PA dataset
get_PAtab <- function(bfd){
  dplyr::bind_cols(
    x = bfd@coord[, 1],
    y = bfd@coord[, 2],
    status = bfd@data.species,
    bfd@PA.table
  )
}

# get the coordiantes of pseudo - absences
## all repetition of pseudo absences sampling merged 
(pa.all.xy.solar <- get_PAtab(pseudo_solar) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
    distinct()

(pa.all.xy.viento <- get_PAtab(pseudo_viento) %>% 
    filter(is.na(status)) %>%
    select(x, y)) %>%
    distinct()

## Renombramos columnas
colnames(pa.all.xy.solar) <- c("longitude", "latitude")
colnames(pa.all.xy.viento) <- c("longitude", "latitude")

pa.all.xy.solar$presencia <- 0
pa.all.xy.viento$presencia <- 0

coord_solar$presencia <- 1
coord_viento$presencia <- 1

coord_solar_pa <- rbind.data.frame(coord_solar, pa.all.xy.solar)
coord_viento_pa <- rbind.data.frame(coord_viento, pa.all.xy.viento)


## Guardamos salidas
PA_POWER_PLANTS_FP <- file.path(REPO_PATH, "data", "reto", "pseudo_ausencias_global_power_plants")
PA_VIENTO_FP <- file.path(PA_POWER_PLANTS_FP, "pseudo_ausencias_viento.csv")
PA_SOLAR_FP <- file.path(PA_POWER_PLANTS_FP, "pseudo_ausencias_solar.csv")

write.csv(coord_solar_pa, PA_SOLAR_FP, row.names = FALSE)
write.csv(coord_viento_pa, PA_VIENTO_FP, row.names = FALSE)

