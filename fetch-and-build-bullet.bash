#/bin/bash

set -e

rm -rf ./bullet-2.82-r2722
svn checkout http://bullet.googlecode.com/svn/trunk@r2722 bullet-2.82-r2722
cd bullet-2.82-r2722
patch src/vectormath/sse/vec_aos.h ../hotfix.patch

cd build
cp -f ../../premake4.lua ./
rm -rf ./xcode4-osx
rm -rf ./xcode4-ios

./premake4_osx clean
./premake4_osx --apple-sdk=osx xcode4
./premake4_osx --apple-sdk=ios xcode4

####

function makeOneComponent()
{
	PROJ_NAME=$1
	SDK_NAME=$2

	xcodebuild -project $PROJ_NAME.xcodeproj -configuration "Release" -sdk $SDK_NAME 
	xcodebuild -project $PROJ_NAME.xcodeproj -configuration "Debug" -sdk $SDK_NAME 
}

function makeAllProjects()
{
	SDK_NAME=$1

	find . -name "*.xcodeproj" -exec xcodebuild -project {} -configuration "Release" -sdk $SDK_NAME \;
	find . -name "*.xcodeproj" -exec xcodebuild -project {} -configuration "Debug" -sdk $SDK_NAME \;
}

cd xcode4-osx
makeAllProjects macosx 
cd ..

cd xcode4-ios
makeAllProjects iphonesimulator
makeAllProjects iphoneos 
cd ..

find ../bin/osx -name AppUnitTest -exec {} \;
find ../lib -name *.a -exec lipo -info {} \;








