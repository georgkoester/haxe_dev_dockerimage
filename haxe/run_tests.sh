#!/bin/bash

TO_TEST="neko js php java cpp";
if [ -z ${1+x} ]; then
  #run all
  echo "no argument given, running all";
else
  TO_TEST="$1";
fi

RESULTS="";
EXIT_STATUS=0;

echo "running $TO_TEST";
cd haxe_repo/tests
for i in $TO_TEST; do
  export TEST=$i;
  if [ "$i" = "php" ]; then
    /etc/init.d/mysql start;
  fi
  neko RunCi.n;
  THIS_RUN_STATUS=$?;
  if [ $THIS_RUN_STATUS != 0 ]; then
    EXIT_STATUS=1;
  fi
  RESULTS="$RESULTS \n$TEST exit status: $?";
done

echo -e "\n\n Results: $RESULTS";

exit $EXIT_STATUS;

