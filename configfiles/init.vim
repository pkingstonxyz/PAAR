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
set colorcolumn=80

"Latex stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

"Coloring and syntax hilighting
syntax enable
set background=dark
set t_co=256

"Template configuration
augroup templates
	autocmd BufNewFile *.md 0r ~/.config/nvim/skeletons/skeleton.md
augroup END

"Sets up automatic building for aoan
autocmd BufWritePost aoan.md !./makeaoan

"
" Plugins
"
call plug#begin('~/.config/nvim/plugged')
	
	Plug 'preservim/nerdtree'

	Plug 'Xuyuanp/nerdtree-git-plugin'

	Plug 'itchyny/lightline.vim'

	Plug 'jiangmiao/auto-pairs'

	Plug 'airblade/vim-gitgutter'

	Plug 'tpope/vim-fugitive'

	Plug 'ghifarit53/tokyonight-vim'

	Plug 'vim-scripts/indentpython.vim'

	Plug 'vim-syntastic/syntastic'

	Plug 'nvie/vim-flake8'

	Plug 'lervag/vimtex'

	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

	Plug 'Valloric/YouCompleteMe'

	Plug 'othree/xml.vim'

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
