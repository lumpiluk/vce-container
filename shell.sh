#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# We need some writable directory for the OMNeT++ IDE to store its error.log file:
OMNETPP_IDE_LOG=$HOME/omnetpp/log
mkdir -p $OMNETPP_IDE_LOG

apptainer shell --bind $OMNETPP_IDE_LOG:/log $SCRIPT_DIR/vce-container.sif
