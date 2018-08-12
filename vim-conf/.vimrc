autocmd BufWritePost $MYVIMRC source $MYVIMRC
let mapleader=";"

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'vundlevim/vundle.vim'
"Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'nathanaelkane/vim-indent-guides'
"Plugin 'derekwyatt/vim-fswitch'
"Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/DfrankUtil'
"Plugin 'vim-scripts/vimprj'
"Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/YouCompleteMe'
"Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'lilydjwg/fcitx.vim'
Plugin 'tpope/vim-surround'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'Raimondi/delimitMate'
Plugin 'sjl/gundo.vim'
Plugin 'a.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'davidhalter/jedi-vim'
Plugin 'liuchengxu/space-vim-dark'
call vundle#end()
filetype plugin indent on
runtime macros/matchit.vim

syntax enable
syntax on
"colorscheme elflord
colorscheme koehler
set guifont=Monospace\ 13

set history=100
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set wildmenu
set incsearch
set ignorecase
set smartcase

vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>
"nmap <Leader>qa :qa<CR>
"nmap <Leader>Qa :qa!<CR>
nmap <Leader>w :w<CR>
nmap <Leader>tn :tn<CR>
nmap <Leader>tp :tp<CR>
nmap <Leader>bn :bn<CR>
nmap <Leader>bp :bp<CR>
"nmap <Leader>ww <C-w><C-w>

inoremap <C-s> <C-o>:w<CR>

filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4 
" vim-indent-guides
"let g:indent_guides_enable_on_vim_startup=1
"let g:indent_guides_start_level=2
"let g:indent_guides_guide_size=1
"nmap <silent> <Leader>i <Plug>IndentGuidesToggle

set gcr=a:block-blinkon0 " forbid cursor flash
set guioptions-=m "menu hidden
set guioptions-=T "toolbar hidden

set laststatus=2
set ruler
set number
"set cursorline
"set cursorcolumn
set hlsearch
set nowrap
set noswapfile

set foldmethod=indent
"set foldmethod=syntax
set nofoldenable

" vim-fswitch
"nmap <silent> <Leader>sw :FSHere<CR>

"" tagbar
"let tagbar_left=1
"nnoremap <Leader>ilt :TagbarToggle<CR>
"let tagbar_width=32
"let g:tagbar_compact=1
"let g:tagbar_type_cpp = {
"    \ 'kinds' : [
"         \ 'c:classes:0:1',
"         \ 'd:macros:0:1',
"         \ 'e:enumerators:0:0', 
"         \ 'f:functions:0:1',
"         \ 'g:enumeration:0:1',
"         \ 'l:local:0:1',
"         \ 'm:members:0:1',
"         \ 'n:namespaces:0:1',
"         \ 'p:functions_prototypes:0:1',
"         \ 's:structs:0:1',
"         \ 't:typedefs:0:1',
"         \ 'u:unions:0:1',
"         \ 'v:global:0:1',
"         \ 'x:external:0:1'
"     \ ],
"     \ 'sro'        : '::',
"     \ 'kind2scope' : {
"         \ 'g' : 'enum',
"         \ 'n' : 'namespace',
"         \ 'c' : 'class',
"         \ 's' : 'struct',
"         \ 'u' : 'union'
"     \ },
"     \ 'scope2kind' : {
"         \ 'enum'      : 'g',
"         \ 'namespace' : 'n',
"         \ 'class'     : 'c',
"         \ 'struct'    : 's',
"         \ 'union'     : 'u'
"     \ }
"\ }
"
" ctrlsf.vim
nnoremap <Leader>sp :CtrlSF<CR>
let g:ctrlsf_ignore_dir=["node_modules",".git",".svn"]
let g:ctrlsf_position='bottom'

" YCM
highlight Pmenu ctermfg=6 ctermbg=7 guifg=#005f87 guibg=#EEE8D5
highlight PmenuSel ctermfg=4 ctermbg=7 guifg=#AFD700 guibg=#106900
let g:ycm_complete_in_comments=1
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
" 开启 YCM 标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
inoremap <Leader>; <C-x><C-o>
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_indentifiers_with_syntax=1
"let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags

"
"" vim-protodef
"let g:protodefprotogetter='~/.vim/bundle/vim-protodef/pullproto.pl'
"let g:disable_protodef_sorting=1

" nerdtree
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

" MiniBufExplorer
map <Leader>bl :MBEToggle<CR>
map <C-Tab> :MBEbn<CR>
map <C-S-Tab> :MBEbp<CR>
"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2

" wildfire.vim
map <SPACE> <Plug>(wildfire-fuel)
vmap <S-SPACE> <Plug>(wildfire-water)
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "i>", "ip"]

" fcitx-vim
" let g:loaded_fcitx = 0

" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<Leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<Leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<Leader><s-tab>"
"let g:UltiSnipsSnippetDirectories=['UltiSnips']

" vim-go custom mappings
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>god <Plug>(go-doc)
au FileType go nmap <Leader>gov <Plug>(go-doc-vertial)
au FileType go nmap <Leader>gr <Plug>(go-run)
au FileType go nmap <Leader>gb <Plug>(go-build)
au FileType go nmap <Leader>gt <Plug>(go-test)
au FileType go nmap <Leader>gc <Plug>(go-converage)
au FileType go nmap <Leader>gd <Plug>(go-def-split)
au FileType go nmap <Leader>gv <Plug>(go-def-vertical)
au FileType go nmap <Leader>got <Plug>(go-def-tab)
au FileType go nmap <Leader>ge <Plug>(go-rename)
" vim-go settings
let g:go_fmt_command="goimports"

" nerdtree-git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" ignored nerdtree-git
"let g:NERDTreeShowIgnoredStatus = 1
" nerdtree-tabs
let g:nerdtree_tabs_open_on_gui_startup=0

" Conque-GDB
let g:ConqueTerm_Color=2
let g:ConqueTerm_CloseOnEnd=1
let g:ConqueTerm_StartMessages=0

function! DebugGoSession()
    silent make -o vimgdb -gcflags "-N -l"
    redraw!
    if (filereadable("vimgdb"))
        ConqueGdb vimgdb
    else
        echom "Couldn't find debug file"
    endif
endfunction
function! DebugGoSessionCleanup(term)
    if (filereadable("vimgdb"))
        let ds=delete("vimgdb")
    endif
endfunction
call conque_term#register_function("after_close", "DebugGoSessionCleanup")
nmap <Leader>d :call DebugGoSession()<CR>

"delimitMate
imap <C-K> <Plug>delimitMateS-Tab
imap <C-L> <Plug>delimitMateJumpMany
"command:DelimitMateSwitch "plugin on or off :help DelimitMateSwitch
"command:DelimitMateOf "plugin on
"command:DelimitMateOff "plugin off

" 调用 gundo 树
nnoremap <Leader>ud :GundoToggle<CR>

let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

"yapf
autocmd FileType python nnoremap <Leader>= :0,$!yapf<CR>

"space-vim-dark
colorscheme space-vim-dark
"set termguicolors
"if $TERM_PROGRAM =~ 'Terminal'
"    hi Normal     ctermbg=NONE guibg=NONE
"    hi LineNr     ctermbg=NONE guibg=NONE
"    hi SignColumn ctermbg=NONE guibg=NONE
"endif
set background=dark
set t_Co=256
