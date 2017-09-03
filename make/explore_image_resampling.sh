convert -crop 600x250+270+300 latest_EVV_vis.jpg g.jpg
convert g.jpg -filter spline -resize 200% g2.jpg
convert g2.jpg -unsharp 0x0.75+0.75+0.008 g4.jpg


convert -crop 600x200+270+350 latest_EVV_vis.jpg \
-filter spline -resize 200% \
-unsharp 0x0.75+0.75+0.008 \
zzf.jpg

composite -gravity center overlay.png zzf.jpg zzf.jpg
montage -geometry +0+0 -background white -label "@date.txt" zzf.jpg zzf.jpg


convert -crop 600x200+270+350 latest_EVV_vis.jpg \
-filter spline -resize 200% \
-unsharp 0x0.75+0.75+0.008 \
zzf.jpg \
composite zzf.jpg -gravity center overlay.png \
zzf.jpg \
montage zzf.jpg -geometry +0+0 -background white -label "@date.txt" \
zzf.jpg

composite -gravity center overlay.png zz2.jpg zz2.jpg
montage -geometry +0+0 -background white -label "@date.txt" zz3.jpg zz3.jpg


# Make Cumberland Gap weather images
/usr/bin/convert -crop 600x200+270+350 latest_EVV_vis.jpg \
-filter spline -resize 200% \
-unsharp 0x0.75+0.75+0.008 \
cuga-vis.jpg
/usr/bin/composite -gravity center overlays/cuga-overlay.png cuga-vis.jpg cuga-vis.jpg
/usr/bin/montage -geometry +0+0 -background white -label "@date.txt" cuga-vis.jpg cuga-vis.jpg

https://www.outragegis.com/weather/solar_eclipse_2017/grsm.gif
https://www.outragegis.com/weather/solar_eclipse_2017/grpk.gif