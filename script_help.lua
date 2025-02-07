-- F6 Help Function
function help()
    log("HELP\nFigura\n    This avatar isn't complex, any settings should be fine, although I can\n    guarantee it will work with \"Action Wheel Mode : Hold\"\n    Avatar Keybinds\n        - Scroll Lock, the button used to navigate to sub pages, hold it and \n          scroll\n        - Zoom, (default \"R\"), ever get annoyed when playing without optifine \n          that you don't have zoom? well this gives you a slightly bootleg \n          alternative\n        - Print Help (default \"F6\"), this prints help to your local chat\n        - End Animations (default \"Right Mouse Button\"), when the action wheel\n          is open, pressing this key will cause any poses to end\n        - \"Fifth One\", automatically set to your action wheel button, sends you\n           to the main page upon closing the wheel\n\nAction Wheel\n    By default set to \"B\" in Figura, although I'd recommend something on your\n    mouse \n    Actions\n        - Wave, plays the wave emote, you're left arm will wave\n        - Sit, plays the sit pose. This does not activate with any other\n          sitting state such as minecarts or boats\n        - Emotes, opens the emotes menu\n        - Poses, opens the poses menu, within there are two pages, accessed           \n          by scrolling\n            - Neutral Poses, poses with a neutral feel, this has one sub page\n            - Confident Poses, poses with a confident feel\n        - Toggles, opens the toggles menu, within there are two buttons\n            - Armor, toggles armor on and off, this will only affect armor that\n              renders in the default method. (Armor such as The Aether's gloves\n              would not) Importantly, armor will disable during animations,\n              this is so that modded armors work\n            - Cape, toggles the cape on and off, the cape texture can be\n              changed by editing \"cape.png\" in the avatar folder\n        - Play Last, will play the most recent animation\n    Config\n        - Hover Color, if you want to customize the color you get when hovering\n          over an action, go into the files \"script.lua\", \n          \"script_poses_page.lua\", and \"script_emotes_page.lua\" with any text \n          editor (notepad works!), and right near the top you will find \n          \"-- Colors\". Here you will find the color constants, GREEN is for \n          toggles that turn on, RED is for toggles that turn off, and HOVER is \n          the color for hovering. These will take an RGB color code that has \n          been converted into a percent (IE Red / 255, Green / 255, Blue / 255)\n\nWarnings\n    - Not guarenteed to work with some mods, espically any that affect the way\n      armor and the player are rendered\n    - Figura is client side, this means that anyone without the mod\n      will not see anything different. Additionally, because of the way\n      actions and movement is synced, any animations that are playing may not\n      sync if a player joins during one, I'd recommend reloading your avatar\n      every once in a while.\n\nIf there are any issues, msg me and I'll attempt to fix them.\n")
end


--[[
Figura
    This avatar isn't complex, any settings should be fine, although I can
    guarantee it will work with "Action Wheel Mode : Hold"
    Avatar Keybinds
        - Scroll Lock, the button used to navigate to sub pages, hold it and 
          scroll
        - Zoom, (default "R"), ever get annoyed when playing without optifine 
          that you don't have zoom? well this gives you a slightly bootleg 
          alternative
        - Print Help (default "F6"), this prints help to your local chat
        - End Animations (default "Right Mouse Button"), when the action wheel
          is open, pressing this key will cause any poses to end
        - "Fifth One", automatically set to your action wheel button, sends you
           to the main page upon closing the wheel

Action Wheel
    By default set to "B" in Figura, although I'd recommend something on your
    mouse 
    Actions
        - Wave, plays the wave emote, you're left arm will wave
        - Sit, plays the sit pose. This does not activate with any other
          sitting state such as minecarts or boats
        - Emotes, opens the emotes menu
        - Poses, opens the poses menu, within there are two pages, accessed           
          by scrolling
            - Neutral Poses, poses with a neutral feel, this has one sub page
            - Confident Poses, poses with a confident feel
        - Toggles, opens the toggles menu, within there are two buttons
            - Armor, toggles armor on and off, this will only affect armor that
              renders in the default method. (Armor such as The Aether's gloves
              would not) Importantly, armor will disable during animations,
              this is so that modded armors work
            - Cape, toggles the cape on and off, the cape texture can be
              changed by editing "cape.png" in the avatar folder
        - Play Last, will play the most recent animation
    Config
        - Hover Color, if you want to customize the color you get when hovering
          over an action, go into the files "script.lua", 
          "script_poses_page.lua", and "script_emotes_page.lua" with any text 
          editor (notepad works!), and right near the top you will find 
          "-- Colors". Here you will find the color constants, GREEN is for 
          toggles that turn on, RED is for toggles that turn off, and HOVER is 
          the color for hovering. These will take an RGB color code that has 
          been converted into a percent (IE Red / 255, Green / 255, Blue / 255)

Warnings
    - Not guarenteed to work with some mods, espically any that affect the way
      armor and the player are rendered
    - Figura is client side, this means that anyone without the mod
      will not see anything different. Additionally, because of the way
      actions and movement is synced, any animations that are playing may not
      sync if a player joins during one, I'd recommend reloading your avatar
      every once in a while.

If there are any issues, msg me and I'll attempt to fix them.
--]]