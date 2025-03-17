local neutral_poses_page_1 = action_wheel:newPage()
local neutral_poses_page_2 = action_wheel:newPage()
local conf_poses_page_1 = action_wheel:newPage()
local shy_poses_page_1 = action_wheel:newPage()

-- Colors
GREEN = vec(0.43, 0.76, 0.246)
RED = vec(0.93, 0.14, 0.23)
HOVER = vec(0.96, 0.66, 0.72)

-- Position
scroll_lock_key = keybinds:newKeybind("Scroll Lock", "key.mouse.right")
local position = 1
local sub_position = 1
function action_wheel.scroll(direction)
    if neutral_poses_page_1 == action_wheel:getCurrentPage() or neutral_poses_page_2 == action_wheel:getCurrentPage() or conf_poses_page_1 == action_wheel:getCurrentPage() or shy_poses_page_1 == action_wheel:getCurrentPage() or other_poses_page_1 == action_wheel:getCurrentPage() then
        if scroll_lock_key:isPressed() then
--[[
            -- Neutral Sub Pages
            if position == 1 then
                sub_position = sub_position - direction
                if sub_position < 1 then
                    sub_position = 1
                elseif sub_position > 1 then
                    sub_position = 1
                end

                if sub_position == 1 then action_wheel:setPage(neutral_poses_page_1) display_text:setText("Neutral 1/1") end
            end
--]]
        else
            position = position - direction
            if position < 1 then
                position = 4
            elseif position > 4 then
                position = 1
            end

            if position == 1 then action_wheel:setPage(neutral_poses_page_1) display_text:setText("Neutral 1/2") end
            if position == 2 then action_wheel:setPage(neutral_poses_page_2) display_text:setText("Neutral 2/2") end
            if position == 3 then action_wheel:setPage(conf_poses_page_1) display_text:setText("Confident 1/1") end
            if position == 4 then action_wheel:setPage(shy_poses_page_1) display_text:setText("Shy 1/1") end
            sub_position = 1 -- sub_position is reset back to default if another page is moved to
        end
    end
end

-- Neutral Page Functions
function pings.lean_fence()
    --pings.armor_off()
    if anim_is_active(animations.model.lean_fence)
        then multimodel_play("lean_fence_end")
            multimodel_stop("lean_fence")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_fence")
            last_animation = "lean_fence"
    end
end

function pings.lean_forward()
    last_animation = "lean_forward"
    --pings.armor_off()
    if anim_is_active(animations.model.lean_forward)
        then multimodel_play("lean_forward_end")
            multimodel_stop("lean_forward")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_forward")
    end
end

function pings.lean_left()
    last_animation = "lean_left"
    --pings.armor_off()
    if anim_is_active(animations.model.lean_left)
        then multimodel_play("lean_left_end")
            multimodel_stop("lean_left")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_left")
    end
end

function pings.lean_right()
    last_animation = "lean_right"
    --pings.armor_off()
    if anim_is_active(animations.model.lean_right)
        then multimodel_play("lean_right_end")
            multimodel_stop("lean_right")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_right")
    end
end

function pings.lean_backward()
    last_animation = "lean_backward"
    --pings.armor_off()
    if anim_is_active(animations.model.lean_backward)
        then multimodel_play("lean_backward_end")
            multimodel_stop("lean_backward")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_backward")
    end
end

function pings.sit_slab()
    last_animation = "sit_slab"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_slab)
        then multimodel_play("sit_slab_end")
            multimodel_stop("sit_slab")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_slab")
    end
end

function pings.sit_block()
    last_animation = "sit_block"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_block)
        then multimodel_play("sit_block_end")
            multimodel_stop("sit_block")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_block")
    end
end

function pings.sit_block_top()
    last_animation = "sit_block_top"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_block_top)
        then sleeping = false multimodel_stop_all() check_toggles()
            multimodel_play("sit_block_top_end")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_block_top")
    end
end

function pings.sit_wall()
    last_animation = "sit_wall"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_wall)
        then multimodel_play("sit_wall_end")
            multimodel_stop("sit_wall")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_wall")
    end
end

function pings.sit_floor()
    last_animation = "sit_floor"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_floor)
        then multimodel_play("sit_floor_end")
            multimodel_stop("sit_floor")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_floor")
    end
end

function pings.sleep()
    last_animation = "sleep"
    --pings.armor_off()
    if anim_is_active(animations.model.sleep)
        then multimodel_play("sleep_end")
            multimodel_stop("sleep")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sleep")
    end
end

function pings.handstand()
    last_animation = "handstand"
    --pings.armor_off()
    if anim_is_active(animations.model.handstand)
        then multimodel_play("handstand_end")
            multimodel_stop("handstand")
        else multimodel_stop_all() check_toggles()
            multimodel_play("handstand")
    end
end

-- Confident Page Functions
function pings.lean_backward_arms_up()
    last_animation = "lean_backward_arms_up"
    --pings.armor_off()
    if anim_is_active(animations.model.lean_backward_arms_up)
        then multimodel_play("lean_backward_arms_up_end")
            multimodel_stop("lean_backward_arms_up")
        else multimodel_stop_all() check_toggles()
            multimodel_play("lean_backward_arms_up")
    end
end

function pings.sit_slab_sprawl()
    last_animation = "sit_slab_sprawl"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_slab_sprawl)
        then multimodel_play("sit_slab_sprawl_end")
            multimodel_stop("sit_slab_sprawl")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_slab_sprawl")
    end
end

function pings.sit_stairs()
    last_animation = "sit_stairs"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_stairs)
        then multimodel_play("sit_stairs_end")
            multimodel_stop("sit_stairs")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_stairs")
    end
end

-- Shy Page Functions
function pings.sit_slab_shy()
    last_animation = "sit_slab_shy"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_slab_shy)
        then multimodel_play("sit_slab_shy_end")
            multimodel_stop("sit_slab_shy")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_slab_shy")
    end
end


function pings.sit_wall_shy()
    last_animation = "sit_wall_shy"
    --pings.armor_off()
    if anim_is_active(animations.model.sit_wall_shy)
        then multimodel_play("sit_wall_shy_end")
            multimodel_stop("sit_wall_shy")
        else multimodel_stop_all() check_toggles()
            multimodel_play("sit_wall_shy")
    end
end

function pings.curl()
    last_animation = "curl"
    --pings.armor_off()
    if anim_is_active(animations.model.curl)
        then sleeping = false multimodel_stop_all() check_toggles()
            multimodel_play("curl_end")
        else multimodel_stop_all() check_toggles()
            multimodel_play("curl")
    end
end

-- Neutral Page Actions
neutral_poses_page_1:newAction()
    :title("Lean Forward (RMB for Fence)")
    :item("minecraft:oak_fence")
    :hoverColor(HOVER)
    :onLeftClick(pings.lean_forward)
    :onRightClick(pings.lean_fence)

neutral_poses_page_1:newAction()
    :title("Lean Left (RMB for Right) ")
    :item("minecraft:oak_log")
    :hoverColor(HOVER)
    :onLeftClick(pings.lean_left)
    :onRightClick(pings.lean_right)

neutral_poses_page_1:newAction()
    :title("Lean Back")
    :item("minecraft:oak_door")
    :hoverColor(HOVER)
    :onLeftClick(pings.lean_backward)

neutral_poses_page_1:newAction()
    :title("Sit Down")
    :item("minecraft:oak_slab")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_slab)

neutral_poses_page_1:newAction()
    :title("Sit Up")
    :item("minecraft:oak_planks")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_block)

neutral_poses_page_1:newAction()
    :title("Sit Down")
    :item("minecraft:oak_trapdoor")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_block_top)

neutral_poses_page_1:newAction()
    :title("Sit Against")
    :item("minecraft:stripped_oak_log")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_wall)

neutral_poses_page_1:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Neutral Page 2 Actions
neutral_poses_page_2:newAction()
    :title("Sit")
    :item("minecraft:grass_block")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_floor)

neutral_poses_page_2:newAction()
    :title("Sleep")
    :item("minecraft:red_bed")
    :hoverColor(HOVER)
    :onLeftClick(pings.sleep)

neutral_poses_page_2:newAction()
    :title("Handstand")
    :item("minecraft:podzol")
    :hoverColor(HOVER)
    :onLeftClick(pings.handstand)

neutral_poses_page_2:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Confident Page Actions
conf_poses_page_1:newAction()
    :title("Lean Back")
    :item("minecraft:warped_door")
    :hoverColor(HOVER)
    :onLeftClick(pings.lean_backward_arms_up)

conf_poses_page_1:newAction()
    :title("Sit Sprawled")
    :item("minecraft:warped_slab")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_slab_sprawl)

conf_poses_page_1:newAction()
    :title("Sit Stairs")
    :item("minecraft:warped_stairs")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_stairs)

conf_poses_page_1:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Shy Page Actions
shy_poses_page_1:newAction()
    :title("Sit Down")
    :item("minecraft:spruce_slab")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_slab_shy)

shy_poses_page_1:newAction()
    :title("Sit Down")
    :item("minecraft:stripped_spruce_log")
    :hoverColor(HOVER)
    :onLeftClick(pings.sit_wall_shy)

shy_poses_page_1:newAction()
    :title("Curl")
    :item("minecraft:sugar")
    :hoverColor(HOVER)
    :onLeftClick(pings.curl)

shy_poses_page_1:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Open Poses
return action_wheel:newAction()
    :title("Poses")
    :onLeftClick(function()
        action_wheel:setPage(neutral_poses_page_1)
        position = 1
        sub_position = 1
        display_text:setText("Neutral 1/2")
    end)
    :hoverColor(HOVER)
    :item("minecraft:armor_stand")
    