
" Common
set hidden
set mouse=a
set nobackup
set number
set scrolloff=15
set smartcase ignorecase hlsearch
set splitbelow splitright
set termguicolors
set undofile
set visualbell
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*.db,*.sqlite,*.class,*/node_modules/*,*/.git/*

set expandtab
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4


let mapleader=" "

" Clear highlight
map <leader>/ :noh<cr>


" Ctrl + hjkl - in insert to move between characters
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Ctrl + hjkl - in normal mode to move betwen splits,
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" q to quit, Q to record macro
nnoremap Q q
nnoremap q :q<cr>

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Keys < and > are way too convenient to be waisted for identation, remap to
" switch tabs instead
nnoremap > gt
nnoremap < gT
" Preserve visual highlighting when changing identation
vnoremap < <gv
vnoremap > >gv

" Shift + HJKL are way too convenient to be waisted on these keys. They
" are left unmapped so user could choose himself whats best for him
nnoremap <leader>h H
nnoremap <leader>j J
nnoremap <leader>k K
nnoremap <leader>l L
nnoremap H <nop>
nnoremap J <nop>
nnoremap K <nop>
nnoremap L <nop>

" Make Y consistent with commands like D,C
nmap Y y$

" Ctrl+C/Ctrl+V to copy/paste to/from system clipboard
nmap <C-C> "+yy
vmap <C-C> "+y
imap <C-V> <Esc>"+pa

" Ctrl+S to save
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>a

" Ctrl+Backspace to delete previous word. https://vi.stackexchange.com/questions/16139/s-bs-and-c-bs-mappings-not-working
imap <C-BS> <C-W>

" Back to normal mode on focus lost 
autocmd FocusLost * stopinsert | wall!

" Preserve cursor location https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
set viminfo='10,\"100,:20,%,n~/.viminfo
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

if has("folding")
  function! UnfoldCur()
    if !&foldenable
      return
    endif
    let cl = line(".")
    if cl <= 1
      return
    endif
    let cf  = foldlevel(cl)
    let uf  = foldlevel(cl - 1)
    let min = (cf > uf ? uf : cf)
    if min
      execute "normal!" min . "zo"
      return 1
    endif
  endfunction
endif

augroup resCur
  autocmd!
  if has("folding")
    autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
  else
    autocmd BufWinEnter * call ResCur()
  endif
augroup END
