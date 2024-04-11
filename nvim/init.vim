
"                                           /$$              
"                                          |__/              
"  /$$$$$$$   /$$$$$$   /$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$ 
" | $$__  $$ /$$__  $$ /$$__  $$|  $$  /$$/| $$| $$_  $$_  $$
" | $$  \ $$| $$$$$$$$| $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
" | $$  | $$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
" | $$  | $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
" |__/  |__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/


" Vim plug """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()
  Plug 'joshdick/onedark.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ryanoasis/vim-devicons'
  Plug 'sheerun/vim-polyglot'
  Plug 'preservim/nerdtree'
call plug#end()


" Global Sets """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on            " Enable syntax highlight
set nu               " Enable line numbers
set relativenumber   " Enable relative numbers
set tabstop=2        " Show existing tab with 4 spaces width
set softtabstop=2    " Show existing tab with 4 spaces width
set shiftwidth=2     " When indenting with '>', use 4 spaces width
set expandtab        " On pressing tab, insert 4 spaces
set smarttab         " Insert tabs on the start of a line according to 
                     " shiftwidth
set smartindent      " Automatically inserts one extra level of indentation in 
                     " some cases
set hidden           " Hides the current buffer when a new file is openned
set incsearch        " Incremental search
set ignorecase       " Ingore case in search
set smartcase        " Consider case if there is a upper case character
set scrolloff=8      " Minimum number of lines to keep above and below the 
                     " cursor
set colorcolumn=80   " Draws a line at the given line to keep aware of the line 
                     " size
"set signcolumn=yes   " Add a column on the left. Useful for linting
set cmdheight=1      " Give more space for displaying messages
set updatetime=100   " Time in miliseconds to consider the changes
set encoding=utf-8   " The encoding should be utf-8 to activate the font icons
set nobackup         " No backup files
set nowritebackup    " No backup files
set splitright       " Create the vertical splits to the right
set splitbelow       " Create the horizontal splits below
set autoread         " Update vim after file update from outside
set mouse=a          " Enable mouse support
set clipboard=unnamedplus " Enable copy and paste to external program 

filetype on          " Detect and set the filetype option and trigger the 
                     " FileType Event
filetype plugin on   " Load the plugin file for the file type, if any
filetype indent on   " Load the indent file for the file type, if any


" Theme """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme onedark

" Enalbe neovim transparent
highlight Normal guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE


" Airline """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


" NerdTree """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-a> :NERDTreeToggle<CR>
