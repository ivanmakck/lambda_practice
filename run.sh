#!/bin/bash

# Set variables
export SCRIPT_FOLDER=$PWD
export LOG_FOLDER=$SCRIPT_FOLDER/log
export PYTHON_SCRIPT=$(cat config.toml | grep pyscript | cut -d "=" -f 2 | tr -d '"')
export LOG_FILE=${PYTHON_SCRIPT}_$(date +"%m%d%Y%H%M%S").log

cd $SCRIPT_FOLDER

# Set logs
exec > >(tee $LOG_FOLDER/$LOG_FILE) 2>&1

# Run script
source sandbox/bin/activate

python3 $PYTHON_SCRIPT

RC=$?

if [ $RC != 0 ]
then
    echo "PYTHON RUN FAILED"
    echo "[ERROR] RETURN CODE $RC"
    echo "[ERROR] REFER TO LOG"
    exit 1
fi

echo "PYTHON RUN SUCCEEDED"

deactivate

exit 0