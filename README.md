# [Docker](https://www.docker.com/) image for smoke testing [haxe](http://haxe.org) contributions

Simply:
 * have a haxe repo clone on your linux box or create one with ```git clone https://github.com/HaxeFoundation/haxe.git haxe_repo``` (you might have done this already)
 * install docker and clone this repo: ```git clone https://github.com/georgkoester/haxe_dev_dockerimage.git```
 * ```cd haxe_dev_dockerimage``` and run ```docker build -t my_haxe_repo_dev_image .```
 * start image with ```docker run -ti -v /path/to/your/haxe_repo:/haxe/haxe_repo my_haxe_repo_dev_image /bin/bash```
 * do in image: ```cd haxe; bash smoke_test.sh```
 * run selected targets: ```bash run_tests.sh php``` or ```bash run_tests.sh neko php cpp```
 * run all supported targets: ```bash run_tests.sh```

Typical output:

```
root@your_machine # docker run -ti -v /mnt/hgfs/haxe_repo:/haxe/haxe_repo haxe_repo_dev /bin/bash
root@87f07126d202:/# cd haxe/
root@87f07126d202:/haxe# ./smoke_test.sh 
Submodule path 'extra/haxelib_src': checked out '5c5e885c0edd2fd3d5773cb98af337ce17057233'
Cloning into 'neko'...
```

[...]
Builds neko and haxe from source...
Runs neko tests

```
Class: io.TestFileInput .........

OK 14 tests, 0 failed, 14 success
Command exited with 0 in 0s: neko [sys.n,foo,12,a b  %PATH% $HOME c\&<>["]#{}|%$]


 Results:  
neko exit status: 0
root@87f07126d202:/haxe#
```

This simply runs all runnable targets and summarizes results at the end:

```
root@87f07126d202:/haxe# ./run_tests.sh 
no argument given, running all
running neko js php java cpp cs
Going to test: [neko]
Now test neko
Changing directory to /haxe/haxe_repo/tests/unit/
Command: haxe [compile-neko.hxml]
Command exited with 0 in 4s: haxe [compile-neko.hxml]
Command: neko [bin/unit.n]
Test.hx:244: Generated at: 2015-01-10 18:10:33
Test.hx:246: START
```

[...] many messages left out...

```
src/unit/issues/Issue3639.hx:21: characters 12-15 : Warning : Type Int is being cast to the unrelated type unit.issues._Issue3639.MyClass.T
Command exited with 0 in 17s: haxe [compile-cs-unsafe.hxml]
Command: mono [/haxe/haxe_repo/tests/unit/bin/cs_unsafe/bin/Test-Debug.exe]
Test.hx:244: Generated at: 2015-01-10 18:25:35
Test.hx:246: START
Test.hx:187: DONE [5778 tests]
Test.hx:353: SUCCESS: true
Command exited with 0 in 1s: mono [/haxe/haxe_repo/tests/unit/bin/cs_unsafe/bin/Test-Debug.exe]


 Results:  
neko exit status: 0 
js exit status: 0 
php exit status: 1 
java exit status: 0 
cpp exit status: 0 
cs exit status: 0
root@87f07126d202:/haxe#
```

Oh, seems your code broke the php target's tests! 

Next steps: Check logs, ```./build.sh``` and run php tests again: ```./run_tests.sh php```

Enjoy!

Georg

### Supported test targets out of the box
 * neko
 * cpp (C++)
 * php
 * java
 * js (Javascript)
 * cs (C#)

### Limitations
 * flash9 target unsupported (not investigated yet)
 * Runs on linux - windows and macosx platforms not tested (travis and appveyor do this if you create a pull request to the haxe repo)

### Optional
 * Speed up creation of initial docker image by commenting unrequired targets in the ```Dockerfile```. They are enclosed in ```optionalN``` comments.
But choose wisely: If you really want to save space you get the inverse effect if you later run the tests in the docker container, because then the
packages get installed again in each new container.
## License

MIT, see LICENSE file.


