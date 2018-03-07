# National Park weather data

A collection of Bash shell scripts to scrape/collect weather data, web camera images, radar imagery, satellite views, etc. to display current weather information, time-lapse animations, and create an archive of weather observations. 

## Prerequisites

The scripts are used on Ubuntu 14 and requite a few packages to be installed on the server: 

* [ImageMagick](https://www.imagemagick.org/) 
* [GDAL](http://www.gdal.org/)

Web pages use [Leaflet JS](http://leafletjs.com/) library to display current radar map overlays. 

## Example usage

The primary script is ```make.sh``` which runs the other scripts in the proper order.  You'll need to create a ```crontab``` to keep the weather data current.

```
# crontab example
# The source imagery and observations are downloaded every 30 minutes to conserve server storage.


*/30	*	*	* 	*	/bin/sh/	/path/to/weather/directory/make.sh

```

## Goals

The scripts have a few goals:

* Pull down weather imagery and data with ```wget``` or ```curl```. 
* Process the imagery with ```convert``` and ```montage``` to make thumbnails, add date stamps, and optimize for web viewing 
* Scrape text data with ```sed```,```awk```, and ```pcregrep``` to format and serve on a web page.
* Create animated gifs for national park webcams and archive the imagery with a unique URL every day.
* Create a raster tileset for the latest doppler radar for the Daniel Boone National Forest and serve on a slippy map.

## Live examples

* Great Smoky Mountains National Park live weather [(https://www.outragegis.com/weather/grsm/)](https://www.outragegis.com/weather/grsm/)
* Archive of time-lapse imagery for the Great Smoky Mountains [(https://www.outragegis.com/weather/img/animation/)](https://www.outragegis.com/weather/img/animation/)
* Cumberland Gap National Historical Park live weather [(https://www.outragegis.com/weather/gap)](https://www.outragegis.com/weather/gap)
* Latest radar for the Daniel Boone country [(https://www.sheltoweetrace.com/hike/radar.html)](https://www.sheltoweetrace.com/hike/radar.html)
* Current GOES-16 imagery for Kentucky [(https://www.outragegis.com/weather/goes16/current.jpg)](https://www.outragegis.com/weather/goes16/current.jpg)
  * Past two-hour animation: https://www.outragegis.com/weather/goes16/animation.gif
  * Yesterday's animation: https://www.outragegis.com/weather/goes16/yesterday.gif

## Data sources

The source data primarily comes from the National Weather Service and various NOAA agencies. The exact URLs are shown in the ```get-webobv.sh``` and ```get-img.sh``` scripts. Also using/exploring the [Dark Sky API](https://darksky.net/dev) for hyperlocal data. [The Weather Underground API](https://www.wunderground.com/weather/api/d/docs) for RSS feeds has also been used in the past. Imagery for the GOES-16 satellite is downloaded from UW-Madison Department of Atmospheric and Oceanic Sciences, [https://www.aos.wisc.edu/](https://www.aos.wisc.edu/)

## Author

outrageGIS mapping makes trails maps to carry into the backcountry. Knowing the weather is pretty helpful.

## History

The first use of the scripts was in June, 2007.






