"设置256位
set t_Co=256
set background=dark

let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
 
" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

if g:iswindows
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endi

syntax enable
syntax on
colorscheme lucius

"去边框
set go=
" 禁止显示滚动条
"set guioptions-=l
"set guioptions-=L
"set guioptions-=r
"set guioptions-=R
"" 禁止显示菜单和工具条
"set guioptions-=m
"set guioptions-=T
"显示状态栏
set laststatus=2
set nowrap
set mouse=a
set backspace=2
set smarttab
set autoread "文件在外部修改时，自动更新该文件

let mapleader = ","

set number
set guicursor=i:ver30
set guifont=YaHei\ Consolas\ Hybrid\ 12
set cursorline
"增量式搜索
set incsearch
"高亮搜索
set hlsearch
set ignorecase smartcase

"与Windows共享剪贴板
set clipboard+=unnamed

let &termencoding=&encoding 
set fileencodings=utf-8,gbk 


"开启检测文件类型
filetype on 
filetype plugin on 
filetype indent on 

nnoremap <leader>; A;<esc>o
nnoremap ; :
nnoremap : ;
nnoremap <leader>" viw<esc>i"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>i'<esc>hbi'<esc>lel
nnoremap <c-v> <c-q>
"nnoremap > 0vg_>
"nnoremap < 0vg_<

inoremap <a-d> <esc>ddi
inoremap <a-w> <esc>bdwi
inoremap <a-`> ~
noremap <leader>U wbvwU
noremap <leader>u wbvwu
nnoremap <a-u> wbvlU
nnoremap <a-s-u> wbvlu

nnoremap D kddO
nnoremap J jA

nnoremap 0 ^
nnoremap ^ 0
nnoremap - g_
vnoremap 0 ^
vnoremap ^ 0
vnoremap - g_
onoremap 0 ^
onoremap ^ 0
onoremap - g_
onoremap ( i(
onoremap " i"
onoremap ' i'
onoremap { i{
onoremap [ i[

"inoremap { {<esc>o}<esc><s-o>



inoremap jk <esc>

"保存html时自动格式化
autocmd BufWritePre *.html :normal gg=
autocmd FileType python noremap <F5> :w<cr>:!python3 %<cr>

  
autocmd FileType c noremap <F5> :call CompileRuncc()
func! CompileRuncc()  
    exec "w"  
    exec "!cc % -o %<"  
    exec "! ./%<"  
endfunc  

if g:iswindows 
    au GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 225)
    set diffexpr=MyDiff()
endif


function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

if g:islinux
    "YouCompleteMe配置
    "补全功能在注释中同样有效  
    let g:ycm_complete_in_comments=1  
    " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示  
    let g:ycm_confirm_extra_conf=0  
    " 开启 YCM 基于标签引擎  
    let g:ycm_collect_identifiers_from_tags_files=1  
    " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键  
    inoremap <leader>; <C-x><C-o>  
    " 补全内容不以分割子窗口形式出现，只显示补全列表  
    set completeopt-=preview  
    " 从第一个键入字符就开始罗列匹配项  
    let g:ycm_min_num_of_chars_for_completion=1  
    " 禁止缓存匹配项，每次都重新生成匹配项  
    let g:ycm_cache_omnifunc=0  
    " 语法关键字补全              
    let g:ycm_seed_identifiers_with_syntax=1  
    " 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;  
    let g:ycm_key_invoke_completion = '<a-;>'  
    " 设置转到定义处的快捷键为ALT + G 
    nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  
endif


filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
"if g:isGUI
    " 在 vim 启动的时候默认开启 NERDTree（autocmd 可以缩写为 au）
"    autocmd VimEnter * NERDTree
"endif
"自动显示行号
let NERDTreeShowLineNumbers=1

let g:pydiction_location = '$VIM/vimfiles/bundle/pydiction/complete-dict'

"indent-guides配置
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=3
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"Vundle配置
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
if g:iswindows
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
elseif g:islinux  
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

"vim lucius color theme
Bundle 'https://github.com/jonathanfilip/vim-lucius.git'
"增强状态栏
Bundle 'https://github.com/Lokaltog/vim-powerline.git'
"批量注释
Bundle "https://github.com/scrooloose/nerdcommenter.git"
"html/xml标签自动闭合
Bundle "https://github.com/othree/xml.vim.git"
"保存时自动创建目录
Bundle "https://github.com/DataWraith/auto_mkdir.git"
"资源管理器
Bundle "https://github.com/scrooloose/nerdtree.git"
"json语法高亮
Bundle "https://github.com/elzr/vim-json.git"
"python自动补全
Bundle "https://github.com/rkulla/pydiction.git"
"缓存区文件查找
Bundle "https://github.com/kien/ctrlp.vim.git"
"stl语法高亮
Bundle "git@github.com:Mizuchi/STL-Syntax.git"
"可视化缩进
Bundle "git@github.com:nathanaelkane/vim-indent-guides.git"
"c++语法高亮
Plugin 'octol/vim-cpp-enhanced-highlight'
"快速增加环绕符号
Bundle "https://github.com/tpope/vim-surround.git"
"命令重复增强
Bundle "https://github.com/tpope/vim-repeat.git"
"markdown支持插件
Bundle "https://github.com/plasticboy/vim-markdown.git"

if g:islinux
    Bundle "https://github.com/Valloric/YouCompleteMe.git"
    Bundle 'Valloric/ListToggle'
    Bundle 'scrooloose/syntastic'
endif

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
