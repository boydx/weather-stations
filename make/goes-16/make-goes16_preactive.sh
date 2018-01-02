#!/bin/bash

# Automate the processing of GOES16 imagery for Kentucky and the central/southern Appalachian region.
# Crotab seetting: */5     7-20    *       *       *  

# Move into directory for processing
cd weather/goes16/img


#  Create date stamp.
date +%l:%M%P\ %a,\ %b\ %d,\ %Y | sed 's/$/ - http:\/\/www.outrageGIS.com/g' > date.txt

# Get hour-minute time stamp for filename
t=$(date +%H%M)

# Get GEOS16 latest visible satellite
curl -o g16.jpg http://whirlwind.aos.wisc.edu/~wxp/goes16/vis/full/latest_full_1.jpg

# Crop and rotate
convert -extract 2000x2000+5950+2500  g16.jpg   \
	-rotate 2.5 +repage  \
	-gravity Center -crop 1900x1900+0+0 +repage  goes16_$t.jpg

# Add parks
composite overlay_large.png goes16_$t.jpg goes16_$t.jpg

# Add timestamp
montage -geometry +0+0 -background white -label "@date.txt" goes16_$t.jpg goes16_$t.jpg

# Move upstairs
cp goes16_$t.jpg ../current.jpg

# Remove original
rm -f g16.jpg

# Create recent three-hour animation for GOES 16
x=$(ls -1t *.jpg | head -36 | sort)
convert -delay 50 $x -loop 0 ../animation.gif