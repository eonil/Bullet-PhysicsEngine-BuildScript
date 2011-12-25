# BULLET PHYSICS BUILD SCRIPT for iOS
-----
Hoon Hwangbo
2011.12.24




This script builds **Bullet** physics engine as static library for *iOS* platform fat binaries.
The binary contains `ARMv6/ARMv7` for device and `x86` for simulator.

This script uses 2.79 (r2440) of Bullet source.










## USAGE

Open *Terminal*, and type these command.

	git clone git@github.com:Eonil/Bullet-PhysicsEngine-BuildScript-iOS.git
	cd "Bullet-PhysicsEngine-BuildScript-iOS"
	sh ./Script/BuildAll.sh ./Build

This will create a new directory `Build` and make binaries in the `Build/Package` directory.









## DEPENDENCIES

This script requires these stuffs.

- Internet connection.
- Mac OS X or iOS SDK.
- CMake. I recommend instaling it with Homebrew. (`brew install cmake`)

