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
function swaputil {
    tmp=`mktemp`
    mv $1 $tmp
    mv $2 $1
    mv $tmp $2
}
alias swap="swaputil"
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






