page_home_posX = 820
page_home_posY = 55
page_home_color = 0xF7EEB2

isColorMatch(posX, posY, expectedColor){
  PixelGetColor, color, posX, posY
  if (color == expectedColor){
    return true
  }else{
    return false
  }
}

isNotColorMatch(posX, posY, expectedColor){
  PixelGetColor, color, posX, posY
  if (color == expectedColor){
    return false
  }else{
    return true
  }
}

waitColor(posX, posY, expectedColor){
  while (isNotColorMatch(posX, posY, expectedColor)){
  }
  sleep, 500
  return true
}

waitNotColor(posX, posY, expectedColor){
  while (isColorMatch(posX, posY, expectedColor)){
  }
  sleep, 500
  return true
}

isExploreDone(){
  if isColorMatch(725, 176, 0xFFFFFF){
    return true
  }else{
    return false
  }
}

waitPageSelection(){
  waitColor(113, 60, 0xCCCCCC)
}

isPageHome(){
  global page_home_posX, page_home_posY, page_home_color
  if isColorMatch(page_home_posX, page_home_posY, page_home_color){
    return true
  }
  return false
}

waitPageHome(){
  global page_home_posX, page_home_posY, page_home_color
  waitColor(page_home_posX, page_home_posY, page_home_color)
}

is_dangerous_in_prep(){
  ; unit is dangerous if empty hp bar is shown
  global fight_prep_unit_dangerous_color
  global fight_prep_unit1_posX, fight_prep_unit1_posY
  global fight_prep_unit2_posX, fight_prep_unit2_posY
  global fight_prep_unit3_posX, fight_prep_unit3_posY
  global fight_prep_unit4_posX, fight_prep_unit4_posY
  global fight_prep_unit5_posX, fight_prep_unit5_posY
  global fight_prep_unit6_posX, fight_prep_unit6_posY
  
  ; make sure page is ready
  while(!is_fight_refill_page()){
  }

  if isColorMatch(fight_prep_unit1_posX, fight_prep_unit1_posY, fight_prep_unit_dangerous_color){
    return true
  }
  if isColorMatch(fight_prep_unit2_posX, fight_prep_unit2_posY, fight_prep_unit_dangerous_color){
    return true
  }
  if isColorMatch(fight_prep_unit3_posX, fight_prep_unit3_posY, fight_prep_unit_dangerous_color){
    return true
  }
  if isColorMatch(fight_prep_unit4_posX, fight_prep_unit4_posY, fight_prep_unit_dangerous_color){
    return true
  }
  if isColorMatch(fight_prep_unit5_posX, fight_prep_unit5_posY, fight_prep_unit_dangerous_color){
    return true
  }
  if isColorMatch(fight_prep_unit6_posX, fight_prep_unit6_posY, fight_prep_unit_dangerous_color){
    return true
  }
  return false
}