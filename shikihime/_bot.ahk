#include home.ahk
#include battle.ahk

Gui, +AlwaysOnTop
Gui, Add, Text,   x0  y0 w170 vtext_status, stopped
Gui, Add, Text,   x0  y20 w170 vtext_debug, debug

Gui, Add, Text,     x10 y70, Unit1
Gui, Add, Checkbox, x45 y70 vchk_skill_1 checked
Gui, Add, Checkbox, x80 y70 vchk_skill_2 checked
Gui, Add, Checkbox, x115 y70 vchk_skill_3 checked

Gui, Add, Text,     x10 y100, Unit2
Gui, Add, Checkbox, x45 y100 vchk_skill_4 checked
Gui, Add, Checkbox, x80 y100 vchk_skill_5 checked
Gui, Add, Checkbox, x115 y100 vchk_skill_6 checked

Gui, Add, Text,     x10 y130, Unit3
Gui, Add, Checkbox, x45 y130 vchk_skill_7 checked
Gui, Add, Checkbox, x80 y130 vchk_skill_8 checked
Gui, Add, Checkbox, x115 y130 vchk_skill_9 checked

Gui, Add, Text, x10 y160, Wait
Gui, Add, Edit, x50 y160 w80 vcd_time, 1800

Gui, Add, Text, x10 y190, Wait enemy
Gui, Add, Checkbox, x90 y190 vwait_enemy_action

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
  
1::trigger_checkbox_skill(1)
2::trigger_checkbox_skill(2)
3::trigger_checkbox_skill(3)
4::trigger_checkbox_skill(4)
5::trigger_checkbox_skill(5)
6::trigger_checkbox_skill(6)
7::trigger_checkbox_skill(7)
8::trigger_checkbox_skill(8)
9::trigger_checkbox_skill(9)
  
trigger_checkbox_skill(index){
    GuiControlGet, flag_skill, , chk_skill_%index%
    if(flag_skill){
        GuiControl, , chk_skill_%index%, 0
    }else{
        GuiControl, , chk_skill_%index%, 1
    }
    Gui, Submit, NoHide
}

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