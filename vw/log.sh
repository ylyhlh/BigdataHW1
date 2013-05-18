#!/bin/bash

#  log.sh
#  
#
#  Created by liu hao
#

./preproc.sh 1 1 0.1 
./preproc.sh 1 2 0.1
./preproc.sh 1 3 0.1
./preproc.sh 1 4 0.1
./preproc.sh 1 5 0.1
./preproc.sh 2 1 0.1
./preproc.sh 3 1 0.1
./preproc.sh 4 1 0.1
./preproc.sh 5 1 0.1 
./repreproc.sh

./run1.sh 1

./run2.sh 1


./run1.sh 0

./run2.sh 0




