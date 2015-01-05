#!/bin/bash

# You should make the haxe repo with your changes available to the docker image, with -v /your/repo:/haxe/haxe_repo . 
# But if you prefere to create a copy of the current haxe repo:
# git clone https://github.com/HaxeFoundation/haxe.git haxe_repo

(cd haxe_repo && git submodule init && git submodule update && cd ..) || exit 5

git clone https://github.com/HaxeFoundation/neko.git

