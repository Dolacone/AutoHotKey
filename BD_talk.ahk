esc:: 
  reload
  return
   
`::
  SetMouseDelay, 100
  talking_loop()
  return

talking_loop(){
  while(True){
    waitColor(81,1038,0x000000)
    npc_talk()
    while(selection_ready()){
      select_unit()
      start_talking()
      confirm_result()
    }
  }
}

npc_talk(){
  MouseMove, 985, 869
  waitColor(985,869,0xB5BB6E)
  MouseClick, left, 985, 869
  waitColor(541,123,0x4D86BB)
}

selection_ready(){
  if isColorMatch(541,123,0x4D86BB){
    return True
  }
  return False
}

select_unit(){
  MouseClick, right, 1323,970
  MouseClick, right, 1430,926
  MouseClick, right, 1552,894
  MouseClick, right, 1666,920
  MouseClick, right, 1775,963
  MouseClick, left, 1223,1044
  waitColor(1324,960,0xDADCDE)
  MouseClick, right, 1323,970
  sleep, 200
}

start_talking(){
  MouseClick, left, 1582,1039
}

confirm_result(){
  MouseMove, 1464, 87
  waitNotColor(1620,82,0x1B1D18)
  if isNotColorMatch(1098,93,0x355369){
    MouseClick, left, 1226,93
    return
  }
  MouseClick, left, 1464, 87
  sleep, 5000
}

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