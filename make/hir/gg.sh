#!/bin/bash

cd /home/pixel/www/weather/make/hir/
source activate geo
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - http:\/\/www.outrageGIS.com/g' > date.txt

 
#########################################
# LICENSE
#Copyright (C) 2012 Dr. Marcial Garbanzo Salas
#This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
#########################################
 
#########################################
# AUTHOR
# This program was created at the University of Costa Rica (UCR)
# It is intended as a tool for meteorology students to obtain data from GOES16
# but it can be used by operational and research meteorology.
#########################################
 
#########################################
# Warning: This program can download a LARGE amount of information
# and this can cause problems with limited bandwidth networks or
# computers with low storage capabilities.
#########################################
 
#########################################
# CLEANING FROM PREVIOUS RUNS
#
rm DesiredData.txt
rm FullList.txt
rm all-info.txt
#########################################
 
echo "GOES16 ABI data downloader"
 
#########################################
# CONFIGURATION
#
# YEAR OF INTEREST
#YEARS='2018'
YEARS=$(date -u +%Y)
 
# DAYS OF THE YEAR
# Can use this link to find out: https://www.esrl.noaa.gov/gmd/grad/neubrew/Calendar.jsp
# Example: 275 for October 2nd, 2017
# NOTE: There is only about 60 days previous to the current date available
# DAYS="340"
DAYS=$(date -u +%j)

# HOUR OF THE DAY
# HOURS="16"
HOURS=$(date -u +%H)

 
# CHANNELS
# Example: CHANNELS='C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12 C13 C14 C15 C16'
CHANNELS='C01 C02 C03'
 
# ABI PRODUCTS
# For a description look into:
# https://aws.amazon.com/public-datasets/goes/
# and
# http://edc.occ-data.org/goes16/getdata/
# Example: PRODUCTS='L1b-RadC L1b-RadF L1b-RadM L2-CMIPC L2-CMIPF L2-CMIPM L2-MCMIPC L2-MCMIPF L2-MCMIPM'
PRODUCTS='L1b-RadC'
#########################################
 
#########################################
# Get list of remote files available
# PART 1. Obtain full list of files
#
for PRODUCT in $PRODUCTS; do
for YEAR in $YEARS; do
for DAY in $DAYS; do
for HOUR in $HOURS; do
 
aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR | awk '{print $4}' >> FullList.txt
aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR >> all-info.txt 
done
done
done
done
 
#
# PART 2. Select only desired channels
for CHANNEL in $CHANNELS; do
grep $CHANNEL FullList.txt | tail -n 1 >> DesiredData.txt
done
#########################################
 
#########################################
# DOWNLOAD
#

CURRENT=$(date +%Y%j%H%M) 

for x in $(cat DesiredData.txt);
do
# SIZE=$(echo $x | cut -d";" -f1)
FULLNAME=$(echo $x)
NAME=$(echo $x | cut -d"/" -f5)
CH=$(echo $NAME | cut -c 19-21)

echo "Processing file $NAME of size $SIZE"
if [ -f $NAME ]; then
 echo "This file exists locally"
 LOCALSIZE=$(du -s $NAME | awk '{ print $1 }')
 if [ $LOCALSIZE ]; then
 echo "The size of the file is not the same as the remote file. Downloading again..."
 aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./
 else
 echo "The size of the file matches the remote file. Not downloading it again."
 fi
else
 echo "This file does not exists locally, downloading..."
 aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./
fi
 
# gdalinfo $NAME
# gdal_translate -ot Byte NETCDF:$NAME:Rad -scale 0 650 0 255 $CH'_'$CURRENT.tif
gdal_translate NETCDF:$NAME:Rad $CH'_'.tif
# gdal_warp 
# gdal_translate -ot Byte -of JPEG $CH'_'$CURRENT.tif $CH'_'$CURRENT.jpg
# gdal_translate NETCDF:$NAME:DQF $CH'_'$(date +%Y%j%H%M).tif
# echo "NETCDF:$NAME:DQF $CH$(date +%Y%j%H%M).tif"
i=$CH'_'.tif
echo "*********************************"$i"*********************************"
gdalinfo -stats $i
MEAN=$(gdalinfo -stats $i | grep ' Mean=' | cut -d "=" -f 4 | cut -d "," -f 1) 
STD=$(gdalinfo -stats $i | grep ' StdDev=' | cut -d "=" -f 5 | cut -d "," -f 1) 
LO=$(gdalinfo -stats $i | grep ' Minimum=' | cut -d "=" -f 2 | cut -d "," -f 1)
HI=$(echo "$MEAN + ($STD*3)" | bc)
echo $i" **** Low: "$LO" **** High: "$HI" ****"
gdal_translate -ot Byte -of Gtiff -scale $LO $HI 0 255 $i  '_scale_'$i
echo $i"**** projecting"
gdalwarp '_scale_'$i -t_srs EPSG:3857 -s_srs '+proj=geos +lon_0=-75 +h=35786023 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs  +sweep=x' -r cubic -of Gtiff  '_prj_'$i
echo $i"**** clipping"
gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'$i '_crop_'$i

if [ $i = "C02_.tif" ]; then
    gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
    convert '_crop_'$i -auto-level '_level_'$i
    composite -gravity center us_goes16_lg.png '_level_'$i '_overlay_'$i 
    montage -geometry +0+0 -background white -label "@date.txt" '_overlay_'$i ../../goes16/gray.jpg
    
    # convert final/gray.tif -auto-level final/gray.tif
else
    gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
    # convert 'final/rgb/_crop_'$i -auto-level 'final/rgb/_crop_'$i
fi
done
# #########################################


gdal_merge.py -separate -of GTiff -o final/rgb.tif --optfile bands.txt
convert final/rgb.tif -auto-level final/rgb_b.jpg
composite -gravity center us_goes16_sm.png final/rgb.jpg final/rgb_a.jpg  
montage -geometry +0+0 -background white -label "@date.txt" final/rgb_a.jpg ../../goes16/rgb.jpg
rm *_*.tif
rm final/*.*
rm final/rgb/*.tif
rm *.nc
rm *.xml

# gdal_translate -ot Byte -of Gtiff -scale 138 600 0 255 _prj_C02_.tif _prj_C02_2.tif

# MEAN=$(gdalinfo -stats _prj_C02_.tif | grep ' Mean=' | cut -d "=" -f 4 | cut -d "," -f 1) 
# HI=$((MEAN + MEAN))

# HI=$(echo "$MEAN*2" | bc)

 
