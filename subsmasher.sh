#!/bin/bash

echo "what is the target domain?"
read domain
echo "what is the path to the subdomain wordlist"
read wordlist
hosts_up=()
echo "Type path for output host file"
read hostfile
echo "Runing Scan, Please Wait..."

ln=0
while read w; do
	
	printf "\r Currently testing line $ln of $(wc -l < $wordlist)"
	test_domain=$w.$domain
	if ping -c 1 $test_domain &> /dev/null
	then
		hosts_up+=($test_domain)
		echo $test_domain > hostfile
	fi
	((ln=ln+1))
done< $wordlist
echo "Currently running hosts on $domain:"
for host in "${hosts_up[@]}"
do
	echo $host
done
