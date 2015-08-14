#!/bin/bash


#VARS
DOMAIN=".com"
#DOMAIN=".com"

#/opt/pbis/bin/get-dc-list $DOMAIN --site Atlanta|grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > /tmp/site-dcs.txt
/opt/pbis/bin/get-dc-list $DOMAIN |grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" > /tmp/site-dcs.txt
#while read in; do echo $in;
#nc -zu "$in" 53;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/53 FAILED"'!';fi;
#nc -z "$in" 53;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/53 FAILED"'!';fi;
#nc -zu "$in" 88;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/88 FAILED"'!';fi;
#nc -z "$in" 88;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/88 FAILED"'!';fi;
#nc -zu "$in" 123;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/123 FAILED"'!';fi;
#nc -zu "$in" 389;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/389 FAILED"'!';fi;
#nc -z "$in" 389;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/389 FAILED"'!';fi;
#nc -z "$in" 445;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/445 FAILED"'!';fi;
#nc -zu "$in" 464;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/464 FAILED"'!';fi;
#nc -z "$in" 464;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/464 FAILED"'!';fi;
#nc -zu "$in" 3268;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/3268 FAILED"'!';fi;
#nc -z "$in" 3268;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/3268 FAILED"'!';fi;
#done < /tmp/site-dcs.txt



while read in; do echo $in;
nc -u "$in" 53;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/53 FAILED"'!';fi;
#nc -z "$in" 53;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/53 FAILED"'!';fi;
nc -u "$in" 88;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/88 FAILED"'!';fi;
nc  "$in" 88;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/88 FAILED"'!';fi;
nc -u "$in" 123;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/123 FAILED"'!';fi;
nc -u "$in" 389;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/389 FAILED"'!';fi;
nc  "$in" 389;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/389 FAILED"'!';fi;
nc  "$in" 445;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/445 FAILED"'!';fi;
nc -u "$in" 464;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/464 FAILED"'!';fi;
nc  "$in" 464;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/464 FAILED"'!';fi;
#nc -zu "$in" 3268;if [ $? -ne 0 ]; then echo "Connection to $in port UDP/3268 FAILED"'!';fi;
nc  "$in" 3268;if [ $? -ne 0 ]; then echo "Connection to $in port TCP/3268 FAILED"'!';fi;
done < /tmp/site-dcs.txt

