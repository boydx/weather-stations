#!/bin/bash

# Make folder for yesterday's weather

cd httpdocs/weather/img/animation
mkdir httpdocs/weather/img/animation/$(cat date)
