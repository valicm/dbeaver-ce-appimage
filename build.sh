#!/bin/bash
# MIT License
#
# Copyright (c) 2022 Valentino Međimorec
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -eu

APP_DIRECTORY="AppDir"
DBEAVER_DIRECTORY=$APP_DIRECTORY/usr/bin
ICON_DIRECTORY=$APP_DIRECTORY/usr/share/icons/hicolor/256x256/apps
rm -rf AppDir

mkdir $APP_DIRECTORY
mkdir -p $ICON_DIRECTORY

echo "==> Download DBeaver CE"
wget -O $APP_DIRECTORY/dbeaver-ce.tar.gz https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz

echo "==> Extract DBeaver CE"
cd $APP_DIRECTORY
tar -xzvf *.tar.gz && rm -r *.tar.gz
mv dbeaver usr/bin
cd ..
VERSION=$(cat $DBEAVER_DIRECTORY/.eclipseproduct | sed -n 3p | sed 's/version=//g')

echo "DBEAVER_CE_VERSION=$VERSION" >> "$GITHUB_ENV"


echo "==> Fetch default AppRun"
wget -O $APP_DIRECTORY/AppRun https://raw.githubusercontent.com/AppImage/AppImageKit/master/resources/AppRun
chmod +x $APP_DIRECTORY/AppRun

echo "==> Extract defaults for AppImage"
# Add defaults which we need for proper app image. Desktop files, icons.
cp dbeaver-ce.desktop $APP_DIRECTORY/.
cp $DBEAVER_DIRECTORY/dbeaver.png $APP_DIRECTORY/dbeaver-ce.png
cp $DBEAVER_DIRECTORY/dbeaver.png $ICON_DIRECTORY/dbeaver-ce.png

# Get GitHub user and repo
GH_USER="$( echo "$GITHUB_REPOSITORY" | grep -o ".*/" | head -c-2 )"
GH_REPO="$( echo "$GITHUB_REPOSITORY" | grep -o "/.*" | cut -c2- )"

echo "==> Build DBeaver CE AppImage"
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage
chmod +x *.AppImage
ARCH=x86_64 ./appimagetool-x86_64.AppImage --comp gzip "$APP_DIRECTORY" -n -u "gh-releases-zsync|$GH_USER|$GH_REPO|$DBEAVER_CE_VERSION|dbeaver-ce*.AppImage.zsync"
mkdir dist
mv dbeaver-ce*.AppImage* dist/.
