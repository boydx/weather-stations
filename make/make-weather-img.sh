cd /var/www/vhosts/outrageGIS.com/httpdocs/weather/make
/usr/bin/convert -crop 400x250+200+275 latest_EVV_vis.jpg KyVIS-m.jpg
# /usr/bin/convert ../vis-sat-anim.gif latest_EVV_vis.jpg -loop 0 ../vis-sat-anim.gif
/usr/bin/convert -resize 600x600 KyVIS-m.jpg KyVIS-l.jpg
/usr/bin/composite -gravity center overlays/KyVis-overlay.png KyVIS-l.jpg KyVIS-l.jpg
/usr/bin/convert -resize 330x330 KyVIS-m.jpg KyVIS-s.jpg
/usr/bin/composite -gravity center overlays/KyVis-s-overlay.png KyVIS-s.jpg KyVIS-s.jpg
/usr/bin/convert -resize 100x100 KyVIS-m.jpg KyVIS-th.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" KyVIS-l.jpg KyVIS-large.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" KyVIS-s.jpg KyVIS-small.jpg
/usr/bin/convert -crop 330x180+90+370 centgrtlakes.gif KyRadar-m.gif
/usr/bin/convert -resize 330x330 KyRadar-m.gif KyRadar-s.gif
/usr/bin/convert -resize 100x100 KyRadar-m.gif KyRadar-th.gif
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" KyRadar-s.gif KyRadar-small.gif
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" centgrtlakes.gif CentralRadar.gif
/usr/bin/composite -gravity center overlays/JKL_overlay.png JKL_0.png JKL_0.png
/usr/bin/convert -resize 330x330 JKL_0.png DBNF-s.png
/usr/bin/convert -resize 100x100 JKL_0.png DBNF-th.png
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" JKL_0.png DBNF-large.png
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" DBNF-s.png DBNF-small.png
/usr/bin/convert -resize 330x330 US.png US-s.png
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" US-s.png US-small.png
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" US.png US-large.png
/usr/bin/convert -crop 350x320+330+300 latest_EVV_vis.jpg GrsmVis.jpg
/usr/bin/convert -resize 600x600 GrsmVis.jpg GrsmVis-l.jpg
/usr/bin/composite -gravity center overlays/GrsmVis-overlay.png GrsmVis-l.jpg GrsmVis-l.jpg
/usr/bin/convert -resize 330x330 GrsmVis.jpg GrsmVis-s.jpg
/usr/bin/composite -gravity center overlays/GrsmVis-s-overlay.png GrsmVis-s.jpg GrsmVis-s.jpg
/usr/bin/convert -resize 100x100 GrsmVis.jpg GrsmVis-th.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" GrsmVis-l.jpg GrsmVis-large.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" GrsmVis-s.jpg GrsmVis-small.jpg
/usr/bin/convert -crop 530x400+0+80 southeast.gif +repage GrsmRadar-m.gif
/usr/bin/convert -crop 558x571+70+0 centgrtlakes.gif +repage GrsmRadar-t.gif
/usr/bin/convert GrsmRadar-m.gif +repage GrsmRadar-1.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" GrsmRadar-1.jpg GrsmRadar-south.jpg
/usr/bin/convert GrsmRadar-t.gif +repage GrsmRadar-north.jpg
/usr/bin/composite -gravity center overlays/MRX_overlay.png MRX_0.png MRX_0.png
/usr/bin/convert -resize 330x330 MRX_0.png GRSM-RADAR-s.png
/usr/bin/convert -resize 100x100 MRX_0.png GRSM-RADAR-th.png
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" GRSM-RADAR-s.png GRSM-RADAR-small.png
/usr/bin/convert -resize 330x330 lrgnamsfcwbg.gif WeOBV.gif
# /usr/bin/convert -crop 650x450+2250+1500 lrgnamsfcwbg.gif WeOBV.gif
# /usr/bin/convert -crop 1200x1000+1900+1200 lrgnamsfcwbg.gif WeOBV-b.gif
/usr/bin/convert -resize 330x330 WeOBV.gif WeOBV-s.gif
/usr/bin/convert -resize 100x100 WeOBV.gif WeOBV-th.gif
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" WeOBV-s.gif WeOBV-small.gif
# /usr/bin/convert -resize 1400x1167 WeOBV-b.gif WeOBV-b.gif
mv lrgnamsfcwbg.gif WeOBV-large.gif
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" awcsfcwbg.gif WeOBV-large.gif
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" WeOBV-b.gif WeOBV-large.gif
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" WeOBV-b.gif WeOBV-big.gif
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" grpk.jpg PurchaseKnob.jpg
# /usr/bin/montage -geometry +0+0 -background white -label "@date.txt" grsmF.jpg LookRock.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" grsm.jpg LookRock.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" SHRO1_1.JPG ColdMountain.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" joki1.jpg JoyceKilmer.jpg
/usr/bin/convert -resize 220x220 SHRO1_1.JPG ColdMountain-400.jpg
/usr/bin/convert -resize 220x220 grsm.jpg LookRock-400.jpg
/usr/bin/convert -resize 220x220 grpk.jpg PurchaseKnob-400.jpg
/usr/bin/convert -resize 220x220 joki1.jpg JoyceKilmer-400.jpg
/usr/bin/convert -resize 145x145 PurchaseKnob.jpg grpk-small.jpg 
/usr/bin/convert -resize 145x145 LookRock.jpg grsm-small.jpg
/usr/bin/convert -resize 145x145 ColdMountain.jpg ColdMountain.jpg-small.jpg
/usr/bin/convert -resize 145x145 JoyceKilmer.jpg JoyceKilmer-small.jpg
/usr/bin/convert -rotate -2 JKLwebcam000M.jpg DBoone-1.jpg 
/usr/bin/convert -crop 1400x1050+70+80 DBoone-1.jpg DBoone-2.jpg
/usr/bin/convert -resize 700x525 DBoone-2.jpg DBoone-3.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" DBoone-3.jpg DBoone-Lg.jpg
/usr/bin/convert -resize 400x400 DBoone-Lg.jpg DBoone-400.jpg
/usr/bin/convert -resize 145x145 DBoone-Lg.jpg DBoone-145.jpg
# cp DBNF-small.png /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aab.thumb.png
# cp JKL_0.png /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aab.png
# cp KyVIS-small.jpg /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aac.thumb.jpg
# cp KyVIS-large.jpg /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aac.jpg
# cp GRSM-RADAR-small.png /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aad.thumb.png
# cp MRX_0.png /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aad.png
# cp GrsmVis-small.jpg /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aaa.thumb.jpg
# cp GrsmVis-large.jpg /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aaa.jpg
# cp WeOBV-small.gif /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aae.thumb.gif
# cp WeOBV-large.gif /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aae.gif
# cp KyVIS-small.jpg /home/httpd/vhosts/outrageGIS.com/httpdocs/pixel/albums/weather_maps/aac.highlight.jpg
chmod 775 *jpg
awk '/<td width="11%/' NewFoundGap.txt > NewFoundGap2.txt
sed 's/\/images\/wtf/http:\/\/forecast.weather.gov\/images\/wtf/g' NewFoundGap2.txt | sed 's/<\/tr>//g' > NewFoundGapWeather.txt
