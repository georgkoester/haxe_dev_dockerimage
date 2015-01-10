#!/bin/bash

TO_TEST="neko js php java cpp cs";
if [ -z ${1+x} ]; then
  #run all
  echo "no argument given, running all";
else
  TO_TEST="$@";
fi

RESULTS="";
EXIT_STATUS=0;

echo "running $TO_TEST";
cd haxe_repo/tests
for i in $TO_TEST; do # no quotes around to_test here - only single words allowed
  export TEST=$i;
  if [ "$i" = "php" ]; then
    /etc/init.d/mysql start;
  fi
  neko RunCi.n;
  THIS_RUN_STATUS=$?;
  if [ $THIS_RUN_STATUS != 0 ]; then
    EXIT_STATUS=1;
  fi
  RESULTS="$RESULTS \n$TEST exit status: $THIS_RUN_STATUS";
done

echo -e "\n\n Results: $RESULTS";

exit $EXIT_STATUS;

