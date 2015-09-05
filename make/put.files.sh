cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/make
chmod 775 *.jpg
chmod 775 *.gif
chmod 775 *.png
chmod 775 *.txt
cp *.jpg /var/www/vhosts/outrageGIS.com/httpdocs/weather/img
cp *.png /var/www/vhosts/outrageGIS.com/httpdocs/weather/img
cp -f  *.gif /var/www/vhosts/outrageGIS.com/httpdocs/weather/img
cp *.txt /var/www/vhosts/outrageGIS.com/httpdocs/weather/img
