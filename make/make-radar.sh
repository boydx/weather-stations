#!/bin/bash

# Make tile set of current radar imagery for Leaflet map at https://sheltoweetrace.com/hike/radar.html

# get jackson radar
rm -f *.gif
rm -f *.gfw
rm -f *.vrt

# radar gif
wget https://radar.weather.gov/ridge/RadarImg/N0R/JKL_N0R_0.gif  
# rader world file
wget https://radar.weather.gov/ridge/RadarImg/N0R/JKL_N0R_0.gfw

# create virtual file from GIF, define its crs, and get the transparent pixels 
gdal_translate -a_srs EPSG:4269 -of vrt -expand rgba JKL_N0R_0.gif temp.vrt

# create tileset with zoom levels 0-10. output is PNG, preserving transparent pixels
gdal2tiles.py -z 0-10 temp.vrt jkl_radar

