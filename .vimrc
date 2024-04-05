syntax on
set tabstop=4
set shiftwidth=2
set expandtab
set ai
set number
set hlsearch
set ruler
highlight Comment ctermfg=green

set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

if &term =~ "xterm"
    let &t_SI = "\<Esc>[2 q" . "\<Esc>]12;blue\x7"
    let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;blue\x7"
endif

augroup cursor_behaviour
      autocmd!

      " reset cursor on start:
      autocmd VimEnter * silent !echo -ne "\e[2 q"
      " cursor blinking bar on insert mode
      let &t_SI = "\e[2 q" . "\<Esc>]12;white\x7"
      " cursor steady block on command mode
      let &t_EI = "\e[2 q" . "\<Esc>]12;white\x7"
          
augroup END
