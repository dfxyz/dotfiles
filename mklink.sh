#!/usr/bin/bash

[[ -n $MSYSTEM ]] && export MSYS=winsymlinks:nativestrict

function mklink() {
    rm -rf $HOME/$1
    ln -s $PWD/$1 $HOME
}

cd $(dirname $0)
for file in $(echo .*); do
    case $file in
        .|..|.git|.gitignore|.gitmodules)
            continue
            ;;
        .bashrc)
            [[ -n $(command -v bash) ]] && mklink $file
            ;;
        .zshrc)
            [[ -n $(command -v zsh) ]] && mklink $file
            ;;
        .ideavimrc|.wslconfig)
            [[ $OS = Windows_NT ]] && mklink $file
            ;;
        *)
            mklink $file
            ;;
    esac
done
