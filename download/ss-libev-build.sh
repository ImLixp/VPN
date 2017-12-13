#!/bin/bash

# cross-compiler: arm-linux-gnueabi-gcc
HOST=arm-linux-gnueabi
# x86-compiler: gcc
#HOST=

#ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
url="
https://github.com/jedisct1/libsodium/releases/download/1.0.15/libsodium-1.0.15.tar.gz
https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
https://github.com/shadowsocks/libev/archive/master.zip
https://c-ares.haxx.se/download/c-ares-1.12.0.tar.gz
https://tls.mbed.org/download/mbedtls-2.6.0-gpl.tgz
"
urlss="
https://github.com/shadowsocks/simple-obfs/archive/v0.0.5.tar.gz
https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.1.1/shadowsocks-libev-3.1.1.tar.gz
"
getDirname()
{
    file=`basename $1`
    case `echo $file | grep -o '\.\(zip\|t\(ar\.\)\{0,1\}gz\)$'` in
        .tar.gz|.tgz)
            tar -tf $file | head -1 | tr -d '/'
        ;;
        .zip)
            unzip -l $file | grep '/$' | head -1 | tr -s ' ' | cut -d ' ' -f 5 | tr -d '/'
        ;;
        *)
        ;;
    esac
        
}

compile()
{
    GCC=gcc
    if [ -n $HOST ];then
        GCC=$HOST-gcc
        HOST="--host=$HOST"
    fi
    dname=`getDirname $1`
    cd $dname
    ln -s ../insdir .
    test -x autogen.sh && ./autogen.sh
    case $dname in
        shadowsocks-libev-3.1.1|simple-obfs-0.0.5)
            if [ $dname == "simple-obfs-0.0.5" ];then
                cp -rf ../shadowsocks-libev-3.1.1/libcork .
            fi
            rootbase=$PWD/insdir
            usrbase=$PWD/insdir/usr/local
            usrlib=$usrbase/lib
            usrinc=$usrbase/include
            rootlib=$rootbase/lib
            rootinc=$rootbase/include
            makeflag="
                --disable-assert
                --disable-ssp
                --disable-system-shared-lib
                --with-cares-include=$usrinc
                --with-cares-lib=$usrlib
                --with-mbedtls-include=$rootinc
                --with-mbedtls-lib=$rootlib
                --with-sodium-include=$usrinc
                --with-sodium-lib=$usrlib
                $HOST
                --with-pcre=$usrbase
                --disable-documentation
                "
            ./configure $makeflag LDFLAGS="-L$usrlib" CFLAGS="-I$usrinc"
            make install DESTDIR=$PWD/insdir
        ;;
        pcre-8.38)
            ./configure $HOST --disable-cpp --enable-pcre8 --enable-pcre16 --enable-pcre32
            make install DESTDIR=$PWD/insdir
        ;;
        mbedtls-2.6.0)
            CC=$GCC make install DESTDIR=$PWD/insdir
        ;;
        libev-master|libsodium-1.0.15|c-ares-1.12.0)
            ./configure $HOST
            make install DESTDIR=$PWD/insdir
        ;;
        *)
            echo "Error $dname" > err.txt
        ;;
    esac
    cd -
}

download()
{
    x=$1
    wget --no-cache --no-cookies $x
    file=`basename $x`
#    ln -s ../../$file .
    echo =====================$file
    case `echo $file | grep -o '\.\(zip\|t\(ar\.\)\{0,1\}gz\)$'` in
        .tar.gz|.tgz)
            tar -zxf $file
        ;;
        .zip )
            unzip $file
        ;;
        * )
            echo unknow
        ;;
    esac
}

timestamp()
{
    dstr=`date '+ %s %N' | grep -o '[1-9][0-9]\+'`
    arr=($dstr)
    echo $((${arr[0]}*1000+${arr[1]}/1000000))
}

stime=`timestamp`
buildDir="shadowsocks-libev-v3.1.1-`date '+%Y%m%d%H%M'`"
if [ -d $buildDir ];then
    echo "ERROR: $buildDir is exist"
    exit 1
fi
mkdir $buildDir
cd $buildDir
mkdir insdir

for x in $url
do
{
    download $x
    compile $x
}&
done

for x in $urlss
do
{
    download $x
}&
done

echo "wait"
wait
for x in $urlss
do
{
    compile $x
}&
done
wait
echo "done"
etime=`timestamp`
echo $stime $etime $(($etime-$stime))
echo $stime $etime $(($etime-$stime)) >> time.txt

