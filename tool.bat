@echo off

:: ---- config ----
set FILE_NAME=pas-data-show.jar

echo help

:: ---- jar -jar xxxx.jar ----
java -jar %FILE_NAME% > run.log 2>&1

echo %FILE_NAME% is running...
pause 
