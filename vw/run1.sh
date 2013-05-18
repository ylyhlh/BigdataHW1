#!/bin/bash

#  run.sh
#  
#
#  Created by liu hao
#

#./preproc.sh 1 1 0.1 &
#./preproc.sh 1 2 0.1 &
#./preproc.sh 1 3 0.1 &
#./preproc.sh 1 4 0.1 &
#./preproc.sh 1 5 0.1 &
#./preproc.sh 2 1 0.1 &
#./preproc.sh 3 1 0.1 &
#./preproc.sh 4 1 0.1 &
#./preproc.sh 5 1 0.1 &
error_weight=$1

w0=1
for w1 in {1..5}
do
name=_${w0}_${w1}
rm log${name}
echo ${loss}
for loss in quantile squared
do
echo ${loss} >> log${name}

echo $name
echo train${name}.dat
vw -d train${name}.dat --adaptive --loss_function $loss -c -f predictor${name}.vw >log
vw -d test${name}.dat -t -i predictor${name}.vw -p predictions${name}.txt
python postproc.py ${w0} ${w1} predictions${name}.txt test${name}.dat $error_weight >> log${name}
done
done

w1=1
for w0 in {2..5}
do
name=_${w0}_${w1}
rm log${name}
for loss in quantile squared
do
echo ${loss} >> log${name}

echo $name
echo train${name}.dat
vw -d train${name}.dat --adaptive --loss_function $loss -c -f predictor${name}.vw >log
vw -d test${name}.dat -t -i predictor${name}.vw -p predictions${name}.txt
    python postproc.py ${w0} ${w1} predictions${name}.txt test$name.dat $error_weight >> log${name}
done
done




