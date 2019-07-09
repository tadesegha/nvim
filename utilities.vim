" git helper functions
function! GitBlame(range)
  let startLine = line('.') - a:range
  let endLine = line('.') + a:range
  execute '! git annotate % -L ' . startLine . ',' . endLine
endfunction
command! -nargs=1 GitBlame :call GitBlame(<args>)
