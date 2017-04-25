campaign_pos_x = 909
campaign_pos_y = 289
campaign_color = 0x0F274A

campaign_start_pos_x = 521
campaign_start_pos_y = 556
campaign_start_color = 0x0A95F4


is_campaign_page(){
  global campaign_pos_x, campaign_pos_y, campaign_color
  if isColorMatch(campaign_pos_x, campaign_pos_y, campaign_color){
    return true
  }
  return false
}


campaign_select(){
  global campaign_pos_x, campaign_pos_y, campaign_color
  waitColor(campaign_pos_x, campaign_pos_y, campaign_color)
  MouseClick, left, campaign_pos_x, campaign_pos_y
}


campaign_start(){
  global campaign_start_pos_x, campaign_start_pos_y, campaign_start_color
  waitColor(campaign_start_pos_x, campaign_start_pos_y, campaign_start_color)
  MouseClick, left, campaign_start_pos_x, campaign_start_pos_y
}


campaign_auto(){
  while(true){
    campaign_select()
    fight_refill()
    campaign_start()
    fight_start()
    fight_result()  
  }
}
