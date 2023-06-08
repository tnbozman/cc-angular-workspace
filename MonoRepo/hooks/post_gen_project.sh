#!/bin/bash

WORKSPACE="{{cookiecutter.workspace_name|lower|replace(' ', '-')|replace('_', '-')}}"
PROJECT="{{cookiecutter.project_name|lower|replace(' ', '-')|replace('_', '-')}}"
LIB="${PROJECT}-lib"
$SHELL="shell"
BASE_PATH="./"

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


./hooks/scripts/patch-existing-lib -n $WORKSPACE -b $BASE_PATH
echo "export * from './lib/golden-layout/base-component.directive';" >> ./projects/$LIB/src/public-api.ts
command_msg $update "projects/$LIB/src/public-api.ts"
echo "export * from './lib/golden-layout/text-component.interface';" >> ./projects/$LIB/src/public-api.ts
command_msg $update "projects/$LIB/src/public-api.ts"

sed -i "/^@NgModule.*/i import { BaseComponentDirective } from './golden-layout/base-component.directive';" ./projects/$LIB/src/lib/$LIB.module.ts
command_msg $update "projects/$LIB/src/lib/$LIB.module.ts"
sed -i "/exports.*/a BaseComponentDirective," ./projects/$LIB/src/lib/$LIB.module.ts
command_msg $update "projects/$LIB/src/lib/$LIB.module.ts"
sed -i "/declarations.*/a BaseComponentDirective," ./projects/$LIB/src/lib/$LIB.module.ts
command_msg $update "projects/$LIB/src/lib/$LIB.module.ts"

echo -e "$starting: create project $SHELL"
ng generate application $SHELL --skip-install --routing true --style scss
command_msg $success "project $SHELL created"
npm install -g npm-add-script
command_msg $success "npm npm-add-script added"

./hooks/scripts/patch-existing-project -n $SHELL -b $BASE_PATH


# echo "{}" > ./projects/$SHELL/src/assets/mf.manifest.json
command_msg $update "./projects/$SHELL/src/assets/mf.manifest.json"


npm install
echo -e "$success Creating workspace $WORKSPACE complete"
