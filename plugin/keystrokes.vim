scriptencoding utf-8

if exists('g:loaded_keystrokes_vim') | finish | endif

let s:save_cpo = &cpoptions
set cpoptions&vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:keystrokes_floating_window_winblend')
    let g:keystrokes_floating_window_winblend = 0
endif

if !exists('g:keystrokes_floating_window_scaling_factor')
  let g:keystrokes_floating_window_scaling_factor = 0.9
endif

command! Keystrokes lua require'keystrokes'.keystrokes()

""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &cpoptions = s:save_cpo
unlet s:save_cpo

let g:loaded_keystrokes_vim = 1
