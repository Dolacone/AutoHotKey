#include identify.ahk
#include explore.ahk
#include repair.ahk
#include fight.ahk
#include practice.ahk
#include campaign.ahk

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

Gui, Add, DropDownList, x85 y170 h20 w30 vteam r5, 1||1|2|3|4
Gui, Add, DropDownList, x85 y200 h20 w30 vformation r5, 2||2|5

Gui, Add, Text, x10 y230, Night
Gui, Add, DropDownList, x50 y230 h20 w70 vnight_fight r5, no||no|force|last

Gui, Add, Checkbox, x50 y260 vchk_fight_once
Gui, Add, Text, x85 y260, one step

Gui, Add, Button, x5 y285 gset_fight_event_stage_pos, Event
Gui, Add, Checkbox, x50 y290 vchk_fight_event
Gui, Add, Edit, x85 y290 w50 vfight_event_stage_pos

Gui, Add, Edit, x60 y50 w20 vexplore_1_chapter
Gui, Add, Edit, x60 y80 w20 vexplore_2_chapter
Gui, Add, Edit, x60 y110 w20 vexplore_3_chapter
Gui, Add, Edit, x60 y140 w20 vexplore_4_chapter

Gui, Add, Edit, x90 y50  w20 vexplore_1_section
Gui, Add, Edit, x90 y80 w20 vexplore_2_section
Gui, Add, Edit, x90 y110 w20 vexplore_3_section
Gui, Add, Edit, x90 y140 w20 vexplore_4_section

Gui, Add, Text, x10 y320, {WheelUp} = automation
Gui, Add, Text, x10 y350, {ESC} = reload

Gui, Show, x80 y150 h380 w140,Auto
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
  GuiControlGet, team_number,, team
  IniWrite, %team_number%, %configFile%, fight, team
  GuiControlGet, formation_number,, formation
  IniWrite, %formation_number%, %configFile%, fight, formation
  GuiControlGet, night_fight_mode,, night_fight
  IniWrite, %night_fight_mode%, %configFile%, fight, night_fight
  GuiControlGet, chk_fight_once_flag,, chk_fight_once
  IniWrite, %chk_fight_once_flag%, %configFile%, fight, once 
  GuiControlGet, chk_fight_event_flag,, chk_fight_event
  IniWrite, %chk_fight_event_flag%, %configFile%, fight, event
  GuiControlGet, event_pos,, fight_event_stage_pos
  IniWrite, %event_pos%, %configFile%, fight, pos
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
  IniRead, team, %configFile%, fight, team
  GuiControl, , team, |%team%||1|2|3|4
  IniRead, formation, %configFile%, fight, formation
  GuiControl, , formation, |%formation%||2|5
  IniRead, night_fight_mode, %configFile%, fight, night_fight
  GuiControl, , night_fight, |%night_fight_mode%||no|force|last
  IniRead, fight_once, %configFile%, fight, once
  GuiControl, , chk_fight_once, %fight_once%
  IniRead, fight_event, %configFile%, fight, event
  GuiControl, , chk_fight_event, %fight_event%
  IniRead, event_pos, %configFile%, fight, pos
  GuiControl, , fight_event_stage_pos, %event_pos%
  Gui, Submit, NoHide
  return
}

GuiClose:
  ExitApp

Escape::
WheelDown::
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
  fight_result()
  return

WheelUp::
  WinActivate 戦艦少女R
  start_auto_fight()
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
    if is_practice_page(){
      practice_auto()
    }
    if is_campaign_page(){
      campaign_auto()
    }
    if is_fight_refill_page(){
      fight_auto()
    }else{
      fight_auto_select()
    }
  }
}

set_fight_event_stage_pos(){
  WinActivate 戦艦少女R
  debug("R Click to set pos")
  KeyWait, LButton, D
  MouseGetPos, x, y
  string = %x%,%y%
  GuiControl, , fight_event_stage_pos, %string%
  Gui, Submit, NoHide
}

log(logString){
  FileAppend, %logString%`n, log.txt
}

logColor(description, posX, posY){
  PixelGetColor, color, posX, posY
  logString := description " @ " posX "," posY " = " color "`n"
  FileAppend, %logString%, log.txt
}