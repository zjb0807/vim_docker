set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" #################### Plugin #################### "
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'https://github.com/scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'
Plugin 'flazz/vim-colorschemes'
" #################### Plugin #################### "

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" #################### Env #################### "
source $VIMRUNTIME/vimrc_example.vim

" YouCompleteMe {{{
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    "let g:ycm_python_binary_path = '/usr/bin/python'
    "let g:syntastic_javascript_checkers = ['standard']
    "let g:syntastic_javascript_standard_generic = 1
    let g:syntastic_javascript_checkers = ['jshint']
    "let g:syntastic_javascript_eslint_exec = 'eslint'
    let g:ycm_error_symbol='>>'
    let g:ycm_warning_symbol='>*'
    nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
    nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
    nmap <F4> :YcmDiags<CR>
    "inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_seed_identifiers_with_syntax = 1
    set completeopt-=preview
    let g:ycm_confirm_extra_conf=0
    let g:ycm_cache_omnifunc=0
    let g:ycm_complete_in_comments=1
    let g:ycm_min_num_of_chars_for_completion=1
" }}}

" NERDTree {{{
    map <F1> :NERDTreeToggle<CR>
" }}}

" tagbar {{{
    map <F2> :TagbarToggle<CR>
    let g:tagbar_autofocus = 1
    let g:tagbar_autoclose = 1
" }}}

" ctrlp {{{
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlP'
    let g:ctrlp_working_path_mode='ra'
    let g:ctrlp_match_window_bottom=1
    let g:ctrlp_max_height=15
    let g:ctrlp_match_window_reversed=0
    let g:ctrlp_follow_symlinks=1
" }}}

" airline {{{
    let g:airline_theme="bubblegum"
    let g:airline_powerline_fonts = 1
    set ambiwidth=double
    "set guifont=Consolas\ for\ Powerline\ FixedD:h11
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    " tabline
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    " whitespace
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#whitespace#symbol = '!'

    let g:airline_left_sep = '⮀'
    let g:airline_left_alt_sep = '⮁'
    let g:airline_right_sep = '⮂'
    let g:airline_right_alt_sep = '⮃'
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
" }}}

" delimitMate {{{
    "set backspace=start,eol
    let delimitMate_expand_cr = 1
    au FileType python let b:delimitMate_nesting_quotes = ['"']
" }}}

" syntastic {{{
    if exists('g:loaded_syntastic_plugin')
        "let g:syntastic_python_python_exec = 'python3'
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
    endif
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
" }}}

" indentLine {{{
    let g:indentLine_enabled = 1
    let g:indentLine_color_term = 239
" }}}

" vim-colorschemes {{{
    if filereadable(expand("/root/.vim/bundle/vim-colorschemes/colors/molokai.vim"))
        colorscheme molokai
    endif
" }}}

" config {{{
    syntax on
    let mapleader = ";"
    set encoding=utf-8
    set vb t_vb=
    set incsearch
    set ignorecase
    set hlsearch
    set showmatch
    set nofoldenable
    set clipboard=unnamed
    set nobackup
    set noundofile
    set noswapfile
    set mouse=a

    set number
    set relativenumber

    set autoindent
    set smartindent
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set t_Co=256

    autocmd FileType c,cpp,go set shiftwidth=4 | set expandtab

    set cursorline
    "hi CursorLine   cterm=none ctermbg=black
    highlight Pmenu ctermfg=86 ctermbg=8 guifg=#ffffff guibg=#000000

    highlight WhitespaceEOL ctermbg=red guibg=red
    match WhitespaceEOL /\s\+$/
    set listchars=tab:>-,trail:-

    "js,html,css style:
    au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
" }}}

" graphviz {{{
    map <f9> :w<CR>:!dot -Tpng -o %:r.png %<CR><CR>
    "map <f10> :w<CR>:!dot -Tsvg -o %:r.svg %<CR><CR>
    "map <f11> :w<CR>:!rm -f %:r.svg<CR><CR>:!dot -Tsvg -o %:r.svg %<CR><CR>
    "map <f5> :w<CR>:!./movetoserver.sh <CR><CR>
" }}}

" #################### Env #################### "
" :resize +3
" :vertical resize -3
" vimcopy "+y "+p
