#!/bin/bash




#VARS
PORT=24346

for SERVER in `cat dev.list`
do
echo $SERVER
nc -z -w5 $SERVER $PORT 
        if  [ $? -ne 0 ]; then echo "Connection to $SERVER on $PORT failed"
        fi
done


