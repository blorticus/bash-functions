shopt -s nullglob

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

sourceable_directory="$HOME/.bash_sourceable"

if [[ ! -d "$sourceable_directory" ]]; then
    mkdir --mode 0700 "$sourceable_directory"
fi

for c in oc kubectl; do
    if [[ ! -f $sourceable_directory/$c ]]; then
        if [[ $(which "$c" 2>/dev/null) != "" ]]; then
            "$c" completion bash > "$sourceable_directory/${c}-completions"
        fi
    fi
done

for s in $sourceable_directory/*; do
    source "$s"
done

if [[ $(declare -F pathprepend) ]]; then
    pathprepend "$HOME/.local/bin" "$HOME/local/bin" "$HOME/bin" "$HOME/local/go/bin"
fi
