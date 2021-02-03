" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" ====================
" === Editor Setup ==
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set exrc
set secure
set hidden
set cursorline
set nowrap
set showcmd
set wildmenu
set ignorecase
set smartcase
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=-1
set autoindent
set list
set listchars=tab:\▏\ ,trail:·
set scrolloff=7
set tw=0
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set inccommand=split
set completeopt=longest,noinsert,menuone,preview
set ttyfast " should make scrolling faster
set lazyredraw " same as above
set visualbell
set colorcolumn=110
set updatetime=100
set virtualedit=block
set shortmess+=c
set laststatus=2
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set guicursor+=n-v-c-sm:blinkon5

" save modification history even after quiting the file
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-o> <C-\><C-N><C-O>
tnoremap <C-n> <C-\><C-N>
tnoremap Q <C-\><C-N>:q<CR>

" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
noremap ; :

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap S :w<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Refresh Nvim Settings
noremap R :w<CR>:source $MYVIMRC<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" space to tab
vnoremap <LEADER><LEADER>tt :s/    /\t/g

" Folding
noremap <silent> <LEADER><LEADER>f za



" ===
" === Cursor Movement
" ===
noremap <silent> J 5j
noremap <silent> K 5k
" noremap <silent> H ^
noremap <silent> L $
noremap W 5w
noremap B 5b
noremap <silent> \v v$h
" Insert Mode Cursor Movement
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
inoremap <silent> <C-j> J

" Command Mode Cursor Movement
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <up>
cnoremap <C-j> <down>
cnoremap <C-l> <right>
cnoremap <C-h> <left>
" Searching Movement
map - N
map = n
" view movement
noremap <C-h> zH
noremap <C-l> zL
noremap <C-j> 5<C-e>
noremap <C-k> 5<C-y>

" fix the bug that <C-i> does not work as jumping in because vim receives it as <tab>
noremap <C-i> <C-i>


" ===
" === Window Management
" ===
" Use <LEADER> + new arrow keys for moving the cursor around windows
noremap <M-k> <C-w>k
noremap <M-j> <C-w>j
noremap <M-h> <C-w>h
noremap <M-l> <C-w>l
" keep only the current window
noremap qe <C-w>o

" Disable s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER><LEADER>q <C-w>j:q<CR>

" ===
" === Tab management
" ===
" Create a new tab 
noremap to :tabe<CR>
" Move around tabs 
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs 
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>


" ===
" === Other useful stuff
" ===
" Open a new instance of st with the cwd
nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Press ` to change case (instead of ~)
noremap ` ~

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Press space twice to jump to the next '<++>' and edit it
" noremap <LEADER>= <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res -10<CR>:term<CR>

" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===
call plug#begin('~/.config/nvim/plugged')
" Smart Relative Number
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Snazzy Theme
Plug 'connorholyday/vim-snazzy'

" File Tree, not used because we have coc-explorer
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Easymotion
Plug 'easymotion/vim-easymotion'

" Syntax highlighting for CJSON in Vim
Plug 'kevinoid/vim-jsonc'

" Status line
" Plug 'vim-airline/vim-airline'
Plug 'liuchengxu/eleline.vim'

" Undo Tree
Plug 'mbbill/undotree'

" Python highlight
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }

" file navigation
" LeaderF, An efficient fuzzy finder that helps to locate files, buffers, mrus, gtags, etc. on the fly
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
" Rooter changes the working directory to the project root when you open a file or directory.
Plug 'airblade/vim-rooter'
" Vim code inspection plugin for finding defitinitions and references/usages
Plug 'pechorin/any-jump.vim'
" allows you to use Ranger in a floating window
Plug 'kevinhwang91/rnvimr'
" fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" autoformat
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" modifies Vim’s indentation behavior to comply with PEP8
Plug 'Vimjas/vim-python-pep8-indent'

" auto-completion for quotes, parens, brackets
Plug 'jiangmiao/auto-pairs'

" auto comment
" Plug 'glts/vim-textobj-comment'
" Plug 'kana/vim-textobj-user'
Plug 'tomtom/tcomment_vim'

" switch between true and false
Plug 'AndrewRadev/switch.vim'

" python indent line
Plug 'Yggdroot/indentLine'


" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ===
" === Plugin Settings
" ===

" Vim-numbertoggle
set number relativenumber

" Snazzy
color snazzy
hi Visual guifg=None guibg=#404859

" easymotion
map <LEADER> <Plug>(easymotion-prefix)
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" search
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)
" This setting makes EasyMotion work similarly to Vim's smartcase option for global searches.
let g:EasyMotion_smartcase = 1
" move in line
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

" eleline
let g:eleline_slim = 1

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" semshi
" Mark selected nodes (those with the same name and scope as the one under the cursor). Set to 2 to highlight the node currently under the cursor, too.
let g:semshi#mark_selected_nodes=2
let g:semshi#error_sign=v:false
" overwrite some default highlight settings
function MyCustomHighlights()
	hi semshiLocal           ctermfg=209 guifg=#ff875f
	hi semshiGlobal          ctermfg=214 guifg=#ffaf00
	hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
	hi semshiParameter       ctermfg=75  guifg=#5fafff
	hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
	hi semshiFree            ctermfg=218 guifg=#ffafd7
	hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
	hi semshiAttribute       ctermfg=49  guifg=#00ffaf
	hi semshiSelf            ctermfg=249 guifg=#e5c07b
	hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
	hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

	hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
	hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
	sign define semshiError text=E> texthl=semshiErrorSign
endfunction
autocmd FileType python call MyCustomHighlights()
" make highlight groups persist across colorscheme switches
autocmd ColorScheme * call MyCustomHighlights()

" LeaderF
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowHidden = 1
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_WildIgnore = {
        \ 'dir': ['.git'],
        \ 'file': []
        \}
let g:Lf_CommandMap = {
\   '<C-]>': ['<C-v>'],
\   '<C-x>': ['<C-h>'],
\}
let g:Lf_PopupPalette = {
    \  'dark': {
    \      'Lf_hl_cursorline': {
    \                'guifg': '#FF8247'
    \              },
    \      },
    \  }
nnoremap <c-p> :Leaderf file<CR>
let g:Lf_UseMemoryCache = 0
let g:Lf_UseCache = 0

" vim-rooter
" root dir contains one of these
let g:rooter_patterns = ['.git', 'Makefile']
let g:rooter_silent_chdir = 1

" any-jump
" Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
" Show line numbers in search results
let g:any_jump_list_numbers = 1

" rnvimr
nnoremap <silent> <LEADER>R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

" codefmt
augroup autoformat_settings
  "autocmd FileType bzl AutoFormatBuffer buildifier
  "autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  "autocmd FileType dart AutoFormatBuffer dartfmt
  "autocmd FileType go AutoFormatBuffer gofmt
  "autocmd FileType gn AutoFormatBuffer gn
  "autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  "autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType rust AutoFormatBuffer rustfmt
  "autocmd FileType vue AutoFormatBuffer prettier
augroup END

" python-pep8-indent
let g:python_pep8_indent_hang_closing=1
let g:python_pep8_indent_multiline_string=-2

" auto-pairs
" do not Map <C-h> to delete brackets, quotes in pair
let g:AutoPairsMapCh = 0
" fly mode
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutFastWrap = '<M-w>'
" delete autopair of "" in vim file because it is used for commentation
" add auto pair of <> in vim file
au Filetype vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", "<":">"}

" tcomment
let g:tcomment_textobject_inlinecomment = ''
" toggle comment
nmap <LEADER>cc gcc
vmap <LEADER>cc gc
" comment lines
nmap <LEADER>cl g>c
vmap <LEADER>cl g>
" uncomment lines
nmap <LEADER>ch g<c
vmap <LEADER>ch g<

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'SpecialKey'




nnoremap H I










" coc-nvim
let g:coc_global_extensions = [
		\ 'coc-json',
		\ 'coc-vimlsp',
		\ 'coc-actions',
		\ 'coc-python',
		\ 'coc-pyright',
		\ 'coc-explorer']

" use <tab> for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
" use <Shift-tab> for navigate upwards
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" use <Enter> to type selected characters; if no character is selected, use <Enter> to move to the next line
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-o> coc#refresh()
" Use them to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" show the explorer
nmap tt :CocCommand explorer<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Use it to show documentation in preview window.
nnoremap <silent> mh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  call CocActionAsync('highlight')
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap nf <Plug>(coc-funcobj-i)
" omap nf <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap nc <Plug>(coc-classobj-i)
" omap nc <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)


" ===================== End of Plugin Settings =====================


" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

