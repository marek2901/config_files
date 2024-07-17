function! ToggleAndSaveBackground()
  let l:bgfile = expand('~/.vim_background')

  " Check if the background file exists and is readable
  if filereadable(l:bgfile)
    let l:saved_bg = readfile(l:bgfile)[0]

    " Call LoadSavedBackground if the saved value is different from the current value
    if l:saved_bg != &background
      call LoadSavedBackground()
    else
      if &background == "dark"
        set background=light
      else
        set background=dark
      endif
    endif
  else
    " Toggle the background if the file does not exist or is not readable
    if &background == "dark"
      set background=light
    else
      set background=dark
    endif
  endif
  highlight Normal guibg=NONE ctermbg=NONE

  " Save the new background value to the file
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

let g:gruvbox_transparent_bg = 1
autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE
highlight Normal guibg=NONE ctermbg=NONE
