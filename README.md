# set-backlight 

## Introduction
This is a small script to set the backlight brignthness for intel\_backlight systems. it was the easies way to get what i want. it can't do much and it shall not do much. you can make your screen brighter or darker on an absolute or relativ scale or increase/decrease the brightness by a relative value. If that is not enough do it and expand functionallity. If you like to change the program to your flavor please forg it, if you want to help me develop the script please create a merge request for your changes. Hope it helps some people struggling with the same problem and searching for an **K.I.S.S.** solution.   

## Install

### Clone the Repository
``` sh
git clone git@github.com:MortenManzelmann/set-backlight.git
 
or

git clone https://github.com/MortenManzelmann/set-backlight.git
```

### Download the zip 
https://github.com/MortenManzelmann/set-backlight/archive/master.zip

### Create symlink to use it where you need it
``` sh
$(cd /usr/bin && sudo ln -s <download dir>/set-backlight/set-backlight.sh set-backlight) ])
```

## Help
``` sh
Call: set-backlight [OPTION] value

 If the value is to high or low the max or min value will be used.
  -a, --absolute    Assigns an absolute value 
  -r, --relative    Assign a relative value in percent 
  -u, --up          Increase the brightness relative
  -d, --down        Decrease the brightness relative
  -h, --help        Display this help


This is kiss aproache to solve a problem encountered by the usage of an intel backlight drive. it's straight forward assigning values to the system files. Feel free to use, change or improve this script for your own usecase.
```


