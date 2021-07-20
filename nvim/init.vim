" QUICK CONFIG
let g:airline_theme='cobalt2'



set nocompatible
exe 'set rtp+=' . $VIMCONFIG

call plug#begin('~/.config/nvim/plugged')

" Editing
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-surround'
imap <C-f> <Plug>(fzf-complete-line)
nmap <C-f> :Lines<return>

" Non-buffer overwrite keybinds
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>D "_D
nnoremap <leader>c "_c
vnoremap <leader>c "_c
nnoremap <leader>C "_C
vnoremap <leader>C "_C
nnoremap <leader>x "_x
vnoremap <leader>x "_x
nnoremap <leader>X "_X
vnoremap <leader>X "_X

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


"Decent 
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'wadackel/vim-dogrun'
"Favorite so far:
Plug 'shapeoflambda/dark-purple.vim' " rec
Plug 'arzg/vim-colors-xcode'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'ayu-theme/ayu-vim'

"   HUD
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'rickhowe/diffchar.vim'
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '▏'
let g:indentLine_conceallevel = 1
let g:indentLine_concealcursor = 'nv'
"   tmux integration
Plug 'christoomey/vim-tmux-navigator'

"- HUD Toggles
Plug 'preservim/nerdtree'
let g:rainbow_active=1 "set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
\	'guifgs': ['magenta', 'cyan', 'orange', 'green', 'yellow'],
\}

let g:gitgutter_highlight_linenrs = 1 " auto highlight change line numbers
let g:gitgutter_preview_win_floating = 0 " Disable floating/popup window for <Leader>hp

" Rendering
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'chrisbra/Colorizer'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
"Plug 'szymonmaszke/vimpyter'

call plug#end()


" Jupyter Notebook

"autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
"autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
"autocmd Filetype ipynb nmap <silent><Leader>l :VimpyterStartNteract<CR>

" My Customs
" " CUSTOM: change backup dir https://stackoverflow.com/a/1625850/10372825
"set backupdir=$VIMCONFIG/autogentmp//
"set directory=$VIMCONFIG/autogentmp//
"set undodir=$VIMCONFIG/autogentmp//,~/.vim/autogentmp/undo//
set nobackup
set nowritebackup

" jump to previous position https://stackoverflow.com/questions/774560/in-vim-how-do-i-get-a-file-to-open-at-the-same-line-number-i-closed-it-at-last
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif

" from https://www.linode.com/docs/tools-reference/tools/introduction-to-vim-customization/
set ttyfast " speed up scrolling
set scrolloff=5 " display 8 lines above and below cursor at all times
set matchpairs+=<:>

" autoread (https://vi.stackexchange.com/a/13092)
set autoread
au FocusGained,BufEnter * :checktime

" passive and HUD
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
set number " line numbers
set ruler " display current cursor "coordinates"
set showmatch " highlight the matching bracket

set nu rnu " reletive line nums
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" show invisibles
set encoding=utf-8
"set listchars=eol:⏎,tab:j·,trail:·,extends:>,precedes:<
set nolist

" colors
" fix neovim's weird highlight (https://github.com/neovim/neovim/issues/9019#issuecomment-521532103)
function! s:CustomizeColors()
	if has('guirunning') || has('termguicolors')
		let cursorline_gui=''
		let cursorline_cterm='ctermfg=white'
	else
		let cursorline_gui='guifg=white'
		let cursorline_cterm=''
	endif
	exec 'hi CursorLine ' . cursorline_gui . ' ' . cursorline_cterm
endfunction
augroup OnColorScheme
	autocmd!
	autocmd ColorScheme,BufEnter,BufWinEnter * call s:CustomizeColors()
augroup END

" force vim to use true colors (https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
colo dark_purple

" allow opacity to work in alacritt
hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
command OP call SetOpa()
command FI colo dark_purple

function! SetOpa()
    hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
    hi! Normal ctermbg=NONE guibg=NONE 
endfunction

"set search stuff
set hlsearch
set incsearch
set ignorecase
set smartcase
" remove search highlight on escape
" nnoremap <esc> :noh<return><esc>

" tab sizing
set shiftwidth=4
set si " smart indent

" stop physical line wrapping
" https://stackoverflow.com/questions/2280030/how-to-stop-line-breaking-in-vim
set textwidth=0
set wrapmargin=0

" code folding: https://codeyarns.com/2014/09/02/how-to-fold-code-in-vim/
set foldmethod=manual
set foldlevelstart=5
set nofoldenable
"   persistent folds (https://til.hashrocket.com/posts/17c44eda91-persistent-folds-between-vim-sessions)
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" cursor stuff
set mouse=a

" background and performance
set lazyredraw " don't redraw when executing macros
set updatetime=100

" Delete trailing white space on save, useful for some filetypes ;)
" Stolen from https://github.com/nickmahd/.vim/blob/master/vimrc in Jan 2020
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.cpp :call CleanExtraSpaces()
endif


" custom keymaps
let mapleader = " "
set timeoutlen=500

nnoremap q: <Nop>

" nerd commenter
nmap <Leader>t <Plug>NERDCommenterToggle
xmap <Leader>t <Plug>NERDCommenterToggle

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"map cn to NERDTreeToggle
nnoremap <Leader>n :NERDTreeToggle<CR>
xnoremap <Leader>n :NERDTreeToggle<CR>

" git gutter jump to next hunk
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap ghn <Plug>(GitGutterNextHunk)
nmap <Leader>hN <Plug>(GitGutterPrevHunk)
nmap ghN <Plug>(GitGutterPrevHunk)
nmap <Leader>HN <Plug>(GitGutterPrevHunk)

" git gutter stage/revert hunk because the default seems to be broken...
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hr <Plug>(GitGutterRevertHunk)

"no escape key (escape pressing escape)
inoremap jc <Esc>
inoremap jf <Esc>:w<return>
inoremap <C-c> <Esc>:w<return>
command W w

" print working file
command PWF echo @%

" source config
command S source ~/.config/nvim/init.vim

" find diff
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Colors! 
command COLH ColorHighlight
command COLC ColorClear


" Note mode
function! s:Note()
    setlocal spell
    setlocal syntax=markdown
    inoremap jf <Esc>
    ZenMode
endfunction
com! Note call s:Note()


" clipboard https://coderwall.com/p/v-st8w/vim-copy-to-system-clipboard-on-a-mac
xmap <Leader>y :w !pbcopy<CR><CR>
nmap <Leader>y :w !pbcopy<CR><CR>
nmap <Leader>yy :%w !pbcopy<CR><CR>

" split direction
set splitbelow
set splitright

set cmdheight=2
set signcolumn=yes
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"   Completion window
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"   Coc Snippets
imap <C-o> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = 'jn'
let g:coc_snippet_prev = 'jh'

"   Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" coc jump to error/warning
nmap gn <Plug>(coc-diagnostic-next)
nmap gN <Plug>(coc-diagnostic-prev)
nmap ge <Plug>(coc-diagnostic-next-error)
nmap gE <Plug>(coc-diagnostic-prev-error)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>rf <Plug>(coc-refactor)

" Formatting selected code.
xmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)
"visual line keybind
nmap <Leader>v V
" better fold keybinds
nmap <Leader>f za
vnoremap <Leader>z zf
"insert newline withough going into insert mode
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j
"better bracket jumping
nmap <C-_> %
vmap <C-_> %
"line moving commands
"nnoremap <A-j> :m .+1<CR>==
"nnoremap <A-k> :m .-2<CR>==
"inoremap <A-j> <Esc>:m .+1<CR>==gi
"inoremap <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <A-j> :m '>+1<CR>gv=gv
"vnoremap <A-k> :m '<-2<CR>gv=gv

noh


