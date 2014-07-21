set solib-absolute-prefix /home/mamk/ssd/workcode/BrowserShell/platform/android/obj/local/armeabi
set solib-search-path /home/mamk/ssd/workcode/BrowserShell/platform/android/obj/local/armeabi
handle SIGHUP nostop pass noprint
define gobt  
  set logging file .gdb.btt  
  set logging overwrite on  
  set logging redirect on  
  set logging on  
  bt  
  set logging off  
  shell echo \#Local Variables: \# >>  .gdb.btt  
  shell echo \#mode: compilation \# >>  .gdb.btt  
  shell echo \#End: \# >>  .gdb.btt  
  shell emacsclient -n .gdb.btt  
end 

file ~/gdb/app_process
target remote:5039
