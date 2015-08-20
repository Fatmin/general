#!/bin/bash

echo "Enter User and Hostname. Example:User@Server :"
read servername 
ssh-copy-id -i ~/.ssh/id_rsa.pub $servername


