" Space is leader
let mapleader = "\<Space>"
let g:mapleader ="\<Space>"

""set pythondll=/Library/Frameworks/Python.framework/Versions/3.5/lib/libpython3.5.dylib

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
" Colors
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'jeffkreeftmeijer/vim-dim'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'gcmt/taboo.vim'

" Status
Plug 'itchyny/lightline.vim'

" Editing
Plug 'justinmk/vim-sneak'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Valloric/YouCompleteMe', {'do' : './install.py --clang-completer --go-completer --rust-completer' }
""let g:loaded_youcompleteme = 1
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'skywind3000/asyncrun.vim'

" Syntax
Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'
Plug 'rust-lang/rust.vim'

" Docs
Plug 'Shougo/echodoc.vim'

" Extra
Plug 'fcangialosi/bootlin.vim'
call plug#end()

" => AsyncRun
" Set to non-zero height to open window automatically always
let g:asyncrun_open = 0
" Default status line
let g:asyncrun_status = "none"
" <space>b runs make in the background 
nnoremap <Leader>b :AsyncRun make<cr>
" <space>r means automatically run make everytime file is written
map <Leader>r :autocmd BufWritePost * AsyncRun make<cr>
" <ctrl>c toggles the quicfix window
nnoremap <C-c> :call asyncrun#quickfix_toggle(10)<cr>

" => Bootlin, set version for non-linux machines
" let g:bootlin_version = "4.19.1"

" => Lightline
" needed for display
set laststatus=2
" modify left side of line to add buildstatus from asyncrun
let g:lightline = {
    \ 'active' : {
    \    'left' : [ ['mode', 'paste'], ['readonly', 'filename', 'modified', 'buildstatus', 'linter_checking', 'linter_warnings', 'linter_errors'] ]
    \},
    \ 'component' : {
    \    'buildstatus' : '%{g:asyncrun_status}'
    \}
\}

let g:lightline#ale#indicator_checking = "✍"
let g:lightline#ale#indicator_warnings = "~"
let g:lightline#ale#indicator_errors = "✘"
let g:lightline.component_expand = {
    \ 'linter_checking' : 'lightline#ale#checking',
    \ 'linter_warnings' : 'lightline#ale#warnings',
    \ 'linter_errors' : 'lightline#ale#errors',
\}

nmap <silent> <C-j> :ALENext<cr>
nmap <silent> <C-k> :ALEPrevious<cr>


" Goto definition for YCM
nnoremap <Leader>gt :YcmCompleter GoTo<CR>
let g:ycm_goto_buffer_command="split"

" Open NERDTree on the right
let g:NERDTreeWinPos = "right"
" Use NERDTree independent of tabs
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Ale keep sign gutter always open
let g:ale_sign_column_always = 1
" Use a nicer sign for ALE
" let g:ale_sign_error = "✖"

" Temporarily make indents more visible when necessary
let g:indentLine_enabled = 0
nnoremap <Leader>in :IndentLinesToggle<CR>
let g:indentLine_char = "▏"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
" set background=dark
colorscheme dim

" Manually set some filetypes
au BufRead,BufNewFile *.ejs setfiletype html
au BufRead,BufNewFile *.gnu setfiletype gnuplot
au BufRead,BufNewFile *.plt setfiletype gnuplot
au BufRead,BufNewFile *.p setfiletype gnuplot
au BufRead,BufNewFile *.md set syntax=tex

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" <space>o opens new file
nnoremap <Leader>o :CtrlP<CR>
" <space>w saves
nnoremap <Leader>w :w<CR>
" <space>q saves and quits all open files
nnoremap <Leader>q :wqa<CR>
" <space>y/p copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Navigating tabs
nnoremap th  :tabfirst<CR>
nnoremap tn  :tabnext<CR>
nnoremap tN  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tc  :tabnew<CR>
nnoremap tm  :tabm<Space>
nnoremap tx  :tabclose<CR>

" Navigating buffers
nnoremap bh  :bfirst<CR>
nnoremap bn  :bnext<CR>
nnoremap bN  :bprev<CR>
nnoremap bl  :ls<CR>
nnoremap bc  :edit<CR>
nnoremap bx :bp <BAR> bd #<CR>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" remap half page down and up
nnoremap J <C-D>
nnoremap K <C-U>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fixes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf8

" Make backspace act as it should
set backspace=indent,eol,start

" Allow direction keys to move to next/previous line
set whichwrap+=<,>,h,l

" Enable filetype detection for highlighting and indentation
filetype plugin indent on

" Remap 0 to first non-blank character
map 0 ^

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
let s:C = ",underline"

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax
set ruler
" Improves smoothness of redrawing
set ttyfast
set lazyredraw
" Relative line numbers, except the current line, and highlight it 
set number 
set relativenumber
hi CursorLineNr ctermfg=231
" Vertical line at 100-char limit
set colorcolumn=100
set showcmd
" Enable mouse usage
set mouse=a
set shortmess+=c
" Disable fold on load
set nofoldenable

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set nowrap
set scrolloff=2

" Open vsplit on the right instead of the left
set splitright
" Open hsplit below instead of above
set splitbelow

" Tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Search incrementally
set incsearch
" Ignore case unless the pattern contains uppercase characters
set ignorecase
set smartcase

" No arrow keys --- force yourself to use the home row
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" No annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Show matching brackets when cursor is over them
set showmatch
set mat=2


" Rust
let g:ale_rust_cargo_use_check = 1
let g:ale_rust_cargo_check_all_targets = 1
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:ycm_rust_src_path = "/Users/frank/.rustup/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src"
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'go': ['go-langserver']}



" Make ctrl+p a lot faster for git
let g:ctrlp_use_caching = $HOME . '/.cache/ctrlp'
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

function! OpenGitRepo() 
    let url = system("git remote -v | head -n1 | cut -d@ -f2 | cut -d\" \" -f1 | tr ':' '/' | sed 's/\.git//'")
    silent exec "!open https://".url | redraw!
endfunction

nnoremap <Leader>gh :call OpenGitRepo()<CR>

