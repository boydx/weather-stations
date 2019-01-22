# Make RGB GOES 16 tileset every 15 minutes.

from datetime import datetime
from astral import Astral
import subprocess
import numpy as np
import xarray
import json
import pytz



datetime.now()
dt = datetime.now()
dt = pytz.timezone('US/Eastern').localize(dt)
print(dt)



# Set location and find local sun times
city_name = 'Louisville'
a = Astral()
a.solar_depression = 'civil'
city = a[city_name]

# Get UTC time for GOES16 harvest
years = datetime.utcnow().strftime("%Y")
days = datetime.utcnow().strftime("%j")
hours = datetime.utcnow().strftime("%H")
minutes = datetime.utcnow().strftime("%M")

# Make label
label = f"{years}_d{days}_h{hours}_m{minutes}"

# Set GEOS 16 projection
proj = "'+proj=geos +lon_0=-75 +h=35786023 +x_0=0 +y_0=0 +ellps=GRS80 +units=m +no_defs  +sweep=x'"

# Set products desired
products = "L1b-RadC"


# Select bands based on time
sun = city.sun(date=datetime.now(), local=True)
dt = datetime.now()
dt = pytz.timezone('US/Eastern').localize(dt)
if (dt > sun["sunrise"]) and (dt < sun["sunset"]):
    channels = "C01 C02 C03"
    mode = "day"
elif (dt < sun["sunrise"]):
    channels = "C16"
    mode = "night"
elif (dt > sun["sunset"]):
    channels = "C16"
    mode = "night"
else:
    channels = "C16"
    mode = "night"
    
print(mode) 


print(f"Time is {mode}: {dt}. Downloading {channels}.")


shellDelete = f"""
echo "Remove past run..."
rm -v *.tif
rm -v *.xml
rm -v FullList.txt
rm -v all-info.txt
rm -v DesiredData.txt
"""

Delete = subprocess.run(shellDelete, shell=True, stdout=subprocess.PIPE)
print(Delete.stdout.decode('UTF-8'))

awk_ = "awk '{print $4}'"
shellGetImg = f"""
for PRODUCT in {products}; do
 for YEAR in {years}; do 
  for DAY in {days}; do 
   for HOUR in {hours}; do                         
    aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR | {awk_} >> FullList.txt 
    aws s3 --no-sign-request ls --recursive noaa-goes16/ABI-$PRODUCT/$YEAR/$DAY/$HOUR >> all-info.txt 
   done
  done
  done
done
for CHANNEL in {channels}; do
 grep $CHANNEL FullList.txt | tail -n 1 >> DesiredData.txt
done
cat DesiredData.txt
"""
GetImg = subprocess.run(shellGetImg, shell=True, stdout=subprocess.PIPE)
print(GetImg.stdout.decode('UTF-8'))


shellDownload = f"""
for x in $(cat DesiredData.txt)
do
 FULLNAME=$(echo $x)
 NAME=$(echo $x | cut -d"/" -f5)
 CH=$(echo $NAME | cut -c 19-21)
 echo "************* Downloaded "$NAME": "$CH
 aws s3 --no-sign-request cp s3://noaa-goes16/$FULLNAME ./$CH".nc"
done
"""
Download = subprocess.run(shellDownload, shell=True, stdout=subprocess.PIPE)
print(Download.stdout.decode('UTF-8'))


for i in channels.split():
    print(f"Translating {i} to GTiff format... ")
    shellTranslate = f"""
    gdal_translate NETCDF:{i}.nc:Rad {i}.tif
    rm {i}.nc
    gdalinfo -stats {i}.tif
    """
    completed = subprocess.run(shellTranslate, shell=True, stdout=subprocess.PIPE)
    print(completed.stdout.decode('UTF-8'))


for i in channels.split():
    bandinfo = subprocess.run(f"gdalinfo -stats -json {i}.tif", shell=True, stdout=subprocess.PIPE)
    bandmeta = json.loads(bandinfo.stdout.decode('UTF-8'))
    # print(bandmeta)
    hi = bandmeta['bands'][0]['mean'] + (bandmeta['bands'][0]['stdDev']*3)
    lo = bandmeta['bands'][0]['min'] #+ (bandmeta['bands'][0]['stdDev']*0.5)
    print(f"************* For {i} applying minimum: {lo} and maximum: {hi} -- no worries about GDAL errors! *************")
    shellScaleDay = f"""
    gdal_translate -ot Byte -of Gtiff -scale {lo} {hi} 0 255 {i}.tif '_scale_'{i}.tif
    gdalwarp '_scale_'{i}.tif -t_srs EPSG:3857 -s_srs {proj} -r cubic -of Gtiff  '_prj_'{i}.tif
    gdalwarp -cutline us.geojson -crop_to_cutline '_prj_'{i}.tif '_us_'{i}.tif
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'{i}.tif '_ky_'{i}.tif
    rm '_scale_'{i}.tif; rm '_prj_'{i}.tif #rm {i}.tif; 
    """
    shellScaleNight = f"""
    gdal_translate -ot Byte -of Gtiff -scale {lo} {hi} 255 0 {i}.tif '_scale_'{i}.tif
    gdalwarp '_scale_'{i}.tif -t_srs EPSG:3857 -s_srs {proj} -r cubic -of Gtiff  '_prj_'{i}.tif
    gdalwarp -cutline us.geojson -crop_to_cutline '_prj_'{i}.tif '_us_'{i}.tif
    gdalwarp -cutline aoi.geojson -crop_to_cutline '_prj_'{i}.tif '_ky_'{i}.tif
    rm '_scale_'{i}.tif; rm '_prj_'{i}.tif #rm {i}.tif; 
    """
    if mode == "day":
        Scale = subprocess.run(shellScaleDay, shell=True, stdout=subprocess.PIPE)
    else:
        Scale = subprocess.run(shellScaleNight, shell=True, stdout=subprocess.PIPE)
    
    print(Scale.stdout.decode('UTF-8'))
    

bands = channels.split()

ratioColor = '"(0.3*A)+(0.45*B)+(0.25*C)"'

if mode == "day":
    print(f"************* Processing day bands for RGB *************")
    shellMergeDay = f"""
    gdalwarp -ts 5158 3222 -r cubic '_us_'{bands[1]}.tif '_resize_'{bands[1]}.tif
    gdal_calc.py -A '_resize_'{bands[1]}.tif -B '_us_'{bands[2]}.tif -C '_us_'{bands[0]}.tif --outfile=_green_.tif --calc={ratioColor} 
    gdal_merge.py -separate -a_nodata 255 255 255 -of GTiff -o _rgb_.tif --optfile bands.txt
    gdal2tiles.py -p mercator -z 0-8 -w all -r average -a 0.0 _rgb_.tif tiles
    """
    Merge = subprocess.run(shellMergeDay, shell=True, stdout=subprocess.PIPE)
else:
    print(f"************* Processing night band for grayscale *************")
    shellMergeNight = f"""
    gdal2tiles.py -p mercator -z 0-8 -w all -r average -a 0.0 '_us_'{bands[0]}.tif tiles
    """
    Merge = subprocess.run(shellMergeNight, shell=True, stdout=subprocess.PIPE)
    
print(Merge.stdout.decode('UTF-8'))

shellTilesProduction = f"""
echo "Added production tiles."
cp -rf tiles/* ~/www/weather/goes16/tiles/
rm -r tiles/*
"""

TilesProduction = subprocess.run(shellTilesProduction, shell=True, stdout=subprocess.PIPE)
print(TilesProduction.stdout.decode('UTF-8'))

if mode == "day":
    print(f"************* Making C02 high res tileset *************")
    shellTilesGrayProduction = f"""
    gdal2tiles.py -p mercator -z 0-9 -w all -r average -a 0.0 _us_C02.tif tilesgray
    cp -rf tilesgray/* ~/www/weather/goes16/tilesgray/
    rm -r tilesgray/*
    mv -f _rgb_.tif ~/www/weather/goes16/rgb.tif
    mv -f _us_C02.tif ~/www/weather/goes16/gray.tif
    """
    TilesGrayProduction = subprocess.run(shellTilesGrayProduction, shell=True, stdout=subprocess.PIPE)
    print(TilesProduction.stdout.decode('UTF-8'))

