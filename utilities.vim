" git helper functions
function! GAnnotate(...)
  if (a:0)
    let startLine = line('.') - a:0
    let endLine = line('.') + a:0
  else
    let startLine = 1
    let endLine = line('$')
  endif
  execute '! git annotate % -L ' . startLine . ',' . endLine
endfunction
command! -nargs=? GAnnotate :call GAnnotate(<args>)
