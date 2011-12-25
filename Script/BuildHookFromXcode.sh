echo		================================
echo		"Build hook in Xcode start."
echo		--------------------------------

export		-p > "$EONIL_EXPFILE"
env			> "$EONIL_ENVFILE"

rm			-f "$EONIL_VARFILE"
touch		"$EONIL_VARFILE"
echo		declare -x PLATFORM_NAME="$PLATFORM_NAME"	>> "$EONIL_VARFILE"
echo		declare -x PLATFORM_DIR="$PLATFORM_DIR"		>> "$EONIL_VARFILE"
echo		declare -x SDK_DIR="$SDK_DIR"				>> "$EONIL_VARFILE"
echo		declare -x SDK_NAME="$SDK_NAME"				>> "$EONIL_VARFILE"

echo		--------------------------------
echo		"Build hook in Xocde finish."
echo		================================
