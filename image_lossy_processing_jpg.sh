
#! /bin/bash

set -e

mkdir -p /work/artifact
cd /images

rust-parallel -r '(.*)\.(.*)' -p gm mogrify -resize 1200x -strip -filter sinc {0} ::: $(find /images -maxdepth 1 -name "*.jpg" ! -name "*fs2.jpg"  ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p cjpeg -outfile {1}-fs2.jpg {0} ::: $(find /images -maxdepth 1 -name "*.jpg" ! -name "*fs2.jpg"  ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p guetzli --verbose {0} {1}a.jpg ::: $(find /images -maxdepth 1 -name "*fs2.jpg" ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p avifenc {0} {1}.avif ::: $(find /images -maxdepth 1 -name "*.jpg" ! -name "*fs2.jpg"  ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p cjxl {0} {1}.jxl ::: $(find /images -maxdepth 1 -name "*.jpg" ! -name "*fs2.jpg"  ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

rust-parallel -r '(.*)\.(.*)' -p cwebp -q 80 -af {0} -o {1}.webp ::: $(find /images -maxdepth 1 -name "*.jpg" ! -name "*fs2.jpg"  ! -name "*fs2a.jpg" -type f -exec basename {} \; | awk '!seen[$0]++' | awk '{ printf("%s " , $0) }')

tar vcJf ./images.tar.xz *.jpg *.avif *.jxl *.webp

mv ./images.tar.xz /work/artifact/
