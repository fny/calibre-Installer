# calibre Installer for OS X

The simple way to update or install calibre.

You can [download the latest release](https://github.com/fny/calibre-Installer/archive/master.zip)
from the source archive or by cloning the repo. (GitHub recently deprecated the
[Downloads Tab](https://github.com/blog/1302-goodbye-uploads).) Expect me to
move the app for proper hosting soon: builds don't belong in code repositories. ;D

![Screenshot](https://raw.github.com/fny/calibre-Installer/master/Screenshot.png "calibre Installer in action!")

As of its current version, [calibre](http://calibre-ebook.com/) requires for
users to visit the [calibre download page](http://calibre-ebook.com/download),
get the latest DMG, and swap the new application with the old one. Laziness
provoked me to spend even more time than visiting a link to write this
installation script.

## What magic lives inside?
file:///Users/farazyashar/Workspace/Published%20Code/calibre%20Installer/README.md
The app consists of a shell script bundled as an OS X application. The script
works as follows:

 1. Closes any running calibre instances
 2. Downloads [the latest calibre](http://calibre-ebook.com/download_osx) and mounts the disk image
 3. Replaces calibre in the local application folder
 (`~/Applications/calibre.app`) or the shared application folder
 (`/Applications/calibre.app`); if calibre is not installed, the script will
 install calibre to `/Applications/calibre.app`
 4. A back up of any previous version can be found in
 ``/tmp/calibre-`date +%s`.app.bak``
 5. When finished, calibre will launch. (Note that as of this implementation, calibre will not become the frontmost application upon launch.)

## Contributing

### Suggestions and Bug Reports

Submit issues and requests through [Github issues](https://github.com/fny/calibre-Installer/issues/new) or the [associated thread on the calibre forums](http://www.mobileread.com/forums/showthread.php?t=204157&referrerid=185801).

Please provide the output of the installer's text window if relevant.

### Hacking Guidelines

 - Play with the shell script (calibre-installer.sh) to your hearts content
 - Try to keep things POSIX compliant
 - Stick to native OS X command-line utilities
 - Make sure to test the output of the script
 - Don't worry about creating a new build of the application

## Many Thanks to...

 - [Kovid Goyal](http://kovidgoyal.net/) and [company](http://calibre-ebook.com/about#contributors) for calibre
 - [Kamil Tatara](http://www.flickr.com/photos/cakeshop_pl/5987792062/) for the calibre icon (used by this app too)
 - [Sveinbjorn Thordarson](https://github.com/sveinbjornt)
   for the magnificent [Platypus](https://github.com/sveinbjornt/Platypus)

## License

calibre Installer is free (as in freedom), open-source software distributed
under the terms and conditions of the Free Software Foundation's
[GNU General Public License](http://www.gnu.org/licenses/gpl.html).
