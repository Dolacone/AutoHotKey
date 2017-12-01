practice_page_pos_x = 17
practice_page_pos_y = 174
practice_page_color = 0x024BB2


is_practice_page(){
  global practice_page_pos_x, practice_page_pos_y, practice_page_color
  if isColorMatch(practice_page_pos_x, practice_page_pos_y, practice_page_color){
    return true
  }
  return false
}


wait_practice_page(){
  global practice_page_pos_x, practice_page_pos_y, practice_page_color
  waitColor(practice_page_pos_x, practice_page_pos_y, practice_page_color)
}


practice_auto(){
  while(true){
    wait_practice_page()
    select_practice_target()
    select_team()
    fight_refill()
    fight_go()
    fight_start()
    fight_result()
  }
}


select_practice_target(){
  base_x = 780
  base_y = 153
  delta_x = 0
  delta_y = 88
  Loop, 5{
    delta_count := A_Index - 1
    pos_x := base_x + (delta_x * delta_count)
    pos_y := base_y + (delta_y * delta_count)
    MouseClick, left, pos_x, pos_y
  }
}
