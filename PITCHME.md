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
* SCRAPE!
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

---?image=https://farm2.staticflickr.com/1483/24448087730_5b3b991737_h.jpg

---
## Organization
@ul[squares]
* Keep GIS folder organized
* Be consistent
* Don't put a file >50 MB in repo
* Don't put a .gdb folder in repo
* Don't put a repo in repo
@ulend

---
## Example folder structure

---?image=images/03/a001.png

---
## Undo?
* Can undo almost anything
* "Revert This Commit" is for single undo in GitHub
* More complex undo need to use Git command line
* [Cheat sheet](https://blog.github.com/2015-06-08-how-to-undo-almost-anything-with-git/)


---
## Use your student resources
@ul[squares]
* Microsoft or Google cloud storage
* Sync large files remotely
* Access via your LinkBlue account
@ulend

---?image=images/03/a002.png

---
## Download ArcGIS Pro
* For installation on personal computer
* Use this [OneDrive shared link](https://luky-my.sharepoint.com/:u:/g/personal/blshea1_uky_edu/EXZc5GPN41ZIrqjiSlO3AjEBJo3Z7ybHSc1qWDqkrySpVw?e=yHASu6)
* On MacOS? [Get Parallels](https://www.parallels.com/products/desktop/trial/)

---
## UKy ArcGIS Online
* UKy has Organization account
* URL: [UKY-EDU.maps.arcgis.com](https://UKY-EDU.maps.arcgis.com)
* Login with credentials created after invite

---?image=images/03/a003.png
<h2 style="color:#eee;text-shadow: 2px 2px 4px #000;">Our Portal</h2>

---
## Setup project in root GIS folder
* [Download and unzip lesson/lab data](https://luky-my.sharepoint.com/:u:/g/personal/blshea1_uky_edu/EZ_A1MZ5tqJKm7E_RFvE3hEByn0LEJN7aIc1VJ0ByrDQ0g?e=I4a3uF)
* Put geodatabase in *data* folder

---
## Let's get started!
* Launch ArcGIS Pro
* [Tutorials](http://pro.arcgis.com/en/pro-app/get-started/pro-quickstart-tutorials.htm)
* Tour drive around GUI



---?image=images/03/a004.png
<h2 style="color:#eee;text-shadow: 2px 2px 4px #000;">Global settings</h2>

---?image=images/02/01.jpg
<h2 style="color:#eee;text-shadow: 2px 2px 4px #000;">Insert > New Local Scene</h2>

---?image=images/02/02.jpg
<h2 style="color:#eee;text-shadow: 2px 2px 4px #000;">Add Elevation Source</h2>

---
## Add all layers
* Explore how to symbolize layers
* Reorder them in the **Contents** pane
* Flex your GIS muscle memory!

---
## Start coding
* Getting scrappy with Python!
* Watch [second lesson videos](https://www.py4e.com/lessons/intro) in *Python for Everybody*


---
## Python 
@ul[squares]
* Modular programming
* functions >> modules >> packages
    * for: simplicity, maintainability, reusability, addressing
* An open-source quilt of contributions
@ulend

---?image=https://www.metmuseum.org/toah/images/hb/hb_1996.4.jpg

---
## Managing your environment
@ul[squares]
* A development environment is a constellation of packages
* Most depend on a distinct version of other packages
* Chain of dependencies must not be broken!
* Create virtual environments
@ulend

---
## Dependency Hell
[Yep, there's a term for it](https://en.wikipedia.org/wiki/Dependency_hell)    


---
Here's what it looks like
![Dependencies for Gentoo Linux](https://cgatoxford.files.wordpress.com/2017/05/gentoo-deps.jpg)
[link](https://cgatoxford.wordpress.com/2017/05/12/the-dependency-hell-in-software-development/)

---
## Python in ArcGIS Pro
@ul[squares]
* Built-in Package Management
* Development in Windows OS only
* Make clone of default read-only environment
@ulend


---
## Python in VS Code
@ul[squares]
* Use Anaconda or ArcGIS Pro
* Create *.py* files to execute in terminal
* Develop on most operating systems
* Create first program: "Geography, Y'all!"
@ulend

---
## Development in ArcGIS Pro
@ul[squares]
* Jupyter Notebook creates *.ipynb* files
* Run cells of code rather than the entire script
* Cells can be Python or Markdown
@ulend

---
## Setting up geoprocessing 
@ul[squares]
* ArcPy is the Python package that ships with ArcGIS Pro
* Very well documented
* Typically other properties are set to customize your workflow
@ulend

---
# ArcPy

---
```python
# get the ArcGIS tools!
import arcpy # case-sensitive!
```

---
```python
# set environment properties
arcpy.env.workspace = r"Z:\BoydsGIS\data\rrg_build.gdb"
arcpy.env.overwriteOutput = True
# use dot notation to address functions, properties, etc.
```

---
```python
# get list of feature classes in our database
# and print them to the screen
featureList = arcpy.ListFeatureClasses()
print(featureList)
```

---
```python
# get list of feature classes in our database
# and print them to the screen
rasterList = arcpy.ListRasters()
print(rasterList)
```

---
```python
# vector clip to area of interest
arcpy.analysis.Clip("cookie dough", "cookie cutter", "output cookie")
```


---
# Wanna see into the future?

---
```python
# build field data type showing properties of us_arches fields.
fields = arcpy.ListFields(layer_name)
for field in fields:
    fieldInLayer = f"{field.name} is a type of {field.type}."
    print(fieldInLayer)
```