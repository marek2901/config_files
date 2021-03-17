call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'tpope/vim-commentary'
  Plug 'joshdick/onedark.vim'
  Plug 'ervandew/supertab'
  Plug 'dense-analysis/ale'
  Plug 'preservim/vimux'

  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
call plug#end()

let g:fzf_preview_window = []

let g:ale_linters = {
      \   'ruby': ['standardrb', 'rubocop'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['eslint'],
      \}

let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \}
let g:ale_fix_on_save = 1

set history=700

set nocompatible

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" I do sometimes use backspace :(
set backspace=indent,eol,start

" Show line numbers
set number relativenumber

"Always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch

" Show whitespaces
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»

syntax on
colorscheme onedark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab


augroup auto_tabs
  au BufEnter *
        \ set shiftwidth=2 |
        \ set tabstop=2 |
  au BufEnter *.py
        \ set tabstop=4 |
        \ set shiftwidth=4 |
  au BufEnter *.go
        \ set expandtab!
  au BufEnter *.java
        \ set expandtab!
augroup END

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}


" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Case insensitive :wq :WQ
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" :find command autocomlete and recursion
set path+=**
set wildmenu

" Never need 'Ex mode'
nnoremap Q <NOP>

set hlsearch

nnoremap <leader>ff :GFiles<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

" Run the current file with rspec
" augroup run_tests_wrapper
"   au!
"   au BufNewFile,BufRead,BufEnter,WinEnter,TabEnter *
"         \ nnoremap <Leader>rb :echo "Implement tests for current file extension"<CR>
"   au BufNewFile,BufRead,BufEnter,WinEnter,TabEnter *spec.rb
"         \ nnoremap <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%") . ":" .  line("."))<CR>
" augroup END
augroup run_tests_wrapper
  au!
  au BufEnter *
        \ nnoremap <Leader>rb :echo "Implement tests for current file extension"<CR>
  au BufEnter *spec.rb
        \ nnoremap <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%") . ":" .  line("."))<CR>
augroup END

" Prompt for a command to run
nnoremap <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
nnoremap <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
nnoremap <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
nnoremap <Leader>vz :call VimuxZoomRunner()<CR>

" Clear the terminal screen of the runner pane.
nnoremap <Leader>v<C-l> :VimuxClearTerminalScreen<CR>
