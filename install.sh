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
 p=`sed "s/github:/github.com\//" <<<"$1"`
 d=`sed "s/_/\//" <<<"${1##*/}"`
 git submodule add $P://$p $d
}

cat ../repos.txt | while read p; do
 f $p
done
