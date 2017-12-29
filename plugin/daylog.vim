" Vim plugin for writing daylog note.
" Last Change: 2017 Dec 29
" Maintainer:  Jiro <jiroron666@gmail.com>
" License:     This file is placed in the public domain.

scriptencoding utf-8

if exists('g:loaded_daylog')
  finish
endif
let g:loaded_daylog = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists(":SetContents")
  command! -nargs=0 SetContents call daylog#set_contents(getline(0, line('$')))
  nnoremap <Leader>dc :SetContents<CR>
endif

if !exists(":PasteTemplateText")
  command! -nargs=0 PasteTemplateText call daylog#paste_template_text()
  nnoremap <Leader>dp :PasteTemplateText<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
