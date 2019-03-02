scriptencoding utf-8
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'dag/vim-fish'
Plug 'michaeljsmith/vim-indent-object'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
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

    set mouse=a

    set noshowmode

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

    let g:ale_completion_enabled = 1
    let g:ale_open_list = 1
" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
"    let g:ale_keep_list_window_open = 1

" Change shell to bash
   if &shell =~# 'fish$'
       set shell=bash
   endif

 " Vimtex
    let g:vimtex_compiler_progname = 'nvr'

" if hidden not set, TextEdit might fail.
  set hidden

" Better display for messages
  "set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
  set updatetime=300

" don't give |ins-completion-menu| messages.
  set shortmess+=c

" always show signcolumns
  set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype ==? 'vim'
     execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

" Highlight symbol under cursor on CursorHold
  augroup autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
  vmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
  " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  vmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
  let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
" Vim Cpp Highlighting
  let g:cpp_class_scope_highlight = 1
  let g:cpp_member_variable_highlight = 1
  let g:cpp_class_decl_highlight = 1
  let g:cpp_experimental_simple_template_highlight = 1
  let g:cpp_concepts_highlight = 1

    silent! helptags ALL
