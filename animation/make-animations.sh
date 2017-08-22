#!/bin/bash

# Make animations

cd httpdocs/weather/img/animation
sh archive.sh
sh make_anim.sh
sh mkdir.sh
sh timelapse.sh