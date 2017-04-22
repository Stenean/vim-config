for i in "isort.cfg" "eslintrc"  "jshintrc" "tmux.conf" "vimrc" "Xresources" "bashrc" "ctags" "inputrc" "zshrc"; do
    if [ ! -f "$HOME/.$i" ]; then
	ln -s "$HOME/.vim/$i" "$HOME/.$i"
    fi
done
