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
