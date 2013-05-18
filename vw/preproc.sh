#!/bin/bash

rm test.dat train.dat

IFS="
"

if [ $# == 3 ]; then
    w0=$(echo " $1 ")
	echo "weight for 0 is " $w0
    w1=$(echo " $2 ")
    echo "weight for 1 is " $w1
    p=$3
    echo "p = " $p
elif [ $# == 1 ]; then
    w0=' '
    w1=' '
    p=$1
    echo "p = " $p
else
    w0=' '
    w1=' '
    p=0.1
    echo "p = " $p
fi

sep=$(python -c "print int(32767 * $p)")

for d in `seq 0 120`;
    do
    echo $d
	cat url_svmlight/Day$d.svm|

sed -e "s/^-1/0$w0|f/" |sed -e "s/^+1/1$w1|f/" |sed -e 's/$/ const:.01/' |

while read line
do 
    if [ $RANDOM -lt $sep ]
    then
	echo $line >> test_$1_$2.dat
#   echo "test"
    else
	echo $line >> train_$1_$2.dat
#   echo "train"
    fi
done

done
