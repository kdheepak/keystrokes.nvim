# Cast keystrokes in vim

You'll need to add this line to neovim.

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

See this gist for reference.

https://gist.github.com/kana/4202311

