#!/bin/bash

set -e

# 
# This script re-merges simulator and device static libraries.
# 


rm -rf final-headers
cd bullet-2.82-r2722
cd src
cp -R ./ ../../final-headers
cd ..
cd ..
cd final-headers
find . -name ".svn" -print0 | xargs -0 -I {} rm -rf "{}"		#	Needs deferring because `find` wants to navigate into deleted directory.
find . -name "*.cpp" -exec rm -rf "{}" \;
find . -name "*.c" -exec rm -rf "{}" \;
find . -name "*.txt" -exec rm -rf "{}" \;
find . -name "Makefile*" -exec rm -rf "{}" \;
find . -name "Doxy*" -exec rm -rf "{}" \;
find . -name "CMake*" -exec rm -rf "{}" \;
find . -name "*.lua" -exec rm -rf "{}" \;
find . -name ".svn"
cd ..

rm -rf final-libs
mkdir -p final-libs/ios/Debug
mkdir -p final-libs/ios/Release
mkdir -p final-libs/osx/Debug
mkdir -p final-libs/osx/Release
DST_DIR=`pwd`/final-libs

cd bullet-2.82-r2722
cd lib

function merge_ios_libs()
{
	LIB_NAME=$1

	cp osx/macosx10.9/Debug/lib$LIB_NAME.a $DST_DIR/osx/Debug/lib$LIB_NAME.a
	cp osx/macosx10.9/Release/lib$LIB_NAME.a $DST_DIR/osx/Release/lib$LIB_NAME.a

	lipo ios/iphonesimulator7.0/Debug/lib$LIB_NAME.a ios/iphoneos7.0/Debug/lib$LIB_NAME.a -create -output $DST_DIR/ios/Debug/lib$LIB_NAME.a
	lipo ios/iphonesimulator7.0/Release/lib$LIB_NAME.a ios/iphoneos7.0/Release/lib$LIB_NAME.a -create -output $DST_DIR/ios/Release/lib$LIB_NAME.a
}

merge_ios_libs BulletCollision
merge_ios_libs BulletDynamics
merge_ios_libs BulletFileLoader
merge_ios_libs BulletSoftBody
merge_ios_libs BulletWorldImporter
merge_ios_libs BulletXmlWorldImporter
merge_ios_libs ConvexDecomposition
merge_ios_libs HACD
merge_ios_libs LinearMath

cd $DST_DIR
find . -name *.a -exec lipo -i {} \;