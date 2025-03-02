-- Constants
GREEN = vec(0.43, 0.76, 0.246)
RED = vec(0.93, 0.14, 0.23)
HOVER = vec(0.96, 0.66, 0.72)

DRESS = true
PE_KEYBOARD = 1
BLOOD_HAIR_BACK = true

-- Hide vanilla player
vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.ELYTRA:setVisible(false)
vanilla_model.CAPE:setVisible(false)

-- Set Visibility
models.model.root:setVisible(true)

models.model.root.Body:setVisible(true)
models.model.root.LeftArm:setVisible(true)
models.model.root.RightArm:setVisible(true)

models.model.root.Head.AnimationHat:setVisible(false)
models.model.root.Head.AnimationHead:setVisible(false)
models.model.root.Head.MainExpression:setVisible(true)
models.model.root.Head.SecondaryExpression:setVisible(false)

models.model.root.Head.Camera.Emoticon1:setVisible(false)
models.model.root.Head.Camera.Emoticon2:setVisible(false)
models.model.root.Head.Camera.Emoticon3:setVisible(false)
models.model.root.Head.Camera.Emoticon4:setVisible(false)

models.model.root.Dress:setVisible(DRESS)
models.model.root.LeftLeg:setVisible(not DRESS)
models.model.root.RightLeg:setVisible(not DRESS)

models.model.Cape:setVisible(false)
models.model.Elytra:setVisible(true)

-- Set Position !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- if DRESS then change the arm rotation by 5 degrees

-- Init Variables
last = nil
last_state = nil
armor = false

-- Start action wheel
main_page = action_wheel:newPage()
pe_page = action_wheel:newPage()
pe_page_2 = action_wheel:newPage()
config_page = action_wheel:newPage()
config_page_2 = action_wheel:newPage()
action_wheel:setPage(main_page)

-- List Functions
function remove_val_from(input_table, val)
    for i = #input_table, 1, -1 do 
        if input_table[i] == val then
            table.remove(input_table, i)
        end
    end
    return input_table
end

-- Armor
function check_armor()
    if helmet then
        pings.helmet_on()
    else
        pings.helmet_off()
    end
    if chestplate then
        pings.chestplate_on()
    else
        pings.chestplate_off()
    end
    if leggings then
        pings.leggings_on()
    else
        pings.leggings_off()
    end
    if boots then
        pings.boots_on()
    else
        pings.boots_off()
    end
end

function pings.armor_off()
    pings.helmet_off()
    pings.chestplate_off()
    pings.leggings_off()
    pings.boots_off()
end

function pings.helmet_on()
    multimodel_stop_all()
    vanilla_model.HELMET:setVisible(true)
end

function pings.helmet_off()
    vanilla_model.HELMET:setVisible(false)
end

function pings.chestplate_on()
    multimodel_stop_all()
    vanilla_model.CHESTPLATE:setVisible(true)
    pings.breast_off()
end

function pings.chestplate_off()
    vanilla_model.CHESTPLATE:setVisible(false)
    pings.breast_on()
end

function pings.leggings_on()
    multimodel_stop_all()
    vanilla_model.LEGGINGS:setVisible(true)
end

function pings.leggings_off()
    vanilla_model.LEGGINGS:setVisible(false)
end

function pings.boots_on()
    multimodel_stop_all()
    vanilla_model.BOOTS:setVisible(true)
end

function pings.boots_off()
    vanilla_model.BOOTS:setVisible(false)
end

function pings.pivots_on()
    models.model.root.LeftArm.LeftItemPivot:setVisible(true)
    models.model.root.RightArm.RightItemPivot:setVisible(true)
end

function pings.pivots_off()
    models.model.root.LeftArm.LeftItemPivot:setVisible(false)
    models.model.root.RightArm.RightItemPivot:setVisible(false)
end

-- Display Text
display_text = models:newPart("display_textGui", "GUI"):newText("ActionWheelPageName")
function events.render()
    local window_size = client:getScaledWindowSize()
    local text_size = client.getTextDimensions(display_text:getText())
    local pos = (window_size - text_size) / 2
    display_text:setPos(-310, -pos.y, 0)
end
display_text:setText("")

-- Camera
function events.render()
    -- Animation Change Controls
    local playing = animations:getPlaying(true)
    --logTable((playing))

    playing = remove_val_from(playing, animations.model.dress_move)
    playing = remove_val_from(playing, animations.model.dress_sit)
    playing = remove_val_from(playing, animations.model.dress_crouch)
    local playing_no_blink = remove_val_from(playing, animations.model.blink)

    local recent = playing_no_blink[1]
    if last ~= recent then
        --log("Change")
        local l = last == nil
        local r = recent == nil
        --log(l, r)

        if l and not r then
            --log("Now Anim")
            pings.helmet_off()
            pings.chestplate_off()
            pings.leggings_off()
            pings.boots_off()
        end
        if not l and not r then
            --log("Anim Change")
        end
        if not l and r then
            --log("End Anim")
            check_armor()
        end
    end
    last = recent
    
    -- Hand Settings
    local render_hands = true
    if #playing_no_blink > 0 then
        render_hands = false
    end

    -- Confirm hands
    if not render_hands then
        renderer:setRenderRightArm(false)
        renderer:setRenderLeftArm(false)
    else
        renderer:setRenderRightArm()
        renderer:setRenderLeftArm()
    end

    -- Link with Animations
    local rot = player:getRot()
    if renderer:isFirstPerson() and player:getPose() ~= "SLEEPING" and player:getPose() ~= "FALL_FLYING" and #playing_no_blink > 0 then
        local look = models.model.root.Head:getAnimRot()
        local anim_pos = models.model.root.Head:getAnimPos()
        local anim_rot = models.model.root.Head:getAnimRot()
        local body_yaw = player:getBodyYaw() % 360
        local x = anim_pos[1] * math.cos(math.rad(body_yaw)) - anim_pos[3] * math.sin(math.rad(body_yaw))
        local z = anim_pos[3] * math.cos(math.rad(body_yaw)) - anim_pos[1] * math.sin(math.rad(body_yaw))
        -- log(tostring(x) .. ", " .. tostring(z))
        renderer:setOffsetCameraPivot((-x) / 16, (anim_pos[2]) / 16, (-z) / 16)
        renderer:setCameraRot(rot[1] - look[1], rot[2] - look[2], -anim_rot[3])
    else
        renderer:setOffsetCameraPivot()
        renderer:setCameraRot()
        renderer:setOffsetCameraPivot()
        renderer:setCameraRot()
    end 
end

-- Dress Movement
function events.tick()
    if DRESS then
        local crouching = player:getPose() == "CROUCHING"
        local moving = player:getVelocity().xz:length() > .01
        local sitting = false
        if player:getVehicle() then
            sitting = true
        end

        animations.model.dress_sit:setPlaying(sitting)
        animations.model.dress_crouch:setPlaying(crouching)

        local face_angle = math.rad(((player:getBodyYaw() - 90) % 360) - 180)
        local face = vec(math.cos(face_angle), math.sin(face_angle))
        local move = player:getVelocity():normalize().xz
        local direction = move:dot(face)

        animations.model.dress_move:setPlaying(moving and not sitting)
        animations.model.dress_move:setSpeed(player:getVelocity().xz:length() * 5)
        if not sitting and not pe_active then models.model.root.Dress:setRot(player:getVelocity().xz:length() * -30 * direction, 0, 0) end
    end
end

-- Multi-model Animations
function multimodel_stop_all()
    animations:stopAll()
    if sleeping then 
        animations.model.blink:play()
        animations.model.blink:pause()
        --animations.model_emissive.blink:play()
        --animations.model_emissive.blink:pause()
    end
end

function multimodel_play(animation)
    animations.model[animation]:play()
    --animations.model_emissive[animation]:stop()
    --log("played " .. tostring(animation))
end

function multimodel_stop(animation)
    animations.model[animation]:stop()
    --animations.model_emissive[animation]:stop()
    --log("stopped " .. tostring(animation))
end

-- State
sleep = true
function events.tick()
    local recent_state = player:getPose()
    -- Sleep
    if last_state ~= recent_state then
        --log("---")
        --log("Change")
        if recent_state == "SLEEPING" then
            --log("slept")
            pings.sleep_on()
        else
            --log("not sleep")
            pings.sleep_off()
        end
        if recent_state == "STANDING" then
            --log("stood")
        end
    end
    last_state = recent_state
end

function pings.sleep_on()
    sleeping = true
    animations.model.blink:play()
    animations.model.blink:pause()
end 

function pings.sleep_off()
    sleeping = false
    animations.model.blink:stop()
end

-- Blink script
blink = true
blink_timer = 0
blink_at = 3  --seconds to wait before blink
SPS = 1 --amount of seconds in second (sps)

-- Add any animations that uses controlled facial expressions to the "if"
function pings.blink() 
    if blink and animations.model.curl_end:isStopped() and animations.model.sit_block_top_end:isStopped() and animations.model.stretch:isStopped() and animations.model.sleep:isStopped() and not sleeping then
        multimodel_play("blink")
    end
end

-- Code for blink
function events.tick()
    -- Blink
    blink_timer = blink_timer + SPS
    if blink_timer >= blink_at*20 then
        pings.blink()
        blink_timer = 0
    end
    blink_clock_timer = math.floor((blink_timer / 20) / 60) .. ':' .. math.floor(blink_timer / 20 / 10) - math.floor((blink_timer / 20) / 60) * 6 .. math.floor((blink_timer / 20) - math.floor(blink_timer / 20 / 10 ) * 10)
    if world:getTime() == math.floor((world:getTime()) / 20) * 20 then
        pings.syncTimer(math.floor(blink_timer / 20))

        -- Debug Options
        --log((math.floor((blink_timer) / 40) * 40) + 10)
        --printJson('[{"text":"Time", "color":"#8800ff"}, {"text":"' .. BlinkclockTimer .. '","color":"#ffaaaa"}]')
    end
end

function pings.syncTimer(tick)
    blink_timer = tick * 20
end

-- Emoticons
current_emoticon = 1

function pings.emoticon_reset()
    models.model.root.Head.Camera.Emoticon1:setVisible(false)
    models.model.root.Head.Camera.Emoticon2:setVisible(false)
    models.model.root.Head.Camera.Emoticon3:setVisible(false)
    models.model.root.Head.Camera.Emoticon4:setVisible(false)
end

function pings.emoticon_set()
    log(current_emoticon)
    if current_emoticon == 1 then
        models.model.root.Head.Camera.Emoticon1:setVisible(true)
        models.model.root.Head.Camera.Emoticon2:setVisible(false)
        models.model.root.Head.Camera.Emoticon3:setVisible(false)
        models.model.root.Head.Camera.Emoticon4:setVisible(false)
    end
    if current_emoticon == 2 then
        models.model.root.Head.Camera.Emoticon1:setVisible(false)
        models.model.root.Head.Camera.Emoticon2:setVisible(true)
        models.model.root.Head.Camera.Emoticon3:setVisible(false)
        models.model.root.Head.Camera.Emoticon4:setVisible(false)
    end
    if current_emoticon == 3 then
        models.model.root.Head.Camera.Emoticon1:setVisible(false)
        models.model.root.Head.Camera.Emoticon2:setVisible(false)
        models.model.root.Head.Camera.Emoticon3:setVisible(true)
        models.model.root.Head.Camera.Emoticon4:setVisible(false)
    end
    if current_emoticon == 4 then
        models.model.root.Head.Camera.Emoticon1:setVisible(false)
        models.model.root.Head.Camera.Emoticon2:setVisible(false)
        models.model.root.Head.Camera.Emoticon3:setVisible(false)
        models.model.root.Head.Camera.Emoticon4:setVisible(true)
    end
end

-- Help
local help_key = keybinds:newKeybind("Print Help", "key.keyboard.f6")
help_key.press = help

-- Auto End

function anim_is_active(anim)
    return anim:isPlaying() or anim:isHolding()
end

function animation_end()
    if action_wheel:isEnabled() and main_page == action_wheel:getCurrentPage() then
        -- Other
        if anim_is_active(animations.model.curl) then pings.curl() end
        if animations.model.handstand:isPlaying() then pings.handstand() end

        -- Sits
        if animations.model.sit_floor:isPlaying() then pings.sit_floor() end
        if animations.model.sit_slab:isPlaying() then pings.sit_slab() end
        if animations.model.sit_slab_shy:isPlaying() then pings.sit_slab_shy() end
        if animations.model.sit_slab_sprawl:isPlaying() then pings.sit_slab_sprawl() end
	if animations.model.sit_stairs:isPlaying() then pings.sit_stairs() end
        if animations.model.sit_block:isPlaying() then pings.sit_block() end
        if animations.model.sit_block_top:isPlaying() then pings.sit_block_top() end
        if animations.model.sit_wall:isPlaying() then pings.sit_wall() end
        if animations.model.sit_wall_shy:isPlaying() then pings.sit_wall_shy() end

        -- Leans
        if animations.model.lean_fence:isPlaying() then pings.lean_fence() end
        if animations.model.lean_forward:isPlaying() then pings.lean_forward() end
        if animations.model.lean_backward:isPlaying() then pings.lean_backward() end
        if animations.model.lean_backward_arms_up:isPlaying() then pings.lean_backward_arms_up() end
        if animations.model.lean_right:isPlaying() then pings.lean_right() end
        if animations.model.lean_left:isPlaying() then pings.lean_left() end
    end
end
local animation_end_key = keybinds:newKeybind("End Animations", "key.mouse.right")
animation_end_key.press = animation_end

-- Play last
last_animation = "none"
function play_last_animation()
    -- Other
    if last_animation == "curl" then pings.curl() end
    if last_animation == "wave" then pings.wave() end
    if last_animation == "stretch" then pings.stretch() end
    if last_animation == "handstand" then pings.handstand() end

    -- Sits
    if last_animation == "sit_floor" then pings.sit_floor() end
    if last_animation == "sit_slab" then pings.sit_slab() end
    if last_animation == "sit_slab_shy" then pings.sit_slab_shy() end
    if last_animation == "sit_slab_sprawl" then pings.sit_slab_sprawl() end
    if last_animation == "sit_stairs" then pings.sit_stairs() end
    if last_animation == "sit_block" then pings.sit_block() end
    if last_animation == "sit_block_top" then pings.sit_block_top() end
    if last_animation == "sit_wall" then pings.sit_wall() end
 
    -- Sleeps
    if last_animation == "sleep" then pings.sleep() end

    -- Leans
    if last_animation == "lean_fence:" then pings.lean_fence() end
    if last_animation == "lean_forward" then pings.lean_forward() end
    if last_animation == "lean_backward" then pings.lean_backward() end
    if last_animation == "lean_backward_arms_up" then pings.lean_backward_arms_up() end
    if last_animation == "lean_right" then pings.lean_right() end
    if last_animation == "lean_left" then pings.lean_left() end
end

-- Blood
overlay_name = "merged"
enable_blood = true
function texture_overlay(base, overlay, not_blank)
    base_size = base:getDimensions()
    local overlay_adjust = textures:copy(overlay_name .. "b", overlay)
    if not BLOOD_HAIR_BACK and base:getName() == "skin" then -- Need to add dress exceptions
        overlay_adjust:fill(31, 20, 9, 28, 0, 1, 0, 0)
        overlay_adjust:fill(16, 20, 1, 28, 0, 1, 0, 0)
        overlay_adjust:fill(29, 16, 6, 1, 0, 1, 0, 0)
    end
    local merged = textures:newTexture(overlay_name, 64, 64)
    for y = 0, base_size.y - 1, 1 do
        for x = 0, base_size.x  - 1, 1 do
            local base_rgba = base:getPixel(x, y)
            local overlay_rgba = overlay_adjust:getPixel(x, y)
            merged:setPixel(x, y, base_rgba)
            if overlay_rgba[4] ~= 0 and base_rgba[4] ~= 0 then
                if overlay_rgba[4] == 1 then
                    merged:setPixel(x, y, overlay_rgba)
                else
                    local r = average(base_rgba[1], overlay_rgba[1])
                    local g = average(base_rgba[2], overlay_rgba[2])
                    local b = average(base_rgba[3], overlay_rgba[3])
                    local a = base_rgba[4]
                    merged:setPixel(x, y, r, g, b, a)
                end
            end
        end
    end
    overlay_name = overlay_name .. "a"
    return merged
end

function average_color(color1, color2)
    local r = average(color1[1], color2[1])
    local g = average(color1[2], color2[2])
    local b = average(color1[3], color2[3])
    local a = color1[4]
    return vec(r, g, b, a)
end

function average(a, b)
    return (a + b) / 2
end

-- Generate Blood Textures
texture_blood_lvl_1 = texture_overlay(textures["skin"], textures["other_textures.blood_lvl_1"], true)
texture_blood_lvl_2 = texture_overlay(textures["skin"], textures["other_textures.blood_lvl_2"], true)
texture_blood_lvl_3 = texture_overlay(textures["skin"], textures["other_textures.blood_lvl_3"], true)

texture_extra_blood_lvl_1 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_1"], true)
texture_extra_blood_lvl_2 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_2"], true)
texture_extra_blood_lvl_3 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_3"], true)

function blood(health)
    if health > 12 or not enable_blood then
        models.model.root:setPrimaryTexture("PRIMARY")
        models.model.root.Dress:setPrimaryTexture("PRIMARY")
    elseif health > 8 then
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_1)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_1)
    elseif health > 4 then
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_2)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_2)
    else
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_3)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_3)
    end
    models.model.root.Head.Camera:setPrimaryTexture("PRIMARY")
end

-- Blood Main
function events.tick()
    blood(player:getHealth())
end

-- Pose Editor
local pe_key_activate = keybinds:newKeybind("PE Start", "key.keyboard.f7")

if PE_KEYBOARD == 1 then
    pe_key_forward = keybinds:newKeybind("PE Forward", "key.keyboard.home")
    pe_key_backward = keybinds:newKeybind("PE Backward", "key.keyboard.end")
    pe_key_left = keybinds:newKeybind("PE Left", "key.keyboard.delete")
    pe_key_right = keybinds:newKeybind("PE Right", "key.keyboard.page.down")
    pe_key_up = keybinds:newKeybind("PE Up", "key.keyboard.insert")
    pe_key_down = keybinds:newKeybind("PE Down", "key.keyboard.page.up")
    pe_key_mode = keybinds:newKeybind("PE Mode", "key.keyboard.up")
    pe_key_update = keybinds:newKeybind("PE Update", "key.keyboard.right")
    pe_key_scale = keybinds:newKeybind("PE Scale", "key.keyboard.left")
    pe_key_gumball = keybinds:newKeybind("PE Gumball", "key.keyboard.down")
elseif PE_KEYBOARD == 2 then
    pe_key_forward = keybinds:newKeybind("PE Forward", "key.keyboard.up")
    pe_key_backward = keybinds:newKeybind("PE Backward", "key.keyboard.down")
    pe_key_left = keybinds:newKeybind("PE Left", "key.keyboard.left")
    pe_key_right = keybinds:newKeybind("PE Right", "key.keyboard.right")
    pe_key_up = keybinds:newKeybind("PE Up", "key.keyboard.slash")
    pe_key_down = keybinds:newKeybind("PE Down", "key.keyboard.right.shift")
    pe_key_mode = keybinds:newKeybind("PE Mode", "key.keyboard.right.control")
    pe_key_update = keybinds:newKeybind("PE Update", "key.keyboard.comma")
    pe_key_scale = keybinds:newKeybind("PE Scale", "key.keyboard.right.alt")
    pe_key_gumball = keybinds:newKeybind("PE Gumball", "key.keyboard.period")
end
-- PE VARIABLES
pe_selected = models.model.root.RightArm

pe_active = false
pe_gumball = true

pe_pos_mode = true
pe_local_mode = false

pe_rot_scale = 15
pe_pos_scale = 1

pe_pos = vec(0, 0, 0)
pe_rot = vec(0, 0, 0)

-- PE OTHER
models.model.Gumball:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")

-- Pe Edit
function pe_edit(vector)
    if pe_active then
        if pe_pos_mode then
	    if pe_local_mode then
                log("WIP")
            else
                pe_pos = pe_pos + vector * pe_pos_scale
            end
            log(pe_pos)
            pe_selected:setPos(pe_pos)
        else
            if pe_local_mode then
                log("WIP")
            else
               pe_rot = pe_rot + vector * pe_rot_scale
            end
            log(pe_rot)
            pe_selected:setRot(pe_rot)
        end
    end
end

-- Pe Selection
function pe_selection(part)
    pe_selected = part
    pe_pos = part:getPos()
    pe_rot = part:getRot()
end

-- PINGS
function pings.pe_update_pos(vec)
    pe_selected:setPos(vec)
end

function pings.pe_update_rot(vec)
    pe_selected:setRot(vec)
end

function pe_update()
    pings.pe_update_pos(pe_pos)
    pings.pe_update_rot(pe_rot)
    log("updated to pos " .. tostring(pe_pos) .. ", and rot " .. tostring(pe_rot))
end

function pe_set_zero(part)
    part:setPos(0, 0, 0)
    part:setRot(0, 0, 0)
end

function pings.pe_clear()
    pe_set_zero(models.model.root)
    pe_set_zero(models.model.root.Head)
    pe_set_zero(models.model.root.Body)
    pe_set_zero(models.model.root.LeftArm)
    pe_set_zero(models.model.root.RightArm)
    pe_set_zero(models.model.root.LeftLeg)
    pe_set_zero(models.model.root.RightLeg)
    pe_set_zero(models.model.root.Body.Breast)
    pe_set_zero(models.model.root.Dress)
    pe_set_zero(models.model.root.LeftArm.LeftItemPivot)
    pe_set_zero(models.model.root.RightArm.RightItemPivot)
    pe_set_zero(models.model.Cape)
    pe_set_zero(models.model.Elytra.LeftElytra)
    pe_set_zero(models.model.Elytra.RightElytra)
end

-- Gumball
function events.tick()
    if pe_active then
        local pos = pe_selected:getPivot() + pe_selected:getTruePos() + pe_selected:getParent():getTruePos() + pe_selected:getParent():getParent():getTruePos() -- this is wildly messy but it works
        models.model.Gumball:setVisible(pe_gumball)
        models.model.Gumball:setPos(pos)
        models.model.Gumball.Pos:setVisible(pe_pos_mode)
        models.model.Gumball.Rot:setVisible(not pe_pos_mode)
        models.model.Gumball.Rot:setRot(pe_selected:getAnimRot())
    else
        models.model.Gumball:setVisible(false)
    end
end

-- Activate
function pe_func_activate()
    pe_active = not pe_active
    if pe_active then
        log("POSE EDITOR ENABLED")
        action_wheel:setPage(pe_page)
        pings.pe_freeze()
    else
        log("POSE EDITOR DISABLED")
        action_wheel:setPage(main_page)
        pings.pe_unfreeze()
    end
end
pe_key_activate.press = pe_func_activate

function pings.pe_freeze()
    animations.model.freeze:play()
end

function pings.pe_unfreeze()
    animations.model.freeze:stop()
end

-- Update
pe_key_update.press = pe_update

-- Scale
function pe_func_scale()
    if pe_active then
        if pe_rot_scale == 15 then
            log("Small")
            pe_rot_scale = 1
            pe_pos_scale = 0.1
        else
            log("Large")
            pe_rot_scale = 15
            pe_pos_scale = 1
        end
    end
end
pe_key_scale.press = pe_func_scale

-- Space
function pe_func_mode()
    if pe_active then
        pe_pos_mode = not pe_pos_mode
        if pe_pos_mode then
            log("Position")
        else
            log("Rotation")
        end
    end
end
pe_key_mode.press = pe_func_mode

-- Gumball
function pe_func_gumball()
    if pe_active then
        pe_gumball = not pe_gumball
        if pe_gumball then
            log("Gumball On")
        else
            log("Gumball Off")
        end
    end
end
pe_key_gumball.press = pe_func_gumball

-- DIRECTIONS

-- Forward
function pe_func_forward()
    if pe_pos_mode then
        pe_edit(vec(0, 0, 1))
    else
        pe_edit(vec(1, 0, 0))
    end
end
pe_key_forward.press = pe_func_forward

-- Backward
function pe_func_backward()
    if pe_pos_mode then
        pe_edit(vec(0, 0, -1))
    else
        pe_edit(vec(-1, 0, 0))
    end
end
pe_key_backward.press = pe_func_backward

-- Left
function pe_func_left()
    if pe_pos_mode then
        pe_edit(vec(1, 0, 0))
    else
        pe_edit(vec(0, 0, 1))
    end
end
pe_key_left.press = pe_func_left

-- Right
function pe_func_right()
    if pe_pos_mode then
        pe_edit(vec(-1, 0, 0))
    else
        pe_edit(vec(0, 0, -1))
    end
end
pe_key_right.press = pe_func_right

-- Up
function pe_func_up()
    if pe_pos_mode then
        pe_edit(vec(0, 1, 0))
    else
        pe_edit(vec(0, -1, 0))
    end
end
pe_key_up.press = pe_func_up

-- Down
function pe_func_down()
    if pe_pos_mode then
        pe_edit(vec(0, -1, 0))
    else
        pe_edit(vec(0, 1, 0))
    end
end
pe_key_down.press = pe_func_down

-- Pose Editor Actions

action = pe_page:newAction(1)
    :title("Head")
    :texture(textures["other_textures.icons"], 0 , 0, 16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_Head()
        log("Head")
    end)
function pings.pe_select_Head() pe_selection(models.model.root.Head) end

action = pe_page:newAction(8)
    :title("Body")
    :texture(textures["other_textures.icons"], 16 ,0 , 16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_Body()
        log("Body")
    end)
function pings.pe_select_Body() pe_selection(models.model.root.Body) end

action = pe_page:newAction(2)
    :title("Left Arm")
    :texture(textures["other_textures.icons"],32 ,0 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_LeftArm()
        log("Left Arm")
    end)
function pings.pe_select_LeftArm() pe_selection(models.model.root.LeftArm) end

action = pe_page:newAction(7)
    :title("Right Arm")
    :texture(textures["other_textures.icons"],48 ,0 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_RightArm()
        log("Right Arm")
    end)
function pings.pe_select_RightArm() pe_selection(models.model.root.RightArm) end

action = pe_page:newAction(3)
    :title("Left Leg")
    :texture(textures["other_textures.icons"],0 ,16 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_LeftLeg()
        log("Left Leg")
    end)
function pings.pe_select_LeftLeg() pe_selection(models.model.root.LeftLeg) end

action = pe_page:newAction(6)
    :title("RightLeg")
    :texture(textures["other_textures.icons"],16 ,16 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_RightLeg()
        log("Right Leg")
    end)
function pings.pe_select_RightLeg() pe_selection(models.model.root.RightLeg) end

action = pe_page:newAction(4)
    :title("Other")
    :texture(textures["other_textures.icons"],32 ,16 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        action_wheel:setPage(pe_page_2)
        display_text:setText("Pose Editor Other")
    end)

action = pe_page:newAction(5)
    :title("Exit (RMB Clear)")
    :item("minecraft:barrier")
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_func_activate()
    end)
    :onRightClick(function()
        pings.pe_clear()
        log("Cleared!")
    end)

-- Pose Editor Other

action = pe_page_2:newAction()
    :title("Dress")
    :texture(textures["other_textures.icons"],48 ,16 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_Dress()
        log("Dress")
    end)
function pings.pe_select_Dress() pe_selection(models.model.root.Dress) end

action = pe_page_2:newAction()
    :title("Breast")
    :texture(textures["other_textures.icons"],0 ,32 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_Breast()
        log("Breast")
    end)
function pings.pe_select_Breast() pe_selection(models.model.root.Body.Breast) end

action = pe_page_2:newAction()
    :title("Root (Warning, rotating this breaks gumball)")
    :texture(textures["other_textures.icons"],16 ,32 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_root()
        log("Root")
    end)
function pings.pe_select_root() pe_selection(models.model.root) end

action = pe_page_2:newAction()
    :title("Cape")
    :texture(textures["other_textures.icons"],32 ,32 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_Cape()
        log("Cape")
    end)
function pings.pe_select_Cape() pe_selection(models.model.Cape) end

action = pe_page_2:newAction()
    :title("Elytra (RMB for other side)")
    :texture(textures["other_textures.icons"],48 ,32 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_LeftElytra()
        log("Left Wing")
    end)
    :onRightClick(function()
        pe_update()
        pings.pe_select_RightElytra()
        log("Right Wing")
    end)
function pings.pe_select_LeftElytra() pe_selection(models.model.Elytra.LeftElytra) end
function pings.pe_select_RightElytra() pe_selection(models.model.Elytra.RightElytra) end

action = pe_page_2:newAction()
    :title("Hands (RMB for other side)")
    :texture(textures["other_textures.icons"],0 ,48 ,16, 16)
    :hoverColor(HOVER)
    :onRightClick(function()
        pe_update()
        pings.pe_select_LeftItemPivot()
        log("Left Hand")
    end)
    :onLeftClick(function()
        pe_update()
        pings.pe_select_RightItemPivot()
        log("Right Hand")
    end)
function pings.pe_select_LeftItemPivot() pe_selection(models.model.root.LeftArm.LeftItemPivot) end
function pings.pe_select_RightItemPivot() pe_selection(models.model.root.RightArm.RightItemPivot) end

action = pe_page_2:newAction()
    :title("Back")
    :item("minecraft:barrier")
    :hoverColor(HOVER)
    :onLeftClick(function()
        action_wheel:setPage(pe_page)
        display_text:setText("Pose Editor")
    end)

-- Action Functions
function pings.breast_on()
    models.model.root.Body.Breast:setVisible(true)
end

function pings.breast_off()
    models.model.root.Body.Breast:setVisible(false)
end

function pings.cape_on()
    models.model.Cape:setVisible(true)
end

function pings.cape_off()
    models.model.Cape:setVisible(false)
end

function pings.blush_on()
    models.model.root.Head.MainExpression:setVisible(false) 
    models.model.root.Head.SecondaryExpression:setVisible(true)
end

function pings.blush_off()
    models.model.root.Head.MainExpression:setVisible(true) 
    models.model.root.Head.SecondaryExpression:setVisible(false)
end

function pings.blood_on()
    enable_blood = true
end

function pings.blood_off()
    enable_blood = false
end

function check_toggles()
    main_page:newAction(8)
        :title("Play Last: " .. last_animation)
        :item("minecraft:amethyst_shard")
        :hoverColor(HOVER)
        :onLeftClick(play_last_animation)
end

-- Actions
local action = main_page:newAction()
    :title("Wave")
    :item("minecraft:bell")
    :hoverColor(HOVER)
    :onLeftClick(pings.wave)

local action = main_page:newAction()
    :title("Curl")
    :item("minecraft:sugar")
    :hoverColor(HOVER)
    :onLeftClick(pings.curl)

local action = main_page:newAction()
    :title("Sit Down")
    :item("minecraft:grass_block")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_floor)

local action = main_page:newAction()
    :title("Sit")
    :item("minecraft:oak_planks")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_block)

main_page:setAction(-1, require("script_emotes_page"))

main_page:setAction(-1, require("script_poses_page"))

local action = main_page:newAction()
    :title("Config")
    :onLeftClick(function()
        action_wheel:setPage(config_page)
        display_text:setText("Config 1/2")
        config_position = 1
    end)
    :hoverColor(HOVER)
    :item("minecraft:name_tag")

local action = main_page:newAction()
    :title("Play Last: " .. last_animation)
    :item("minecraft:amethyst_shard")
    :hoverColor(HOVER)
    :onLeftClick(play_last_animation)

--[[ Config Scroll
config_position = 1
function action_wheel.scroll(direction)
    if config_page == action_wheel:getCurrentPage() or config_page_2 == action_wheel:getCurrentPage() then
            config_position = config_position - direction
            if config_position < 1 then
                config_position = 2
            elseif config_position > 2 then
                config_position = 1
            end

            if config_position == 1 then action_wheel:setPage(config_page) display_text:setText("Config 1/2") end
            if config_position == 2 then action_wheel:setPage(config_page_2) display_text:setText("Config 2/2") end
    end
end --]]

-- Config
config_page:newAction()
    :title("Blush Enable")
    :toggleTitle("Blush Disable")
    :item("minecraft:pink_dye")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(pings.blush_on)
    :onUntoggle(pings.blush_off)

config_page:newAction()
    :title("Blink Disable")
    :toggleTitle("Blink Enable")
    :item("minecraft:ender_eye")
    :hoverColor(HOVER)
    :toggleColor(RED)
    :onToggle(function() 
        blink = false
    end)
    :onUntoggle(function() 
        blink = true
    end)

config_page:newAction()
    :title("Sleepy")
    :item("minecraft:ender_pearl")
    :hoverColor(HOVER)
    :onLeftClick(function()
        if sleeping then
            pings.sleep_off()
        else
            pings.sleep_on()
        end
    end)

config_page:newAction()
    :title("Cape Enable")
    :toggleTitle("Cape Disable")
    :item("minecraft:yellow_carpet")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(pings.cape_on)
    :onUntoggle(pings.cape_off)

config_page:newAction()
    :title("Blood Off")
    :toggleTitle("Blood On")
    :item("minecraft:redstone")
    :hoverColor(HOVER)
    :toggleColor(RED)
    :onToggle(pings.blood_off)
    :onUntoggle(pings.blood_on)

config_page:newAction()
    :title("Armor")
    :onLeftClick(function()
        action_wheel:setPage(config_page_2)
        display_text:setText("Armor")
    end)
    :hoverColor(HOVER)
    :item("minecraft:iron_chestplate")

config_page:newAction()
    :title("Emoticon (\" ! \")")
    :item("minecraft:oak_sign")
    :hoverColor(HOVER)
    :onLeftClick(pings.emoticon_set)
    :onRightClick(pings.emoticon_reset)
    :setOnScroll(function(dir, self)
        current_emoticon = current_emoticon - dir
        if current_emoticon < 1 then
            current_emoticon = 4
        elseif current_emoticon > 4 then
            current_emoticon = 1
        end
        if current_emoticon == 1 then self:title("Emoticon (\" ! \")") log("1") end 
        if current_emoticon == 2 then self:title("Emoticon (\" ? \")") log("2") end 
        if current_emoticon == 3 then self:title("Emoticon (\" :3 \")") log("3") end 
        if current_emoticon == 4 then self:title("Emoticon (\" :) \")") log("4") end
    end)

config_page:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Config Page 2
config_page_2:newAction(1)
    :title("Helmet Off")
    :toggleTitle("Helmet On")
    :item("minecraft:iron_helmet")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() 
        helmet = true
        pings.helmet_on()
    end)
    :onUntoggle(function() 
        helmet = false
        pings.helmet_off()
    end)

config_page_2:newAction(2)
    :title("Chestplate Off")
    :toggleTitle("Chestplate On")
    :item("minecraft:iron_chestplate")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() 
        chestplate = true
        pings.chestplate_on()
    end)
    :onUntoggle(function() 
        chestplate = false
        pings.chestplate_off()
    end)

config_page_2:newAction(3)
    :title("Leggings Off")
    :toggleTitle("Leggings On")
    :item("minecraft:iron_leggings")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() 
        leggings = true
        pings.leggings_on()
    end)
    :onUntoggle(function() 
        leggings = false
        pings.leggings_off()
    end)

config_page_2:newAction(4)
    :title("Boots Off")
    :toggleTitle("Boots On")
    :item("minecraft:iron_boots")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() 
        boots = true
        pings.boots_on()
    end)
    :onUntoggle(function() 
        boots = false
        pings.boots_off()
    end)

config_page_2:newAction(7)
    :title("Pivots Off")
    :toggleTitle("Pivots On")
    :item("minecraft:iron_sword")
    :hoverColor(HOVER)
    :toggleColor(RED)
    :onToggle(function() 
        pivots = true
        pings.pivots_off()
    end)
    :onUntoggle(function() 
        pivots = false
        pings.pivots_on()
    end)

config_page_2:newAction(8)
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
        config_position = 1
    end)
    :hoverColor(HOVER)

-- Main Page On Close
local close_key = keybinds:fromVanilla("figura.config.action_wheel_button")
close_key:setOnRelease(function()
    if pe_active then
        action_wheel:setPage(pe_page)
    else
        action_wheel:setPage(main_page)
    end
    display_text:setText("")
end)

close_key:setOnPress(function()
    if pe_active then
        display_text:setText("Pose Editor")
    else
        display_text:setText("Main")
    end
end)
