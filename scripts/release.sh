#! /usr/bin/env bash

VERSION=$1
TMP_FOLDER=$2
RELEASE_FOLDER=$3
ENV=$4

rm -rf $TMP_FOLDER/$RELEASE_FOLDER
mkdir $TMP_FOLDER/$RELEASE_FOLDER
git clone git@github.com:wallabag/wallabag.git -b $VERSION $TMP_FOLDER/$RELEASE_FOLDER/$VERSION
cd $TMP_FOLDER/$RELEASE_FOLDER/$VERSION && SYMFONY_ENV=$ENV composer up -n --no-dev
cd $TMP_FOLDER/$RELEASE_FOLDER/$VERSION && php bin/console wallabag:install --env=$ENV
cd $TMP_FOLDER/$RELEASE_FOLDER && tar czf wallabag-$VERSION.tar.gz --exclude="var/cache/*" --exclude="var/logs/*" --exclude="var/sessions/*" --exclude=".git" $VERSION
echo "MD5 checksum of the package for wallabag $VERSION"
md5 $TMP_FOLDER/$RELEASE_FOLDER/wallabag-$VERSION.tar.gz
scp $TMP_FOLDER/$RELEASE_FOLDER/wallabag-$VERSION.tar.gz framasoft_bag@78.46.248.87:/var/www/framabag.org/web
rm -rf $TMP_FOLDER/$RELEASE_FOLDER
