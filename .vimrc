"                      .__                       
"  _____ ___.__. ___  _|__| ____________   ____  
" /     <   |  | \  \/ /  |/     \_  __ \_/ ___\ 
"|  Y Y  \___  |  \   /|  |  Y Y  \  | \/\  \___ 
"|__|_|  / ____|   \_/ |__|__|_|  /__|    \___  >
"      \/\/                     \/            \/ 
"
"


" ===
" === Common set
" ===

" 设置语言编码"
set langmenu=zh_CN.UTF-8
set helplang=cn
" 显示中文帮助"
if version >= 603
        set helplang=cn
        set encoding=utf-8
endif
" 打印设置
set printencoding=utf-8
set printmbcharset=ISO10646
set printmbfont=r:UMingCN
" 设置字体"
" set guifont=dejaVu\ Sans\ MONO\ 10
set guifont=Courier_New:h10:cANSI
" TextEdit might fail if hidden is not set.
set hidden
"自动编译
autocmd BufNewFile,BufReadPre *.java nnoremap <leader>cra :w<cr>:!javac *.java<cr>:!java Main<cr>
" 用于解决切换普通模式慢半拍的问题
set timeoutlen=1000 ttimeoutlen=0
" 设置光标样式
" macos iterm2 style
"let &t_SI="\<Esc>]50;CursorShape=1\x7"
"let &t_SR="\<Esc>]50;CursorShape=2\x7"
"let &t_EI="\<Esc>]50;CursorShape=0\x7"
"mac os tmux style
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" netrw vim原生的文件管理器
set nocompatible
filetype plugin on
runtime macros/matchit.vim
packadd! matchit




" ===
" === Set some useful key
" ===

" set leaderKey
"let mapleader=";"
"let g:mapleader=";"
" 缓冲区导航映射
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
"大写Q退出
map Q :q<CR>
" 使用前缀对应缓冲区
nnoremap <leader>1 :1b<CR>
nnoremap <leader>2 :2b<CR>
nnoremap <leader>3 :3b<CR> 
"<c-p><c-n>代替updown
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Spelling Check with <leader>sc
map <leader>sc :set spell!<CR>
" input %% to fullpath
cnoremap <expr> %% getcmdtype()==':'?expand('%:h').'/':'%%'





" ===
" === Set some FCT
" ===

" set Smartim input
let g:smartim_default = 'com.apple.keylayout.ABC'
" 按F2进入粘贴模式
set pastetoggle=<F2>
" 在处理未保存或只读文件的时候，弹出确认"
"set confirm








" ===
" === set show style
" ===

set history=200
set scrolloff=5
syntax on  
" 设置行号
set number
" 将所有数字都作为十进制
set nrformats=
set relativenumber
" 高亮搜索
"set hlsearch
set incsearch
"搜索忽略大小写
set ignorecase
" 设置折叠方式
"set foldmethod=indent
" 自动高亮成对的括号
set showmatch
" 显示按钮
set showcmd
" 设置缩进
set softtabstop=4
set shiftwidth=4
set expandtab
" 不设置交换文件
"set noswapfile








" ===
" === Set NERDTree
" ===

" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) |q | endif
"修改树的显示图标
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=45
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp','tags','\.iml']
let g:NERDTreeGitStatusIndicatorMapCustom = {
			\"Modified"  : "✹",
			\"Staged"    : "✚",
			\"Untracked" : "✭",
			\"Renamed"   : "➜",
			\"Unmerged"  : "═",
			\"Deleted"   : "✖",
			\"Dirty"     : "✗",
			\"Clean"     : "✔︎",
			\"Ignored"   : "☒",
			\"Unknown"   : "?"
			\      }
                                            " }}}
" nerdtree
nmap <F3> :NERDTreeFind<cr>
nmap <F3> :NERDTreeToggle<cr>



" ===
" === imports plug
" ===

call plug#begin()
    "Plug 'scrooloose/nerdtree'
    Plug 'flazz/vim-colorschemes'
    Plug 'vim-scripts/nginx.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ybian/smartim'
    Plug 'szw/vim-tags'
    Plug 'preservim/nerdtree' 
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'dica-developer/vim-jdb'
    Plug 'moznion/java_getset.vim'
    Plug 'gmarik/vundle'
    Plug 'scrooloose/syntastic'
    Plug 'dbeniamine/cheat.sh-vim'
    Plug 'tpope/vim-surround'
call plug#end()


" 设置低栏的样式
let g:airline_theme="badwolf"



" ===
" === Set coc 
" ===

"let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" 非常有用的自动导入 java中的import   Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>












