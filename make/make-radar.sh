#!/bin/bash

#Make tile set of current radar imagery for Leaflet map at https://sheltoweetrace.com/hike

# get jackson radar
rm -f *.gif
rm -f *.gfw
rm -f *.vrt

wget https://radar.weather.gov/ridge/RadarImg/N0R/JKL_N0R_0.gif  
wget https://radar.weather.gov/ridge/RadarImg/N0R/JKL_N0R_0.gfw

gdal_translate -a_srs EPSG:4269 -of vrt -expand rgba JKL_N0R_0.gif temp.vrt
gdal2tiles.py -z 0-10 temp.vrt jkl_radar

