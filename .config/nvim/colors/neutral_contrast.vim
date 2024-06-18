" Neovim color file
" Filename: neutral_contrast.vim
" Author: Your Name
" Description: A colorscheme using uncommon colors with good contrast for both light and dark backgrounds

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "neutral_contrast"

" Normal text
hi Normal ctermfg=68 ctermbg=NONE guibg=NONE

" Comments
hi Comment ctermfg=102 ctermbg=NONE guibg=NONE

" Constants
hi Constant ctermfg=108 ctermbg=NONE guibg=NONE

" Strings
hi String ctermfg=28 ctermbg=NONE guibg=NONE

" Keywords
hi Keyword ctermfg=160 ctermbg=NONE guibg=NONE

" Functions
hi Function ctermfg=36 ctermbg=NONE guibg=NONE

" Variables
hi Identifier ctermfg=75 ctermbg=NONE guibg=NONE

" Type definitions
hi Type ctermfg=109 ctermbg=NONE guibg=NONE

" Preprocessor directives
hi PreProc ctermfg=33 ctermbg=NONE guibg=NONE

" Special characters
hi Special ctermfg=93 ctermbg=NONE guibg=NONE

" Underlined text
hi Underlined ctermfg=45 ctermbg=NONE guibg=NONE

" Error messages
hi Error ctermfg=231 ctermbg=160 guibg=#d70000

" Warnings
hi WarningMsg ctermfg=231 ctermbg=124 guibg=#ffaf00

" Search highlighting
hi Search ctermfg=16 ctermbg=194 guibg=#d7d700
hi IncSearch ctermfg=16 ctermbg=108 guibg=#87ff87

" Line numbers
hi LineNr ctermfg=68 ctermbg=NONE guibg=NONE

" Cursor line
hi CursorLineNr ctermfg=75 ctermbg=234 guibg=#303030

" Status line
hi StatusLine ctermfg=16 ctermbg=251 guibg=#d0d0d0
hi StatusLineNC ctermfg=16 ctermbg=243 guibg=#808080

" Visual mode
hi Visual ctermbg=238 guibg=#444444

" Diff text
hi DiffAdd ctermfg=NONE ctermbg=22 guibg=#005f00
hi DiffChange ctermfg=NONE ctermbg=58 guibg=#5f00af
hi DiffDelete ctermfg=NONE ctermbg=52 guibg=#5f0000
hi DiffText ctermfg=NONE ctermbg=94 guibg=#d70087
