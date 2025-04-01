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

function action_wheel_animation_control(animation_name)
    last_animation = animation_name
    if anim_is_active(animations.model[animation_name]) then
        animations.model[animation_name .. "_end"]:play()
        animations.model[animation_name]:stop()
    else
        animations:stopAll()
        check_toggles()
        animations.model[animation_name]:play()
    end
end

-- Neutral Page Functions
function pings.lean_fence()
    action_wheel_animation_control("lean_fence")
end

function pings.lean_forward()
    action_wheel_animation_control("lean_forward")
end

function pings.lean_left()
    action_wheel_animation_control("lean_left")
end

function pings.lean_right()
    action_wheel_animation_control("lean_right")
end

function pings.lean_backward()
    action_wheel_animation_control("lean_backward")
end

function pings.sit_slab()
    action_wheel_animation_control("sit_slab")
end

function pings.sit_block()
    action_wheel_animation_control("sit_block")
end

function pings.sit_block_top()
    action_wheel_animation_control("sit_block_top")
end

function pings.sit_wall()
    action_wheel_animation_control("sit_wall")
end

function pings.sit_floor()
    action_wheel_animation_control("sit_floor")
end

function pings.sleep()
    action_wheel_animation_control("sleep")
end

function pings.handstand()
    action_wheel_animation_control("handstand")
end

-- Confident Page Functions
function pings.lean_backward_arms_up()
    action_wheel_animation_control("lean_backward_arms_up")
end

function pings.sit_slab_sprawl()
    action_wheel_animation_control("sit_slab_sprawl")
end

function pings.sit_stairs()
    action_wheel_animation_control("sit_stairs")
end

-- Shy Page Functions
function pings.sit_slab_shy()
    action_wheel_animation_control("sit_slab_shy")
end

function pings.sit_wall_shy()
    action_wheel_animation_control("sit_wall_shy")
end

function pings.curl()
    action_wheel_animation_control("curl")
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
    