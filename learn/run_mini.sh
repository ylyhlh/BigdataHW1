#!/bin/sh

#  begin.sh
#  
#
#  Created by liu hao on 13-3-17.
#

for opt in sgd bfgs lbfgs
do
for batchSize in 1 2 4 8 16 64 96 100 200
do
./run.sh $opt minibatch $batchSize
done
done
