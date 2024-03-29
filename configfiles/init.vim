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

	Plug 'nvim-treesitter/nvim-treesitter', {'do': 'TSUpdate'}

"	Plug 'Valloric/YouCompleteMe'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	Plug 'othree/xml.vim'

"	Plug 'othree/jsdoc-syntax.vim'

"	Plug 'MaxMEllon/vim-jsx-pretty'

	Plug 'rhysd/vim-grammarous'

	Plug 'dart-lang/dart-vim-plugin'

	Plug 'thosakwe/vim-flutter'

	Plug 'luochen1990/rainbow'

	Plug 'Raimondi/delimitMate'

	Plug 'elixir-editors/vim-elixir'

	Plug 'vimwiki/vimwiki'

	"Plug 'Olical/conjure'

	"Plug 'tpope/vim-dispatch'

	"Plug 'clojure-vim/vim-jack-in'

	"Plug 'radenling/vim-dispatch-neovim'
	
	Plug 'ctrlpvim/ctrlp.vim'

	Plug 'guns/vim-sexp', {'for': 'clojure'}

	Plug 'tpope/vim-sexp-mappings-for-regular-people'

	Plug 'tpope/vim-repeat'

	Plug 'tpope/vim-surround'

	Plug 'liquidz/vim-iced', {'for': 'clojure'}

	Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}

	Plug 'github/copilot.vim'

call plug#end()

" Use vim iced config
let g:iced_enable_default_key_mappings = v:true

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

"coc tab completion
set hidden
set updatetime=300
set cmdheight=1
set shortmess+=c
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ CheckBackspace() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1] =~# '\s'
endfunction

"coc code actions
noremap ca :CocAction<CR>

"Vimwiki setup
let wiki = {}
let wiki.path = '~/Projects/wiki/'
let wiki.auto_toc = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_list = [wiki]
autocmd BufRead,BufNewFile *.wiki setlocal spell

" Setup for J
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.ijs,*.ijt,*.ijp,*.ijx        setfiletype j
augroup END

"Carp setup
let g:syntastic_carp_checkers = ['carp']
au FileType carp set lisp

"BQN setup
au! BufRead,BufNewFile *.bqn setf bqn
au! BufRead,BufNewFile * if getline(1) =~ '^#!.*bqn$' | setf bqn | endif
