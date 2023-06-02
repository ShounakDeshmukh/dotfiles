set nocompatible

colo catppuccin_mocha
filetype on
filetype plugin on
filetype indent on
syntax on
set relativenumber
set number
set shiftwidth=4
set tabstop=4
set expandtab
set termguicolors
set nobackup
set smartindent
set scrolloff=10
set noshowmode
set noruler
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set history=1000

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.


call plug#begin()
Plug 'dense-analysis/ale'
Plug 'valloric/youcompleteme'
Plug 'rust-lang/rust.vim'
call plug#end()

" ALE SETTINGS
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_completion_symbols = {
    \ 'text': '',
    \ 'method': '',
    \ 'function': '',
    \ 'constructor': '',
    \ 'field': '',
    \ 'variable': '',
    \ 'class': '',
    \ 'interface': '',
    \ 'module': '',
    \ 'property': '',
    \ 'unit': 'v',
    \ 'value': 'v',
    \ 'enum': 't',
    \ 'keyword': 'v',
    \ 'snippet': 'v',
    \ 'color': 'v',
    \ 'file': 'v',
    \ 'reference': 'v',
    \ 'folder': 'v',
    \ 'enum_member': 'm',
    \ 'constant': 'm',
    \ 'struct': 't',
    \ 'event': 'v',
    \ 'operator': 'f',
    \ 'type_parameter': 'p',
    \ '<default>': 'v'
    \ }

" RUST.vim settings

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor
" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{


set laststatus=2

set statusline=
set statusline+=\  
set statusline+=%1*
set statusline+=%{StatuslineMode()}
set statusline+=%4*
set statusline+=\ %n\ 
set statusline+=%3*
set statusline+=\ %F\ 
set statusline+=%m
set statusline+=%=
set statusline+=%h
set statusline+=%r
set statusline+=\ %Y\                  
set statusline+=%4*
set statusline+=\ [%l:%-2c\]    
set statusline+=\ %p%%\ 

hi User1 ctermbg=lightgreen ctermfg=black 
hi User2 ctermbg=black ctermfg=black 
hi User3 ctermbg=black ctermfg=white
hi User4 ctermbg=grey ctermfg=black




function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return " NORMAL "
  elseif l:mode==?"v"
    return " VISUAL "
  elseif l:mode==#"i"
    return " INSERT "
  elseif l:mode==#"R"
    return " REPLACE "
  elseif l:mode==?"s"
    return " SELECT "
  elseif l:mode==#"t"
    return " TERMINAL "
  elseif l:mode==#"c"
    return " COMMAND "
  elseif l:mode==#"!"
    return " SHELL "
  endif
endfunction
" }}}
