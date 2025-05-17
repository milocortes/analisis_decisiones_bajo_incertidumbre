using RasterDataSources
using Rasters 
using NCDatasets
using Plots 
using ArchGDAL 


ENV["RASTERDATASOURCES_PATH"] = "/home/milo/Documents/egtp/clases/ccm/decisiones_incertidumbre/data/reto/rasters"


getraster(WorldClim{BioClim})
getraster(WorldClim{Climate}, month=1:12)
#getraster(WorldClim{Weather}, month=1:12)

#getraster(EarthEnv{HabitatHeterogeneity})
getraster(EarthEnv{LandCover})





Raster()
A = Raster(WorldClim{BioClim}, 5)
plot(A; max_res=3000)
