#include identify.ahk
#include explore.ahk
#include repair.ahk
#include fight.ahk

configFile = config.ini

Gui, +AlwaysOnTop
Gui, Add, Text,   x0  y0 w170 vtext_status, stopped
Gui, Add, Text,   x0  y20 w170 vtext_debug, debug

Gui, Add, Text, x10 y50, 1
Gui, Add, Text, x10 y80, 2
Gui, Add, Text, x10 y110, 3
Gui, Add, Text, x10 y140, 4
Gui, Add, Text, x10 y170, Repair
Gui, Add, Text, x10 y200, Fight

Gui, Add, Checkbox, x30 y50  vchk_explore_1 
Gui, Add, Checkbox, x30 y80  vchk_explore_2
Gui, Add, Checkbox, x30 y110 vchk_explore_3
Gui, Add, Checkbox, x30 y140 vchk_explore_4
Gui, Add, Checkbox, x50 y170 vchk_repair
Gui, Add, Checkbox, x50 y200 vchk_fight

Gui, Add, DropDownList, x85 y200 h20 w30 vformation r5, 2||2|5

Gui, Add, Checkbox, x50 y230 vchk_fight_once
Gui, Add, Text, x85 y230, once

Gui, Add, Edit, x60 y50 w20 vexplore_1_chapter
Gui, Add, Edit, x60 y80 w20 vexplore_2_chapter
Gui, Add, Edit, x60 y110 w20 vexplore_3_chapter
Gui, Add, Edit, x60 y140 w20 vexplore_4_chapter

Gui, Add, Edit, x90 y50  w20 vexplore_1_section
Gui, Add, Edit, x90 y80 w20 vexplore_2_section
Gui, Add, Edit, x90 y110 w20 vexplore_3_section
Gui, Add, Edit, x90 y140 w20 vexplore_4_section

Gui, Add, Text, x10 y290, {WheelUp} = automation
Gui, Add, Text, x10 y320, {ESC} = reload

Gui, Show, x80 y150 h350 w130,Auto
Gui, Submit, NoHide
config_load()
Return

config_save(){
  Gui, Submit, NoHide
  configFile = config.ini
  
  loop, 4{
    enable  := chk_explore_%A_Index%
    chapter := explore_%A_Index%_chapter
    section := explore_%A_Index%_section
    IniWrite, %enable%,  %configFile%, unit%A_Index%, enable
    IniWrite, %chapter%, %configFile%, unit%A_Index%, chapter
    IniWrite, %section%, %configFile%, unit%A_Index%, section
  }
  GuiControlGet, chk_repair_flag,, chk_repair
  IniWrite, %chk_repair_flag%, %configFile%, repair, enable
  GuiControlGet, chk_fight_flag,, chk_fight
  IniWrite, %chk_fight_flag%, %configFile%, fight, enable
  GuiControlGet, formation_number,, formation
  IniWrite, %formation_number%, %configFile%, fight, formation
  GuiControlGet, chk_fight_once_flag,, chk_fight_once
  IniWrite, %chk_fight_once_flag%, %configFile%, fight, once 
  return
}
  
config_load(){
  configFile = config.ini
  loop, 4{
    IniRead, enable, %configFile%, unit%A_Index%, enable
    GuiControl, , chk_explore_%A_Index%, %enable%
    IniRead, chapter, %configFile%, unit%A_Index%, chapter
    GuiControl, , explore_%A_Index%_chapter, %chapter%
    IniRead, section, %configFile%, unit%A_Index%, section
    GuiControl, , explore_%A_Index%_section, %section%
  }
  IniRead, repair, %configFile%, repair, enable
  GuiControl, , chk_repair, %repair%
  IniRead, fight, %configFile%, fight, enable
  GuiControl, , chk_fight, %fight%
  IniRead, formation, %configFile%, fight, formation
  GuiControl, , formation, |%formation%||2|5
  IniRead, fight_once, %configFile%, fight, once
  GuiControl, , chk_fight_once, %fight_once%
  Gui, Submit, NoHide
  return
}

GuiClose:
  ExitApp

Escape::
  config_save()
  reload
  return

status(text){
  GuiControl, , text_status, %text%
}

debug(text){
  GuiControl, , text_debug, %text%
}

`::
  GuiControl, , chk_fight, 1
  Gui, Submit, NoHide
  return
  
z::
  if is_dangerous_in_prep(){
    msgbox aa
  }
  return

WheelUp::
  global autoClick
  autoClick := true
  config_save()
  
  while (autoClick == true){
    status("automation working")
    automation()
    sleep 2000
  }
  status("stopped")
  return
  
WheelDown::
  global autoClick
  autoClick := false
  return

automation(){    
  if explore_done(){
    log("explore done")
    
    ; collect explore result
    explore_result()
    
    ; set new explore
    Loop, 4{
      if (chk_explore_%A_Index% == 1){
        log("explore for team " A_Index)
        unitIndex := A_Index
        chapter := explore_%A_Index%_chapter
        section := explore_%A_Index%_section
        explore_set(unitIndex, chapter, section)
      }
    }
    
    ; repair
    GuiControlGet, chk_repair_flag,, chk_repair
    if (chk_repair_flag == 1){
      repair_auto()
    }
  }
  
  GuiControlGet, chk_fight_flag,, chk_fight
  if (chk_fight_flag == 1){
    if is_fight_refill_page(){
      fight_auto_half()
    }else{
      fight_auto()
    }
  }
}

log(logString){
  FileAppend, %logString%`n, log.txt
}

logColor(description, posX, posY){
  PixelGetColor, color, posX, posY
  logString := description " @ " posX "," posY " = " color "`n"
  FileAppend, %logString%, log.txt
}