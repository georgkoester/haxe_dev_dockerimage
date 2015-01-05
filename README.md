# Docker image for smoke testing [haxe](http://haxe.org) contributions

Simply:
 * have a haxe repo clone on your linux box or create one with ```git clone https://github.com/HaxeFoundation/haxe.git haxe_repo```
 * run ```docker build -t my_haxe_repo_dev_image .```
 * start image with ```docker run -ti -v /path/to/your/haxe_repo:/haxe/haxe_repo my_haxe_repo_dev_image /bin/bash```
 * do in image: cd haxe; bash smoke_test.sh

Enjoy!
Georg

## License

MIT, see LICENSE file.


