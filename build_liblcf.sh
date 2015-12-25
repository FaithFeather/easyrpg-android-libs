#!/bin/bash
export WORKSPACE=$PWD

git clone https://github.com/EasyRPG/liblcf.git

# x86
export NDK_ROOT=$WORKSPACE/android-ndk-r10e
export PLATFORM_PREFIX=$WORKSPACE/x86-toolchain
export OLD_PATH=$PATH
export PATH=$PLATFORM_PREFIX/bin:$PATH
export CPPFLAGS="-I$PLATFORM_PREFIX/include -I$NDK_ROOT/sources/android/support/include"
export LDFLAGS="-L$PLATFORM_PREFIX/lib"
export PKG_CONFIG_PATH=$PLATFORM_PREFIX/lib/pkgconfig
export TARGET_HOST="i686-linux-android"

autoreconf -i
./configure --host=$TARGET_HOST --prefix=$PLATFORM_PREFIX --disable-shared --enable-static --disable-xml
make -j2
make install

# armeabi
export PLATFORM_PREFIX=$WORKSPACE/armeabi-toolchain
export PATH=$OLD_PATH
export PATH=$PLATFORM_PREFIX/bin:$PATH
export CPPFLAGS="-I$PLATFORM_PREFIX/include -I$NDK_ROOT/sources/android/support/include"
export LDFLAGS="-L$PLATFORM_PREFIX/lib"
export PKG_CONFIG_PATH=$PLATFORM_PREFIX/lib/pkgconfig
export TARGET_HOST="arm-linux-androideabi"

./configure --host=$TARGET_HOST --prefix=$PLATFORM_PREFIX --disable-shared --enable-static --disable-xml
make clean
make -j2
make install

# armeabi-v7a
export CPPFLAGS="-I$PLATFORM_PREFIX/include -I$NDK_ROOT/sources/android/support/include -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3"
./configure --host=$TARGET_HOST --prefix=$PLATFORM_PREFIX --disable-shared --enable-static --disable-xml
make clean
make -j2
make install

# mips
export PLATFORM_PREFIX=$WORKSPACE/mips-toolchain
export PATH=$OLD_PATH
export PATH=$PLATFORM_PREFIX/bin:$PATH
export CPPFLAGS="-I$PLATFORM_PREFIX/include -I$NDK_ROOT/sources/android/support/include"
export LDFLAGS="-L$PLATFORM_PREFIX/lib"
export PKG_CONFIG_PATH=$PLATFORM_PREFIX/lib/pkgconfig
export TARGET_HOST="mipsel-linux-android"

./configure --host=$TARGET_HOST --prefix=$PLATFORM_PREFIX --disable-shared --enable-static --disable-xml
make clean
make -j2
make install
