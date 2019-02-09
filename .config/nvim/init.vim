scriptencoding utf-8
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'dag/vim-fish'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'amix/vim-zenroom2'
"Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

  let g:tex_flavor = 'latex'
    set showmatch           " Show matching brackets.
    set number              " Show the line numbers on the left side.
    set formatoptions+=o    " Continue comment marker in new lines.
    set expandtab           " Insert spaces when TAB is pressed.
    set tabstop=2           " Render TABs using this many spaces.
    set shiftwidth=2        " Indentation amount for < and > commands.

    set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

    set autoindent
    set copyindent

    set smarttab

    set hlsearch            " Highlight search
    set incsearch           " Show search matches dynamically

    filetype plugin indent on " Auto indent
    filetype plugin on
" More natural splits
    set splitbelow          " Horizontal split below current.
    set splitright          " Vertical split to right of current.

    let mapleader=' '
    nnoremap ; :
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

" Map Q as format paragraph
    vmap Q qg
    nmap Q gqap

" Unmap arrow keys you idiot STOP USING THEM
    map <Up> <nop>
    map <Down> <nop>
    map <Left> <nop>
    map <Right> <nop>

" Reloadd VIMRC
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

    set pastetoggle=<F2>

    cmap w!! w !sudo tee % >/dev/null

    if !&scrolloff
        set scrolloff=3       " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
        set sidescrolloff=5   " Show next 5 columns while side-scrolling.
    endif
    set nostartofline       " Do not jump to first character with page commands.

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
    if &listchars ==# 'eol:$'
        set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    endif
    set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    match ExtraWhitespace /\s\+$\|\r/

    set ignorecase          " Make searching case insensitive
    set smartcase           " ... unless the query has capital letters.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.

" Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
    endif

" Search and Replace
    nmap <Leader>rr :%s//<Left>

    " Relative numbering
    function! NumberToggle()
      if(&relativenumber == 1)
        set norelativenumber
        set number
      else
        set relativenumber
      endif
    endfunc

" Toggle between normal and relative numbering.
    nnoremap <leader>n :call NumberToggle()<cr>

" Enable the list of buffers
    let g:airline#extensions#tabline#enabled = 1

" Show just the filename
    let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
    set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
    nmap <A-k> :enew<cr>
    "nmap <A-Up> :enew<cr>

" Move to the next buffer
    nmap <A-l> :bnext<CR>
    "nmap <A-Right> :bnext<CR>

" Move to the previous buffer
    nmap <A-h> :bprevious<CR>
    "nmap <A-Left> :bprevious<CR>

" Close the current buffer and move to the previous one
    nmap <A-j> bp <BAR> bd #<CR>
    "nmap <A-Down> bp <BAR> bd #<CR>

" Show all open buffers and their status
    nmap <leader>bl :ls<CR>

"ALE

"    let g:ale_completion_enabled = 1
    let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
"    let g:ale_keep_list_window_open = 1

"Airline
  let g:airline_powerline_fonts = 1
  let g:airline_theme='powerlineish'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

" unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''

" Change shell to bash
   if &shell =~# 'fish$'
       set shell=bash
   endif

 " Vimtex
    let g:vimtex_compiler_progname = 'nvr'

    " use <tab> for trigger completion and navigate to next complete item
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  " use <c-space>for trigger completion
    imap <c-c> coc#refresh{)

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    inoremap <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    silent! helptags ALL
