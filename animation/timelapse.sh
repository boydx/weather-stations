#!/bin/bash

# Create Cold Mountain time-lapse animation

x=$(ColdMountain-*.jpg)
convert -delay 50  $x -loop 0 ColdMountain.gif

x=$(find NewGap-*.jpg)
convert -delay 50  $x -loop 0 NewGap2.gif

# Create LookRock time-lapse animation

x=$(LookRock-*.jpg)
convert -delay 50  $x -loop 0 LookRock.gif

# Create Purchase Knob time-lapse animation

x=$(PurchaseKnob-*.jpg)
convert -delay 50  $x -loop 0 PurchaseKnob.gif
