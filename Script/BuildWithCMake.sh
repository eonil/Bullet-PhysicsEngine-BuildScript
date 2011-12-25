



########		Build with CMake in current directory.
SRCDIR="$1"
TCFILE="$2"





########		Check arguments.
if [ ! -d "$SRCDIR" ]
then
echo			Cannot locate source dir = "$SRCDIR"
exit			1
fi

if [ ! -f "$TCFILE" ]
then
echo			Cannot locate toolchain file = "$TCFILE"
exit			2
fi




########		Perform.
env
export			-p
declare			-x	CC=`xcrun -sdk iphoneos -find clang`
declare			-x	CXX=`xcrun -sdk iphoneos -find clang++`
declare			-x	LD=`xcrun -sdk iphoneos -find ld`
declare			-x	CFLAGS="-arch armv6 -arch armv7 -isysroot $SDK_DIR -miphoneos-version-min=4.0"
declare			-x	CXXFLAGS=$CFLAGS
declare			-x	LDFLAGS=$CFLAGS

cmake			"$SRCDIR" -DCMAKE_TOOLCHAIN_FILE="$TCFILE" -G "Unix Makefiles"
make