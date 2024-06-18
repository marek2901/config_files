"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Do not pretend to be vi compatible
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

" Highlight search results as you type
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" Show whitespaces
set list
set listchars=tab:→\ ,nbsp:␣,trail:•,precedes:«,extends:»

syntax enable

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

set shiftwidth=2
set tabstop=2

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set shiftwidth=4 |

au BufNewFile,BufRead *.go
    \ set expandtab!

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
set laststatus=2

" Format the status line
set statusline=%r%{resolve(expand('%:p'))}%h\ \ \ Line:\ %l

function! InsertTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
      else
        return "\<c-n>"
      endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
function! InsertShiftTabWrapper()
      let col = col('.') - 1
      if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
      else
        return "\<c-p>"
      endif
endfunction
inoremap <s-tab> <c-r>=InsertShiftTabWrapper()<cr>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" Case insensitive :wq :WQ
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" :find command autocomlete and recursion
set path+=**
set wildmenu

" Never need 'Ex mode'
nnoremap Q <NOP>

" Copy to tmux buffer.
vnoremap <leader>ty y<cr>:call system("tmux load-buffer -", @0)<cr>gv
nnoremap <leader>tp :let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;

""""
" THEME
""""
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "neutral_uncommon_colors"

" Normal text
hi Normal ctermfg=222 ctermbg=NONE

" Comments
hi Comment ctermfg=244

" Constants
hi Constant ctermfg=172

" Strings
hi String ctermfg=65

" Keywords
hi Keyword ctermfg=162

" Functions
hi Function ctermfg=173

" Variables
hi Identifier ctermfg=117

" Type definitions
hi Type ctermfg=109

" Preprocessor directives
hi PreProc ctermfg=81

" Special characters
hi Special ctermfg=112

" Underlined text
hi Underlined ctermfg=46

" Error messages
hi Error ctermfg=231 ctermbg=160

" Warnings
hi WarningMsg ctermfg=231 ctermbg=124

" Search highlighting
hi Search ctermfg=16 ctermbg=220
hi IncSearch ctermfg=16 ctermbg=142

" Line numbers
hi LineNr ctermfg=245

" Cursor line
hi CursorLineNr ctermfg=184

" Status line
hi StatusLine ctermfg=16 ctermbg=228
hi StatusLineNC ctermfg=16 ctermbg=250

" Visual mode
hi Visual ctermbg=238

" Diff text
hi DiffAdd ctermfg=NONE ctermbg=22
hi DiffChange ctermfg=NONE ctermbg=58
hi DiffDelete ctermfg=NONE ctermbg=52
hi DiffText ctermfg=NONE ctermbg=94

"""
" END THEME
"""


" include machine specific vimrc
try
  source ~/.vimrc.local
catch
  " No file, no problem :D!
endtry
