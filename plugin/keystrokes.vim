
scriptencoding utf-8

if exists('g:loaded_monitorkeystroke_vim') | finish | endif

let s:save_cpo = &cpoptions
set cpoptions&vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:monitorkeystroke_floating_window_winblend')
    let g:monitorkeystroke_floating_window_winblend = 0
endif

if !exists('g:monitorkeystroke_floating_window_scaling_factor')
  let g:monitorkeystroke_floating_window_scaling_factor = 0.9
endif

command! MonitorKeystroke lua require'monitorkeystroke'.monitorkeystroke()

""""""""""""""""""""""""""""""""""""""""""""""""""""""

let &cpoptions = s:save_cpo
unlet s:save_cpo

let g:loaded_monitorkeystroke_vim = 1
