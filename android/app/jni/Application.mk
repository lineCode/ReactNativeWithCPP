# Android makefile for helloworld shared lib, jni wrapper around libhelloworld C API

APP_ABI := all
APP_OPTIM := release
# Min version supported by ReactNative
APP_PLATFORM := android-16
# GCC 4.9 Toolchain
NDK_TOOLCHAIN_VERSION = 4.9
# GNU libc++ is the only Android STL which supports C++11 features
APP_STL := gnustl_static
APP_BUILD_SCRIPT := jni/Android.mk
# Module Created by Gyp
APP_MODULES := librncpp_jni
