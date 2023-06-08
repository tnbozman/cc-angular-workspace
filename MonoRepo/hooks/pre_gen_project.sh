#!/bin/bash

WORKSPACE="{{cookiecutter.workspace_name|lower|replace(' ', '-')|replace('_', '-')}}"
PROJECT="{{cookiecutter.project_name|lower|replace(' ', '-')|replace('_', '-')}}"
LIB="${PROJECT}-lib"
$SHELL="shell"

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

npm i concurrently --save-dev
command_msg $success "npm concurrently added to project"

npm install -g npm-add-script
command_msg $success "npm npm-add-script added globally"

ng new $WORKSPACE --no-create-application --directory ./ --skip-install

ng generate library $LIB --skip-install

echo -e "$starting: create project $SHELL"
ng generate application $SHELL --skip-install --routing true --style scss
command_msg $success "project $SHELL created"
npm install -g npm-add-script
command_msg $success "npm npm-add-script added"

ng add @angular/material --project $SHELL
command_msg $success "added angular/material added to project $SHELL"
ng add @angular/cdk
command_msg $success "added angular/component development kit to project $SHELL"

ng add @angular-architects/module-federation --project $SHELL --port 4200 --type dynamic-host
command_msg $success "Module federation added to $SHELL project"

mfReattemp=0
# Sometimes module-federation isn't being installed. Lets force it
until (grep -q '"@angular-architects/module-federation":' ./package.json)
do
  mfReattemp=1
  echo -e "${Yellow}REATTEMPT${Color_Off} detected module federation missing, trying to add"
  ng add @angular-architects/module-federation --project $SHELL --port 4200 --type dynamic-host
done

if [[ $mfReattempt == 1 ]]; then
  echo -e "$success Module federation reattempt"
fi