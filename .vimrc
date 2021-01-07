"Vundls
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on

"Plugin
Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'ycm-core/YouCompleteMe'
highlight YcmErrorLine guibg=#3f0000
"Normal setting
set encoding=utf-8
syntax enable
set cursorline
hi CursorLine cterm=bold
hi CursorLineNr cterm=bold ctermfg=202 ctermbg=15
set nu
highlight LineNr term=bold cterm=NONE ctermfg=202 ctermbg=NONE gui=NONE guifg=White guibg=NONE
set smartcase
set hlsearch
hi Search cterm=reverse ctermbg=none ctermfg=none
set cursorline
set nowrap
set backspace=indent,eol,start

"狀態列
set laststatus=2
set statusline=[%{expand('%:p')}][%{strlen(&fenc)?&fenc:&enc},\ %{&ff},\ %{strlen(&filetype)?&filetype:'plain'}]%{FileSize()}%{IsBinary()}%=%c,%l/%L\ [%3p%%]
function IsBinary()
	if (&binary == 0)
		return ""
    else
        return "[Binary]"
    endif
endfunction
function FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return "[Empty]"
    endif
    if bytes < 1024
        return "[" . bytes . "B]"
    elseif bytes < 1048576
        return "[" . (bytes / 1024) . "KB]"
    else
        return "[" . (bytes / 1048576) . "MB]"
    endif
endfunction

"編碼
if has("multi_byte")

else
    echoerr "If +multi_byte is not included, you should compile Vim with big features."
endif
set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1

"縮排設定
set tabstop=4
set shiftwidth=4
set autoindent
set list listchars=tab:\┆\ ,trail:·

"Save
map <F5> :call SaveFile()<CR>
func! SaveFile()
	exec "w"
endfunc

"編譯執行
map <F6> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
	elseif &filetype == 'rust'
		exec "!rustc %<"
		exec "!./%<"
	elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
        exec "!time python3.6 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

"Rust
syntax enable
filetype plugin indent on

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

hi SpellBad ctermfg=196 ctermbg=15
hi SpellCap ctermfg=196 ctermbg=15

"YouCompleteMe
set completeopt-=preview
highlight Comment ctermfg=lightblue ctermbg=0 guifg=#ffffff guibg=#000000
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1