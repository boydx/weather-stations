---?image=presentation/img/st-b.svg
<h3 style="color:rgba(255,255,255,0.2)">Presentation @</h3>
## boyd.xyz/w
### [repo](https://github.com/boydx/weather-stations)

---?image=presentation/img/p001.jpg&opacity=40
## Weather mapping in 
# HD
### a season of Kentucky sunsets

---?image=presentation/img/p002.jpg&opacity=40
## Weather mapping for
# Funsies

---?image=presentation/img/p003.jpg
## Satellites, surveillance, chemtrails


---?image=presentation/img/p005.jpg&opacity=70
## Automating 
### the capture, storage, and dissemination of webcam and satellite imagery

---?image=presentation/img/p004.jpg&opacity=20
## CLI mapping 

---
## Outline
@ul[squares]
* Project origins
* GOES-16
* A library of imagery
@ulend

---?image=https://outragegis.com/weather/img/animation/170201/LookRock-small.gif&opacity=20
# 2007
@ul[squares]
* Year of the webcam
* Collect images every 15 minutes
@ulend

---?image=presentation/img/p006.jpg

---?image=presentation/img/p006.jpg&opacity=25
## Great Smoky Mountain National Park
[weather station](https://www.outragegis.com/weather/grsm/)

---
## Tech stack
@ul[squares]
* Ubuntu Linux
* CLI text utilities, [grep](https://www.pcre.org/original/doc/html/pcregrep.html), [sed](https://www.gnu.org/software/sed/manual/sed.html), etc.
* [Imagemagick](https://www.imagemagick.org/)
* task scheduler [cron](https://en.wikipedia.org/wiki/Cron)
* Brute force scraping
@ulend

---
## Brief example
@[2]
@[3]
@[4]
@[5]
```bash
#!/bin/bash
rm -f *.jpg 
date +%l:%M%P\ %a,\ %b\ %d,\ %Y > date.txt
wget http://www.nature.nps.gov/air/webcams/parks/grsmcam/grsm.jpg
montage -geometry +0+0 -background white -label "@date.txt" grsm.jpg LookRock.jpg
```

---?image=https://www.outragegis.com/weather/img/LookRock.jpg&size=contain

---
<iframe width="100%" height="500px" src="https://www.outragegis.com/weather/img/animation/yesterday"><iframe>


---
## Make yesterday
@[2]
@[3]
@[4]
@[5]
@[6-7]
```bash
#!/bin/bash
cd yesterday
x=$(ls -1t) #list one file per line sort by newest first
convert -delay 50 $x -loop 0 LookRock.gif
date +%0y%m%d > ../date
mkdir ../$(cat date)
cp -rf ../yesterday/ ../$(cat date)/
```


---?image=presentation/img/p007.jpg&size=contain

---?image=presentation/img/p007.jpg&size=contain&opacity=25
## Archive
@ul[squares]
* Keep three years online
* One year approximately 8 GB
* [yesterdays archived](https://www.outragegis.com/weather/img/animation/)
@ulend


---
## Problems?
@ul[squares]
* HTML scraping is an alley fight 
* Need a new satellite
@ulend

---
```bash
#Brute force! 
pcregrep -M -A 90 "<style>" Sevier2.txt | sed 's_<html><head>__g' | sed 's_font-family: Arial !important;__g' | sed 's_<img src="/images/wtf/12.gif" border=0 height=35 width=30 alt=Print>__g' | sed 's_<img src="_<img src="http://forecast.weather.gov/_g' | sed 's_<a href="showsigwx_<a href="http://forecast.weather.gov/showsigwx_g' | sed 's_table width="800"_table width="100%"_g' | sed 's_<hr><br>__g' | sed 's_<br><br><br><br><br>_<br>_g' > SevierForecast2.txt
```

---?image=https://www.outragegis.com/weather/img/cuga-vis.jpg

---?image=https://www.outragegis.com/weather/img/cuga-vis.jpg&opacity=25
## Not detailed enough
### We expect more from our data.

---?image=https://www.outragegis.com/weather/img/animation/180621/PurchaseKnob.gif&opacity=20
# 2017
@ul[squares]
* Year of the webcam
* Collect images every 15 minutes
@ulend

