page_fight_btn_posX = 718
page_fight_btn_posY = 160
page_fight_btn_color = 0xB8B8B8
tab_fight_posX = 52
tab_fight_posY = 80
tab_fight_color = 0x2878DD

fight_select_posX = 890
fight_select_posY = 493
fight_select_color = 0xA0B7C5

fight_prep_unit_dangerous_color = 0x8399A7
fight_prep_unit1_posX = 256
fight_prep_unit1_posY = 362
fight_prep_unit2_posX = 354
fight_prep_unit2_posY = 362
fight_prep_unit3_posX = 453
fight_prep_unit3_posY = 362
fight_prep_unit4_posX = 551
fight_prep_unit4_posY = 362
fight_prep_unit5_posX = 650
fight_prep_unit5_posY = 362
fight_prep_unit6_posX = 749
fight_prep_unit6_posY = 362
fight_prep_refill_posX = 937
fight_prep_refill_posY = 91
fight_prep_refill_color = 0x1FDAFC
fight_prep_refill_confirm_posX = 569
fight_prep_refill_confirm_posY = 453
fight_prep_refill_confirm_color = 0xEAC13D
fight_prep_go_posX = 460
fight_prep_go_posY = 564
fight_prep_go_color = 0x008EF3

fight_itemPoint_posX = 516
fight_itemPoint_posY = 410
fight_itemPoint_color = 0xF0CB43

fight_start_enemyConfirm_posX = 719
fight_start_enemyConfirm_posY = 512
fight_start_enemyConfirm_color = 0x3481E6
fight_start_formation_2_posX = 883  ; 2nd formation
fight_start_formation_2_posY = 217  ; 2nd formation
fight_start_formation_2_color = 0xCCCCCC  ; 2nd formation
fight_start_formation_5_posX = 818  ; 5th formation
fight_start_formation_5_posY = 524  ; 5th formation
fight_start_formation_5_color = 0xA4A4A4  ; 5th formation

fight_night_posX = 631
fight_night_posY = 421
fight_night_color = 0xF0CB43

fight_end_result_posX = 713
fight_end_result_posY = 523
fight_end_result_color = 0xD3D3D3
fight_end_result_btn_posX = 901
fight_end_result_btn_posY = 582
fight_end_result_btn_color = 0xEBC43F
fight_end_newShip_posX = 900
fight_end_newShip_posY = 564
fight_end_newShip_color = 0xCCCCCC
fight_end_newShip_lock_posX = 321
fight_end_newShip_lock_posY = 415
fight_end_newShip_lock_color = 0xEAC33E

fight_next_leader_dangerous_posX = 787
fight_next_leader_dangerous_posY = 463
fight_next_leader_dangerous_color = 0xEFC942
fight_next_retreat_posX = 642
fight_next_retreat_posY = 420
fight_next_retreat_color = 0xF1CB43
fight_next_safe_posX = 321
fight_next_safe_posY = 425
fight_next_safe_color = 0x2D7CE1

fight_auto_select(){
  fight_page_open()
  fight_select()
  fight_auto()
}

fight_auto(){
  fight_refill()
  if is_dangerous_in_prep(){
    stop_auto_fight()
    return
  }
  fight_go()
  is_in_fight := true
  while(is_in_fight){
    is_in_fight := fight_start()
    if not is_in_fight{
      break
    }
    fight_result()
    is_in_fight := fight_retreat()
  }
}

is_fight_refill_page(){
  global fight_prep_refill_posX, fight_prep_refill_posY, fight_prep_refill_color
  if isColorMatch(fight_prep_refill_posX, fight_prep_refill_posY, fight_prep_refill_color){
    return true
  }
  return false
}

fight_page_open(){
  debug("fight_page_open")
  global page_fight_btn_posX, page_fight_btn_posY, page_fight_btn_color
  global tab_fight_posX, tab_fight_posY, tab_fight_color
  
  waitColor(page_fight_btn_posX, page_fight_btn_posY, page_fight_btn_color)
  MouseClick, left, page_fight_btn_posX, page_fight_btn_posY
  waitPageSelection()
  MouseClick, left, tab_fight_posX, tab_fight_posY
  waitColor(tab_fight_posX, tab_fight_posY, tab_fight_color)
}

fight_select(){
  debug("fight_select")
  global fight_select_posX, fight_select_posY, fight_select_color
  
  waitColor(fight_select_posX, fight_select_posY, fight_select_color)
  MouseClick, left, fight_select_posX, fight_select_posY
}

fight_refill(){
  debug("fight_refill")
  global fight_prep_refill_posX, fight_prep_refill_posY, fight_prep_refill_color
  global fight_prep_refill_confirm_posX, fight_prep_refill_confirm_posY, fight_prep_refill_confirm_color

  waitColor(fight_prep_refill_posX, fight_prep_refill_posY, fight_prep_refill_color)
  MouseClick, left, fight_prep_refill_posX, fight_prep_refill_posY
  waitColor(fight_prep_refill_confirm_posX, fight_prep_refill_confirm_posY, fight_prep_refill_confirm_color)
  MouseClick, left, fight_prep_refill_confirm_posX, fight_prep_refill_confirm_posY
}

fight_go(){
  debug("fight_go")
  global fight_prep_go_posX, fight_prep_go_posY, fight_prep_go_color
  
  waitColor(fight_prep_go_posX, fight_prep_go_posY, fight_prep_go_color)
  MouseClick, left, fight_prep_go_posX, fight_prep_go_posY
}

fight_start(){
  debug("fight_start")
  global fight_itemPoint_posX, fight_itemPoint_posY, fight_itemPoint_color
  global fight_start_enemyConfirm_posX, fight_start_enemyConfirm_posY, fight_start_enemyConfirm_color
  global fight_start_formation_2_posX, fight_start_formation_2_posY, fight_start_formation_2_color
  global fight_start_formation_5_posX, fight_start_formation_5_posY, fight_start_formation_5_color
  GuiControlGet, formation_number,, formation
  
  while(true){
    ; item point
    if isColorMatch(fight_itemPoint_posX, fight_itemPoint_posY, fight_itemPoint_color){
      MouseClick, left, fight_itemPoint_posX, fight_itemPoint_posY
    }
    
    ; encounter
    if isColorMatch(fight_start_enemyConfirm_posX, fight_start_enemyConfirm_posY, fight_start_enemyConfirm_color){
      MouseClick, left, fight_start_enemyConfirm_posX, fight_start_enemyConfirm_posY
    }
    if isColorMatch(fight_start_formation_%formation_number%_posX, fight_start_formation_%formation_number%_posY, fight_start_formation_%formation_number%_color){
      MouseClick, left, fight_start_formation_%formation_number%_posX, fight_start_formation_%formation_number%_posY
      return true
    }
    
    ; battle ended
    if isPageHome(){
      return false
    }
  }
}

fight_result(){
  debug("fight_result")
  global fight_night_posX, fight_night_posY, fight_night_color
  global fight_end_result_posX, fight_end_result_posY, fight_end_result_color
  global fight_end_result_btn_posX, fight_end_result_btn_posY, fight_end_result_btn_color
  global fight_end_newShip_posX, fight_end_newShip_posY, fight_end_newShip_color
  global fight_end_newShip_lock_posX, fight_end_newShip_lock_posY, fight_end_newShip_lock_color
  global fight_next_retreat_posX, fight_next_retreat_posY, fight_next_retreat_color
  
  while(true){
    if isColorMatch(fight_night_posX, fight_night_posY, fight_night_color){
      sleep, 1000
      MouseClick, left, fight_night_posX, fight_night_posY
    }
    if isColorMatch(fight_end_result_posX, fight_end_result_posY, fight_end_result_color){
      sleep, 1000
      MouseClick, left, fight_end_result_posX, fight_end_result_posY
      break
    }
  }
  waitColor(fight_end_result_btn_posX, fight_end_result_btn_posY, fight_end_result_btn_color)
  MouseClick, left, fight_end_result_btn_posX, fight_end_result_btn_posY
  while(true){
    if isColorMatch(fight_end_newShip_posX, fight_end_newShip_posY, fight_end_newShip_color){
      sleep, 1000
      MouseClick, left, fight_end_newShip_posX, fight_end_newShip_posY
    }
    if isColorMatch(fight_end_newShip_lock_posX, fight_end_newShip_lock_posY, fight_end_newShip_lock_color){
      sleep, 1000
      MouseClick, left, fight_end_newShip_lock_posX, fight_end_newShip_lock_posY
    }
    if isColorMatch(fight_next_retreat_posX, fight_next_retreat_posY, fight_next_retreat_color){
      break
    }
    if isPageHome(){
      break
    }
  }
}

fight_retreat(){
  debug("fight_retreat")
  global fight_next_leader_dangerous_posX, fight_next_leader_dangerous_posY, fight_next_leader_dangerous_color
  global fight_next_safe_posX, fight_next_safe_posY, fight_next_safe_color
  global fight_next_retreat_posX, fight_next_retreat_posY, fight_next_retreat_color
  
  while(true){
    if isColorMatch(fight_next_leader_dangerous_posX, fight_next_leader_dangerous_posY, fight_next_leader_dangerous_color){
      MouseClick, left, fight_next_leader_dangerous_posX, fight_next_leader_dangerous_posY
      return false
    }
  
    if isColorMatch(fight_next_retreat_posX, fight_next_retreat_posY, fight_next_retreat_color){    
      ; check to retreat
      if isNotColorMatch(fight_next_safe_posX, fight_next_safe_posY, fight_next_safe_color){
        stop_auto_fight()
        
        ;retreat
        MouseClick, left, fight_next_retreat_posX, fight_next_retreat_posY
        return false
      }
      
      ; force retreat
      GuiControlGet, chk_fight_once_flag,, chk_fight_once
      if(chk_fight_once_flag == 1){
        MouseClick, left, fight_next_retreat_posX, fight_next_retreat_posY
        return false
      }

      ; keep going
      MouseClick, left, fight_next_safe_posX, fight_next_safe_posY
      return true
    }
    
    if isPageHome(){
      return false
    }
  }
}

stop_auto_fight(){
  GuiControl, , chk_fight, 0
}