#!/bin/bash

# Archive yesterday's animations
cd httpdocs/weather/img/animation/
cd $(cat date-yesterday)
wget --user-agent="" -O index.php http://www.outrageGIS.com/weather/img/animation/yesterday
