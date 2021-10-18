function! CleanPackages()
  call map(dein#check_clean(), "delete(v:val, 'rf')")
endfunction

function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*:node_modules/*'
  endif
endfunction

command! -nargs=* SmartFuzzy :call SmartFuzzy()
