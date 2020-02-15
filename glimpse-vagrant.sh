#!/bin/bash

export INSTALL_PREFIX=/vagrant/glimpse-prefix
export SRC_PREFIX=/vagrant
export PATH=$HOME/.local/bin:$INSTALL_PREFIX/bin:$PATH
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/lib/x86_64-linux-gnu/pkgconfig:$INSTALL_PREFIX/share/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib:$INSTALL_PREFIX/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export ACLOCAL_FLAGS="-I $INSTALL_PREFIX/share/aclocal $ACLOCAL_FLAGS"

mkdir -p $INSTALL_PREFIX
mkdir -p $INSTALL_PREFIX/share/aclocal

. build-linux.sh
