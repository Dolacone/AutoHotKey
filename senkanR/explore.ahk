section_1_posX = 762
section_1_posY = 119
section_1_color_ready = 0xE8C03B
section_1_color_complete = 0x1F73DA
section_2_posX = 762
section_2_posY = 231
section_2_color_ready = 0xE9C13C
section_2_color_complete = 0x1F73DA
section_3_posX = 762
section_3_posY = 344
section_3_color_ready = 0xE8C03B
section_3_color_complete = 0x1F73DA
section_4_posX = 762
section_4_posY = 456
section_4_color_ready = 0xE9C13C
section_4_color_complete = 0x1F73DA
team_1_posX = 370
team_1_posY = 415
team_2_posX = 465
team_2_posY = 415
team_3_posX = 560
team_3_posY = 415
team_4_posX = 655
team_4_posY = 415
team_selected = 0x2174D9
team_standby  = 0xF0CA42
explore_go = 0x0591F2

explore_done(){
  if isColorMatch(725, 176, 0xFFFFFF){
    return true
  }else{
    return false
  }
}

explore_prep(){
  log("explore_prep")
  MouseClick, left, 725, 176
  waitPageSelection()
  ; change to explore tab
  MouseClick, left, 8, 227
  sleep, 1000
  return
}

explore_end(){
  waitPageSelection()
  MouseClick, left, 50, 600
  waitColor(820, 55, 0xF7EEB2)
  return
}

explore_result(){
  log("explore_result")
  explore_prep()
  section := explore_get_done_section()
  explore_result_collect(section)
  explore_end()
  log("explore_result done")
}

; set unit to explore
explore_set(team, chapter, section){
  log("explore_set")
  explore_prep()
  explore_select_chapter(chapter)
  if explore_section_isReady(section){
    explore_select_section(section)
    explore_select_team(team)
    explore_end()
  }else{
    explore_end()
  }
  log("explore_set done")
}

;;;;;;;;;;

; get the section of which explore is done
explore_get_done_section(){
  Loop, 4{
    if explore_section_isComplete(A_Index){
      log("section: " A_Index " complete")
      return %A_Index%
    }
  }
  return false
}

explore_section_isComplete(section){
  log("explore_section_isComplete - " section)
  posX := section_%section%_posX
  posY := section_%section%_posY
  color_complete := section_%section%_color_complete
  logColor("section " section, posX, posY)
  if isColorMatch(posX, posY, color_complete){
    return true
  }
  return false
}

explore_section_isReady(section){
  posX := section_%section%_posX
  posY := section_%section%_posY
  color_ready := section_%section%_color_ready
  if isColorMatch(posX, posY, color_ready){
    return true
  }
    log("section " chapter "-" section " not ready (" color_ready ")")
    logColor("current color:", posX, posY)
  return false
}

explore_result_collect(section){
  log("explore_result_collect @ " section)
  posX := section_%section%_posX
  posY := section_%section%_posY

  if explore_section_isComplete(section){
    MouseClick, left, posX, posY
    ; wait for "next" text
    waitColor(857, 565, 0xFFFFFF)
    MouseClick, left, posX, posY
    waitPageSelection()
  }else{
    log("section " section " (" posX "," posY ") is not completed")
  }  
}

explore_select_chapter(chapter){
  log("explore_select_chapter")
  reset_chapter()
  counter := 1
  while (counter < chapter){
    MouseClick, left, 910, 570
    counter := counter + 1
    sleep, 500
  }
}

reset_chapter(){
  log("reset_chapter")
  previousColor = 0x000000
  while(isNotColorMatch(320, 565, previousColor)){
    PixelGetColor, previousColor, 320, 565
    MouseClick, left, 185, 570
    sleep, 500
  }
}

explore_select_section(section){
  log("explore_select_section")
  posX := section_%section%_posX
  posY := section_%section%_posY
  MouseClick, left, posX, posY
}

explore_select_team(team){
  log("explore_select_team")
  global team_selected
  global team_standby
  global explore_go
  ; wait for team loading page
  waitColor(190, 90, 0xAB6905)
  posX := team_%team%_posX
  posY := team_%team%_posY
  MouseClick, left, posX, posY
  sleep, 2000
  MouseClick, left, 480, 570
  waitPageSelection()
  sleep, 500
}