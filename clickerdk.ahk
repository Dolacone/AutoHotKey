Gui, Add, Text, x10 y10 w80 h40 vtext_log center, stopped
Gui, Add, Edit, x10 y30 w80 vdelay, 100
Gui, Add, Text, x10 y60, WheelUp to start
Gui, Add, Text, x10 y80, WheelDown to stop
Gui, Show, x360 y750 h110 w120, clicker
Gui, Submit, NoHide
Return

GuiClose:
ExitApp

logging(text){
  GuiControl, , text_log, %text%
}

Esc::
Reload
return

autoClick := false

WheelUp::
  global autoClick
  autoClick := true
  Gui, Submit, NoHide
  ;SendEvent {d down}
  while (autoClick = true){
    logging("clicking")
    Send {k down}
    sleep 50
    Send {k up}
    sleep %delay%
  }
  logging("stopped")
  return
  
WheelDown::
  global autoClick
  autoClick := false
  return
