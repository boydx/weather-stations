#!/bin/bash

# Create recent six-hour animation for Cumberland Gap

x=$(ls -1t | head -24 | sort)
convert -delay 50 $x -loop 0 ../../sat/cuga-sat-animation.gif
