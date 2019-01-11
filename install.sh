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

pushd $HOME

mkdir -p $bakdir

# mv .bashrc $bakdir/
mv .vimrc     $bakdir/
mv .tmux.conf $bakdir/

ln -s $ROOT/.vimrc     .vimrc
ln -s $ROOT/.tmux.conf .tmux.conf

popd


