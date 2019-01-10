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
set background=dark

silent! colorscheme night-owl

if (executable('ag'))
  set grepprg=ag\ --nogroup\ --nocolor
  let $FZF_DEFAULT_COMMAND = 'ag -g . --ignore build --ignore bin --ignore obj --ignore node_modules'
endif

" ale settings
let g:ale_linters = { 'cs': ['OmniSharp'], 'javascript': ['eslint'] }
let g:ale_fixers = {
      \'javascript': ['eslint', 'prettier'],
      \'html': [],
      \'*': ['remove_trailing_lines', 'trim_whitespace']
      \}
let g:ale_fix_on_save = 1

" ultisnips settings
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" omnisharp settings
let g:OmniSharp_timeout = 5

" minpac settings
packadd minpac
call minpac#init()
call minpac#add('tadesegha/vim-Term')
call minpac#add('tadesegha/vim-csharp', {'type': 'opt'})
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('mhinz/vim-sayonara')
call minpac#add('omnisharp/omnisharp-vim', {'type': 'opt'})
call minpac#add('omnisharp/omnisharp-roslyn', {'type': 'opt'})
call minpac#add('sheerun/vim-polyglot')
call minpac#add('sirver/ultisnips')
call minpac#add('w0rp/ale', {'type': 'opt'})
call minpac#add('tpope/vim-fugitive')
call minpac#add('haishanh/night-owl.vim')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('mhartington/nvim-typescript', { 'do': './install.sh' })

let mapleader = " "
let maplocalleader = ","

" noop key mappings
nnoremap :w<cr> :throw "you should be using <c-s> to save"<cr>

" key mappings
nnoremap <Leader><Leader> <c-^>
nnoremap <Leader>e :FZF<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <esc> :nohlsearch<cr>
nnoremap <Leader>q :Sayonara!<cr>
nnoremap <Leader>Q :bd<cr>
nnoremap <c-z> :call term#defaultTerm()<cr>i
nnoremap <Leader>rc :e $MYVIMRC<cr>
nnoremap <c-s> :write<cr>

tnoremap <LocalLeader><LocalLeader> <c-\><c-n>

imap <c-s> <esc><c-s>

augroup help
  autocmd!
  autocmd BufEnter * if &buftype == "help" | wincmd L | endif
augroup END

augroup csharp
  autocmd!
  autocmd Filetype cs packadd omnisharp-vim
  autocmd Filetype cs packadd vim-csharp
  autocmd Filetype cs packadd ale
augroup END

augroup typescript
  autocmd!

  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>fu :TSRef<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>gd :TSDef<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>gt :TSTypeDef<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>fm :TSGetDocSymbols<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>fs :TSGetWorkspaceSymbols<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>ca :TSGetCodeFix<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>fx :TSImport<cr>
  autocmd Filetype typescript nnoremap <buffer> <LocalLeader>/ :TSSearchFZF<cr>
augroup END

augroup quickfix
  autocmd!
  autocmd Filetype qf 20wincmd_
augroup END

augroup javascript
  autocmd!
  autocmd Filetype javascript packadd ale

  autocmd Filetype javascript nnoremap <buffer> <LocalLeader>gd <c-]>
  autocmd Filetype javascript nnoremap <buffer> <LocalLeader>vgd :vs<cr><c-]>
augroup END

augroup xml
  autocmd!
  autocmd FileType xml nnoremap <buffer> <Leader>cf :%! python -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"<cr>
augroup END

augroup json
  autocmd!
  autocmd FileType json nnoremap <buffer> <LocalLeader>cf :%! python -m json.tool<cr>
augroup END

" utility functions
function! FindUpwardInPath(absolutePath, pattern)
  let components = split(a:absolutePath, '\')

  let parent = components[0]
  for component in components[1: ]
    let parent = parent . '\' . component
    let file = expand(parent . '\' . a:pattern)
    if (filereadable(file))
      return file
    endif
  endfor

  echoerr "file matching pattern not found. pattern: " . pattern . " | path: " . absolutePath
endfunction

let initLocal = expand('<sfile>:h') . '/init.local.vim'
if (filereadable(initLocal))
  execute "source " . initLocal
endif

if has('win32') || has('win64')
  execute "source " . expand('<sfile>:h') . '/init.windows.vim'
else
  execute "source " . expand('<sfile>:h') . '/init.mac.vim'
endif
