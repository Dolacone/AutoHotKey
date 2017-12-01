battle_join_first_posX = 293
battle_join_first_posY = 234
battle_join_first_color = 0xDEF4F5

battle_join_second_posX = 292
battle_join_second_posY = 545
battle_join_second_color = 0xE6FAFB

battle_join_btn_back_posX = 64
battle_join_btn_back_posY = 92
battle_join_btn_back_color = 0x3199BB

battle_prepare_btn_quit_posX = 672
battle_prepare_btn_quit_posY = 649
battle_prepare_btn_quit_color = 0x16305F

battle_join_failed_btn_posX = 648
battle_join_failed_btn_posY = 482
battle_join_failed_btn_color = 0x6C4100

battle_battle_page_posX = 36
battle_battle_page_posY = 64
battle_battle_page_color = 0xA6C1E3

battle_hide_btn_posX = 1101
battle_hide_btn_posY = 55
battle_hide_btn_color = 0xA46C34
battle_show_btn_posX = 960
battle_show_btn_posY = 621
battle_show_btn_color = 0x0D6C97
battle_enemy_skill_posX = 635
battle_enemy_skill_posY = 103
battle_enemy_skill_color = 0xEA75B4
battle_enemy_attack_posX = 736
battle_enemy_attack_posY = 76
battle_enemy_attack_color = 0xFFB5E8

battle_result_btn_next_posX = 841
battle_result_btn_next_posY = 678
battle_result_btn_next_color = 0x8661FF

is_finding_battle(){
    global battle_join_btn_back_posX, battle_join_btn_back_posY, battle_join_btn_back_color
    if is_color_match(battle_join_btn_back_posX, battle_join_btn_back_posY, battle_join_btn_back_color){
        return true
    }
    return false
}

battle_join_battle(){
    ; second battle is opened
    global battle_join_second_posX, battle_join_second_posY, battle_join_second_color
    if is_color_match(battle_join_second_posX, battle_join_second_posY, battle_join_second_color){
        MouseClick, left, battle_join_second_posX, battle_join_second_posY
        sleep 300
        MouseClick, left, battle_join_second_posX, battle_join_second_posY
        sleep 3000
        wait_battle_start()
    }

    ; first battle is opened
    global battle_join_first_posX, battle_join_first_posY, battle_join_first_color
    if is_color_match(battle_join_first_posX, battle_join_first_posY, battle_join_first_color){
        MouseClick, left, battle_join_first_posX, battle_join_first_posY
        sleep 300
        MouseClick, left, battle_join_first_posX, battle_join_first_posY
        sleep 3000
        wait_battle_start()
    }

    ; join failed / battle closed
    global battle_join_failed_btn_posX, battle_join_failed_btn_posY, battle_join_failed_btn_color
    if is_color_match(battle_join_failed_btn_posX, battle_join_failed_btn_posY, battle_join_failed_btn_color){
        MouseClick, left, battle_join_failed_btn_posX, battle_join_failed_btn_posY
        sleep 1000
    }
    
    ; return to home page
    global battle_join_btn_back_posX, battle_join_btn_back_posY, battle_join_btn_back_color
    if is_color_match(battle_join_btn_back_posX, battle_join_btn_back_posY, battle_join_btn_back_color){
        MouseClick, left, battle_join_btn_back_posX, battle_join_btn_back_posY
        sleep 1000
    }
}

wait_battle_start(){
    global battle_prepare_btn_quit_posX, battle_prepare_btn_quit_posY, battle_prepare_btn_quit_color
    wait_not_color(battle_prepare_btn_quit_posX, battle_prepare_btn_quit_posY, battle_prepare_btn_quit_color)
}

is_in_battle(){
    global battle_battle_page_posX, battle_battle_page_posY, battle_battle_page_color
    if is_color_match(battle_battle_page_posX, battle_battle_page_posY, battle_battle_page_color){
        return true
    }
    return false
}

battle_loop(){
    if is_hide_available(){
        cooldown := 18000
        while is_hide_available(){
            if not is_in_battle(){
                return
            }
            battle_hide()
            sleep 1000
            cooldown := cooldown - 1000
            if (cooldown <= 0){
                break
            }
        }
        if (cooldown > 0){
            sleep %cooldown%
        }
        if not is_in_battle(){
            return
        }
        wait_enemy_attack()
        battle_show()
        battle_use_skills()        
    }
}

is_hide_available(){
    global battle_hide_btn_posX, battle_hide_btn_posY, battle_hide_btn_color
    if is_color_match(battle_hide_btn_posX, battle_hide_btn_posY, battle_hide_btn_color){
        return true
    }
    return false
}

battle_hide(){
    global battle_hide_btn_posX, battle_hide_btn_posY, battle_hide_btn_color
    MouseClick, left, battle_hide_btn_posX, battle_hide_btn_posY
}

is_show_available(){
    global battle_show_btn_posX, battle_show_btn_posY, battle_show_btn_color
    if is_color_match(battle_show_btn_posX, battle_show_btn_posY, battle_show_btn_color){
        return true
    }
    return false
}

wait_enemy_attack(){
    while (not is_enemy_attacking()){
        sleep 50
        if not is_in_battle(){
            return
        }

    }
}

battle_show(){
    global battle_show_btn_posX, battle_show_btn_posY, battle_show_btn_color
    MouseClick, left, battle_show_btn_posX, battle_show_btn_posY
    wait_not_color(battle_show_btn_posX, battle_show_btn_posY, battle_show_btn_color)
}

is_enemy_attacking(){
    global battle_enemy_attack_posX, battle_enemy_attack_posY, battle_enemy_attack_color
    if is_color_match(battle_enemy_attack_posX, battle_enemy_attack_posY, battle_enemy_attack_color){
        return true
    }
    return false
}

is_enemy_casting(){
    global battle_enemy_skill_posX, battle_enemy_skill_posY, battle_enemy_skill_color
    if is_color_match(battle_enemy_skill_posX, battle_enemy_skill_posY, battle_enemy_skill_color){
        return true
    }
    return false
}

battle_use_skills(){
    delay := 50
    sleep 200
    
    ; skill 9
    MouseClick, left, 1200, 700
    sleep %delay%
    ; skill 6
    MouseClick, left, 780, 700
    sleep %delay%
    ; skill 3
    MouseClick, left, 360, 700
    sleep %delay%
    ; skill 8
    MouseClick, left, 1060, 700
    sleep %delay%
    ; skill 5
    MouseClick, left, 640, 700
    sleep %delay%
    ; skill 2
    MouseClick, left, 220, 700
    sleep %delay%
    ; skill 7
    MouseClick, left, 920, 700
    sleep %delay%
    ; skill 4
    MouseClick, left, 500, 700
    sleep %delay%
    ; skill 1
    MouseClick, left, 80, 700    
    sleep %delay%
}

is_in_result(){
    global battle_result_btn_next_posX, battle_result_btn_next_posY, battle_result_btn_next_color
    if is_color_match(battle_result_btn_next_posX, battle_result_btn_next_posY, battle_result_btn_next_color){
        return true
    }
    return false
}

battle_end_result(){
    global battle_result_btn_next_posX, battle_result_btn_next_posY, battle_result_btn_next_color
    MouseClick, left, battle_result_btn_next_posX, battle_result_btn_next_posY
}
