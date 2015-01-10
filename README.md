# Docker image for smoke testing [haxe](http://haxe.org) contributions

Simply:
 * have a haxe repo clone on your linux box or create one with ```git clone https://github.com/HaxeFoundation/haxe.git haxe_repo```
 * run ```docker build -t my_haxe_repo_dev_image .```
 * start image with ```docker run -ti -v /path/to/your/haxe_repo:/haxe/haxe_repo my_haxe_repo_dev_image /bin/bash```
 * do in image: ```cd haxe; bash smoke_test.sh```
 * run selected targets: ```bash run_tests.sh php``` or ```bash run_tests.sh neko php cpp```
 * run all supported targets: ```bash run_tests.sh```

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


