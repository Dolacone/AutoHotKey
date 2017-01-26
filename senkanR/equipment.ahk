equipment_slot_1_posX = 575
equipment_slot_1_posY = 235
equipment_slot_1_color_drop = 0x6AD728
equipment_slot_2_posX = 687
equipment_slot_2_posY = 235
equipment_slot_2_color_drop = 0x5EC824
equipment_slot_3_posX = 800
equipment_slot_3_posY = 235
equipment_slot_3_color_drop = 0x6AD728
equipment_slot_4_posX = 912
equipment_slot_4_posY = 235
equipment_slot_4_color_drop = 0x5EC824

equipment_page_ready_posX = 416
equipment_page_ready_posY = 520
equipment_page_ready_color = 0xCCCCCC

equipment_remove(){
  global equipment_page_ready_posX, equipment_page_ready_posY, equipment_page_ready_color
  Loop, 4{
    posX := equipment_slot_%A_Index%_posX
    posY := equipment_slot_%A_Index%_posY
    color := equipment_slot_%A_Index%_color_drop
    
    if isColorMatch(posX, posY, color){
      MouseClick, left, posX, posY
      waitNotColor(posX, posY, color)
    }
  }
  MouseClick, left, equipment_page_ready_posX, equipment_page_ready_posY
}

equipment_isInPage(){
  global equipment_page_ready_posX, equipment_page_ready_posY, equipment_page_ready_color
  if isColorMatch(equipment_page_ready_posX, equipment_page_ready_posY, equipment_page_ready_color){
    return true
  }
  return false
}