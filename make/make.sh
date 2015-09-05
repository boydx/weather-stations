cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/make
sh getimg.sh
sh getweobv.sh
sh make-weather-img.sh
sh make-weobv.sh
sh put.files.sh
date +'%d' > /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/day
date +'%m' > /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/month