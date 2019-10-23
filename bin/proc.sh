#!/bin/bash
# start|stop|status|help options
# @author jiawj 2016-12-14
# www.meix.com All rights reserved.

# path params
RUN_FILE=$1
RUN_OPTIONS="-Xms128m -Xmx256m -Xss256k"
RUN_PARAMS=$3
OPTION=$2
PID_FILE="run.pid"
RUN_LOG="run.log"
PID=0;
BASE_PATH=$4

# file path
cd $BASE_PATH

# to check options, and format options
if [ -z $OPTION -o -z $RUN_FILE ]; then
	echo "---- Parameters are invalid. eg. ./tool.sh start|stop|status|help ----"
	exit 0
else
	# check Run_file name,eg.. *.jar
	FILE_SUFFIX=${RUN_FILE##*.}
	if [ $? != 0 -o $FILE_SUFFIX != "jar" ]; then
		echo "$RUN_FILE is not executable jarfile..."
		exit 0
	fi
	FILE_NAME=${RUN_FILE%.jar}
fi

message(){
	echo ""
	echo "---- BASE_PATH:   "$BASE_PATH
	echo "---- RUN_FILE:    "$RUN_FILE
	echo "---- FILE_NAME:   "$FILE_NAME
	echo "---- FILE_SUFFIX: "$FILE_SUFFIX
	echo "---- RUN_OPTIONS: "$RUN_OPTIONS
	echo "---- RUN_PARAMS:  "$RUN_PARAMS
	echo "---- OPTION:      "$OPTION
	echo "---- PID:         "$PID
	echo "---- PID_FILE:    "$PID_FILE
	echo "---- RUN_LOG:     "$RUN_LOG
	echo ""
}

# start fun
start(){
	check_running
	if [ $? == 0 ]; then
		echo "---- $RUN_FILE is running,pid:$PID. ----"
	else
		echo ""
		echo "---- OPTIONS: java $RUN_OPTIONS -jar $RUN_FILE $RUN_PARAMS > $BASE_PATH/$RUN_LOG ----"
		echo ""
		nohup java -server $RUN_OPTIONS -jar $RUN_FILE $RUN_PARAMS > ./$RUN_LOG 2>&1 &
		if [ $? != 0 ]; then
			echo "---- Start $RUN_FILE is failure. ----"
		else
			PID=$!
			check_running
			if [ $? == 0 ]; then
				rm -rf $PID_FILE
			fi
			if [ $PID -gt 0 ]; then
				echo $PID > $PID_FILE
				echo "---- Start $RUN_FILE is success,pid:$PID. ----"
				message
				exit 0
			else
				echo "---- Start $RUN_FILE is failure. ----"
			fi
		fi
	fi
}

# check process running,0=ture,-1=false
check_running(){
	if [ -f $PID_FILE ]; then
		while read pid
		do
			if [ $pid -gt 0 ]; then
				PID=$pid
				return 0
			else
				return 1;
			fi
		done < ./$PID_FILE
	else
		return 1;
	fi
}

# stop fun
stop(){
	check_running
	if [ $? == 0 ]; then
		kill -9 $PID
		rm -rf $PID_FILE
		if [ $? == 0 ]; then
			echo "---- Stop $RUN_FILE:$PID is success."
			exit 0
		else
			echo "---- Stop $RUN_FILE:$PID is failure."
			exit 1
		fi
	else
		echo "---- Stop $RUN_FILE failure,because it is not running."
		exit 1
	fi
}

# status fun
status(){
	check_running
	if [ $? == 0 ]; then
		echo "---- $RUN_FILE is running, pid:$PID."
	else
		echo "---- $RUN_FILE is not running."
	fi
}

# help fun
help(){
	echo ""
	echo "---- eg.. ./$RUN_FILE start|stop|status|help "
	echo ""
}

# switch options
case $OPTION in
	'stop') 
		stop
	;;
	'start')
		start
	;;
	'status')
		status
	;;
	'help')
		help
	;;
	*)
		echo "---- Parameters is invalid."
		echo "---------------------------------------------"
		help
	;;
esac
