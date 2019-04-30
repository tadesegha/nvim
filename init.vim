call plug#begin()
  Plug 'haishanh/night-owl.vim'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'sirver/ultisnips'
  Plug 'omnisharp/omnisharp-vim'
  Plug 'vim-scripts/dbext.vim'
  Plug 'w0rp/ale'
  Plug 'Shougo/deoplete.nvim'
  Plug 'tpope/vim-fugitive'

  Plug 'tadesegha/vim-csharp'
  Plug 'tadesegha/vim-term'

  Plug 'HerringtonDarkholme/yats.vim'
  " Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
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

nnoremap <space> :
nnoremap <Leader>e :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader><Leader> <c-^>
tnoremap <Leader><Leader> <c-\><c-n>
nnoremap <Leader>t :call term#goToTerm('shell')<cr>a
nnoremap <Leader>/ :set hlsearch!<cr>

nnoremap <Leader>d :call DatabaseBuffer()<cr>
nnoremap L zL
nnoremap H zH

colorscheme night-owl

" FZF settings
let $FZF_DEFAULT_COMMAND = 'rg --files --glob !*node_module* --glob !*bin* --glob !*obj* --glob !*build* --glob !*packages*'

" nvim-typescript settings
let $NVIM_NODE_LOG_FILE = '/tmp/nvim-node.log'
let $NVIM_NODE_LOG_LEVEL = 'warn'

" dbext settings
let g:dbext_default_profile_sqlServer = 'type=SQLSRV:integratedlogin=1:srvname=localhost:dbname=gcts_nominations'
let g:dbext_default_profile = 'sqlServer'

" vim-term settings
let g:termShell = 'powershell'

" ale settings
let g:ale_linters = { 'cs': ['OmniSharp'] }

" omnisharp settings
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_start_server = 0
let g:OmniSharp_port = 2000

" deoplete settings
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', { 'cs': ['omnisharp'] })

" typescript mappings
augroup typescript
  autocmd!
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>gd m':TSDef<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>ga :call GoToAlternateFile()<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>fs :TSGetDocSymbols<cr>
  autocmd FileType typescript nnoremap <buffer> <LocalLeader>fu :TSRefs<cr>
augroup END

augroup quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer> q :ccl<cr>
augroup END

function! GoToAlternateFile()
  let curr = expand("%")
  let tsPattern = '.ts$'
  let htmlPattern = '.html$'

  if match(curr, tsPattern) != -1
    let alternate = substitute(curr, tsPattern, ".html", "")
    execute "edit " . alternate
  elseif match(curr, htmlPattern) != -1
    let alternate = substitute(curr, htmlPattern, ".ts", "")
    execute "edit " . alternate
  endif
endfunction

function! CsharpBuild()

endfunction

function! DatabaseBuffer()
  if bufexists('databaseBuffer')
    execute "buffer databaseBuffer"
  else
    e databaseBuffer
    set buftype=nofile
    set filetype=sql
    nnoremap <buffer> <LocalLeader>r :DBExecSQLUnderCursor<cr>
  endif
endfunction
