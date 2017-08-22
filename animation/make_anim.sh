#!/bin/bash

# Create yesterday's animation

cd httpdocs/weather/img/animation/
cd $(cat date)
sh timelapse.sh

convert GrsmVis-large.gif -resize 20% -delay 40 GrsmVis-small.gif
convert LookRock.gif -resize 20% -delay 40 LookRock-small.gif
convert ColdMountain.gif -resize 20% -delay 40 ColdMountain-small.gif
convert PurchaseKnob.gif -resize 20% -delay 40 PurchaseKnob-small.gif

rm -f ../yesterday/*.gif
cp *.gif ../yesterday
rm -f ../date-yesterday
cp ../date ../date-yesterday
date +%0y%m%d > ../date
