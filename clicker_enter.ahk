Gui, +AlwaysOnTop
Gui, Add, Text, x10 y10 w80 h40 vtext_log center, stopped
Gui, Add, Edit, x10 y30 w80 vdelay, 1000
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

autoClick := false

WheelUp::
  global autoClick
  autoClick := true
  Gui, Submit, NoHide
  while (autoClick = true){
    timeCount := 0
    SendInput {Enter}
    sleep 200
    SendInput {Enter}
    while (timeCount < (delay/1000)){
      logging(timeCount)
      timeCount := timeCount + 1
      sleep 1000
    }
  }
  logging("stopped")
  return
  
WheelDown::
  global autoClick
  autoClick := false
  return
