#!/bin/bash

#PBS -l nodes=3:ppn=10,walltime=5:00:00
#PBS -N jobname
#PBS -M hl1283@nyu.edu
#PBS -m abe
#PBS -e localhost:$PBS_O_WORKDIR/${PBS_JOBNAME}.e${PBS_JOBID}
#PBS -o localhost:$PBS_O_WORKDIR/${PBS_JOBNAME}.o${PBS_JOBID}

cd Bigdata/

./run_batch.sh &
./run_mini.sh &
./run_stoc.sh &

exit 0;