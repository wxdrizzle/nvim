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
" set autochdir


" ===
" === Editor behavior
" ===
set exrc
set secure
set hidden
set cursorline
set colorcolumn=120
set wrap
autocmd BufRead *.py set nowrap
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
set updatetime=300
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

autocmd BufLeave *
    \ if &buftype ==# '' || &buftype == 'acwrite' |
    \     silent write |
    \ endif

" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
tnoremap <C-o> <C-\><C-n><C-o>
tnoremap <ESC> <C-\><C-n>
tnoremap Q <C-\><C-n>:q<CR>
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
autocmd WinEnter term://* nohlsearch
autocmd TermOpen term://* setlocal signcolumn=auto
autocmd TermOpen term://* startinsert

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
noremap <silent> H ^
noremap <silent> L $
noremap W 5w
noremap B 5b
noremap <silent> \v v$h
" Insert Mode Cursor Movement
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

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

" fix the bug that <C-i> does not work as jumping in because vim receives it as <tab>
noremap <C-i> <C-i>

noremap <C-j> J


" ===
" === Window Management
" ===
" Use <LEADER> + new arrow keys for moving the cursor around windows
noremap <leader>k <C-w>k
noremap <leader>j <C-w>j
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l
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
noremap <LEADER><LEADER>h <C-w>t<C-w>K
" Place the two screens side by side
noremap <LEADER><LEADER>v <C-w>t<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER><LEADER>q <C-w>j:q<CR>


" highlight cursorline only in current window
" Background colors for active vs inactive windows
augroup WindowManagement
  autocmd!
  autocmd BufNewFile,BufReadPre * call ActiveWindowColor()
  autocmd WinEnter * call ActiveWindowColor()
  autocmd WinLeave * call InactiveWindowColor()
augroup END
" Change highlight group of active/inactive windows
function! ActiveWindowColor()
  " hi ActiveWindow guibg=#1e2430
  " hi InactiveWindow guibg=#343943
hi Normal guibg=#1e2430
  hi Visual guibg=#404859
  " set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow,SignColumn:ActiveWindow
  set cursorline
  if &filetype == "python"
    setlocal colorcolumn=120
  else
    setlocal colorcolumn=""
  endif
endfunction
function! InactiveWindowColor()
  " hi ActiveWindow guibg=#1e2430
  " hi InactiveWindow guibg=#343943
hi Normal guibg=#1e2430
  hi Visual guibg=#404859
  " set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow,SignColumn:InactiveWindow
  set nocursorline
  setlocal colorcolumn=""
endfunction
autocmd BufRead *.py setlocal colorcolumn=120

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
	" if &filetype == 'c'
	" 	exec "!g++ % -o %<"
	" 	exec "!time ./%<"
	" elseif &filetype == 'cpp'
	" 	set splitbelow
	" 	exec "!g++ -std=c++11 % -Wall -o %<"
	" 	:sp
	" 	:res -15
	" 	:term ./%<
	" elseif &filetype == 'java'
	" 	exec "!javac %"
	" 	exec "!time java %<"
	if &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
        let $PYTHON_EXE_PATH=split($PATH, ":")[0] . '/python'
        :set splitbelow
        :sp
        " :call jobsend(b:terminal_job_id, python_cmd)
        :term! $PYTHON_EXE_PATH '%:p'
    elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	" elseif &filetype == 'dart'
	" 	exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
	" 	silent! exec "CocCommand flutter.dev.openDevLog"
	" elseif &filetype == 'javascript'
	" 	set splitbelow
	" 	:sp
	" 	:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	" elseif &filetype == 'go'
	" 	set splitbelow
	" 	:sp
	" 	:term go run .
	endif
endfunc

"auto upload file to server
command! -nargs=1 StartAsync
         \ call jobstart(<f-args>, {
         \    'on_exit': { j,d,e ->
         \       execute('echom "command finished with exit status '.d.'"', '')
         \    }
         \ })

autocmd BufWritePost *.py,*.sh call AutoUploading()
func! AutoUploading()
    if exists('g:ssh_usr')
        let $ssh_usr_name=g:ssh_usr
        let $ssh_ip_address=g:ssh_ip
        let $path_local_file=expand('%:p')
        if g:remote_os == "linux"
            let $path_in_projects=join(split($path_local_file, "/")[3:], "/")
            let $path_remote_dir=g:remote_dir . join(split(expand('%:p:h'), "/")[3:], "/")
        endif
        if g:remote_os == "win"
            let $path_in_projects=join(split($path_local_file, "/")[3:], "\\")
            let $path_remote_dir=g:remote_dir . join(split(expand('%:p:h'), "/")[3:], "\\")
        endif

        let $path_remote_file=g:remote_dir . $path_in_projects
        let $project_name=split(expand('%:p'), "/")[3]

        :StartAsync ssh $ssh_usr_name@$ssh_ip_address mkdir -p $path_remote_dir
        :StartAsync scp $path_local_file $ssh_usr_name@$ssh_ip_address:$path_remote_file
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
" one dark theme
Plug 'joshdick/onedark.vim'

" File Tree
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Easymotion
Plug 'easymotion/vim-easymotion'

" Syntax highlighting for CJSON in Vim
Plug 'kevinoid/vim-jsonc'

" Status line
" Plug 'liuchengxu/eleline.vim'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'

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
" Plug 'google/vim-maktaba'
" Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
" Plug 'google/vim-glaive'

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

" rainow brackets
Plug 'luochen1990/rainbow'

" gitgutter
Plug 'airblade/vim-gitgutter'

" scroll status
" Plug 'ojroques/vim-scrollstatus'

" Text objects, folding, and more for Python
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" tag list
Plug 'liuchengxu/vista.vim'

" python virtual env
Plug 'cjrh/vim-conda'

" easy use of terminal 
" Plug 'kassio/neoterm'

" Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python'}

" quickly select text object
Plug 'gcmt/wildfire.vim'

" text object
Plug 'wellle/targets.vim'

" modify surrounding chars
Plug 'machakann/vim-sandwich'

" multi cursor
Plug 'mg979/vim-visual-multi'

" thesaurus
Plug 'ron89/thesaurus_query.vim'

" bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" start page
Plug 'mhinz/vim-startify', {'branch': 'center'}

" tabularize
Plug 'godlygeek/tabular'

" pythin docstring
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" show color with color code
" Plug 'gko/vim-coloresque'

" git
Plug 'tpope/vim-fugitive'

" for syntax hightlighting
" Plug 'dense-analysis/ale'

" snippet engine
" Plug 'SirVer/ultisnips'
" snippets
" Plug 'honza/vim-snippets'

Plug 'embear/vim-localvimrc'

" scroll
Plug 'psliwka/vim-smoothie'

" markdown
Plug 'instant-markdown/vim-instant-markdown'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" auto sync
Plug 'kenn7/vim-arsync'


call plug#end()

" ===
" === Plugin Settings
" ===

" Vim-numbertoggle
set number relativenumber

" Snazzy
" color snazzy

" one dark theme
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
syntax on
colorscheme onedark

" nerdtree
" autocmd FileType nerdtree setlocal signcolumn=auto
" augroup filetype_nerdtree
"     au!
"     au FileType nerdtree call s:disable_lightline_on_nerdtree()
"     au WinEnter,BufWinEnter,TabEnter * call s:disable_lightline_on_nerdtree()
" augroup END
" fu s:disable_lightline_on_nerdtree() abort
"     let nerdtree_winnr = index(map(range(1, winnr('$')), {_,v -> getbufvar(winbufnr(v), '&ft')}), 'nerdtree') + 1
"     call timer_start(0, {-> nerdtree_winnr && setwinvar(nerdtree_winnr, '&stl', '%#Normal#')})
" endfu

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
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>h <Plug>(easymotion-linebackward)

" lightline
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'cwdname', 'readonly'], 
      \             [ 'relativepath', 'modified' ],
      \             [ 'linterstatus' ]],
      \   'right': [ [ 'gitbranch', 'condaenvname' ],
      \              [ 'gitstatus' ],
      \              [ 'percent' ]]
      \ },
      \ 'component_function': {
      \   'relativepath': 'RelativePathName',
      \   'gitbranch': 'GitBranchName',
      \   'cwdname': 'CurrentWorkingDirName',
      \   'condaenvname': 'CondaEnvName',
      \   'linterstatus': 'LinterStatus',
      \   'gitstatus': 'GitStatus'
      \ },
      \ }
function GitBranchName()
    let b:GitBranchName = FugitiveHead()
    return b:GitBranchName != '' ? ' ' . b:GitBranchName : ''
endfunction
function  CurrentWorkingDirName()
    let b:WorkingFolderName = fnamemodify(getcwd(), ':t')
    return FugitiveHead() != '' ? ' ' . b:WorkingFolderName : ' ' . b:WorkingFolderName
endfunction
function RelativePathName()
    return expand("%")
endfunction
function CondaEnvName()
    return $CONDA_DEFAULT_ENV != '' ? ' ' . $CONDA_DEFAULT_ENV : ""
endfunction

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" semshi
" Mark selected nodes (those with the same name and scope as the one under the cursor). Set to 2 to highlight the node currently under the cursor, too.
let g:semshi#mark_selected_nodes=2
let g:semshi#error_sign=v:false
let g:semshi#simplify_markup=v:false
let g:semshi#self_to_attribute=v:true
let g:semshi#update_delay_factor=0.05
let g:semshi#always_update_all_highlights=v:true
" overwrite some default highlight settings
function MyCustomHighlights()
    hi semshiGlobal           guifg=#61afef
    hi semshiImported         guifg=#61afef gui=None
    hi semshiParameter        guifg=#E5C07B
    hi semshiParameterUnused  guifg=#D19A66  gui=italic
    hi semshiFree             guifg=#ffafd7
    hi semshiBuiltin          guifg=#c678dd
    hi semshiAttribute        guifg=#61afef
    hi semshiSelf             guifg=#e5c07b
    hi semshiUnresolved       guifg=#e06c75  gui=underline,italic
    hi semshiSelected         guifg=None guibg=#4c525c  

    hi   pythonStatement      guifg=#c678dd
    hi   pythonFunction       guifg=#61afef
    hi   pythonConditional    guifg=#c678dd
    hi   pythonRepeat         guifg=#c678dd
    hi   pythonOperator       guifg=#c678dd
    hi   pythonException      guifg=#c678dd
    hi   pythonInclude        guifg=#c678dd
    hi   pythonAsync          guifg=#c678dd
    hi   pythonDecorator      guifg=#e5c07b gui=italic
    hi   pythonDecoratorName  guifg=#98c379 gui=italic
    hi   pythonDoctest        guifg=#61afef
    hi   pythonDoctestValue   guifg=#c678dd
    hi   pythonTodo           guifg=#e5c07b
    hi   pythonComment        guifg=#5c6370
    hi   pythonQuotes         guifg=#98c379
    hi   pythonEscape         guifg=#61afef
    hi   pythonString         guifg=#98c379
    hi   pythonTripleQuotes   guifg=#98c379
    hi   pythonRawString      guifg=#98c379
    hi   pythonNumber         guifg=#d19a66
endfunction
autocmd FileType python call MyCustomHighlights()
" make highlight groups persist across colorscheme switches
autocmd ColorScheme * call MyCustomHighlights()
autocmd BufWritePost *.py :Semshi highlight

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
let g:any_jump_disable_default_keybindings = 1
nnoremap <LEADER><LEADER>j :AnyJump<CR>
xnoremap <LEADER><LEADER>j :AnyJumpVisual<CR> 
nnoremap <leader>ab :AnyJumpBack<CR>
nnoremap <leader>al :AnyJumpLastResults<CR>

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
let g:indentLine_fileTypeExclude = ['nerdtree', 'coc-explorer', 'startify']
autocmd FileType json,markdown let g:indentLine_conceallevel = 0

" rainbow brackets
let g:rainbow_active = 1
let g:rainbow_conf = {
	\	'guifgs': ['#61afef', '#98c379', '#e5c07b', '#e06c75', '#c678dd']}


" gitgutter
let g:gitgutter_map_keys = 0
set foldtext=gitgutter#fold#foldtext()
set signcolumn=yes:1
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'

nnoremap <LEADER>gs :GitGutterStageHunk<CR>
nnoremap <LEADER>gu :GitGutterUndoHunk<CR>
nnoremap <LEADER>gp :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>
nnoremap <LEADER>gf :GitGutterFold<CR>
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" braceless
autocmd FileType python BracelessEnable +indent +fold 

" vista.vim
noremap <LEADER>v :Vista!!<CR>
noremap <C-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_cursor_delay = 100
let g:vista_ignore_kinds = ['Variable']
let g:vista#renderer#icons = {
\   "function": "",
\   "variable": "",
\  }

" pyrhon conda env
let g:conda_startup_wrn_suppress = 1
let g:conda_startup_msg_suppress = 1
map <F1> :CondaChangeEnv<CR>
" autocmd BufEnter,WinEnter * call ChangeCONDA_PYTHON_EXE()
" function ChangeCONDA_PYTHON_EXE()
"     let $CONDA_PYTHON_EXE = split($PATH, ":")[0] . '/python'
" endfunction

" neoterm
let g:neoterm_default_mod = 'botright'

" vimspector
let g:vimspector_enable_mappings = 'HUMAN'


" wildfire
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it", "i>", "iP"]
nmap <BS> <Plug>(wildfire-quick-select)

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" vim-visual-multi
let g:VM_maps                       = {}
let g:VM_custom_motions             = {'H': '^', 'L': '$'}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '='
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'

" thesaurus
let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"
let g:tq_enabled_backends=['mthesaur_txt', 'cilin_txt', 'openthesaurus_de', 'yarn_synsets', 'jeck_ru', 'openoffice_en', 'datamuse_com']

" bookmarks
let g:bookmark_sign = ''
highlight BookmarkSign guifg=#61afef
highlight BookmarkAnnotationSign guifg=#61afef
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ms <Plug>BookmarkShowAll
nmap ml <Plug>BookmarkNext
nmap mh <Plug>BookmarkPrev
nmap mC <Plug>BookmarkClear
nmap mX <Plug>BookmarkClearAll
nmap mk <Plug>BookmarkMoveUp
nmap mj <Plug>BookmarkMoveDown
nmap mg <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1

" startify
autocmd User Startified call ActiveWindowColor()
let g:startify_enable_special      = 0
let g:startify_files_number        = 8
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_update_oldfiles     = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_change_to_dir       = 0
let g:startify_skiplist = [
        \ ]
let g:startify_bookmarks = [
        \ { 'c': '~/.config/nvim/init.vim'},
        \ { 'd': '~/Projects/DeepLearningBox/networks/layers.py'},
        \ { 's': '~/.config/nvim/Ultisnips' }
        \ ]
let g:startify_custom_header =
        \ startify#center(startify#fortune#cowsay('', '═','║','╔','╗','╝','╚'))
let g:MyName=[
       \ '   __  ___        __        __                ', 
       \ '   \ \/ (_)_ __   \ \      / /_ _ _ __   __ _ ',
       \ '    \  /| | `_ \   \ \ /\ / / _` | `_ \ / _` |',
       \ '    /  \| | | | |   \ V  V / (_| | | | | (_| |',
       \ '   /_/\_\_|_| |_|    \_/\_/ \__,_|_| |_|\__, |',
       \ '                                        |___/ ',
       \]
let g:startify_custom_footer =
            \ startify#center(g:MyName)
hi StartifyBracket guifg=#e5c07b
hi StartifyFile    guifg=#e5c07b
hi StartifyHeader  guifg=#61afef
hi StartifyFooter  guifg=#61afef
hi StartifyNumber  guifg=#e5c07b
hi StartifyPath    guifg=#98c379
hi StartifySection guifg=#e06c75
hi StartifySlash   guifg=#ffffff
hi StartifySpecial guifg=#e06c75
let g:startify_lists = [
      \ { 'type': 'dir',       'header': startify#center(['Recently Used Files: ' . getcwd()]) },
      \ { 'type': 'sessions',  'header': startify#center(['Sessions'])},
      \ { 'type': 'bookmarks', 'header': startify#center(['Bookmarks'])},
      \ ]
let g:startify_center=60

" tabular
vmap ga :Tabularize /

" pydocstring
let g:pydocstring_formatter = 'google'
nmap <silent> <LEADER>pd vaPo<ESC><Plug>(pydocstring)

" fugitive

" snippets
let g:UltiSnipsExpandTrigger="<BS>"
let g:UltiSnipsJumpForwardTrigger="<M-l>"
let g:UltiSnipsJumpBackwardTrigger="<M-h>"

" localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_persistent=1

" markdown
filetype plugin on
let g:instant_markdown_mathjax = 1



" ==============
" ==============
" ====coc-nvim
" ==============
" ==============
let g:coc_global_extensions = [
		\ 'coc-json',
		\ 'coc-vimlsp',
		\ 'coc-pyright',
        \ 'coc-snippets',
        \ 'coc-yank',
        \]

function! LinterStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  if get(info, 'information', 0)
    call add(msgs, 'I' . info['information'])
  endif
  if get(info, 'hint', 0)
    call add(msgs, 'H' . info['hint'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
		
" ===============coc-vimlsp
" document highlight
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

" ===============coc-pyright
" autocmd BufWritePre *.py CocCommand pyright.organizeimports 
nmap <leader>oi :CocCommand pyright.organizeimports<CR>

" " ===============coc-snippets
" Use <C-l> for trigger snippet expand.
imap <M-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <M-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<M-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<M-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <M-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


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
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent><nowait><expr> <C-=> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C--> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-=> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C--> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-=> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C--> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

hi   CocErrorSign      guifg=#d25361
hi   CocErrorFloat     guifg=#d25361
hi   CocWarningSign    guifg=#dcb364
hi   CocWarningFloat   guifg=#dcb364
hi   CocInfoSign       guifg=#98c379
hi   CocInfoFloat      guifg=#98c379
hi   CocHintSign       guifg=#56b6c2
hi   CocHintFloat      guifg=#56b6c2

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ===================== End of Plugin Settings =====================


" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

