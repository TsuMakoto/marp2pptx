#!/bin/bash

curl -O https://qiita.com/api/v2/items/$1
cat $1 | jq -r ".body" >> $1.md

cat $1 | jq -r ".title" >> slide.md
echo "" >> slide.md
echo "---" >> slide.md
echo "" >> slide.md

sed -i '/^$/d' $1.md
IFS=''
while read line
do
  if [ ${line:0:1} = "#" ]; then
    echo "" >> slide.md
    echo "---" >> slide.md
    echo "" >> slide.md
    echo $line >> slide.md
    echo "" >> slide.md
  else
    echo $line >> slide.md
  fi
done < $1.md

marp slide.md -o publish/index.html
