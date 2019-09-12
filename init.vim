call plug#begin()
  Plug 'haishanh/night-owl.vim'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'sirver/ultisnips'
  Plug 'omnisharp/omnisharp-vim'
  Plug 'vim-scripts/dbext.vim'
  Plug 'w0rp/ale'
  Plug 'Shougo/deoplete.nvim'
  Plug 'mxw/vim-jsx'
  Plug 'pangloss/vim-javascript'
  Plug 'tpope/vim-fugitive'
  Plug 'leafgarland/typescript-vim'
  Plug 'PProvost/vim-ps1'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'mattn/emmet-vim'

  Plug 'tadesegha/vim-csharp'
  Plug 'tadesegha/vim-term'
call plug#end()

let maplocalleader = ','

set number
set relativenumber
set listchars=eol:¬,trail:·,tab:»\
set noswapfile
set hidden
set ignorecase
set smartcase
set smartindent
set list
set expandtab
set shiftwidth=2
set tabstop=2
set completeopt=menu,noinsert
set nowrap
set nohlsearch
set cmdheight=2
set linespace=7
set splitright
set timeoutlen=250

nnoremap <space> :
nnoremap <Leader>e :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader><Leader> <c-^>
tnoremap <Leader><Leader> <c-\><c-n>
nnoremap <Leader>t :call term#goToTerm('shell')<cr>a
nnoremap <Leader>d :call DatabaseBuffer()<cr>
nnoremap <Leader>/ :set hlsearch!<cr>
nnoremap L zL
nnoremap H zH
nnoremap <LocalLeader><LocalLeader> :ll<cr>
nnoremap <Leader>q :ccl<cr>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

colorscheme night-owl

highlight LineNr guifg=#f15d2a
highlight SpellBad cterm=underline ctermbg=none

" FZF settings
let $FZF_DEFAULT_COMMAND = 'rg --files --glob !*node_module* --glob !*bin* --glob !*obj* --glob !*build* --glob !*packages*'

" nvim-typescript settings
let $NVIM_NODE_LOG_FILE = 'c:\users\tolu_adesegha\temp\nvim-node.log'
let $NVIM_NODE_LOG_LEVEL = 'warn'

" ale settings
let g:ale_linters = { 'cs': ['OmniSharp'] }

" omnisharp settings
let g:OmniSharp_selector_ui = 'fzf'

" deoplete settings
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \ 'sources': { 'cs': ['omnisharp'] },
      \ 'auto_complete': v:false
      \ })

" prettier settings
let g:prettier#exec_cmd_async = 1
let g:prettier#config#print_width = 120
augroup prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
augroup END

" typescript mappings
augroup typescript
  autocmd!
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>gd m':TSDef<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>ga :call GoToAlternateFile()<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>fs :TSGetDocSymbols<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>fu :TSRefs<cr>
augroup END

augroup sql
  autocmd!
  autocmd FileType sql nnoremap <buffer> <LocalLeader>r :DBExecSQLUnderCursor<cr>
augroup END

augroup json
  autocmd!

  autocmd FileType json nnoremap <buffer> <LocalLeader>cf :%!python -m json.tool<cr>
augroup END

augroup quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :ccl<cr>

execute 'source ' . expand('<sfile>:h') . '/utilities.vim'

" ========= Windows OS specific settings ============
if has('win32') || has('win64')
  let windowsrc = expand('<sfile>:h') . "/init.windows.vim"
  if filereadable(windowsrc)
    execute "source " . windowsrc
  endif
endif

" ========= Mac OS specific settings ============
if !(has('win32') || has('win64'))
  let macrc = expand('<sfile>:h') . "/init.mac.vim"
  if filereadable(macrc)
    execute "source " . macrc
  endif
endif

" ========= Local settings ============
let localInitFile = expand('<sfile>:h') . "/init.local.vim"
if filereadable(localInitFile)
  execute "source " . localInitFile
endif
