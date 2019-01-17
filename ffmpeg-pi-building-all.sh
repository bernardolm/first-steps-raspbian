#!/bin/sh

sudo apt remove --purge libmp3lame-dev libtool libssl-dev libaacplus-* libx264 libvpx librtmp ffmpeg
sudo apt update
#sudo apt upgrade
sudo apt install libmp3lame-dev -y
sudo apt install -y libopus-dev
sudo apt install autoconf -y
sudo apt install libtool -y
sudo apt install checkinstall -y
sudo apt install libssl-dev -y
sudo apt install libtool-bin -y
sudo apt install unzip -y
sudo apt install curl -y
sudo apt install git -y
sudo apt install pkg-config -y

cd /usr/local/src/

#LibaacPlus
cd /usr/local/src/
sudo wget http://tipok.org.ua/downloads/media/aacplus/libaacplus/libaacplus-2.0.2.tar.gz
sudo tar -xzf libaacplus-2.0.2.tar.gz
cd libaacplus-2.0.2
./autogen.sh --with-parameter-expansion-string-replace-capable-shell=/bin/bash --host=arm-unknown-linux-gnueabi --enable-static
make
sudo make install
cd ..

# Libx264
cd /usr/local/src/
sudo git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
sudo make install
cd ..

#LibVPX
cd /usr/local/src/
sudo git clone https://chromium.googlesource.com/webm/libvpx
cd libvpx
./configure
make
checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no     --deldoc=yes --fstrans=no --default
cd ..

#LibRTMP
cd /usr/local/src/
sudo git clone git://git.ffmpeg.org/rtmpdump
cd rtmpdump
#make SYS=posix
checkinstall --pkgname=rtmpdump --pkgversion="2:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
ldconfig
cd ..

#Libfaac
cd /usr/local/src/
sudo curl -#LO http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz
sudo tar xzvf faac-1.28.tar.gz
cd faac-1.28
sudo sed -i '126a #ifdef _STRING_H' common/mp4v2/mpeg4ip.h
sudo sed -i '127c char *strcasestr(const char *haystack, const char *needle);' common/mp4v2/mpeg4ip.h
sudo sed -i '127a #endif' common/mp4v2/mpeg4ip.h
./configure --host=arm-unknown-linux-gnueabi
make
sudo make install
ldconfig
cd ..

#reboot

#LibFDK-aac
cd /usr/local/src/
sudo wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master
sudo tar xzvf fdk-aac.tar.gz
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --enable-shared
make -j2
sudo make install
cd ..

#FFMPEG (Latest Version)
cd /usr/local/src/
sudo git clone --depth 1 https://github.com/FFmpeg/FFmpeg.git
cd FFmpeg
./configure --enable-cross-compile --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-libfdk-aac --enable-libvpx --enable-libopus --enable-libmp3lame
make -j3
sudo make install
ldconfig
#cd ~
cd ..

reboot
