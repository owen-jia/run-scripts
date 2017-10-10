#!/bin/bash
# start|stop|status|help options

# path params
RUN_FILE="pas-data-show.jar"
OPTION="help"
BASE_PATH=$(cd `dirname $0`; pwd)
PARAMS="base_dir="$BASE_PATH" temp_dir=/dev/null"

# switch file fold
cd $BASE_PATH

# find executable *.jar file
temp_run_file=$(ls -l ./|awk '/.jar$/ {print $NF}')
if [ $? == 0 -a -n $temp_run_file ]; then
	RUN_FILE=$temp_run_file
else
	echo "$BASE_PATH has not such *.jar"
fi

# read option, eg.. start|stop|status|help
if [ -n $1 ]; then
	OPTION=$1
else
	echo "options is invalid,eg.. start|stop|status|help"
fi
exec ./process.sh "$RUN_FILE" "$OPTION" "$PARAMS"
