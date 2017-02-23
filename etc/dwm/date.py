#!/usr/bin/python
from time import strftime, sleep
from subprocess import call

timeformat = "%d %b %H:%M"

while True:
    timestring = strftime(timeformat)
    call(['xsetroot', '-name', timestring])
    sleep(1)
    
