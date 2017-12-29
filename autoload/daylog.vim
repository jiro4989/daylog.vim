let s:save_cpo = &cpo
set cpo&vim

" #contents という文字列の箇所に、
" テキストファイルを解析して取得した目次文字列を貼り付ける
function! daylog#set_contents(alltext) " {{{
  let l:chs = ['目次', '====================']
  for i in range(0, len(a:alltext)-1)
    let l:sep = a:alltext[i]

    if l:sep =~ '^=\{3,}'
      let l:title = '- [' . a:alltext[i-1] . ']'

      " 勤務時間は目次に含めたくないので除外
      if a:alltext[i-1] !~ '^勤務時間'
        call add(l:chs, l:title)
      endif

      unlet l:title
    elseif l:sep =~ '^-\{3,}'
      let l:title = '  - [' . a:alltext[i-1] . ']'
      call add(l:chs, l:title)
      unlet l:title
    elseif l:sep =~ 'contents'
      let l:contents_index = i + 1
    endif

    unlet l:sep
  endfor

  if exists('l:contents_index')
    call append(l:contents_index, l:chs)
    exec l:contents_index . 'delete'
    unlet l:contents_index
  endif

  unlet l:chs
endfunction " }}}

" 外部ファイルからテンプレートを読み込んで、
" daylogsディレクトリ内に日付ファイルを新しく作成して書き込む
function! daylog#paste_template_text() " {{{
  let l:tmplFile = $HOME . "/dotfiles/template/daylog.md"

  " ファイル読み込み
  exec ':e ' . escape(l:tmplFile, ' ')
  let l:lastLineNo = line("$")
  let l:i = 0
  let l:list = []
  while l:i < l:lastLineNo
    let l:i = l:i + 1
    call add(l:list, getline(l:i))
  endwhile
  bdelete

  let l:daylogFile = $HOME . "/Documents/daylogs/" .  strftime('%Y%m%d.md')
  if filereadable(l:daylogFile)
    " すでにファイルが存在するときは特に変更せずに開く
    exec ':e ' . escape(l:daylogFile, ' ')
  else
    " 新しく日付ファイルを生成して書き込み
    exec ':e ' . escape(l:daylogFile, ' ')
    call append(1, l:list)
    exec '1delete'
    exec ':w'
  endif

  unlet l:daylogFile
  unlet l:tmplFile
  unlet l:i
  unlet l:list
  unlet l:lastLineNo
endfunction " }}}

let &cpo = s:save_cpo
unlet s:save_cpo
