function! ToggleAndSaveBackground()
  if &background == "dark"
    set background=light
  else
    set background=dark
  endif
  let l:bgfile = expand('~/.vim_background')
  call writefile([&background], l:bgfile)
endfunction

nnoremap <leader>tb :call ToggleAndSaveBackground()<CR>

function! LoadSavedBackground()
  let l:bgfile = expand('~/.vim_background')
  if filereadable(l:bgfile)
    let l:saved_bg = readfile(l:bgfile)[0]
    if l:saved_bg == 'light' || l:saved_bg == 'dark'
      execute 'set background=' . l:saved_bg
    endif
  endif
endfunction

autocmd BufEnter * call LoadSavedBackground()
