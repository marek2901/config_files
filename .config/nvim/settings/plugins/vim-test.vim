nnoremap <silent> <Leader>rb :TestFile<CR>
nnoremap <silent> <Leader>rf :TestNearest<CR>
nnoremap <silent> <Leader>rl :TestLast<CR>

if exists('$TMUX')
  let g:test#strategy = 'vimux'
else
  let test#strategy = "neovim"
endif
