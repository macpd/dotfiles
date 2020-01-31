" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle settings
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'
" misc vim functions from xolox. needed for vim-session
" Bundle 'https://github.com/xolox/vim-misc.git'
" Improved session management
" Bundle 'xolox/vim-session'
" plugin to comment all kinds of filetypes
Plugin 'scrooloose/nerdcommenter'
" Syntastic for syntax checking
Plugin 'scrooloose/syntastic'
" git vim integration
" Bundle 'tpope/vim-fugitive'
" supertab naive, but helpful tab completion
" Plugin 'ervandew/supertab'
" YouCompleteMe auto completion system
Plugin 'ycm-core/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

set number " Show line numbers
set relativenumber " show relative number lines
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set laststatus=2 "Always show status line

let mapleader=","
set expandtab
set shiftwidth=2
set tabstop=2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text setlocal textwidth=80
" Set all python and cpp files to 80 charactrs.
autocmd FileType python setlocal textwidth=80 sw=2 ts=2 ai et
autocmd FileType c setlocal textwidth=80 sw=2 ts=2 ai et
autocmd FileType cpp setlocal textwidth=80 sw=2 ts=2 ai et
autocmd FileType markdown setlocal textwidth=80 sw=4 ts=4 ai et
autocmd BufEnter,WinEnter * setlocal relativenumber
autocmd BufLeave,WinLeave * setlocal number
set colorcolumn=+1,+2,+3

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

augroup END

colorscheme peachpuff
set background=dark

" toggle relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction

" add/remove leading space when commenting/uncommenting lines
let g:NERDSpaceDelims=1

" auto save session
let g:session_autosave = 'yes'

" tell syntastic to always populate location list with
let g:syntastic_always_populate_loc_list=1

" python syntax checker
" let g:syntastic_python_checker=['pylint']

" copied from /usr/share/vim/vim73/vimrc_example.vim provided with arch vim package
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

" below are copied from Damian Conway's Instantly Better Vim 2013
" https://docs.google.com/file/d/0Bx3f0gFZh5Jqc0MtcUstV3BKdTQ/edit

"====[ Open any file with a pre-existing swapfile in readonly mode "]=========

    augroup NoSimultaneousEdits
        autocmd!
        autocmd SwapExists * let v:swapchoice = 'o'
        autocmd SwapExists * echomsg ErrorMsg
        autocmd SwapExists * echo 'Duplicate edit session (readonly)'
        autocmd SwapExists * echohl None
        autocmd SwapExists * sleep 2
    augroup END

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set list
