home_page_posX = 29
home_page_posY = 62
home_page_color = 0x0D8BD2

home_help_btn_posX = 982
home_help_btn_posY = 59
home_help_btn_color = 0x6284A6

is_home(){
    global home_page_posX, home_page_posY, home_page_color
    if is_color_match(home_page_posX, home_page_posY, home_page_color){
        return true
    }
    return false
}

home_join_battle(){
    global home_help_btn_posX, home_help_btn_posY, home_help_btn_color
    wait_not_color(home_help_btn_posX, home_help_btn_posY, home_help_btn_color)
    MouseClick, left, home_help_btn_posX, home_help_btn_posY
}
