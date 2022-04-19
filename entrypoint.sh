#!/bin/bash
set -xe
mkdir -p /root/convert
mkdir -p /root/convert/output
cd /root/convert

# set memory limits
sed -i -E 's/name="memory" value=".+"/name="memory" value="4GiB"/g' /etc/ImageMagick-6/policy.xml
sed -i -E 's/name="map" value=".+"/name="map" value="4GiB"/g' /etc/ImageMagick-6/policy.xml
sed -i -E 's/name="area" value=".+"/name="area" value="4GiB"/g' /etc/ImageMagick-6/policy.xml
sed -i -E 's/name="disk" value=".+"/name="disk" value="10GiB"/g' /etc/ImageMagick-6/policy.xml

LESS_VERBOSE_OUTPUT="-hide_banner -loglevel warning"
IMAGE_10_FPS_320P="fps=10,scale=320:-1:flags=lanczos" # delay 10
IMAGE_20_FPS_480P="fps=20,scale=480:-1:flags=lanczos" # delay 5
IMAGE_20_FPS_720P="fps=20,scale=720:-1:flags=lanczos" # delay 5
IMAGE_20_FPS_1080P="fps=20,scale=1080:-1:flags=lanczos" # delay 5

echo "Converting..."
convert -list resource
ffmpeg -i input.mov $LESS_VERBOSE_OUTPUT -vf "$IMAGE_20_FPS_1080P" -c:v pam -f image2pipe - | convert -limit memory 1024MiB -verbose -delay 5 - -loop 0 -layers optimize /root/convert/output/output.gif

