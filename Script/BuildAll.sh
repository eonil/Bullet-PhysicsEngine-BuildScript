########		This script is designed to be run at the target direcotry.

if [ "$1" == "" ]
then
echo                    "You have to specify target build directory and helper directory."
echo
echo                    Usage:
echo
echo                            sh BuildAdd.sh ./../Build
echo
exit 1
fi









########		Determine absolute paths.

CURDIR=`pwd`

cd				"$CURDIR"
cd				`dirname $0`

SCRDIR=`pwd`

cd				"$CURDIR"
mkdir			-p "$1"
cd				"$1"

BLDDIR=`pwd`

TCFILE="$SCRDIR"/"Eonil's CMake Toolchain for iOS"
EXPFILE="$BLDDIR"/"Xcode export"
ENVFILE="$BLDDIR"/"Xcode env"
VARFILE="$BLDDIR"/"Xcode var"




########		Prepare materials.
echo			Current Directory = "$CURDIR"
echo			Script Directory = "$SCRDIR"
echo			Build Directory = "$BLDDIR"

cd				"$CURDIR"

rm				-rf "$BLDDIR"
mkdir			-p "$BLDDIR"
cd				"$BLDDIR"

#tar				-xvzf /Users/Eonil/Work/Github/BulletPhysics-BuildScript-iOS/Script/test-src.tar.gz ./Source
svn            	checkout http://bullet.googlecode.com/svn/trunk/ -r 2440 ./Source





########		Retrieve SDK & tools locations.
xcodebuild		-workspace "$SCRDIR"/Helper/Helper.xcworkspace -scheme Help EONIL_ENVFILE="$ENVFILE" EONIL_EXPFILE="$EXPFILE" EONIL_VARFILE="$VARFILE"




########		Perform actual build with retrieved environment variables.
declare			MAKESCR="$BLDDIR"/CMakeWithEnv.sh
rm				-f "$MAKESCR"
cp				"$VARFILE" "$MAKESCR"

echo			cd		\""$BLDDIR"\"/Source															>> "$MAKESCR"
echo			sh		\""$SCRDIR"\"/BuildWithCMake.sh \""$BLDDIR"\"/Source \""$TCFILE"\"				>> "$MAKESCR"

sh				"$MAKESCR"




########		Harvest results.
cd				"$BLDDIR"
rm				-rf "$BLDDIR"/Package
mkdir			"$BLDDIR"/Package
cd				"$BLDDIR"/Source/src
for FILE in `find . \( -name "*.a" -o -name "*.h" \)`
do
	cd			"$BLDDIR"/Source/src
	cd			`dirname "$FILE"`

	SRCFILE=`pwd`/`basename "$FILE"`

	cd			"$BLDDIR"/Package
	mkdir		-p `dirname "$FILE"`
	cd			`dirname "$FILE"`

	DESTFILE=`pwd`/`basename "$FILE"`

	cp "$SRCFILE" "$DESTFILE"
done



########		Finished.
exit			0






