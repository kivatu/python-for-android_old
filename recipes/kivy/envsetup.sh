#!/system/bin/sh

# We need both a TEMP and a TMPDIR set.
export TMPDIR=/data/kivy/tmp
mkdir -p $TMPDIR

export LANG=en
EXTERNAL_STORAGE=/data/kivy
export PYTHONPATH=/system/lib:/system/lib/python2.7:/system/lib/python2.7/site-packages
export TEMP=/data/kivy/tmp
export PYTHON_EGG_CACHE=$TEMP
export PYTHONHOME=/system
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/system/lib/python2.7:/system/lib/python2.7/lib-dynload:/system/lib/python2.7/site-packages
export ANDROID_ARGUMENT=1
export ANDROID_PRIVATE=/system/lib/python-private 
export ANDROID_APP_PATH=/data/app
export KIVY_WINDOW=egl_klaatu
#ANDROID_PRIVATE should point to libpymodules.so (due to custom-loader.patch)

# these are the old values. I overrode them for us since maguro has no sdcard and as root, 
# we can use /data for this.
#export EXTERNAL_STORAGE=/mnt/sdcard
#export TEMP=/mnt/storage/com.googlecode.pythonforandroid/extras/python/tmp
#export PYTHON_EGG_CACHE=$TEMP



