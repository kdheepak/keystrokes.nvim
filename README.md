# keystrokes.vim

Show keystrokes in vim.

This package is a proof of concept.

![](https://user-images.githubusercontent.com/1813121/85680593-adbe6e00-b687-11ea-8fce-2f84434f27c0.gif)

Add this plugin:

```
Plug 'kdheepak/keystrokes.nvim'
```

Start `vim` with the `-W` flag.

Example:

```
./build/bin/nvim -W ~/.config/keystrokes.txt src/nvim/main.c
```

This plugin provides a function that reads `~/.config/keystrokes.txt` and displays in a floating window.

If you add the following autocmd, it'll call the `:Keystrokes` command at your vim's checktime interval.

```
autocmd CursorHold <buffer> Keystrokes
```

You'll need to patch vim/neovim for this to work.

```
diff --git a/src/nvim/main.c b/src/nvim/main.c
index ae64046d0..71aed4cf8 100644
--- a/src/nvim/main.c
+++ b/src/nvim/main.c
@@ -1173,6 +1173,7 @@ scripterror:
               mch_errmsg("\"\n");
               os_exit(2);
             }
+            setvbuf(scriptout, NULL, _IONBF, 0);
             break;
           }
         }
```

In vim, you'll have to add it to this line:

https://github.com/vim/vim/blob/7acde51832f383f9a6d2e740cd0420b433ea841a/src/main.c#L2582

### References

See this gist for reference for the patch:

https://gist.github.com/kana/4202311
https://github.com/nelstrom/macvim/commit/c65e7e650b806682152681c58078d29cb1904bfe

See vimsplain:

https://github.com/pafcu/vimsplain

See vimprint for inspiration:

https://github.com/nelstrom/vimprint
http://vimcasts.org/blog/2013/05/vimprint---a-vim-keystroke-parser/
