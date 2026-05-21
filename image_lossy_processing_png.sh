
#! /bin/bash

set -e

mkdir -p /work/artifact
cd /images

rust-parallel -r '(.*)\.(.*)' -p gm mogrify -resize 600x -strip -filter sinc {0} ::: $(find . -maxdepth 1 -name "*.png" ! -name "*-fs8.png" ! -name "*-fs8a.png" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p pngquant --quality=75-85 --ext=-fs8.png {0} ::: $(find . -maxdepth 1 -name "*.png" ! -name "*-fs8.png" ! -name "*-fs8a.png" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p zopflipng --lossy_transparent {0} {1}a.png ::: $(find . -maxdepth 1 -name "*-fs8.png" ! -name "*-fs8a.png" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

tar vcJf ./images.tar.xz *.png

mv ./images.tar.xz /work/artifact/
