#! /bin/sh
#
# Install the latest version of calibre for OS X
# Replaces any existing version in /Applications or ~/Applications
#
# Copyright (C) 2013 Faraz Yashar
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <http://www.gnu.org/licenses/>.

# Note: `set -e` is not included in order to provide custom error failures for
# failed cURL requests; with `set -e`, cURL the script will exit if returns `1`
# with a failed download

#
# Utility functions
#

log_file="$HOME/Library/Logs/calibre-installer.log"

# Exit with an optional [error message] and [exit status]
error_exit() {
  echo "Calibre install error: ${1:-"Unknown Error"}
You can manually download and install calibre from http://calibre-ebook.com/download_osx
See the log file for more information: $log_file
" 1>&2; exit "${2:-1}"
}

# GET a <URL> and write the output to <output file>; throw an error if the request fails
download_or_exit(){
  response_code=`curl --write-out %{http_code} --output $2 $1`
#  echo ''
#  [ "$response_code" != "200" ] && error_exit "Failed HTTP request!
#Server responded with a $response_code error when requesting \"$1\"
# See $2 for the full output of the request"
}

#
# Main script
# Wrapped in a function for logging purposes; executes at the end of this file
#
main_function(){
[ `uname` != 'Darwin' ] && error_exit "This installation script is incompatible with `uname` operating systems."

if [ `osascript -e 'tell application "System Events" to (name of processes) contains "calibre"'` = true ]; then
  echo "Quitting calibre..."
  osascript -e 'tell app "calibre" to quit' || error_exit 'Calibre failed to quit!'
fi

release_url='http://code.google.com/feeds/p/calibre-ebook/downloads/basic'
echo "Downloading the calibre release feed from $release_url..."
download_or_exit $release_url /tmp/calibre-feed

calibre_download_url=`cat /tmp/calibre-feed | grep -o "http://calibre-ebook\.googlecode\.com/files/calibre.*\.dmg"`
# Raise an error if no download URL is found
if [ -z $calibre_download_url ]; then
  page_title=`cat /tmp/calibre-feed | grep "<title>.*</title>" | sed s/'<\/*title>'//g`
  error_exit "No download URL found at $release_url. Instead found page: $page_title
See /tmp/calibre-feed for the full contents of $release_url."
fi

echo "Downloading calibre image from $calibre_download_url..."
dmg=`basename $calibre_download_url` # The image filename (e.g. 'calibre-x.x.x.dmg')
download_or_exit "$calibre_download_url" /tmp/$dmg

mount_point="/Volumes/`basename $dmg .dmg`"
echo "Mounting /tmp/$dmg to $mount_point..."
hdiutil attach /tmp/$dmg
[ -e $mount_point/calibre.app ] || error_exit '"calibre.app" could not be found in the downloaded .dmg'

local_calibre="$HOME/Applications/calibre.app"
backup_dir="/tmp/calibre-`date +%s`.app.bak"

install_dir='/Applications/calibre.app'
if [ -e local_calibre ]; then
  echo "Moving current calibre installation in ~/Applications to $backup_dir..."
  mv local_calibre $backup_dir
  install_dir=$local_calibre
elif [ -e /Applications/calibre.app ]; then
  echo "Moving current calibre installation in /Applications to $backup_dir..."
  mv /Applications/calibre.app $backup_dir
fi

echo "Installing calibre to $install_dir"
cp -R $mount_point/calibre.app $install_dir

echo "Unmounting the image..."
hdiutil detach `hdiutil info | grep $mount_point | grep -o "/dev/disk\d*s\d*"`

echo "Install complete! Launching calibre!"
osascript -e "tell application \"calibre\" to activate" || error_exit "Calibre failed to open!"
sleep 5
} # End main_function wrap

echo "Logging output to $log_file..."
main_function 2>&1 | tee -a $log_fle
