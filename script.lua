-- Settings
GREEN = vec(0.43, 0.76, 0.246)
RED = vec(0.93, 0.14, 0.23)
HOVER = vec(0.96, 0.66, 0.72) --(0.96, 0.66, 0.72)

DRESS = true			-- true or false
WIDE = false			-- true or false
BREASTS = true			-- true or false

PE_KEYBOARD = 2			-- currently 1 or 2
PE_SCALE = 2			-- scale factor, any number

ARMOR_HELMET = false		-- true or false
ARMOR_CHESTPLATE = true		-- true or false
ARMOR_LEGGINGS = true		-- true or false
ARMOR_BOOTS = true		-- true or false
ARMOR_SETTING = 1		-- 1 for default, up to 4

CAPE = false			-- true or false
EYES = 1			-- 1 for default, up to 5
BLOOD = 1			-- 1 for default, up to 5

MODDED_MATERIALS = {
    ["aether"] = {
        "zanite", 
        "phoenix", 
        "valkyrie", 
        "obsidian", 
        "neptune", 
        "gravitite"},
    ["create_sa"] = {
        "zinc",
        "brass"} 
}

TECHNICAL_ANIMATIONS = {
    animations.model.dress_move, 
    animations.model.dress_sit, 
    animations.model.dress_crouch, 
    animations.model.blink_left, 
    animations.model.blink_right, 
    animations.model.blink, 
    animations.model.consume, 
    animations.model.consume_offhand
}

-- Set vanilla player
vanilla_model.PLAYER:setVisible(false)
vanilla_model.HELMET_ITEM:setVisible(true)
vanilla_model.ELYTRA:setVisible(false)
vanilla_model.CAPE:setVisible(false)

vanilla_model.HELMET:setVisible(ARMOR_HELMET)
vanilla_model.CHESTPLATE:setVisible(ARMOR_CHESTPLATE)
vanilla_model.LEGGINGS:setVisible(ARMOR_LEGGINGS)
vanilla_model.BOOTS:setVisible(ARMOR_BOOTS and not DRESS)

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

models.model.root.LeftArm.LeftSlim:setVisible(not WIDE)
models.model.root.LeftArm.LeftWide:setVisible(WIDE)
models.model.root.RightArm.RightSlim:setVisible(not WIDE)
models.model.root.RightArm.RightWide:setVisible(WIDE)

models.model.root.Body.Breast.BreastArmor:setVisible(false)
models.model.root.Dress.DressArmor:setVisible(false)

models.model.Cape:setVisible(CAPE)
models.model.Elytra:setVisible(true)

-- Set Position
if DRESS then
    models.model.root.LeftArm:setOffsetRot(0, 0, -5)
    models.model.root.RightArm:setOffsetRot(0, 0, 5)
end

-- Start action wheel
main_page = action_wheel:newPage()
pe_page = action_wheel:newPage()
pe_page_2 = action_wheel:newPage()
config_page = action_wheel:newPage()
config_page_2 = action_wheel:newPage()
action_wheel:setPage(main_page)

-- KattArmor
local kattArmor = require("KattArmor")()

kattArmor.Armor.Chestplate
    :addParts(models.model.root.Body.Breast.BreastArmor.BreastArmor)
    :addTrimParts(models.model.root.Body.Breast.BreastArmor.BreastTrim)
kattArmor.Armor.Leggings
    :addParts(models.model.root.Dress.DressArmor.DressArmor)
    :addTrimParts(models.model.root.Dress.DressArmor.DressTrim)
    :addParts(models.model.root.Dress.DressArmor.DressArmorLower)
    :addTrimParts(models.model.root.Dress.DressArmor.DressTrimLower)

for i, route in pairs(MODDED_MATERIALS) do
    for j, material in pairs(route) do
        kattArmor.Materials[material]
            :setTexture(i .. ":textures/models/armor/" .. material .. "_layer_1.png")
            :setTextureLayer2(i .. ":textures/models/armor/" .. material .. "_layer_2.png")
    end
end

-- Universal Functions
function remove_val_from(input_table, val)
    for i = #input_table, 1, -1 do 
        if input_table[i] == val then
            table.remove(input_table, i)
        end
    end
    return input_table
end

local function split(str, delimiter) -- Courtesy of u/luascriptdev
    local returnTable = {}
    for k, v in string.gmatch(str, "([^" .. delimiter .. "]+)") 
    do
        returnTable[#returnTable+1] = k
    end
    return returnTable
end

-- Armor
last = nil
armor = ARMOR_SETTING

function events.tick()
    local playing = animations:getPlaying(true)
    
    for i = #TECHNICAL_ANIMATIONS, 1, -1 do
        playing = remove_val_from(playing, TECHNICAL_ANIMATIONS[i])
    end

    local recent = playing[1]
    if last ~= recent then
        --log("Change")
        local l = last == nil
        local r = recent == nil
        --log(l, r)

        if l and not r then
            --log("Now Anim")
            if armor == 3 or armor == 4 then
                pings.helmet_off()
                pings.chestplate_off()
                pings.leggings_off()
                pings.boots_off()
            end
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

    models.model.root.Body.Breast.BreastArmor:setVisible(armor == 1 and vanilla_model.CHESTPLATE:getVisible() and BREASTS)
    models.model.root.Dress.DressArmor:setVisible(armor == 1 and vanilla_model.LEGGINGS:getVisible())

    if player:getItem(5).id == "minecraft:air" or player:getItem(5).id == "minecraft:elytra" then
        models.model.root.Body.Breast:setVisible(true)
    else
        if vanilla_model.CHESTPLATE:getVisible() then
            if armor == 1 or armor == 4 then
                models.model.root.Body.Breast:setVisible(true)
            else
                models.model.root.Body.Breast:setVisible(false)
            end
        else
            models.model.root.Body.Breast:setVisible(true)
        end
    end
end

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
    if not pe_active and not models.model.root.Head.HelmetPivot:getVisible() then animations:stopAll() end
    vanilla_model.HELMET:setVisible(true)
end

function pings.helmet_off()
    vanilla_model.HELMET:setVisible(false)
end

function pings.chestplate_on()
    if not pe_active and not models.model.root.Head.HelmetPivot:getVisible() then animations:stopAll() end
    models.model.root.Body.Breast.BreastArmor:setVisible(models.model.root.Body.ChestplatePivot:getVisible() and BREASTS)
    vanilla_model.CHESTPLATE:setVisible(true) 
end

function pings.chestplate_off()
    models.model.root.Body.Breast.BreastArmor:setVisible(false)
    vanilla_model.CHESTPLATE:setVisible(false)
end

function pings.leggings_on()
    if not pe_active and not models.model.root.Head.HelmetPivot:getVisible() then animations:stopAll() end
    models.model.root.Dress.DressArmor:setVisible(models.model.root.Body.LeggingsPivot:getVisible())
    vanilla_model.LEGGINGS:setVisible(true)
end

function pings.leggings_off()
    models.model.root.Dress.DressArmor:setVisible(false)
    vanilla_model.LEGGINGS:setVisible(false)
end

function pings.boots_on()
    if not pe_active and not models.model.root.Head.HelmetPivot:getVisible() then animations:stopAll() end
    vanilla_model.BOOTS:setVisible(not DRESS)
end

function pings.boots_off()
    vanilla_model.BOOTS:setVisible(false)
end

function pings.pivots_toggle(setting)
    models.model.root.LeftArm.LeftItemPivot:setVisible(setting)
    models.model.root.RightArm.RightItemPivot:setVisible(setting)
end

function pings.armor_set(armor_setting)
    armor = armor_setting
    local figura_parts = false
    if armor_setting == 1 or armor_setting == 2 then
        figura_parts = true
    end
    if figura_parts == false then
        models.model.root.Body.Breast.BreastArmor:setVisible(false)
        models.model.root.Dress.DressArmor:setVisible(false)
    end
    models.model.root.Head.HelmetPivot:setVisible(figura_parts)
    models.model.root.Body.ChestplatePivot:setVisible(figura_parts)
    models.model.root.Body.LeggingsPivot:setVisible(figura_parts)
    models.model.root.LeftArm.LeftShoulderPivot:setVisible(figura_parts)
    models.model.root.RightArm.RightShoulderPivot:setVisible(figura_parts)
    models.model.root.LeftLeg.LeftLeggingPivot:setVisible(figura_parts)
    models.model.root.LeftLeg.LeftBootPivot:setVisible(figura_parts)
    models.model.root.RightLeg.RightLeggingPivot:setVisible(figura_parts)
    models.model.root.RightLeg.RightBootPivot:setVisible(figura_parts)
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
function events.render(_, context)
    -- Hide Head in FPV for first person mod
    models.model.root.Head:setVisible(not (renderer:isFirstPerson() and context == "OTHER"))
    --vanilla_model.HELMET:setVisible(not (renderer:isFirstPerson() and context == "OTHER"))
    
    -- Animation Change Controls
    local playing = animations:getPlaying(true)
    
    for i = #TECHNICAL_ANIMATIONS, 1, -1 do
        playing = remove_val_from(playing, TECHNICAL_ANIMATIONS[i])
    end
    
    -- Hand Settings
    local render_hands = true
    if #playing > 0 then
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
    if renderer:isFirstPerson() and player:getPose() ~= "SLEEPING" and player:getPose() ~= "FALL_FLYING" and #playing > 0 then
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

-- Special animation (dress movement and world interactions)
function events.tick()
    -- Dress Movement
    if DRESS then
        local crouching = player:getPose() == "CROUCHING"
        local moving = player:getVelocity().xz:length() > .01
        local sitting = false
        local flying = player:getPose() == "FALL_FLYING"
        if player:getVehicle() then
            sitting = true
        end

        animations.model.dress_sit:setPlaying(sitting)
        animations.model.dress_crouch:setPlaying(crouching)

        local face_angle = math.rad(((player:getBodyYaw() - 90) % 360) - 180)
        local face = vec(math.cos(face_angle), math.sin(face_angle))
        local move = player:getVelocity():normalize().xz
        local direction = move:dot(face)

        animations.model.dress_move:setPlaying(moving and not (sitting or flying))
        animations.model.dress_move:setSpeed(player:getVelocity().xz:length() * 5)
        if not (sitting or pe_active or flying) then models.model.root.Dress:setOffsetRot(player:getVelocity().xz:length() * -30 * direction, 0, 0) end
    end

    -- Using
    if player:getActiveItem():getUseAction() == "EAT" or player:getActiveItem():getUseAction() == "DRINK" then
        if player:getActiveItem().id == player:getHeldItem().id then
            animations.model.consume:setPlaying(true)
            animations.model.consume_offhand:setPlaying(false)
        else
            animations.model.consume_offhand:setPlaying(true)
            animations.model.consume:setPlaying(false)
        end
    else
        animations.model.consume:setPlaying(false)
        animations.model.consume_offhand:setPlaying(false)
    end
end

-- Blink
blink = EYES
blink_timer = 0
blink_at = 3  --seconds to wait before blink
SPS = 1 --amount of seconds in second (sps)

animations.model.blink_right:setPriority(-1)
animations.model.blink_left:setPriority(-1)
animations.model.blink:setPriority(-1)

function pings.blink() 
    animations.model.blink:play()
end

-- Code for blink
function events.tick()
    if blink == 1 then
        animations.model.blink_right:setPlaying(false)
        animations.model.blink_left:setPlaying(false)

        -- Blink
        blink_timer = blink_timer + SPS
        if blink_timer >= blink_at*20 then
            pings.blink()
            blink_timer = 0
        end
        blink_clock_timer = math.floor((blink_timer / 20) / 60) .. ':' .. math.floor(blink_timer / 20 / 10) - math.floor((blink_timer / 20) / 60) * 6 .. math.floor((blink_timer / 20) - math.floor(blink_timer / 20 / 10 ) * 10)
        if world:getTime() == math.floor((world:getTime()) / 20) * 20 then
            pings.syncTimer(math.floor(blink_timer / 20))
        end
        if player:getPose() == "SLEEPING" then
            animations.model.blink:setPlaying(true)
            animations.model.blink:pause()
        end
    elseif blink == 2 then
        animations.model.blink_right:setPlaying(false)
        animations.model.blink_left:setPlaying(false)

        animations.model.blink:setPlaying(true)
        animations.model.blink:pause()
    elseif blink == 3 then
        animations.model.blink:setPlaying(false)
        animations.model.blink_left:setPlaying(false)

        animations.model.blink_right:setPlaying(true)
        animations.model.blink_right:pause()
    elseif blink == 4 then
        animations.model.blink:setPlaying(false)
        animations.model.blink_right:setPlaying(false)

        animations.model.blink_left:setPlaying(true)
        animations.model.blink_left:pause()
    elseif blink == 5 then
        animations.model.blink_right:setPlaying(false)
        animations.model.blink_left:setPlaying(false)

        animations.model.blink:setPlaying(false)
    end
end

function pings.blink_set(setting)
    blink = setting
    animations.model.blink:stop()
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

function pings.emoticon_set(setting)
    current_emoticon = setting
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
        if anim_is_active(animations.model.handstand) then pings.handstand() end
        if anim_is_active(animations.model.sleep) then pings.sleep() end

        -- Sits
        if anim_is_active(animations.model.sit_floor) then pings.sit_floor() end
        if anim_is_active(animations.model.sit_slab) then pings.sit_slab() end
        if anim_is_active(animations.model.sit_slab_shy) then pings.sit_slab_shy() end
        if anim_is_active(animations.model.sit_slab_sprawl) then pings.sit_slab_sprawl() end
	if anim_is_active(animations.model.sit_stairs) then pings.sit_stairs() end
        if anim_is_active(animations.model.sit_block) then pings.sit_block() end
        if anim_is_active(animations.model.sit_block_top) then pings.sit_block_top() end
        if anim_is_active(animations.model.sit_wall) then pings.sit_wall() end
        if anim_is_active(animations.model.sit_wall_shy) then pings.sit_wall_shy() end

        -- Leans
        if anim_is_active(animations.model.lean_fence) then pings.lean_fence() end
        if anim_is_active(animations.model.lean_forward) then pings.lean_forward() end
        if anim_is_active(animations.model.lean_backward) then pings.lean_backward() end
        if anim_is_active(animations.model.lean_backward_arms_up) then pings.lean_backward_arms_up() end
        if anim_is_active(animations.model.lean_right) then pings.lean_right() end
        if anim_is_active(animations.model.lean_left) then pings.lean_left() end
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
    if last_animation == "lean_fence" then pings.lean_fence() end
    if last_animation == "lean_forward" then pings.lean_forward() end
    if last_animation == "lean_backward" then pings.lean_backward() end
    if last_animation == "lean_backward_arms_up" then pings.lean_backward_arms_up() end
    if last_animation == "lean_right" then pings.lean_right() end
    if last_animation == "lean_left" then pings.lean_left() end
end

-- Blood
blood_setting = BLOOD
overlay_name = "merged"

function match_texture_sections(texture, b1, b2, c)
     for y = b1.y, b2.y, 1 do
         for x = b1.x, b2.x, 1 do
             local texture_rgba = texture:getPixel(x, y)
             local mod_x = x - b1.x + c.x
             local mod_y = y - b1.y + c.y
             texture:setPixel(mod_x, mod_y, texture_rgba)
         end
     end
end

function generate_second_layer(texture)
    match_texture_sections(texture, vec( 0, 16), vec(53, 31), vec( 0, 32))
    match_texture_sections(texture, vec( 0,  0), vec(31, 15), vec(32,  0))
    match_texture_sections(texture, vec( 8,  8), vec(15, 15), vec(56,  0))
    match_texture_sections(texture, vec(16, 48), vec(31, 63), vec( 0, 48))
    match_texture_sections(texture, vec(32, 48), vec(47, 63), vec(48, 48))
    match_texture_sections(texture, vec( 8,  8), vec(15, 15), vec( 0,  0))
    match_texture_sections(texture, vec( 8,  8), vec(15, 15), vec(24,  0))
    match_texture_sections(texture, vec( 8,  8), vec(15, 15), vec(32,  0))
    match_texture_sections(texture, vec(56, 16), vec(63, 23), vec(56, 24))
end

function texture_overlay(base, overlay, not_blank)
    base_size = base:getDimensions()
    local overlay_adjust = textures:copy(overlay_name .. "b", overlay)
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
init_blood_lvl_1 = textures["other_textures.blood_lvl_1"] generate_second_layer(init_blood_lvl_1)
init_blood_lvl_2 = textures["other_textures.blood_lvl_2"] generate_second_layer(init_blood_lvl_2)
init_blood_lvl_3 = textures["other_textures.blood_lvl_3"] generate_second_layer(init_blood_lvl_3)

texture_blood_lvl_1 = texture_overlay(textures["skin"], init_blood_lvl_1, true)
texture_blood_lvl_2 = texture_overlay(textures["skin"], textures["other_textures.blood_lvl_2"], true)
texture_blood_lvl_3 = texture_overlay(textures["skin"], textures["other_textures.blood_lvl_3"], true)

texture_extra_blood_lvl_1 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_1"], true)
texture_extra_blood_lvl_2 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_2"], true)
texture_extra_blood_lvl_3 = texture_overlay(textures["extra"], textures["other_textures.extra_blood_lvl_3"], true)

function blood(health)
    if blood_setting == 1 then
        if health > 12 then
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
    elseif blood_setting == 2 then
        models.model.root:setPrimaryTexture("PRIMARY")
        models.model.root.Dress:setPrimaryTexture("PRIMARY")
    elseif blood_setting == 3 then
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_1)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_1)
    elseif blood_setting == 4 then
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_2)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_2)
    elseif blood_setting == 5 then
        models.model.root:setPrimaryTexture("CUSTOM", texture_blood_lvl_3)
        models.model.root.Dress:setPrimaryTexture("CUSTOM", texture_extra_blood_lvl_3)
    end
    models.model.root.Head.Camera:setPrimaryTexture("PRIMARY")
end

function pings.blood_set(setting)
    blood_setting = setting
end

-- Blood Main
function events.tick()
    blood(player:getHealth())
    models.model.root.Head:setVisible(false)
end

-- Pose Editor
PE_FORMAT = "format_default"

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

-- Pe Variables
pe_selected = models.model.root.RightArm

pe_active = false
pe_gumball = true

pe_pos_mode = true
pe_local_mode = false

pe_rot_scale = 15
pe_pos_scale = 1

pe_pos = vec(0, 0, 0)
pe_rot = vec(0, 0, 0)

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

-- Pe Pings
function pings.pe_update_pos(vec)
    pe_selected:setPos(vec)
end

function pings.pe_update_rot(vec)
    pe_selected:setRot(vec)
end

function pe_update()
    if pe_active then
        pings.pe_update_pos(pe_pos)
        pings.pe_update_rot(pe_rot)
        log("§7    " .. tostring(pe_selected:getName()) .. " updated to pos " .. tostring(pe_pos) .. ", and rot " .. tostring(pe_rot))
    end
end

function pe_set_zero(part)
    part:setPos(0, 0, 0)
    part:setRot(0, 0, 0)
end

function pings.pe_clear()
    log("§c§lCleared!")
    pe_rot = vec(0, 0, 0)
    pe_pos = vec(0, 0, 0)
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

-- HUD
models.model.Hud:setScale(PE_SCALE, PE_SCALE, 1)

models.model.Gumball:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")
models.model.Hud:setPrimaryRenderType("CUTOUT_EMISSIVE_SOLID")

pe_button_mode = models.model.Hud.ButtonMode.HighlightMode
pe_button_update = models.model.Hud.ButtonUpdate.HighlightUpdate
pe_button_scale = models.model.Hud.ButtonScale.HighlightScale
pe_button_gumball = models.model.Hud.ButtonGumball.HighlightGumball

if PE_KEYBOARD == 1 then
    models.model.Hud.BlockLaptop:setVisible(false) 
    models.model.Hud.BlockHome:setVisible(true)

    models.model.Hud.ButtonMode:setPos(0, -8, 0)
    models.model.Hud.ButtonScale:setPos(0, -16, 0)
    models.model.Hud.ButtonGumball:setPos(0, -24, 0)
    models.model.Hud.ButtonUpdate:setPos(-16, -24, 0)

    pe_button_forward = models.model.Hud.BlockHome.HighlightHomeForward
    pe_button_backward = models.model.Hud.BlockHome.HighlightHomeBackward
    pe_button_left = models.model.Hud.BlockHome.HighlightHomeLeft
    pe_button_right = models.model.Hud.BlockHome.HighlightHomeRight
    pe_button_up = models.model.Hud.BlockHome.HighlightHomeUp
    pe_button_down = models.model.Hud.BlockHome.HighlightHomeDown
    
elseif PE_KEYBOARD == 2 then
    models.model.Hud.BlockLaptop:setVisible(true) 
    models.model.Hud.BlockHome:setVisible(false) 

    pe_button_forward = models.model.Hud.BlockLaptop.HighlightLaptopForward
    pe_button_backward = models.model.Hud.BlockLaptop.HighlightLaptopBackward
    pe_button_left = models.model.Hud.BlockLaptop.HighlightLaptopLeft
    pe_button_right = models.model.Hud.BlockLaptop.HighlightLaptopRight
    pe_button_up = models.model.Hud.BlockLaptop.HighlightLaptopUp
    pe_button_down = models.model.Hud.BlockLaptop.HighlightLaptopDown
end

function events.tick()
    if pe_active then
        -- Gumball
        local pos = pe_selected:getPivot() + pe_selected:getTruePos() + pe_selected:getParent():getTruePos() + pe_selected:getParent():getParent():getTruePos() -- this is wildly messy but it works
        models.model.Gumball:setVisible(pe_gumball and client:isHudEnabled())
        models.model.Gumball:setPos(pos)
        models.model.Gumball.Pos:setVisible(pe_pos_mode)
        models.model.Gumball.Rot:setVisible(not pe_pos_mode)
        models.model.Gumball.Rot:setRot(pe_selected:getAnimRot())

        -- Hud
        models.model.Hud:setVisible(true) 
        pe_button_mode:setVisible(pe_key_mode:isPressed())
        pe_button_scale:setVisible(pe_key_scale:isPressed())
        pe_button_gumball:setVisible(pe_key_gumball:isPressed())
        pe_button_update:setVisible(pe_key_update:isPressed())
        pe_button_forward:setVisible(pe_key_forward:isPressed())
        pe_button_backward:setVisible(pe_key_backward:isPressed())
        pe_button_up:setVisible(pe_key_up:isPressed())
        pe_button_down:setVisible(pe_key_down:isPressed())
        pe_button_left:setVisible(pe_key_left:isPressed())
        pe_button_right:setVisible(pe_key_right:isPressed())
    else
        models.model.Gumball:setVisible(false)
        models.model.Hud:setVisible(false) 
    end
end

-- Export and Load
function pe_export()
    export = PE_FORMAT
    export = export .. pe_get_part(models.model.root)
    export = export .. pe_get_part(models.model.root.Head)
    export = export .. pe_get_part(models.model.root.Body)
    export = export .. pe_get_part(models.model.root.LeftArm)
    export = export .. pe_get_part(models.model.root.RightArm)
    export = export .. pe_get_part(models.model.root.LeftLeg)
    export = export .. pe_get_part(models.model.root.RightLeg)
    export = export .. pe_get_part(models.model.root.Body.Breast)
    export = export .. pe_get_part(models.model.root.Dress)
    export = export .. pe_get_part(models.model.root.LeftArm.LeftItemPivot)
    export = export .. pe_get_part(models.model.root.RightArm.RightItemPivot)
    export = export .. pe_get_part(models.model.Cape)
    export = export .. pe_get_part(models.model.Elytra.LeftElytra)
    export = export .. pe_get_part(models.model.Elytra.RightElytra)
    
    log("§9§lExported to Clipboard!")
    host:setClipboard(export)
end

function pe_load_func()
    local data = host:getClipboard()
    if #data < 512 then 
        pings.pe_load(data)
    else
        log("    §cLoad failure, §lDATA OVERSIZE " .. tostring(#data) .. "/512")
    end
end

pe_check = 0

function pings.pe_load(data)
    load = split(data, "|")
    if load[1] == PE_FORMAT then
        pe_set_and_convert_part(models.model.root, load[2])
        pe_set_and_convert_part(models.model.root.Head, load[3])
        pe_set_and_convert_part(models.model.root.Body, load[4])
        pe_set_and_convert_part(models.model.root.LeftArm, load[5])
        pe_set_and_convert_part(models.model.root.RightArm, load[6])
        pe_set_and_convert_part(models.model.root.LeftLeg, load[7])
        pe_set_and_convert_part(models.model.root.RightLeg, load[8])
        pe_set_and_convert_part(models.model.root.Body.Breast, load[9])
        pe_set_and_convert_part(models.model.root.Dress, load[10])
        pe_set_and_convert_part(models.model.root.LeftArm.LeftItemPivot, load[11])
        pe_set_and_convert_part(models.model.root.RightArm.RightItemPivot, load[12])
        pe_set_and_convert_part(models.model.Cape, load[13])
        pe_set_and_convert_part(models.model.Elytra.LeftElytra, load[14])
        pe_set_and_convert_part(models.model.Elytra.RightElytra, load[15])

        log("§9§lLoaded from Clipboard! " .. tostring(pe_check) .. "/" .. "14 successful")
    else
        log("    §cLoad failure, §lNO TAG")
    end
    pe_check = 0
end

function pe_set_and_convert_part(part, data)
    if data ~= nil then
        data = string.gsub(data, "{", "")
        data = string.gsub(data, "}", "")
        data = string.gsub(data, ":", ", ")
        data_table = split(data, ", ")

        if pe_check_data(data_table) then
            part:setPos(data_table[1], data_table[2], data_table[3])
            part:setRot(data_table[4], data_table[5], data_table[6])
            pe_check = pe_check + 1
        else
            log("    §c" .. part:getName() .. " failed to load, §lNUMBER ISSUE")
        end
    else
        log("    §c" .. part:getName() .. " failed to load, §lNO DATA")
    end
end

function pe_check_data(data)
    local check = 0
    for i = 1, #data, 1 do
        local data_point = data[i]
        data_point = tonumber(data_point)
        if type(data_point) == "number" then
            check = check + 1
        end
    end
    if check == 6 then  end
    return check == 6
end

function pe_get_part(part)
    pos = part:getPos(0, 0, 0)
    rot = part:getRot(0, 0, 0)
    return "|" .. tostring(pos) .. ":" .. tostring(rot)
end

-- Activate
function pe_func_activate()
    pe_active = not pe_active
    if pe_active then
        log("\n\n§lPOSE EDITOR ENABLED\n")
        action_wheel:setPage(pe_page)
        pings.pe_freeze()
    else
        log("\n\n§lPOSE EDITOR DISABLED\n")
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
            log("§dSmall")
            models.model.Hud.ButtonScale:setScale(1, 1, -1)
            pe_rot_scale = 1
            pe_pos_scale = 0.1
        else
            log("§dLarge")
            models.model.Hud.ButtonScale:setScale(1, 1, 1)
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
            models.model.Hud.ButtonMode:setScale(1, 1, 1)
            log("§6Position")
        else
            models.model.Hud.ButtonMode:setScale(1, 1, -1)
            log("§6Rotation")
        end
    end
end
pe_key_mode.press = pe_func_mode

-- Gumball
function pe_func_gumball()
    if pe_active then
        pe_gumball = not pe_gumball
        if pe_gumball then
            models.model.Hud.ButtonGumball:setScale(1, 1, 1)
            log("§aGumball On")
        else
            models.model.Hud.ButtonGumball:setScale(1, 1, -1)
            log("§aGumball Off")
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
        pe_edit(vec(-1, 0, 0))
    end
end
pe_key_forward.press = pe_func_forward

-- Backward
function pe_func_backward()
    if pe_pos_mode then
        pe_edit(vec(0, 0, -1))
    else
        pe_edit(vec(1, 0, 0))
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
    :title("Other (RMB Config)")
    :texture(textures["other_textures.icons"],32 ,16 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(function()
        action_wheel:setPage(pe_page_2)
        display_text:setText("Pose Editor Other")
    end)
    :onRightClick(function()
        action_wheel:setPage(config_page)
        display_text:setText("Config")
    end)


action = pe_page:newAction(5)
    :title("Exit (RMB Clear)")
    :item("minecraft:barrier")
    :hoverColor(HOVER)
    :onLeftClick(function()
        pe_func_activate()
    end)
    :onRightClick(function()
        --pe_export()
        pings.pe_clear()
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
    :title("Export to Clipboard (RMB Load)")
    :texture(textures["other_textures.icons"],16 ,48 ,16, 16)
    :hoverColor(HOVER)
    :onLeftClick(pe_export)
    :onRightClick(pe_load_func)

action = pe_page_2:newAction()
    :title("Back")
    :item("minecraft:barrier")
    :hoverColor(HOVER)
    :onLeftClick(function()
        action_wheel:setPage(pe_page)
        display_text:setText("Pose Editor")
    end)

-- Action Functions
function pings.cape_toggle(setting)
    models.model.Cape:setVisible(setting)
end

function pings.blush_toggle(setting)
    models.model.root.Head.MainExpression:setVisible(not setting) 
    models.model.root.Head.SecondaryExpression:setVisible(setting)
end

function check_toggles()
    main_page:newAction(8)
        :title("Play Last: " .. last_animation)
        :item("minecraft:amethyst_shard")
        :hoverColor(HOVER)
        :onLeftClick(play_last_animation)
end

-- Actions
local action = main_page:newAction(1)
    :title("Wave")
    :item("minecraft:bell")
    :hoverColor(HOVER)
    :onLeftClick(pings.wave)

local action = main_page:newAction(2)
    :title("Curl")
    :item("minecraft:sugar")
    :hoverColor(HOVER)
    :onLeftClick(pings.curl)

local action = main_page:newAction(3)
    :title("Sit Down")
    :item("minecraft:grass_block")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_floor)

local action = main_page:newAction(4)
    :title("Sit")
    :item("minecraft:oak_planks")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_block)

main_page:setAction(5, require("script_emotes_page"))

main_page:setAction(6, require("script_poses_page"))

local action = main_page:newAction(7)
    :title("Config")
    :onLeftClick(function()
        action_wheel:setPage(config_page)
        display_text:setText("Config")
        config_position = 1
    end)
    :hoverColor(HOVER)
    :item("minecraft:name_tag")

local action = main_page:newAction(8)
    :title("Play Last: " .. last_animation)
    :item("minecraft:amethyst_shard")
    :hoverColor(HOVER)
    :onLeftClick(play_last_animation)

-- Config
config_page:newAction()
    :title("Blush Enable")
    :toggleTitle("Blush Disable")
    :item("minecraft:pink_dye")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() pings.blush_toggle(true) end)
    :onUntoggle(function() pings.blush_toggle(false) end)

if EYES == 1 then blink_name = "Blink Auto" end 
if EYES == 2 then blink_name = "Eyes Closed" end 
if EYES == 3 then blink_name = "Right Eye Closed" end 
if EYES == 4 then blink_name = "Left Eye Closed" end
if EYES == 5 then blink_name = "Eyes Open" end

if EYES == 1 then blink_icon = "minecraft:ender_eye" end 
if EYES == 2 then blink_icon = "minecraft:ender_pearl" end 
if EYES == 3 then blink_icon = "minecraft:ender_pearl" end 
if EYES == 4 then blink_icon = "minecraft:ender_pearl" end
if EYES == 5 then blink_icon = "minecraft:ender_pearl" end

config_page:newAction()
    :title(blink_name)
    :item(blink_icon)
    :hoverColor(HOVER)
    :setOnScroll(function(dir, self)
        blink = blink - dir
        if blink < 1 then
            blink = 5
        elseif blink > 5 then
            blink = 1
        end
        if blink == 1 then self:title("Blink Auto") self:item("minecraft:ender_eye") end 
        if blink == 2 then self:title("Eyes Closed") self:item("minecraft:ender_pearl") end 
        if blink == 3 then self:title("Right Eye Closed") self:item("minecraft:ender_pearl") end 
        if blink == 4 then self:title("Left Eye Closed") self:item("minecraft:ender_pearl") end 
        if blink == 5 then self:title("Eyes Open") self:item("minecraft:ender_pearl") end 
        pings.blink_set(blink)
    end)

config_page:newAction()
    :title("Pose Editor")
    :texture(textures["other_textures.technical"], 0, 47, 17, 17)
    :hoverColor(HOVER)
    :onLeftClick(pe_func_activate)

if CAPE then
    config_page:newAction()
        :title("Cape Enabled")
        :toggleTitle("Cape Disabled")
        :item("minecraft:yellow_carpet")
        :hoverColor(HOVER)
        :toggleColor(RED)
        :onToggle(function() pings.cape_toggle(false) end)
        :onUntoggle(function() pings.cape_toggle(true) end)
else
    config_page:newAction()
        :title("Cape Disabled")
        :toggleTitle("Cape Enabled")
        :item("minecraft:yellow_carpet")
        :hoverColor(HOVER)
        :toggleColor(GREEN)
        :onToggle(function() pings.cape_toggle(true) end)
        :onUntoggle(function() pings.cape_toggle(false) end)
end

if BLOOD == 1 then blood_name = "Blood Auto" end 
if BLOOD == 2 then blood_name = "Blood Off" end 
if BLOOD == 3 then blood_name = "Blood Lvl 1" end 
if BLOOD == 4 then blood_name = "Blood Lvl 2" end
if BLOOD == 5 then blood_name = "Blood Lvl 3" end

if BLOOD == 1 then blood_icon = "minecraft:redstone" end 
if BLOOD == 2 then blood_icon = "minecraft:redstone_block" end 
if BLOOD == 3 then blood_icon = "minecraft:redstone_block" end 
if BLOOD == 4 then blood_icon = "minecraft:redstone_block" end
if BLOOD == 5 then blood_icon = "minecraft:redstone_block" end

config_page:newAction()
    :title(blood_name)
    :item(blood_icon)
    :hoverColor(HOVER)
    :setOnScroll(function(dir, self)
        blood_setting = blood_setting - dir
        if blood_setting < 1 then
            blood_setting = 5
        elseif blood_setting > 5 then
            blood_setting = 1
        end
        if blood_setting == 1 then self:title("Blood Auto") self:item("minecraft:redstone") end 
        if blood_setting == 2 then self:title("Blood Off") self:item("minecraft:redstone_block") end 
        if blood_setting == 3 then self:title("Blood Lvl 1") self:item("minecraft:redstone_block") end 
        if blood_setting == 4 then self:title("Blood Lvl 2") self:item("minecraft:redstone_block") end
        if blood_setting == 5 then self:title("Blood Lvl 3") self:item("minecraft:redstone_block") end
        pings.blood_set(blood_setting)
    end)


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
    :onLeftClick(function() pings.emoticon_set(current_emoticon) end)
    :onRightClick(pings.emoticon_reset)
    :setOnScroll(function(dir, self)
        current_emoticon = current_emoticon - dir
        if current_emoticon < 1 then
            current_emoticon = 4
        elseif current_emoticon > 4 then
            current_emoticon = 1
        end
        if current_emoticon == 1 then self:title("Emoticon (\" ! \")") end 
        if current_emoticon == 2 then self:title("Emoticon (\" ? \")") end 
        if current_emoticon == 3 then self:title("Emoticon (\" :3 \")") end 
        if current_emoticon == 4 then self:title("Emoticon (\" :) \")") end
    end)

config_page:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        if pe_active then
            action_wheel:setPage(pe_page)
            display_text:setText("Pose Editor")
        else
            action_wheel:setPage(main_page)
            display_text:setText("Main")
        end
    end)
    :hoverColor(HOVER)

-- Config Page 2
if ARMOR_HELMET then
    helmet = true
    config_page_2:newAction(1)
        :title("Helmet On")
        :toggleTitle("Helmet Off")
        :item("minecraft:iron_helmet")
        :hoverColor(HOVER)
        :toggleColor(RED)
        :onUntoggle(function() 
            helmet = true
            pings.helmet_on()
        end)
        :onToggle(function() 
            helmet = false
            pings.helmet_off()
        end)
else
    helmet = false
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
end

if ARMOR_CHESTPLATE then
    chestplate = true
    config_page_2:newAction(2)
        :title("Chestplate On")
        :toggleTitle("Chestplate Off")
        :item("minecraft:iron_chestplate")
        :hoverColor(HOVER)
        :toggleColor(RED)
        :onUntoggle(function() 
            chestplate = true
            pings.chestplate_on()
        end)
        :onToggle(function() 
            chestplate = false
            pings.chestplate_off()
        end)
else
    chestplate = false
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
end

if ARMOR_LEGGINGS then
    leggings = true
    config_page_2:newAction(3)
        :title("Leggings On")
        :toggleTitle("Leggings Off")
        :item("minecraft:iron_leggings")
        :hoverColor(HOVER)
        :toggleColor(RED)
        :onUntoggle(function() 
            leggings = true
            pings.leggings_on()
        end)
        :onToggle(function() 
            leggings = false
            pings.leggings_off()
        end)
else
    leggings = false
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
end

if ARMOR_BOOTS then
    boots = true
    config_page_2:newAction(4)
        :title("Boots On")
        :toggleTitle("Boots Off")
        :item("minecraft:iron_boots")
        :hoverColor(HOVER)
        :toggleColor(RED)
        :onUntoggle(function() 
            boots = true
            pings.boots_on()
        end)
        :onToggle(function() 
            boots = false
            pings.boots_off()
        end)
else
    boots = false
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
end

config_page_2:newAction(6)
    :title("ModCompat: Figura")
    :item("minecraft:iron_ingot")
    :hoverColor(HOVER)
    :setOnScroll(function(dir, self)
        armor = armor - dir
        if armor < 1 then
            armor = 4
        elseif armor > 4 then
            armor = 1
        end
        if armor == 1 then self:title("ModCompat: Figura") self:item("minecraft:iron_ingot") end 
        if armor == 2 then self:title("ModCompat: Figura - Modelparts") self:item("minecraft:iron_ingot") end 
        if armor == 3 then self:title("ModCompat: Vanilla") self:item("minecraft:iron_ingot") end 
        if armor == 4 then self:title("ModCompat: Vanilla + Breast") self:item("minecraft:iron_ingot") end 

        pings.armor_set(armor)
    end)

--[[
config_page_2:newAction(6)
    :title("Mod Compat Off")
    :toggleTitle("Mod Compat On")
    :item("minecraft:iron_ingot")
    :hoverColor(HOVER)
    :toggleColor(GREEN)
    :onToggle(function() 
        pings.armor_pivots_toggle(false)
    end)
    :onUntoggle(function() 
        pings.armor_pivots_toggle(true)
    end)
--]]

config_page_2:newAction(7)
    :title("Pivots On")
    :toggleTitle("Pivots Off")
    :item("minecraft:iron_sword")
    :hoverColor(HOVER)
    :toggleColor(RED)
    :onToggle(function() 
        pings.pivots_toggle(false)
    end)
    :onUntoggle(function() 
        pings.pivots_toggle(true)
    end)

config_page_2:newAction(8)
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(config_page)
        display_text:setText("Config Page")
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
