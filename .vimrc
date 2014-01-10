filetype plugin on

set runtimepath+=/home/emeric/.vim/vam
set runtimepath+=/home/emeric/.vim/mySnippet

let mapleader = ","

let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': ['scala'] }
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=2
let g:syntastic_quiet_warning=1
fun SetupVAM()


  let g:vim_addon_manager = {}
  let g:vim_addon_manager.plugin_sources = {}


  let g:vim_addon_manager.plugin_sources['self'] = {'type': 'git', 'url': 'https://github.com/megaannum/self.git'}
  let g:vim_addon_manager.plugin_sources['forms'] = {'type': 'git', 'url': 'https://github.com/megaannum/forms.git'}
  let g:vim_addon_manager.plugin_sources['vimproc'] = {'type': 'git', 'url': 'https://github.com/Shougo/vimproc.git'}
  let g:vim_addon_manager.plugin_sources['vimshell'] = {'type': 'git', 'url': 'https://github.com/Shougo/vimshell.git'}
  let g:vim_addon_manager.plugin_sources['ensime'] = {"type": "git", "url": "https://github.com/aemoncannon/ensime.git", "branch" : "scala-2.10"}
  let g:vim_addon_manager.plugin_sources['vimside'] = {'type': 'git', 'url': 'https://github.com/megaannum/vimside.git'}
  let g:vim_addon_manager.plugin_sources['ghcmod-vim'] = {'type': 'git', 'url': 'https://github.com/eagletmt/ghcmod-vim.git'}
  let g:vim_addon_manager.plugin_sources['agda-vim'] = {'type': 'git', 'url': 'https://github.com/derekelkins/agda-vim.git'}

  let plugins = [
    \  'molokai'
    \ ,'vim-airline'
    \ ,'The_NERD_tree'
    \ ,'snipmate'
    \ ,'vim-snippets'
    \ ,'fugitive'
    \ ,'DrawIt'
    \ ,'surround'
    \ ,'Syntastic'
    \ ,'vimproc'
    \ ,'ghcmod-vim'
    \ ,'HaskellMode'
    \ ,'Solarized'
    \ ,'Color_Sampler_Pack'
    \ ,'Align%294'
    \ ,'agda-vim'
    \ ]

  let unusedplugins = [
    \ 'self'
    \ ,'forms'
    \ ,'vimshell'
    \ ,'ensime'
    \ ,'vimside'
    \ ,'LustyExplorer'
    \ ,'Markdown_syntax'
    \ ]

  call vam#ActivateAddons(plugins,{'auto_install' : 0})


endf

call SetupVAM()

set hidden
"autocmd needed due to vam usage
autocmd VimEnter *.hs,*,*.lhs,*.chs,*.hsc colorscheme molokai
autocmd VimEnter *.scala colorscheme molokai

"text tag custo
au Bufenter *.txt set concealcursor=n
au Bufenter *.txt set conceallevel=1
au Bufenter *.txt syntax match SpanEnd "</span>" conceal
au Bufenter *.txt syntax match SpanSta "<span.\{-}>" conceal cchar=T
"au Bufenter *.txt let b:surround_106 = "<span itemtype='tag' itemprop=''>\r</span>}"

"encodings
set fileencodings=ucs-bom,utf-8,sjis,default,latin-1

"for airline display always
set laststatus=2
set noshowmode
set guifont=Deja\ Vu\ Sans\ Mono\ for\ Powerline
let g:airline_powerline_fonts=1

"haskell tabs
au Bufenter *.hs,*,*.lhs,*.chs,*.hsc set expandtab
au Bufenter *.hs,*,*.lhs,*.chs,*.hsc set tabstop=2
"haskell align
" p0P1Wlg ^.*,.* , p1P0Wlg ^.*[.* [
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc AlignCtrl p1P1Wl:g ^.*=.* =
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :vnoremap aa :Align = <CR>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :vnoremap a( :Align! p1P0Wl:g ^.*(.* ( <CR>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :vnoremap at :Align! p0P1Wl:g * , [ <CR>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :vnoremap A( :Align! p1P0Wlg ^.*(.* ( <CR>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :vnoremap At :Align! p0P1Wlg * , [ <CR>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :setlocal autoindent
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let maplocalleader = ","
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let b:ghc_staticoptions = '-package-db=.cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d/'
let g:syntastic_haskell_ghc_mod_args = '-g -package-db=.cabal-sandbox/x86_64-linux-ghc-7.6.3-packages.conf.d/'
"au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let g:ghcmod_ghc_options = ['-package-db=cabal-dev/packages-7.6.3.conf']
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc compiler ghc
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc,*txt iabbrev » ->
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc,*txt iabbrev « <-

"Haskell surround comment 99 is char2nr("c") h ascii 104
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let b:surround_99 = "{- \r -}"
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let b:surround_104 = "{- | \r -}"
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let b:surround_40 = "(\r)"

"au Bufenter *.hs setlocal path += 'cabal-dev/bin'
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc setlocal foldmethod=marker
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :nn <LocalLeader>g <C-]>
au Bufenter *.scala :nn <LocalLeader>g <C-]>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :nn <F2> :w<cr>:call GHC_CreateTagfile()<cr>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :nn <F3> :w<cr>:!make<RETURN>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :nn <F4> :w<cr>:make<RETURN>:cwindow<RETURN>
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :inoremap <C-e> <C-X><C-U>

let g:haddock_browser="uzbl-browser"
let g:haddock_indexfiledir="/home/emeric/.vim/indexhaddock/"
if !has("gui_running")
  let g:haddock_browser_callformat = '%s %s &'
endif
 
"launch manually haddock_doc
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc :source /home/emeric/.vim/HaskellMode/ftplugin/haskell_doc.vim
au Bufenter *.hs,*,*,*.lhs,*.chs,*.hsc let g:haddock_launched="ok"

set wildmenu
set wildmode=list:longest,full
set mouse=a
colorscheme desert

set encoding=utf-8
set fileencoding=utf-8


:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

:syntax enable
"Nul is for terminal ctr space
inoremap <Nul> <C-X><C-O>
inoremap <C-Space> <C-X><C-O>

" {W} -> [É]
" 
" On remappe W sur É :
noremap é w
noremap É W
" Corollaire, pour effacer/remplacer un mot quand on nest pas au début (daé / laé).
" (attention, cela diminue la réactivité du {A})
"noremap aé aw
"noremap aÉ aW
" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
noremap w <C-w>
noremap W <C-w><C-w>

" [HJKL] -> {CTSR}
" 
" {cr} = « gauche / droite »
noremap c h
noremap r l
" {ts} = « haut / bas »
noremap t j
noremap s k
" {CR} = « haut / bas de l'écran »
noremap C H
noremap R L
" {TS} = « joindre / aide »
noremap T J
noremap S K
" Corollaire : repli suivant / précédent
noremap zs zj
noremap zt zk

" {HJKL} <- [CTSR]
" 
" {J} = « Jusqu'à »            (j = suivant, J = précédant)
noremap j t
noremap J T
" {L} = « Change »             (h = bloc, H = jusqu'à la fin de ligne)
noremap l c
noremap L C
" {H} = « Remplace »           (l = caractère, L = texte)
noremap h r
noremap H R
" {K} = « Substitue »          (k = caractère, K = ligne)
noremap k s
noremap K S
" Corollaire : correction orthographique
noremap ]k ]s
noremap [k [s

" Désambiguation de {g}
" 
" ligne écran précédente / suivante (à l'intérieur d'une phrase)
noremap gs gk
noremap gt gj
" onglet précédant / suivant
noremap gb gT
noremap gé gt
" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" optionnel : {g"} pour aller au début de la ligne écran
noremap g" g0
" map x buffer
noremap P "+p
noremap Y "+y

" <> en direct
" 
noremap « <
noremap » >
vmap <Tab> >gv
vmap <S-Tab> <gv
snoremap c c
snoremap r r
snoremap s s
snoremap t t
snoremap C C
snoremap R R
snoremap S S
snoremap T T 
snoremap h h 
snoremap H H

" surround plugin 'autocmd' for unmap after plugin launch
autocmd VimEnter * nunmap cs
autocmd VimEnter * nmap gs <Plug>Csurround
