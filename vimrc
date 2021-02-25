" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Sayan Nandy
 



"Plugin installs using plug
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer --system-libclang' }
Plug 'bling/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug 'gosukiwi/vim-atom-dark'
call plug#end()




"Some ycm-autocomplete settings
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py' 
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ycm_auto_trigger=1
let g:ycm_semantic_triggers = {
\'c' : ['->', '    ', '.', ' ', '(', '[', '&'],
\'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
\'perl' : ['->', '::', ' '],
\'php' : ['->', '::', '.'],
\'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
\'ruby' : ['.', '::'],
\'lua' : ['.', ':'],
\'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
\'html': ['<', '"', '</', ' '],
\'javascript': ['.', 're!(?=[a-zA-Z]{3,4})'],
\}








"Editor settings

"autocompletion in command mode
set wildmode=longest,list,full

"vertical splits
set splitbelow splitright

"Spell checking
set spelllang=en
set complete+=kspell
:set spellfile=~/.vim/spell/en.utf-8.add

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4


" Enhanced keyboard mappings
"
" in normal mode F2 will save the file
nmap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
imap <F2> <ESC>:w<CR>i
"F9 to compile and run C++
map <F9> :!g++ -g % -o %:r && ./%:r <CR>

"This was intended for bracket completion but for some reason doesn't work

let s:pairs={
            \'<': '>',
            \'{': '}',
            \'[': ']',
            \'(': ')',
            \'«': '»',
            \'„': '“',
            \'“': '”',
            \'‘': '’',
        \}
call map(copy(s:pairs), 'extend(s:pairs, {v:val : v:key}, "keep")')
function! InsertPair(left, ...)
    let rlist=reverse(map(split(a:left, '\zs'), 'get(s:pairs, v:val, v:val)'))
    let opts=get(a:000, 0, {})
    let start   = get(opts, 'start',   '')
    let lmiddle = get(opts, 'lmiddle', '')
    let rmiddle = get(opts, 'rmiddle', '')
    let end     = get(opts, 'end',     '')
    let prefix  = get(opts, 'prefix',  '')
    let start.=prefix
    let rmiddle.=prefix
    let left=start.a:left.lmiddle
    let right=rmiddle.join(rlist, '').end
    let moves=repeat("\<Left>", len(split(right, '\zs')))
    return left.right.moves
endfunction
 noremap! <expr> ,f   InsertPair('{')
 noremap! <expr> ,h   InsertPair('[')
 noremap! <expr> ,s   InsertPair('(')
 noremap! <expr> ,u   InsertPair('<')

 vnoremap <C-c> "*y
