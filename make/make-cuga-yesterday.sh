#!/bin/bash

# Grap historic MODIS imagery and create animated gif of daily views of Cumberland Gap
# declare -i dayYear
# declare -i yesterday
dayYear=$(date +'%j')
yesterday=`expr $dayYear - 1`
dateLabel=$(date +'%Y')$yesterday

curl -s 'https://gibs.earthdata.nasa.gov/image-download?TIME=2017'$yesterday'&extent=-84.33207836140053,36.22681809106972,-82.97922269459613,37.008834659442016&epsg=4326&layers=MODIS_Terra_CorrectedReflectance_TrueColor,Coastlines,Reference_Features,Reference_Labels&opacities=1,1,1,1&worldfile=false&format=image/jpeg&width=616&height=356' > yesterday-$dateLabel.jpg

x=$(ls *.jpg)
convert -delay 50 $x -loop 0 yesterday.gif
