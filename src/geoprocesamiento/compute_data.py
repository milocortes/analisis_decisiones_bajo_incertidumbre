import os
import pandas as pd
import geopandas as gpd
import rasterio as rio
import matplotlib.pyplot as plt
import rioxarray as rxr

raster_filepath = "/home/milo/Documents/egtp/clases/2025/ccm/ltp/analisis_decisiones_bajo_incertidumbre/data/reto/raster/WorldClim/Climate/srad/wc2.1_10m_srad_08.tif"
raster = rxr.open_rasterio(raster_filepath, mask_and_scale=True)
raster =  raster.sel(band=1)

fig, ax = plt.subplots(1, 1)
fig.set_size_inches(10, 7)

cbar_kwargs = {
    'orientation':'horizontal',
    'fraction': 0.025,
    'pad': 0.05,
    'extend':'neither'
}

raster.plot.imshow(
    ax=ax,  add_labels=False,
    cmap='coolwarm', cbar_kwargs=cbar_kwargs)

ax.set_title('Temprature Anomaly for July 2022', fontsize = 14)
ax.set_aspect('equal')
plt.show()


#### Carga plantas
plantas = pd.read_csv("/home/milo/Documents/egtp/clases/2025/ccm/ltp/analisis_decisiones_bajo_incertidumbre/data/reto/global_power_plants/global_power_plant_database.csv")

solar = plantas.query("primary_fuel=='Solar'")

geometry = gpd.points_from_xy(solar.longitude, solar.latitude)

gdf = gpd.GeoDataFrame(solar, crs='EPSG:4326', geometry=geometry)
gdf


fig, ax = plt.subplots(1, 1)
fig.set_size_inches(10, 7)

cbar_kwargs = {
    'orientation':'horizontal',
    'fraction': 0.025,
    'pad': 0.05,
    'extend':'neither'
}

raster.plot.imshow(
    ax=ax, add_labels=False,
    cmap='coolwarm', cbar_kwargs=cbar_kwargs)
gdf.plot(ax=ax, markersize=5)
ax.set_xlim([raster.x.min(), raster.x.max()])
ax.set_ylim([raster.y.min(), raster.y.max()])
ax.set_title('Urban Areas and Temperature Anomaly for July 2022', fontsize = 14)
ax.set_aspect('equal')

plt.show()


###### Sampling Raster Values
x_coords = gdf.geometry.x.to_xarray()
y_coords = gdf.geometry.y.to_xarray()

sampled = raster.sel(x=x_coords, y=y_coords, method='nearest')

gdf['srad'] = sampled.to_series()
