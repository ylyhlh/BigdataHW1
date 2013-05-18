#!/bin/sh

#  begin.sh
#  
#
#  Created by liu hao on 13-3-17.
#

for opt in sgd bfgs lbfgs
do
./run.sh $opt stochastic 1 &
done
