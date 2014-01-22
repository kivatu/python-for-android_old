#!/bin/bash

VERSION_kivy=
URL_kivy=
DEPS_kivy=(pygame android)
MD5_kivy=
BUILD_kivy=$BUILD_PATH/kivy/kivy
RECIPE_kivy=$RECIPES_PATH/kivy

function prebuild_kivy() {
	cd $BUILD_PATH/kivy

	if [ ! -d kivy ]; then
		try git clone git@github.com:kivatu/kivy_old.git kivy
	fi

	try cp kivy/kivy/lib/klaatu/libklaatu_window.so ../libs
}

function build_kivy() {
	if [ -d "$BUILD_PATH/python-install/lib/python2.7/site-packages/kivy" ]; then
		return
	fi

	cd $BUILD_kivy

	push_arm

	export LDFLAGS="$LDFLAGS -L$LIBS_PATH"
	export LDSHARED="$LIBLINK"

	# fake try to be able to cythonize generated files
	$BUILD_PATH/python-install/bin/python.host setup.py build_ext
	try find . -iname '*.pyx' -exec cython {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py build_ext -v
	try find build/lib.* -name "*.o" -exec $STRIP {} \;
	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2

	try rm -rf $BUILD_PATH/python-install/lib/python*/site-packages/kivy/tools

	unset LDSHARED
	pop_arm
}

function postbuild_kivy() {
	try cp $RECIPE_kivy/envsetup.sh $BUILD_PATH/python-install
	try cp $RECIPE_kivy/getconf $BUILD_PATH/python-install/bin
}
