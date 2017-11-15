set nocompatible              " be iMproved, required
filetype off                  " required
autocmd BufWritePre *.py :%s/\s\+$//e

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'https://github.com/shmargum/vim-sass-colors.git'
" Max's colorful CSS plugin
Plugin 'https://github.com/tomtom/tcomment_vim.git'
"tComment"

Plugin 'junegunn/fzf'
" http://vimawesome.com/plugin/fzf

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"--- General Setting:  
set nocompatible        " This must be the first or the changes you are
                        " expecting may not be the changes that occur
set title               " Show filename and path
set backspace=2         " Allow backspace in insert mode
set nu                  " Line number
set showmatch           " Matches {} [] ()
set paste
set showmode            " Display current mode on the last line
set ignorecase
set smartcase
set ruler               " Show cursor position
set statusline=%<%f%h%m%r\ (%n)%=%b\ 0x%B\ \ %l,%c%V\ %P
set laststatus=2
"set mousehide            " Hides the mouse pointer when typing
set undolevels=1000        " # of commands that stored for undo
set foldmethod=marker
" ---

" --- Coding convention
syntax on               " Automatically detect syntax
filetype on
"set textwidth=79       " Wrap line at 79 characters
"syntax enable            
"set background=dark
" ---
 
" --- My personal settings:
set noswapfile            " No intermidiate files are used when saving
au BufReadPost *.get,*.post set syntax=perl
au BufReadPost *.tt set syntax=html
au BufRead,BufNewFile *.tt set filetype=tt
au! Syntax tt source ~/.tt2html.vim
hi link htmlLink NONE
" ---
 
" --- Indenting
set shiftwidth=2         " 4 spaces insteads of tab
set expandtab            " turn tabs into spaces
set softtabstop=2        " Makes backspace has a tab-like feeling
set formatoptions=tcrq   " Autoindent (also auto indent comments /* */)
set smartindent          " Auto indient for {} block
" ---
 
nmap <F7> :g#\({\n\)\@<=#.,/}/sort<CR>
let mapleader=','
map <leader>c <c-_><c-_>
