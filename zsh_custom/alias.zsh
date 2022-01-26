###########################################
#   QOL
###########################################
alias c="clear"
alias desk="cd ~/desktop"
alias l="ls -a"
alias vim="nvim"
alias jp="jupyter notebook"
alias cpwd="pwd | pbcopy"
alias f=". ranger"
alias ff='~;ranger --cmd fzf_select --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'


alias m="run_generic"
alias mc='gcc main.c -o ./auto && ./auto && rm ./auto'

export PATH=$PATH:~/.bin:/usr/local/smlnj/bin
alias sml='rlwrap /usr/local/smlnj/bin/sml $@'

function exporter {
    pandoc -s $1 -c /Users/huxmarv/.config/note_conf/export_confs/csstemplate.css --template /Users/huxmarv/.config/note_conf/export_confs/template.html -o out.html --mathjax
}
alias epandoc="exporter"

function swaputil {
    tmp=`mktemp`
    mv $1 $tmp
    mv $2 $1
    mv $tmp $2
}
alias swap="swaputil"
#alias fd="__zoxide_z"
eval "$(zoxide init zsh)"
defaults write -g ApplePressAndHoldEnabled -bool false

###########################################
#    git
###########################################
alias gpl='git pull'
function gpext {
    nohup git push "$@" > /dev/null &
}
alias gp='gpext'
alias grsh='git remote show'
function gutil {
    gpl
    tmux split-window -h -p 16 -d cmatrix
    git add ${1:-"."} && git commit -v --allow-empty
    gp
    tmux select-pane -R
    tmux kill-pane
}
alias gg='gutil'
alias GG='gutil -A'
alias grsh='git remote show'

###########################################
#    python 
###########################################
alias py='python3'
alias p='python3'
alias pip='python3 -m pip'
alias pym='python3 -m'

function chpwd () {    # auto called by zsh
#    cur="$(pwd)"

#    # pyvenv stuff
#    if command -v deactivate; then deactivate; fi
#    while [[ -n $cur && $cur != "/" ]]; do   # search upwards https://unix.stackexchange.com/a/35265
#        [[ -f "$cur/pyvenv.cfg" ]] && source "$cur/bin/activate" && break
#        [[ -f "$cur/.venv/pyvenv.cfg" ]] && source "$cur/.venv/bin/activate" && break

#        # Note: if you want to ignore symlinks, use "$(realpath -s "$path"/..)"
#        cur="$(readlink -f "$cur"/..)"
#    done
}

function toggleOPP {
    #tmpp=`mktemp`
    #mv "/Users/huxmarv/.config/alacritty/alacritty.yml" $tmpp
    #mv "/Users/huxmarv/.config/alacritty/alacritty_temp.yml" "/Users/huxmarv/.config/alacritty/alacritty.yml" 
    #mv $tmpp "/Users/huxmarv/.config/alacritty/alacritty_temp.yml"
    ##echo '' >> ~/.config/alacritty/alacritty.yml
    ##nvim "/Users/huxmarv/.config/alacritty/alacritty.yml" 

    tmpp=`mktemp`
    mv "/Users/huxmarv/.config/alacritty/alacritty.yml" $tmpp
    mv "/Users/huxmarv/.config/alacritty/alacritty_temp.yml" "/Users/huxmarv/.config/alacritty/alacritty.yml" 
    mv $tmpp "/Users/huxmarv/.config/alacritty/alacritty_temp.yml"
    touch ~/.config/alacritty/alacritty.yml

}


alias opt="toggleOPP"


run_generic () {
    files="$(ls 2>/dev/null)"
    if echo $files | ag '^start\.z?sh$' > /dev/null
    then
        source start.*sh
    elif echo $files | ag '^[Mm]akefile$' > /dev/null
    then
        make -j
    elif echo $files | ag '^yarn\.lock$' > /dev/null
    then
        yarn && yarn run
    else
        TEMP_RUN_HEADER="$(date)\n$(printf "%*s\n" "${COLUMNS:-$(tput cols)}" '' | tr " " "#")"
        if echo $files | ag '^main.*\.cpp$' > /dev/null
        then
            clang++ -std=c++11 main*.cpp -o auto && echo $TEMP_RUN_HEADER && ./auto && setopt +o nomatch && cat *.out 2> /dev/null
        elif echo $files | ag '^main\.py$' > /dev/null
        then
            echo $TEMP_RUN_HEADER && python main.py
        elif echo $files | ag '^index\.js$' > /dev/null
        then
            if echo $files | ag '^package(-lock)?\.json$' > /dev/null
            then
                npm install
            fi
            echo $TEMP_RUN_HEADER && node index.js
        elif echo $files | ag '^main\.js$' > /dev/null
        then
            echo $TEMP_RUN_HEADER && node main.js
        fi
    fi
}



