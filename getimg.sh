#!/bin/bash
INPUT2=$2
INPUT3=$3
HUB=${INPUT2:-10.10.34.36:5001}

#查询images
function select_img() {
IMG=$(curl -s $HUB/v2/_catalog |jq .repositories |awk -F'"' '{for(i=1;i<=NF;i+=2)$i=""}{print $0}')
[[ $IMG = "" ]] && { echo -e "\033[31m$HUB 没有docker镜像\033[0m";exit; }
#echo "$HUB Docker镜像："
for n in $IMG;
  do
  TAG=$(curl -s http://$HUB/v2/$n/tags/list |jq .tags |awk -F'"' '{for(i=1;i<=NF;i+=2)$i=""}{print $0}')
    for t in $TAG;
    do
      echo "$n:$t";
    done
done
}

select_img
