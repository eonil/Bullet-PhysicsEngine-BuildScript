#	This script designed to be executed at current directory.
#	You have to run this script at the directory where you want to perform on.

rm	-rf ./Build
mkdir	./Build/
cd	Build

svn	checkout http://bullet.googlecode.com/svn/trunk/ -r 2440 ./Source

