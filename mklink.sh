cd $(dirname $0)
for file in $(echo .*); do
    case $file in
        .|..|.git|.gitignore)
            continue
            ;;
        *)
            rm -rf $HOME/$file
            ln -s $PWD/$file $HOME
            ;;
    esac
done
