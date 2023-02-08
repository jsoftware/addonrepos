#!/bin/bash
#
# make addons subdirectory and install all addons

cd `dirname "$(realpath $0)"`

# protocol
# P=https|git
# use git instead of https if you have write access to the repos

P=git

mkdir addons
cd addons
git init .

f() {
 n=`sed "s/|.*//" <<< "$1"`
 p=`sed "s/github:/github.com\//" <<<"$n"`
 d=`sed "s/_/\//" <<<"${n##*/}"`
 git submodule add $P://$p $d
}

cat ../repos.txt | while read p; do
 f $p
done
