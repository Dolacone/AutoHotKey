﻿#include home.ahk
#include battle.ahk

Gui, +AlwaysOnTop
Gui, Add, Text,   x0  y0 w170 vtext_status, stopped
Gui, Add, Text,   x0  y20 w170 vtext_debug, debug

Gui, Add, Text, x10 y320, {WheelUp} = automation
Gui, Add, Text, x10 y350, {ESC} = reload

Gui, Show, x80 y150 h380 w140,Auto
Gui, Submit, NoHide
Return

GuiClose:
  ExitApp

Escape::
WheelDown::
  reload
  return

status(text){
  GuiControl, , text_status, %text%
}

debug(text){
  GuiControl, , text_debug, %text%
}

WheelUp::
  WinActivate 夜神模擬器
  status("automation start")
  while (true){
    automation()
    sleep 1000
  }
  return

automation(){
    if is_home(){
        status("is_home")
        home_join_battle()
    }
  
    if is_finding_battle(){
        status("is_finding_battle")
        battle_join_battle()
    }
  
    if is_in_battle(){
        status("is_in_battle")
        battle_loop()
        ;battle_use_skills()
    }
  
    if is_in_result(){
        status("is_in_result")
        battle_end_result()
    }
    return
}

is_color_match(posX, posY, expectedColor){
  PixelGetColor, color, posX, posY
  if (color == expectedColor){
    return true
  }else{
    return false
  }
}

is_not_color_match(posX, posY, expectedColor){
  PixelGetColor, color, posX, posY
  if (color == expectedColor){
    return false
  }else{
    return true
  }
}

wait_color(posX, posY, expectedColor){
  while is_not_color_match(posX, posY, expectedColor){
  }
  sleep, 300
  return true
}

wait_not_color(posX, posY, expectedColor){
  while (is_color_match(posX, posY, expectedColor)){
  }
  sleep, 300
  return true
}

log(logString){
  FileAppend, %logString%`n, log.txt
}

logColor(description, posX, posY){
  PixelGetColor, color, posX, posY
  logString := description " @ " posX "," posY " = " color "`n"
  FileAppend, %logString%, log.txt
}