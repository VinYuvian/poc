#!/bin/bash
server="$2"
type="$1"
if [ $type == "[masters]" ];then
	sed -i "/^\[masters\]/a $server" inventory
elif [ $type == "[workers]" ];then
	sed -i "/^\[workers\]/a $server" inventory
fi
