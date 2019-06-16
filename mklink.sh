#!bash

[[ -n $MSYSTEM ]] && export MSYS=winsymlinks:nativestrict

function mklink() {
    rm -rf $HOME/$1
    ln -s $PWD/$1 $HOME
}

cd $(dirname $0)
for file in $(echo .*); do
    case $file in
        .|..|.git|.gitignore)
            continue
            ;;
        .bashrc)
            [[ -n $(command -v bash) ]] && mklink $file
            ;;
        .zshrc)
            [[ -n $(command -v zsh) ]] && mklink $file
            ;;
        .ideavimrc)
            [[ -n $(ls ~/.Idea* 2>/dev/null) ]] && mklink $file
            ;;
        .mintty)
            [[ -n $(command -v mintty) ]] && mklink $file
            ;;
        *)
            mklink $file
            ;;
    esac
done
