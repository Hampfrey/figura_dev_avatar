local emotes_page = action_wheel:newPage()

-- Colors
GREEN = vec(0.43, 0.76, 0.246)
RED = vec(0.93, 0.14, 0.23)
HOVER = vec(0.96, 0.66, 0.72)

local function action_wheel_animation_control(animation_name)
    last_animation = animation_name
    animations:stopAll() check_toggles()
    animations.model[animation_name]:play()
end

-- Functions
function pings.wave()
    action_wheel_animation_control("wave")
end

function pings.stretch()
    action_wheel_animation_control("stretch")
end

-- Actions
emotes_page:newAction()
    :title("Wave")
    :item("minecraft:bell")
    :hoverColor(HOVER)
    :onLeftClick(pings.wave)

emotes_page:newAction()
    :title("Stretch")
    :item("minecraft:pink_wool")
    :hoverColor(HOVER)
    :onLeftClick(pings.stretch)

emotes_page:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

-- Open Emotes
return action_wheel:newAction()
    :title("Emotes")
    :onLeftClick(function()
        action_wheel:setPage(emotes_page)
        display_text:setText("Emotes")
    end)
    :hoverColor(HOVER)
    :item("minecraft:music_disc_otherside")
    