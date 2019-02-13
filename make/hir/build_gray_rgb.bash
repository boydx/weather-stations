
#!/bin/bash

#########################################
# LICENSE
# Copyright (C) 2019 Boyd Shearer and Dr. Marcial Garbanzo Salas
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
#########################################

#########################################
# AUTHOR
# This program was created at the University of Kentucky and University of Costa Rica (UCR)
#########################################

#########################################
# SET UP ENIVRONMENT
#
source activate geo
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - https:\/\/uky-gis.github.io/g' > date.txt

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
# YEARS='2018'
YEARS=$(date -u +%Y)

# DAYS OF THE YEAR
# DAYS="340"
DAYS=$(date -u +%j)

# HOUR OF THE DAY
# HOURS="16"
HOURS=$(date -u +%H)

# CHANNELS
# Example: CHANNELS='C01 C02 C03 C04 C05 C06 C07 C08 C09 C10 C11 C12 C13 C14 C15 C16'
CHANNELS='C01 C02 C03'
# CHANNELS='C07 C14 C12'

# ABI PRODUCTS
# Description: https://aws.amazon.com/public-datasets/goes/
# and http://edc.occ-data.org/goes16/getdata/
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

#########################################
# PART 2. Select only desired channels
#
for CHANNEL in $CHANNELS; do
    grep $CHANNEL FullList.txt | tail -n 1 >> DesiredData.txt
done
#########################################

#########################################
# PART 3. Loop through list, download data, and apply GDAL processing
#
CURRENT=$(date +%Y%j%H%M)
for x in $(cat DesiredData.txt);

do
    
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
    
    # Translate NetCDF format to TIFF
    gdal_translate NETCDF:$NAME:Rad $CH'_'.tif
    
    # Create variable for processing
    i=$CH'_'.tif
    
    # Run image statistics for toning
    echo "*********************************"$i"*********************************"
    gdalinfo -stats $i
    MEAN=$(gdalinfo -stats $i | grep ' Mean=' | cut -d "=" -f 4 | cut -d "," -f 1)
    STD=$(gdalinfo -stats $i | grep ' StdDev=' | cut -d "=" -f 5 | cut -d "," -f 1)
    LO=$(gdalinfo -stats $i | grep ' Minimum=' | cut -d "=" -f 2 | cut -d "," -f 1)
    HI=$(echo "$MEAN + ($STD*3)" | bc)
    echo $i" **** Low: "$LO" **** High: "$HI" ****"
    gdal_translate -ot Byte -of Gtiff -scale $LO $HI 0 255 $i '_scale_'$i
    
    # Project to Web Mercator
    echo $i"**** projecting"
    gdalwarp '_scale_'$i -t_srs EPSG:3857 -s_srs '+proj=geos +lon_0=-75 +h=35786023 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs  +sweep=x' -r cubic -of Gtiff  '_prj_'$i
    
    # Clip to area of interest
    echo $i"**** clipping"
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'$i '_crop_'$i
    
    # If high resolution red band, then resize for RGB and export high resolution gray
    if [ $i = "C02_.tif" ]; then
        gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
        convert '_crop_'$i -auto-level '_level_'$i
        composite -gravity center us_goes16_lg.png '_level_'$i '_overlay_'$i
        montage -geometry +0+0 -background white -label "@date.txt" '_overlay_'$i gray.jpg
    else
        gdalwarp -ts 1540 1339 -r cubic '_crop_'$i 'final/rgb/_crop_'$i
    fi
done
# End PART 3.
# #########################################

#########################################
# PART 4. Calculate Green Band  - 30% R, 45% Veggie, 25% B
#
gdal_calc.py -A final/rgb/_crop_C02_.tif -B final/rgb/_crop_C03_.tif -C final/rgb/_crop_C01_.tif --outfile=final/rgb/_green_.tif --calc="(0.3*A)+(0.45*B)+(0.25*C)"

#########################################
# PART 5. Composite pseudo color RGB
#
gdal_merge.py -separate -a_nodata 255 255 255 -of GTiff -o final/rgb.tif --optfile bands.txt
convert final/rgb.tif -auto-level final/rgb_b.jpg
composite -gravity center us_goes16_sm.png final/rgb_b.jpg final/rgb_a.jpg
montage -geometry +0+0 -background white -label "@date.txt" final/rgb_a.jpg rgb.jpg

