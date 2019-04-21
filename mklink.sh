#!bash

cd $(dirname $0)
for file in $(ls -A | grep "^\."); do
    case $file in
        .git|.gitignore)
            continue
            ;;
        *)
            rm -rf $HOME/$file
            ln -s $PWD/$file $HOME
            ;;
    esac
done
