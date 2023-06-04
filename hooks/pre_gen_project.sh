#!/bin/bash

NAME="{{cookiecutter.package}}"
LIB_NAME="{{cookiecutter.library_name}}"

ng new $NAME --no-create-application --directory ./ --skip-install

ng generate library $LIB_NAME --skip-install

