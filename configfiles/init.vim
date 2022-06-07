"
"Normal nvim config
"
"
set nocompatible

"Sets up my prefered numbering
set relativenumber
set number

"Sets up my encoding
set encoding=utf-8

"Formatting
set tabstop=2
set shiftwidth=2
set softtabstop=2
filetype plugin indent on
set autoindent
set colorcolumn=80

"Latex stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"Php stuff
autocmd BufNewFile,BufRead *.php set syntax=html
autocmd BufNewFile,BufRead *.php set filetype=html

"Coloring and syntax hilighting
syntax enable
set background=dark
set t_co=256

"Template configuration
augroup templates
	autocmd BufNewFile *.md 0r ~/.config/nvim/skeletons/skeleton.md
augroup END

"Sets up automatic building for aoan
"autocmd BufWritePost aoan.md !./makeaoan

"Allows me to press ,u to run uwebsite
map ,u :!rsync -a ~/Projects/pkingston webmaster@pkingston.xyz:/var/www<CR>

"
" Plugins
"
call plug#begin('~/.config/nvim/plugged')
	
	Plug 'preservim/nerdtree'

	Plug 'Xuyuanp/nerdtree-git-plugin'

	Plug 'itchyny/lightline.vim'

	Plug 'airblade/vim-gitgutter'

	Plug 'tpope/vim-fugitive'

	Plug 'ghifarit53/tokyonight-vim'

	Plug 'vim-scripts/indentpython.vim'

	Plug 'vim-syntastic/syntastic'

	Plug 'nvie/vim-flake8'

	Plug 'lervag/vimtex'

"	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

	Plug 'Valloric/YouCompleteMe'

	Plug 'othree/xml.vim'

	Plug 'othree/jsdoc-syntax.vim'

	Plug 'MaxMEllon/vim-jsx-pretty'

	Plug 'rhysd/vim-grammarous'

	Plug 'dart-lang/dart-vim-plugin'

	Plug 'thosakwe/vim-flutter'

	Plug 'luochen1990/rainbow'

	Plug 'Raimondi/delimitMate'
call plug#end()

"NerdTree config
noremap <leader>n :NERDTreeFocus<CR>
noremap <C-n> :NERDTree<CR>
noremap <C-t> :NERDTreeToggle<CR>
noremap <C-f> :NERDTreeFind<CR>

"Colorscheme config
set termguicolors
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight

let g:llightline = {'colorscheme': 'tokyonight'}

"Rainbow on
let g:rainbow_active = 1
