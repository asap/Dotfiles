set nocompatible              " be iMproved, required
autocmd BufWritePre *.py :%s/\s\+$//e

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub

Plug 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)

Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.

" Prettier
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Max's colorful CSS plugin
Plug 'https://github.com/shmargum/vim-sass-colors.git'

"tComment"
Plug 'https://github.com/tomtom/tcomment_vim.git'

" http://vimawesome.com/plugin/fzf
Plug 'junegunn/fzf'

" https://medium.com/@hpux/vim-and-eslint-16fa08cc580f"
" Plug 'vim-syntastic/syntastic'

" https://github.com/MaxMEllon/vim-jsx-pretty
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Asynchronous Lint Engine 
Plug 'https://github.com/w0rp/ale.git'

" NerdTree"
Plug 'https://github.com/scrooloose/nerdtree.git'

" https://github.com/sheerun/vim-polyglot
Plug 'sheerun/vim-polyglot'

call plug#end()

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

" " --- LINT -- "
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exe = 'eslint'
" " --- END LINT -- "
"
" --- ALE --- "
let g:ale_sign_column_always=1
let g:ale_fix_on_save=1

" let g:ale_linters = {‘javascript’: [‘eslint’]}
" let g:ale_fixers = {‘javascript’: [‘eslint’]}
" --- END ALE --- "

" --- PRETTIER --- "
let g:prettier#config#bracket_spacing = 'true'

if exists('g:loaded_prettier')
 let g:prettier#autoformat = 0
 autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql Prettier
endif

" --- END PRETTIER --- "

set laststatus=2
"set mousehide            " Hides the mouse pointer when typing
set undolevels=1000        " # of commands that stored for undo
set foldmethod=marker
" ---

" -- COLORS --- "
colorscheme koehler
" -- END COLORS --- "

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
nnoremap <leader>sv :vertical split<cr>
nnoremap <leader>sh :split<cr>
nnoremap <silent> <leader>w= :wincmd =<CR>
nnoremap <silent> <M-k> :wincmd k<CR>
nnoremap <silent> <M-j> :wincmd j<CR>
nnoremap <silent> <M-h> :wincmd h<CR>
nnoremap <silent> <M-l> :wincmd l<CR>

if has("mac") && has("gui")
 set macmeta "Uses the Alt key as the Meta Key
endif

