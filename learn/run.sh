#!/bin/sh

#  run.sh
#  
#
#  Created by liu hao
#
for lambda in 0.005 0.05 0.5 1 2 
do
for lrate in 0.0001 0.001 0.01 0.1 1
do
for epoches in 20 30
do
for loss in mse quant hinge logis
do
    torch main.lua $lambda $lrate $1 $loss $2 $epoches $3
done
done
done
done
