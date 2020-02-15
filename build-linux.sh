#!/bin/bash
set -e

cwd=$(pwd)
export INSTALL_PREFIX=${INSTALL_PREFIX:-/usr/local}
export SRC_PREFIX=${SRC_PREFIX:-$cwd}
export INSTALL_COMMAND=${INSTALL_COMMAND:-sudo make install}
export PATH=$INSTALL_PREFIX/bin:$PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/lib/x86_64-linux-gnu/pkgconfig:$INSTALL_PREFIX/share/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib:$INSTALL_PREFIX/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

if [ ! -e $INSTALL_PREFIX ]; then
    mkdir -p $INSTALL_PREFIX
fi

echo "** Cloning submodules in $SRC_PREFIX..."
cd $SRC_PREFIX
git submodule init
git submodule update

echo "** Building BABL in $SRC_PREFIX..."
cd $SRC_PREFIX/babl
./autogen.sh --prefix=$INSTALL_PREFIX
make
$INSTALL_COMMAND

echo "** Building mypaint-brushes in $SRC_PREFIX..."
cd $SRC_PREFIX/mypaint-brushes
./autogen.sh --prefix=$INSTALL_PREFIX
./configure --prefix=$INSTALL_PREFIX
make
$INSTALL_COMMAND

echo "** Building libmypaint in $SRC_PREFIX..."
cd $SRC_PREFIX/libmypaint
./autogen.sh --prefix=$INSTALL_PREFIX
./configure --prefix=$INSTALL_PREFIX
make
$INSTALL_COMMAND

echo "** Building GEGL in $SRC_PREFIX..."
cd $SRC_PREFIX/gegl
cp ../install-sh .
./autogen.sh --prefix=$INSTALL_PREFIX
make
$INSTALL_COMMAND

echo "** Building Glimpse in $SRC_PREFIX..."
cd $SRC_PREFIX
./autogen.sh --prefix=$INSTALL_PREFIX
make
$INSTALL_COMMAND
