# calibre Installer for OS X

The simple way to update or install calibre.

![Screenshot](Screenshot.png "calibre Installer in action!")

As of its current version, [calibre](http://calibre-ebook.com/) requires for
users to visit the [calibre download page](http://calibre-ebook.com/download),
get the latest DMG, and swap the new application with the old one. Laziness
provoked me to spend even more time than visiting a link to write this
installation script.

## What magic lives inside?

The app consists of a shell script bundled as an OS X application. The script
works as follows:

 1. Closes any running calibre instances
 2. Checks the
 [calibre release feed](http://code.google.com/feeds/p/calibre-ebook/downloads/basic)
 for the latest version of calibre.
 3. Downloads and mounts the latest disk image
 4. Replaces calibre in the local application folder
 (`~/Applications/calibre.app`) or the shared application folder
 (`/Applications/calibre.app`); if calibre is not installed, the script will
 install calibre to `/Applications/calibre.app`
 5. A back up of any previous version can be found in
 ``/tmp/calibre-`date +%s`.app.bak``
 6. When finished, calibre will launch!

All output will be logged to `~/Library/Logs/calibre-installer.log`.

## Many Thanks to...

 - [Kovid Goyal](http://kovidgoyal.net/) and [company](http://calibre-ebook.com/about#contributors) for calibre
 - diaboNL for the calibre icon (used by the installer)
   script)
 - [Sveinbjorn Thordarson](https://github.com/sveinbjornt)
   for the magnificent [Platypus](https://github.com/sveinbjornt/Platypus)

## License

calibre Installer is free (as in freedom), open-source software distributed
under the terms and conditions of the Free Software Foundation's
[GNU General Public License](http://www.gnu.org/licenses/gpl.html).
