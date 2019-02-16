## Ubuntu 18.04 LTS 64Bit

### Local Build
```
sudo apt install build-essential autoconf p7zip p7zip-full p7zip-rar libxml2-utils yui-compressor mtd-utils
```
**Helpful**

Check the yui-compressor link to right java version.
The java wrapper on the yui-compressor bin can be strange on the path building, remove it when not needed.
If this is not corrected the css and js is missing on the camera frontend

### Hi SDK & Drivers Dependencies
```
sudo apt install build-essential lib32z1 lib32stdc++6-4.8-dbg u-boot-tools zlib1g-dev libncurses5-dev libncursesw5-dev uuid-dev
```
Download this file for patch
http://nl.archive.ubuntu.com/ubuntu/pool/universe/m/mtd-utils/mtd-utils_1.5.2.orig.tar.bz2