#!/bin/bash

curl -O https://qiita.com/api/v2/items/$1
cat $1 | jq -r ".body" >> $1.md

sed -i '/^$/d' $1.md
IFS=''
while read line
do
  if [ ${line:0:1} = "#" ]; then
    line="\n---\n${line}"
  fi
  echo $line >> slide.md
done < $1.md

marp slide.md
marp -s .

