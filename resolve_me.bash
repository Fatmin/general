#!/bin/bash

for ip in `cat ip.list`
do
resolveip -s $ip | grep -v resolv
done


