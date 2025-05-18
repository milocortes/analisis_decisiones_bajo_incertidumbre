using RasterDataSources
using Rasters 
using NCDatasets
using Plots 
using ArchGDAL 


ENV["RASTERDATASOURCES_PATH"] = "/home/milo/Documents/egtp/clases/2025/ccm/ltp/analisis_decisiones_bajo_incertidumbre/data/reto/rasters"

#= WorldClim

The data is available at the four spatial resolutions, between 30 seconds (~1 km2) to 10 minutes (~340 km2). 
Each download is a “zip” file containing 12 GeoTiff (.tif) files, one for each month of the year (January is 1; December is 12).
=#

getraster(WorldClim{BioClim}, res = "2.5m") # res: String chosen from ("30s", "2.5m", "5m", "10m"), "10m" by default.
getraster(WorldClim{Climate}, res = "2.5m", month=1:12) #res: String chosen from ("30s", "2.5m", "5m", "10m"), "10m" by default.
#getraster(WorldClim{Weather}, month=1:12)

#getraster(EarthEnv{HabitatHeterogeneity})
getraster(EarthEnv{LandCover}, res = "5km") # res: String chosen from ("1km", "5km", "25km"), defaulting to "25km".





Raster()
A = Raster(WorldClim{BioClim}, 5)
plot(A; max_res=3000)
