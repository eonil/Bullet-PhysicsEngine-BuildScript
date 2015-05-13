BulletPhysics Automatic Build Script
====================================
2014/02/11
Hoon H.


Run this command.

	bash fetch-and-build-bullet.bash; bash post-processing.bash

This script automatically builds Bullet Physics engine v2.82 r2722
for OS X and iOS (both of simulator and device) platforms.

Trunk version chosen for ARM64 support.

Original script included in Bullet project does work, but the result
isn't that much good for actual iOS development due to lack of simulator
support. This script will also produce binary for simulator.

Premake script completely re-written to support this behavior. This script
will overwrite the default Premake script, and supports only OS X and iOS
build. Xcode settings tailored a little to minimize caveats.

There was a small issue with unit-test code, and I included hotfix for it.
If the author confirms the issue as a bug, I would (maybe...) update this.



License
-------
Licensed under "MIT License".




Update
------
This script is designed for outdated version of Bullet library, and reported not to work for latest version of Bullet source. If you're looking for a way to build the latest source, [here's a QA](http://www.bulletphysics.org/Bullet/phpBB3/viewtopic.php?t=10555&p=35461) for it. 
