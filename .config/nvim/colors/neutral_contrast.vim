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
hi Normal ctermfg=145 ctermbg=NONE guifg=#87af87 guibg=NONE

" Comments
hi Comment ctermfg=102 ctermbg=NONE guifg=#5f5f5f guibg=NONE

" Constants
hi Constant ctermfg=144 ctermbg=NONE guifg=#87afaf guibg=NONE

" Strings
hi String ctermfg=65 ctermbg=NONE guifg=#5f875f guibg=NONE

" Keywords
hi Keyword ctermfg=131 ctermbg=NONE guifg=#af5f5f guibg=NONE

" Functions
hi Function ctermfg=108 ctermbg=NONE guifg=#87afaf guibg=NONE

" Variables
hi Identifier ctermfg=144 ctermbg=NONE guifg=#87afaf guibg=NONE

" Type definitions
hi Type ctermfg=109 ctermbg=NONE guifg=#5fafaf guibg=NONE

" Preprocessor directives
hi PreProc ctermfg=67 ctermbg=NONE guifg=#5f87af guibg=NONE

" Special characters
hi Special ctermfg=132 ctermbg=NONE guifg=#af5f87 guibg=NONE

" Underlined text
hi Underlined ctermfg=73 ctermbg=NONE guifg=#5faf87 guibg=NONE

" Error messages
hi Error ctermfg=231 ctermbg=160 guifg=#ffffff guibg=#d75f5f

" Warnings
hi WarningMsg ctermfg=231 ctermbg=166 guifg=#ffffff guibg=#d7875f

" Search highlighting
hi Search ctermfg=16 ctermbg=187 guifg=#000000 guibg=#d7af87
hi IncSearch ctermfg=16 ctermbg=143 guifg=#000000 guibg=#87af87

" Line numbers
hi LineNr ctermfg=244 ctermbg=NONE guifg=#808080 guibg=NONE

" Cursor line
hi CursorLineNr ctermfg=109 ctermbg=234 guifg=#87afaf guibg=#303030

" Status line
hi StatusLine ctermfg=16 ctermbg=251 guifg=#000000 guibg=#d0d0d0
hi StatusLineNC ctermfg=16 ctermbg=243 guifg=#000000 guibg=#808080

" Visual mode
hi Visual ctermbg=238 guifg=NONE guibg=#444444

" Diff text
hi DiffAdd ctermfg=NONE ctermbg=65 guifg=NONE guibg=#5f875f
hi DiffChange ctermfg=NONE ctermbg=67 guifg=NONE guibg=#5f87af
hi DiffDelete ctermfg=NONE ctermbg=131 guifg=NONE guibg=#af5f5f
hi DiffText ctermfg=NONE ctermbg=132 guifg=NONE guibg=#af5f87

" NERDTree
hi NERDTreeDir ctermfg=145 ctermbg=NONE guifg=#87af87 guibg=NONE
hi NERDTreeDirSlash ctermfg=145 ctermbg=NONE guifg=#87af87 guibg=NONE
hi NERDTreeOpenable ctermfg=131 ctermbg=NONE guifg=#af5f5f guibg=NONE
hi NERDTreeClosable ctermfg=131 ctermbg=NONE guifg=#af5f5f guibg=NONE
hi NERDTreeFile ctermfg=145 ctermbg=NONE guifg=#87af87 guibg=NONE
hi NERDTreeExecFile ctermfg=65 ctermbg=NONE guifg=#5f875f guibg=NONE
hi NERDTreeUp ctermfg=145 ctermbg=NONE guifg=#87af87 guibg=NONE
hi NERDTreeCWD ctermfg=109 ctermbg=NONE guifg=#5fafaf guibg=NONE
hi NERDTreeHelp ctermfg=102 ctermbg=NONE guifg=#5f5f5f guibg=NONE
hi NERDTreeToggleOn ctermfg=65 ctermbg=NONE guifg=#5f875f guibg=NONE
hi NERDTreeToggleOff ctermfg=131 ctermbg=NONE guifg=#af5f5f guibg=NONE
