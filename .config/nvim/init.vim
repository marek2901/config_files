call plug#begin()
  Plug 'preservim/vimux'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'itchyny/lightline.vim'
  Plug 'sheerun/vim-polyglot'

  " Markdown
  Plug 'mzlogin/vim-markdown-toc'

  " Ruby
  Plug 'tpope/vim-rails'
  Plug 'vim-scripts/blockle.vim'

  " Elixir
  Plug 'elixir-editors/vim-elixir'

  " Rust
  Plug 'rust-lang/rust.vim'

  " Text
  Plug 'PeterRincker/vim-argumentative'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-repeat'
  Plug 'vim-scripts/ruby-matchit', { 'for': 'ruby' }
  Plug 'kana/vim-textobj-user'
  Plug 'lucapette/vim-textobj-underscore'
  Plug 'nelstrom/vim-textobj-rubyblock'
  Plug 'vim-scripts/matchit.zip'

  " Tests
  Plug 'vim-test/vim-test'

  " Happiness
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'rking/ag.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'Olical/vim-enmasse', { 'on': 'EnMasse' }
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'honza/vim-snippets'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-git'
  Plug 'pgr0ss/vim-github-url'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'beanworks/vim-phpfmt'

  " Syntax colors
  Plug 'arcticicestudio/nord-vim'
  Plug 'tomasr/molokai'
call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
  set termguicolors
end

filetype plugin indent on
syntax enable

set background=dark
let g:enable_italic_font=1
colorscheme molokai

highlight clear SignColumn

set synmaxcol=1000

set autoindent
set autoread
set colorcolumn=80
set cursorline
set expandtab
set guicursor=
set hidden
set hlsearch
set incsearch
set inccommand=nosplit
set ignorecase
set lazyredraw
set nobackup
set noswapfile
set relativenumber
set number
set nowrap
set nowritebackup
set ruler
set scrolloff=4
" https://github.com/neoclide/coc.nvim#example-vim-configuration
set shortmess+=c
set sidescrolloff=5
set signcolumn=no
set shiftround
set shiftwidth=2
set showcmd
set smartcase
set smarttab
set splitright
set splitbelow
set softtabstop=2
set tabstop=2
set visualbell
set wildmenu
set wildmode=list:longest
set updatetime=100
set noshowmode

for config_file in split(glob('~/.config/nvim/settings/**/*'), '\n')
  if filereadable(config_file)
    execute 'source' config_file
  endif
endfor
