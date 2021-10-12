#!/bin/bash

function parse_env {
  originalfile=$1
  tmpfile=$(mktemp)
  cp -a $originalfile $tmpfile
  cat $originalfile | envsubst "$(printf '${%s} ' ${!leviia*})" > $tmpfile &&  mv $tmpfile $originalfile
}

export leviia_app_color='#00BC73'

export leviia_app_name=Leviia
export leviia_app_prefix=leviia
subname=client
export leviia_app_version="4.0.5"
export leviia_app_build_version="4"
#Ncloginweb compare the two to know if it should add login to url
#do not put the same base adress unless you love bugs
export leviia_app_domain_name=cloud.leviia.com
export leviia_app_ecommerce=https://www.leviia.com
export leviia_app_idb=com.$leviia_app_prefix.$subname

parse_env src/main/res/layout/account_setup.xml
parse_env src/main/res/values/setup.xml
parse_env build.gradle

./gradlew assembleGenericDebug

#adb install build/outputs/apk/generic/debug/generic-debug-30180000.apk
mv build/outputs/apk/generic/debug/generic-debug-30180000.apk .
