--add the 0 so the solution comes first in the directory (when sorted on name)
--print "uncomment this hello premake4 world for debugging the script"

-- newoption 
-- {
-- 	trigger     =	"ios",
-- 	description =	"Enable iOS target (requires xcode4)",
-- }
newoption 
{
	trigger     =	"apple-sdk",
	value		=	"NAME",
	allowed		=	
	{
		{"ios",	"iOS Universal binary."},
		{"osx",	"OS X Universal binary. (default)"},
	},
	description =	"Select Apple SDK (requires xcode4)",
}

-- newoption 
-- {
-- 	trigger     = "with-double-precision",
-- 	description = "Enable double precision build",
-- }

-- if _OPTIONS["with-double-precision"] then
-- 	defines {"BT_USE_DOUBLE_PRECISION"}
-- end

local apple_sdk_name	=	_OPTIONS["apple-sdk"]
if apple_sdk_name == nil then
	apple_sdk_name = ""
end





solution 		"BulletPhysics"
configurations 	{"Release", "Debug"}
platforms 		{"Universal"}
flags			{"NoRTTI"}

targetdir		"../bin"
language 		"C++"
location		("./xcode4-" .. apple_sdk_name)



configuration	"Release"
flags { "Optimize", "EnableSSE", "StaticRuntime", "NoMinimalRebuild", "FloatFast"}
xcodebuildsettings
{
	'GCC_OPTIMIZATION_LEVEL = "fast"',
}
configuration	"Debug"
flags { "Symbols", "StaticRuntime" , "NoMinimalRebuild", "NoEditAndContinue" ,"FloatFast"}

configuration	{}


















xcodebuildsettings
{
	'ONLY_ACTIVE_ARCH = "NO"',
}



if apple_sdk_name == "osx" then
	xcodebuildsettings
	{
		'ARCHS = "$(ARCHS_STANDARD_32_64_BIT)"',
		'CLANG_CXX_LANGUAGE_STANDARD = "gnu++0x"',
		'SDKROOT = "macosx"',				
		'MACOSX_DEPLOYMENT_TARGET = "10.4"',
	}
else
	xcodebuildsettings
	{
		'INFOPLIST_FILE = "../../Test/Info.plist"',
		'ARCHS = "$(ARCHS_STANDARD_INCLUDING_64_BIT)"',
		'TARGETED_DEVICE_FAMILY = "1,2"',
		'SDKROOT = "iphoneos"',
		'IPHONEOS_DEPLOYMENT_TARGET = "4.3"',
		-- 'CODE_SIGN_IDENTITY = "iPhone Developer"',
	}
end







function defineOneRegularComponentProject(name)
	project (name)
		
	kind		"StaticLib"
	targetdir	("../lib/" .. apple_sdk_name .. "/$SDKROOT/$CONFIGURATION")
	includedirs 
	{
		"../src",
	}
	files 
	{
		"../src/" .. name .. "/**.cpp",
		"../src/" .. name .. "/**.h",
	}
end

function defineOneExtraComponentProject(name,includeDirectories)
	project (name)
		
	kind		"StaticLib"
	targetdir	("../lib/" .. apple_sdk_name .. "/$SDKROOT/$CONFIGURATION")
	includedirs (includeDirectories)
	files 
	{
		"../Extras/" .. name .. "/**.cpp",
		"../Extras/" .. name .. "/**.h",
	}
end

function defineOneExtraSerializeComponentProject(name,includeDirectories)
	project (name)
		
	kind		"StaticLib"
	targetdir	("../lib/" .. apple_sdk_name .. "/$SDKROOT/$CONFIGURATION")
	includedirs (includeDirectories)
	files 
	{
		"../Extras/Serialize/" .. name .. "/**.cpp",
		"../Extras/Serialize/" .. name .. "/**.h",
	}
end

defineOneRegularComponentProject("LinearMath")
defineOneRegularComponentProject("BulletCollision")
defineOneRegularComponentProject("BulletDynamics")
defineOneRegularComponentProject("BulletSoftBody")

defineOneExtraComponentProject("HACD", {"../Extras/HACD"})
defineOneExtraComponentProject("ConvexDecomposition", {"../Extras/ConvexDecomposition", "../src"})

defineOneExtraSerializeComponentProject("BulletFileLoader", {"../src"})
defineOneExtraSerializeComponentProject("BulletWorldImporter", {"../Extras/Serialize/BulletFileLoader", "../src"})
defineOneExtraSerializeComponentProject("BulletXmlWorldImporter", {"../Extras/Serialize/BulletWorldImporter", "../Extras/Serialize/BulletFileLoader", "../src"})

-- -- include "../Demos/HelloWorld"
-- -- include "../Demos/Benchmarks"

-- -- if apple_sdk_name == "osx" then
-- -- 	include "../Demos"
-- -- end



project "AppUnitTest"

if apple_sdk_name == "ios" then
	kind "WindowedApp"
else	
	kind "ConsoleApp"
end
targetdir ("../bin/" .. apple_sdk_name .. "/$SDKROOT/$CONFIGURATION")

includedirs {"../src","Source", "Source/Tests"}
links 
{
	"BulletDynamics","BulletCollision", "LinearMath"
}
language "C++"
files {
	"../Test/Source/**.cpp",
	"../Test/Source/**.h",
}





