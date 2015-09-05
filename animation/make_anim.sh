# cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/$(echo $(date +%d) - 1 | bc)
cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/
cd $(cat date)
sh ../pk.sh
sh ../grsm.sh
sh ../lookrock.sh
sh ../cold.sh
#convert ColdMountain.gif ColdMountain.mpeg
#convert LookRock.gif LookRock.mpeg
#convert PurchaseKnob.gif PurchaseKnob.mpeg
# convert GrsmVis-large.gif GrsmVis-large.mpeg
#ffmpeg -i ColdMountain.mpeg -s 300x200 ColdMountain.flv
#ffmpeg -i LookRock.mpeg -s 300x200 LookRock.flv
#ffmpeg -i PurchaseKnob.mpeg -s 300x200  PurchaseKnob.flv
# ffmpeg -i GrsmVis-large.mpeg -s 300x200 GrsmVis-large.flv
convert GrsmVis-large.gif -resize 20% -delay 40 GrsmVis-small.gif
convert LookRock.gif -resize 20% -delay 40 LookRock-small.gif
convert ColdMountain.gif -resize 20% -delay 40 ColdMountain-small.gif
convert PurchaseKnob.gif -resize 20% -delay 40 PurchaseKnob-small.gif
#flvtool2 -U ColdMountain.flv
#flvtool2 -U  LookRock.flv
#flvtool2 -U PurchaseKnob.flv
# flvtool2 -U GrsmVis-large.flv
# mkdir /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/$(echo $(date +%y%m%d) - 2 | bc)
# mv ../yesterday/*.gif /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/$(echo $(date +%y%m%d) - 2 | bc)/
# mv ../yesterday/*.jpg /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/$(echo $(date +%y%m%d) - 2 | bc)/
rm -f *.mpeg
rm -f ../yesterday/*.gif
rm -f ../yesterday/*.flv
cp *.gif ../yesterday
#cp *.flv ../yesterday
rm -f ../date-yesterday
cp ../date ../date-yesterday
date +%0y%m%d > ../date
