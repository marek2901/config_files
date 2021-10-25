if !isdirectory("~/.config/nvim/vendor")
  call system("mkdir -p ~/.config/nvim/vendor")
endif

call system("~/.config/nvim/vendor/nvim-py3/bin/python3 -c 'import pynvim'")
if v:shell_error
  call system("python3 -m venv ~/.config/nvim/vendor/nvim-py3")
  call system("~/.config/nvim/vendor/nvim-py3/bin/python3 -m pip install --upgrade pynvim")
endif

let g:python3_host_prog = "~/.config/nvim/vendor/nvim-py3/bin/python3"
