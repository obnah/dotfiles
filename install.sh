#!/bin/bash

#----------------------------------------------------------
# get ROOT directory(where current script placed) from within
SOURCE="${BASH_SOURCE[0]}"
# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]; do
    ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    # if $SOURCE was a relative symlink, we need to resolve
    # it relative to the path where the symlink file was located
    [[ $SOURCE != /* ]] && SOURCE="$ROOT/$SOURCE"
done
ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
#----------------------------------------------------------

bakdir=~/dotfiles-backup-$(date +"%Y-%m-%d")
mkdir -p $bakdir

backup() {
	local f=~/$1
	if [ -e $f ] ; then
		if readlink $f ; then
			rm $f
		else
			mv $f $bakdir/
		fi
	fi
}

install_file() {
	ln -s $ROOT/$1 ~/$1
}

files="
.vimrc
.tmux.conf
.aaron_bashrc
"


for f in $files; do
	backup $f
	install_file $f
done

grep '.aaron_bashrc' ~/.bashrc >/dev/null || \
echo "source .aaron_bashrc" >> ~/.bashrc

rmdir $bakdir 2>/dev/null

