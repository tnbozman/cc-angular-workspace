#!/bin/bash

Color_Off='\033[0m'       # Text Reset
# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Blue='\033[0;34m'         # Blue
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple

remove="${Purple}DELETE${Color_Off}"
success="${Green}SUCCESS${Color_Off}"
create="${Green}CREATE${Color_Off}"
update="${Green}UPDATE${Color_Off}"
error="${Red}ERROR${Color_Off}"
starting="${Yellow}STARTING${Color_Off}"
line="${Yellow}#################################${Color_Off}"
complete="${Yellow}COMPLETED${Color_Off}"

command_msg(){
  if [ $? == 0 ] ; then
    echo -e "$1 $2"
  else
    echo -e "$error $2"
    exit 1
  fi
}


NAME="{{cookiecutter.package}}"
LIB_NAME="{{cookiecutter.library_name}}"

./hooks/scripts/patch-existing-lib -n $NAME -b ./
echo "export * from './lib/golden-layout/base-component.directive';" >> ./projects/$LIB_NAME/src/public-api.ts
command_msg $update "projects/$LIB_NAME/src/public-api.ts"
echo "export * from './lib/golden-layout/text-component.interface';" >> ./projects/$LIB_NAME/src/public-api.ts
command_msg $update "projects/$LIB_NAME/src/public-api.ts"