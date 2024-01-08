shopt -s nullglob

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

sourceable_directory="$HOME/.bash_sourceable"

if [[ ! -d "$sourceable_directory" ]]; then
    mkdir --mode 0700 "$sourceable_directory"
fi

for kapia in oc kubectl; do
    if [[ ! -f $sourceable_directory/$kapia ]]; then
        if [[ $(which $kapia 2>/dev/null) != "" ]]; then
            $($kapia completion bash) > "$sourceable_directory/${kapia}-completions"
        fi
    fi
done

for s in $sourceable_directory/*; do
    source "$s"
done

pathprepend "$HOME/bin" "$HOME/local/bin" "$HOME/local/go/bin"
