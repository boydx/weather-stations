cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/img/animation/
cd $(cat date-yesterday)
wget --user-agent="" -O index.php http://www.outrageGIS.com/weather/img/animation/yesterday
