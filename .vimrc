"Vundls
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
call vundle#end()
filetype plugin indent on

"Plugin
Plugin 'rust-lang/rust.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'

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
set backspace=indent,eol,start

"Status line
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

"Encoding
if has("multi_byte")

else
    echoerr "If +multi_byte is not included, you should compile Vim with big features."
endif
set fileencodings=utf-8,utf-16,big5,gb2312,gbk,gb18030,euc-jp,euc-kr,latin1

"Indent
set tabstop=4
set shiftwidth=4
set autoindent
set list listchars=tab:\┆\ ,trail:·


"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Error
hi SpellBad ctermfg=196 ctermbg=15

"Warning
hi SpellCap ctermfg=192 ctermbg=16

" move line up/down
set shiftwidth=4

" move cursor faster
map <C-k>  5gk
map <C-j>  5gj
map <C-UP> 5gk
map <C-DOWN> 5gj

"Save
map <F5> :call SaveFile()<CR>
func! SaveFile()
	exec "w"
endfunc

"Compile
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
		exec "!cargo build"
		exec "!cargo run"
	elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	elseif &filetype == 'lex'
		exec "!sh start.sh"
	endif
endfunc

"Rust
syntax enable
filetype plugin indent on

" YouCompleteMe
let g:ycm_confirm_extra_conf=0
let g:ycm_python_binary_path='/usr/bin/python'