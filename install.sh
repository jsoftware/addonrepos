#!/bin/sh
#
# make addons subdirectory and install all addons

cd `dirname "$(realpath $0)"`

# protocol
# P=https|git
# use git instead of https if you have write access to the repos

# url = git@github.com:jsoftware/arc_zip.git
# url = https://github.com/jsoftware/jsource.git

set -e

P=git
# P=https

mkdir addons
cd addons
git init .

f() {
 n=`sed "s/|.*//" <<< "$1"`
 if [ "$P" = "git" ] ; then
  p=`sed "s/github:/github.com:/" <<<"$n"`
  d=`sed "s/_/\//" <<<"${n##*/}"`
  git submodule add $P@$p $d
 else
  p=`sed "s/github:/github.com\//" <<<"$n"`
  d=`sed "s/_/\//" <<<"${n##*/}"`
  git submodule add $P://$p $d
 fi

}

cat ../repos.txt | while read p; do
 f $p
done
