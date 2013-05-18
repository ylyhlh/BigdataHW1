#!/bin/sh

w0=1
for w1 in {1..5}
do
name=_${w0}_${w1}
echo $name
cat train${name}.dat | sed -e "s/^0/-1/" > Train${name}
cat test${name}.dat | sed -e "s/^0/-1/" > Test${name}
done

w1=1
for w0 in {2..5}
do
name=_${w0}_${w1}
echo $name
cat train${name}.dat | sed -e "s/^0/-1/" > Train${name}
cat test${name}.dat | sed -e "s/^0/-1/" > Test${name}
done