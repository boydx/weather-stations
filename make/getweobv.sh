#!/bin/bash

# Remove old observations.

rm -f *.txt

# Get new observations

wget "http://forecast.weather.gov/product.php?site=NWS&product=RTP&issuedby=MRX" -O past-obs.txt
wget "http://forecast.weather.gov/MapClick.php?zoneid=TNZ074&FcstType=text&TextType=1" -O Sevier.txt
wget "http://forecast.weather.gov/MapClick.php?lat=35.566&lon=-83.5037&unit=0&lg=english&FcstType=text&TextType=2" -O Sevier2.txt   
wget "http://forecast.weather.gov/MapClick.php?lat=37.78&lon=-83.6671&unit=0&lg=english&FcstType=text&TextType=2" -O Red.txt
wget "http://forecast.weather.gov/MapClick.php?lat=36.4601&lon=-84.6651&unit=0&lg=english&FcstType=text&TextType=2" -O BISO.txt