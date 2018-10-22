" settings
set noswapfile
set relativenumber
set tabstop=2
set shiftwidth=2
set hidden
set ignorecase
set smartcase
set smartindent
set splitright
set numberwidth=2
set listchars=eol:¬,trail:·,tab:»\
set list
set expandtab

silent! colorscheme nova

if (executable('ag'))
  set grepprg=ag\ --nogroup\ --nocolor
  let $FZF_DEFAULT_COMMAND = 'ag -g . --ignore build --ignore bin --ignore obj --ignore node_modules'
endif

if (executable('powershell'))
  let g:termShell = 'powershell'
endif

" auto-pairs settings
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = "<c-]>"

" ale settings
let g:ale_linters = { 'cs': ['OmniSharp'], 'javascript': ['eslint'] }
let g:ale_fixers = {
      \'javascript': ['eslint', 'prettier'],
      \'*': ['remove_trailing_lines', 'trim_whitespace']
      \}
let g:ale_fix_on_save = 1

" ultisnips settings
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

function! s:compileRoslyn(hooktype, name)
  call system("cd src/OmniSharp.Http.Driver; msbuild /v:q /t:restore,rebuild")
endfunction

" minpac settings
packadd minpac
call minpac#init()
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('mhinz/vim-sayonara')
call minpac#add('omnisharp/omnisharp-vim', {'type': 'opt'})
call minpac#add('omnisharp/omnisharp-roslyn', {'type': 'opt', 'do': function('s:compileRoslyn')})
call minpac#add('sheerun/vim-polyglot')
call minpac#add('sirver/ultisnips', {'type': 'opt'})
call minpac#add('tadesegha/vim-Term')
call minpac#add('tadesegha/vim-csharp', {'type': 'opt'})
call minpac#add('trevordmiller/nova-vim')
call minpac#add('w0rp/ale', {'type': 'opt'})
call minpac#add('jiangmiao/auto-pairs')

" omnisharp settings
let g:OmniSharp_timeout = 5

let mapleader = " "

" key mappings
nnoremap <Leader><Leader> <c-^>
nnoremap <Leader>e :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <esc> :nohlsearch<cr>
nnoremap <c-q> :Sayonara!<cr>
nnoremap <c-z> :Term<cr>
nnoremap <Leader>rc :e $MYVIMRC<cr>
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
tnoremap <c-z> <c-\><c-n><c-^>
tnoremap <c-q> <c-\><c-n>:bd!<cr>
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-l> <c-\><c-n><c-w>l
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k

augroup help
  autocmd!
  autocmd BufEnter * if &buftype == "help" | wincmd L | endif
augroup END

augroup csharp
  autocmd!
  autocmd Filetype cs packadd omnisharp-vim
  autocmd Filetype cs packadd ultisnips
  autocmd Filetype cs packadd vim-csharp
  autocmd Filetype cs packadd ale
augroup END

augroup quickfix
  autocmd!
  autocmd Filetype qf 20wincmd_
  autocmd BufLeave * if &buftype == "quickfix" | cclose | endif
augroup END

augroup javascript
  autocmd!
  autocmd Filetype javascript packadd ultisnips
  autocmd Filetype javascript packadd ale
  autocmd Filetype typescript set filetype=javascript
augroup END

augroup css
  autocmd!
  autocmd Filetype css packadd ultisnips
augroup END

augroup xml
  autocmd!
  autocmd FileType xml nnoremap <buffer> <Leader>cf :%! python -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<cr>
augroup END

augroup json
  autocmd!
  autocmd FileType json nnoremap <buffer> <Leader>cf :%! python -m json.tool<cr>
augroup END

let initLocal = expand('<sfile>:h') . '/init.local.vim'
if (filereadable(initLocal))
  execute "source " . initLocal
endif

if has('win32') || has('win64')
  execute "source " . expand('<sfile>:h') . '/init.windows.vim'
else
  execute "source " . expand('<sfile>:h') . '/init.mac.vim'
endif
