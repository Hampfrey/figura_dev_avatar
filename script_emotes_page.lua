local emotes_page = action_wheel:newPage()

-- Colors
GREEN = vec(0.43, 0.76, 0.246)
RED = vec(0.93, 0.14, 0.23)
HOVER = vec(0.96, 0.66, 0.72)

-- Functions
function pings.wave()
    last_animation = "wave"
    armor_checked = false
    multimodel_stop_all() check_toggles()
    multimodel_play("wave")
end

function pings.stretch()
    last_animation = "stretch"
    armor_checked = false
    multimodel_stop_all() check_toggles()
    multimodel_play("stretch")
end

-- Define the Actions within the Page
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

-- This variable stores the Page to go back to when done with this Page

-- This Action just sets the stored page as active
emotes_page:newAction()
    :title("Go Back")
    :item("minecraft:barrier")
    :onLeftClick(function()
        action_wheel:setPage(main_page)
        display_text:setText("Main")
    end)
    :hoverColor(HOVER)

return action_wheel:newAction()
    :title("Emotes")
    :onLeftClick(function()
        action_wheel:setPage(emotes_page)
        display_text:setText("Emotes")
    end)
    :hoverColor(HOVER)
    :item("minecraft:music_disc_otherside")
    