#!/bin/bash

cd neko || (echo "Neko repo not found, build with build_neko.sh" && exit 1)
make
make install
cd ..

cd haxe_repo || (echo "Repo not found: Run with docker run -v /your/haxe/repo/gitclone:/haxe/haxe_repo" && exit 1)
make
make tools
make install
cd tests # HAVE TO go into tests before using haxelib! Else weird errors...
mkdir -p ~/haxelib && haxelib setup ~/haxelib
haxelib git hx-yaml https://github.com/mikestead/hx-yaml master src
haxe -version
haxe -neko RunCi.n -main RunCi -lib hx-yaml
cd ..

echo "Rebuilt neko and haxe, run test with 'run_tests.sh neko' or 'run_tests.sh' to run for each of js neko php java cpp"


