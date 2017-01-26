page_dock_btn_posX = 720
page_dock_btn_posY = 362
page_dock_btn_color = 0xB8B8B8
tab_repair_btn_posX = 15
tab_repair_btn_posY =160
tab_repair_btn_color_active = 0x0051C4
tab_repair_loaded_posX = 290
tab_repair_loaded_posY = 95
tab_repair_loaded_color = 0xB16E05

page_repair_selectUnit_loaded_posX = 200
page_repair_selectUnit_loaded_posY = 80
page_repair_selectUnit_loaded_color = 0xE0B204

repair_selectUnit_1_posX = 68
repair_selectUnit_1_posY = 152
repair_selectUnit_1_color_exist = 0xCDCDCD
repair_selectUnit_2_posX = 267
repair_selectUnit_2_posY = 471
repair_selectUnit_2_color_exist = 0xC1CCD3

repair_slot_1_posX = 257
repair_slot_1_posY = 198
repair_slot_1_color = 0xFFFFFF
repair_slot_2_posX = 257
repair_slot_2_posY = 311
repair_slot_2_color = 0xFFFFFF

repair_auto(){
  open_page_dock()
  open_repair_tab()
  Loop, 2{
    if repair_isReady(A_Index){
      repair_set(A_Index)
      sleep, 1000
    }
  }
  dock_end()
}

;;;;

open_page_dock(){
  log("open_page_dock")
  global page_dock_btn_posX, page_dock_btn_posY, page_dock_btn_color
  
  if isColorMatch(page_dock_btn_posX, page_dock_btn_posY, page_dock_btn_color){
    MouseClick, left, page_dock_btn_posX, page_dock_btn_posY
    waitPageSelection()
  }else{
    log("not ready: page_dock_btn")
  }
}

open_repair_tab(){
  log("open_repair_tab")
  global tab_repair_btn_posX, tab_repair_btn_posY
  global tab_repair_loaded_posX, tab_repair_loaded_posY, tab_repair_loaded_color
  MouseClick, left, tab_repair_btn_posX, tab_repair_btn_posY
  waitColor(tab_repair_loaded_posX, tab_repair_loaded_posY, tab_repair_loaded_color)
  sleep, 500
}

repair_isReady(index){
  log("repair_isReady - " index)
  posX := repair_slot_%index%_posX
  posY := repair_slot_%index%_posY
  color := repair_slot_%index%_color
  if isColorMatch(posX, posY, color){
    log("true")
    return true
  }
  return false
}

repair_set(index){
  log("repair_set - " index)
  global page_repair_selectUnit_loaded_posX, page_repair_selectUnit_loaded_posY, page_repair_selectUnit_loaded_color
  global repair_selectUnit_1_posX, repair_selectUnit_1_posY, repair_selectUnit_1_color_exist
  global repair_selectUnit_2_posX, repair_selectUnit_2_posY, repair_selectUnit_2_color_exist
  posX := repair_slot_%index%_posX
  posY := repair_slot_%index%_posY
  color := repair_slot_%index%_color
  
  MouseClick, left, posX, posY
  waitColor(page_repair_selectUnit_loaded_posX, page_repair_selectUnit_loaded_posY, page_repair_selectUnit_loaded_color)
  sleep, 1000
  ; stop auto repair if no more
  if isNotColorMatch(repair_selectUnit_2_posX, repair_selectUnit_2_posY, repair_selectUnit_2_color_exist){
    GuiControl, , chk_repair, 0
    Gui, Submit, NoHide
  }
  ; select first unit
  MouseClick, left, repair_selectUnit_1_posX, repair_selectUnit_1_posY
}

dock_end(){
  waitPageSelection()
  MouseClick, left, 50, 600
  waitPageHome()
  return
}
