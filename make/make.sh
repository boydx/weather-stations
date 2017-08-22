#!/bin/bash
# Group of bash scripts to create data

cd httpdocs/weather/make
sh getimg.sh
sh getweobv.sh
sh make-weather-img.sh
sh make-weobv.sh
sh put.files.sh
sh make-radar.sh
sh make-cuga-sat-animation.sh
date +'%d' > httpdocs/weather/img/day
date +'%m' > httpdocs/weather/img/month