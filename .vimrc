set number
syntax on
colorscheme peachpuff

" basic googly tab/space settings
set sw=2 ts=2 ai et 
" show EOL and other characters
"set list

" insert a # at the beginning of current line
function! CommentOutCurrentLine()
  s/^\(\s*[^#]\S\{-}\)/#\1/
endfunction

nnoremap ,c :call CommentOutCurrentLine()<Cr>
