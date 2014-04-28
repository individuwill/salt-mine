" Many settings discovered and copied from
" http://amix.dk/vim/vimrc.html
set nocompatible
filetype off

" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()
" Bundle 'gmarik/vundle'
" Bundle 'Shutnik/jshint2.vim'
" Bundle 'scrooloose/syntastic'
" Bundle 'scrooloose/nerdtree'
" Bundle 'vim-scripts/taglist.vim'
" Bundle 'Glench/Vim-Jinja2-Syntax'
"Bundle 'Valloric/YouCompleteMe'
"Bundle 'tpope/vim-surround'
"Bundle 'tristen/vim-sparkup'

colorscheme desert "colorscheme elflord
set background=dark
set t_Co=256

set encoding=utf8
set ffs=unix,dos,mac
set autoread " detect when file changed externally

filetype plugin indent on
syntax on " syntax highlighting
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"set lines=50 columns=120
set cursorline
" following 2 lines will highlight text after a certain length
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/ "apply above highlight to column 120+
" set colorcolumn=80 " highlight right margin/gutter at column
set ruler " show current position
set scrolloff=7 " show # lines above/below cursor when scrolling
set number
set title

set incsearch
set hlsearch " highlight search results, use :nohlsearch to turn off
let loaded_matchparen = 1 " disable highlighting matching parens
set matchtime=2 " blink 2 tenths of a second when showing matching brackets
set showmatch " shaow matching brackets when indicator is over them
" change paren match colors if enabled
hi MatchParen cterm=none ctermbg=green ctermfg=blue 
" configure backspace to act like normal text editor
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set wildmenu
" Don't let wild show auto complete for the following files
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set cmdheight=2 " height of command bar at bottom of screen
set laststatus=2 " always show status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ At:\ %l,\%c

set mouse=a
set clipboard=unnamed
""""""""""""""""""""""""""""""
" Commands & Mappings
""""""""""""""""""""""""""""""
command Clearsearch let @/ = ""
command Thtml set ft=html | execute "%!tidy -q -i --show-errors 0 --doctype omit"
"command Tc %!astyle --style=java --pad-oper --add-brackets --break-blocks
command Tc %!uncrustify -q -l C -c ~/.uncrustify/mystyle.cfg
command Tcpp %!uncrustify -q -l CPP -c ~/.uncrustify/mystyle.cfg
command Tjava %!uncrustify -q -l JAVA -c ~/.uncrustify/mystyle.cfg
" remap a double "j" to escape from insert mode
" imap jj <Esc>
" Remap leader "\" to a comma
let mapleader = ","
map <leader>ss :setlocal spell!<cr>
map <leader>cs :Clearsearch<cr>
map <leader>nt :NERDTreeToggle<cr>

" Making moving between windows easier
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <F2> :NERDTreeToggle<CR>
map <F3> :TlistToggle<CR>

""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction
