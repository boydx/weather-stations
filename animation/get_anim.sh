cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/
cd $(cat date)
cp /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/LookRock.jpg LookRock-$(date +%0k%M).jpg 
cp /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/PurchaseKnob.jpg PurchaseKnob-$(date +%0k%M).jpg 
cp /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/ColdMountain.jpg ColdMountain-$(date +%0k%M).jpg 
cp /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/GrsmVis-large.jpg GrsmVis-large-$(date +%0k%M).jpg 
