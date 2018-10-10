#!/bin/bash

addr=(
"88.125.66.77"
"88.172.8.114"
"82.242.172.190"
"78.224.190.70"
"81.56.168.243"
"82.66.161.132"
"86.241.220.15"
"5.135.179.191"
"37.187.140.222"
"193.70.32.180"
"147.135.223.50"
"37.187.226.141"
"37.59.25.150"
"54.37.87.103"
"217.182.193.172"
"37.110.197."{3,5,6,18,19,20,21,22,23,24}
)

content="$(printf -- "--add-rich-rule='rule family=\"ipv4\" source address=\"%s\" accept' " "${addr[@]}")"
zone="public"
permanent=""

firewall-cmd --zone="$zone" --add-service=http --add-service=https --add-service=ftp --add-service=ssh
eval firewall-cmd --zone="$zone" $content
