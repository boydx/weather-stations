tar -zcf 1101.tgz 1101*
rm -fv 1101*/*.jpg
rm -fv 1101*/*.flv
tar -zcf 1102.tgz 1102*
rm -fv 1102*/*.jpg
rm -fv 1102*/*.flv
tar -zcf 1103.tgz 1103*
rm -fv 1103*/*.jpg
rm -fv 1103*/*.flv
tar -zcf 1104.tgz 1104*
rm -fv 1104*/*.jpg
rm -fv 1104*/*.flv
tar -zcf 1105.tgz 1105*
rm -fv 1105*/*.jpg
rm -fv 1105*/*.flv
tar -zcf 1106.tgz 1106*
rm -fv 1106*/*.jpg
rm -fv 1106*/*.flv
su bh
scp *.tgz monsoon:Weather\ Photos/
exit
