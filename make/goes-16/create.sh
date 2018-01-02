#!/bin/bash
# Download and manipulate GEOS-16 satellite imagery that is now active. Dec 31, 2017.
# Source: https://www.star.nesdis.noaa.gov/GOES/GOES16_sectors.php?sector=cgl

# remove existing jpegs
rm *.jpg

# find current year, day of year, and hour in UTC
timez=$(TZ=UTC date +%y%j%H) 

# find current year in UTC
timem=$(TZ=UTC date +%M)  

# create offset to find latest 15 images
timemm=$((timem-15))

# remove negative values
if [ $timemm -lt 0 ]
		then 
			timemm=00
	fi

# test what we have
echo $timemm; echo "true minutes: "$timem

# download range of images based on time variables defined above
curl -O "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/cgl/GEOCOLOR/20{$timez}[$timemm-$timem]_GOES16-ABI-cgl-GEOCOLOR-1200x1200.jpg"

# dump list of jpegs to list in order of last modification
ls -t *.jpg > list 

# find the images, copy them to a unique folder, and remove the rest
for i in `cat list`
	do 
	#define byte size of each file as variable to test
	size=$(wc -c <$i)
	echo $size
	if [ $size -ge 1000 ]
		then cp $i images/$i
		else rm $i
	fi
 done 

# dump list of jpegs to list in order of last modification
ls -t *.jpg > list

# find the last image
head -1 list > flist 

# for loop for one image. create image for central appalachia region
for y in `cat flist`
	do 
	echo $y
	convert $y -colorspace LAB  -filter Lanczos  -distort resize 200% \
	-filter Lanczos  -distort Perspective '0,0 0,0  2400,0 2400,0   2400,2400 2000,2400  0,2400 400,2400' \
 	-gravity south  -extent 1600x1000 c1.jpg
 done 
