-- F6 Help Function
function help()
    log("\nFigura Settings\n    This avatar isn't complex, any settings should be fine, although I can\n    guarantee it will work with \"Action Wheel Mode : Hold\"\n    Avatar Keybinds\n      - Print Help (default \"F6\"), this prints help to your local chat\n      - Pose Editor (default \"F7\"), this toggles the pose editor\n      - End Animations (default \"Right Mouse Button\"), when the action wheel\n        is open, pressing this key will cause any poses to end\n\nAction Wheel\n    By default set to \"B\" in Figura, recommend changing to a mouse button\n    Actions\n      - Wave, plays the wave emote, you're left arm will wave\n      - Three on Demand Animations, see \"script\" settings for these\n      - Emotes, opens the emotes menu\n      - Poses, opens the poses menu, scroll to access the rest of the animations\n      - Config, opens the config menu and all of its special aspects\n      - Play Last, will play the most recent animation\n    Other\n      - Quick End, press the \"End Animations\" button, to end active animation\n\nConfig Menu\n    A moderate array of settings\n    Actions\n      - Secondary Facial Expression, switches to the second face\n      - Eye, scroll to select the active eye mode, \"Auto\" animates the face\n        while the others hold specific settings\n      - Pose Editor, toggles the pose editor\n      - Cape, toggles the cape\n      - Blood, scroll to select the active blood mode, \"Auto\" will change\n        blood based on health, other settings hold specific textures\n      - Armor, opens the armor menu\n          - Helmet\n          - Chestplate\n          - Leggings\n          - Boots\n          - ModCompat, scroll to select the armor render mode\n              - \"Figura\" will use KattArmor to apply dress armor and breast \n                armor, and will use figura's renderer\n              - \"Figura - Modelparts\" disables KattArmor, hides the breast, but\n                continues to use figura's renderer\n              - \"Vanilla\" switches to vanilla armor and hides the breast, \n                vanilla armor hides itself during animations \n                (can be bugged with pose editor)\n              - \"Vanilla + Breast\" reenables the breast for certain stylistic \n                choices\n          - Pivots, toggles whether or not to use figura's item renderer\n      - Emoticons, adds a little emote above your head, left click to enable, \n        right click to disable, scroll to select emote\n\nPose Editor\n    A tool for making poses or editing animation poses on the fly, select a\n    part to edit, then rotate and position it to your liking, the names of\n    actions are based on the actual part name, their position on the wheel is\n    based on their position in space relative to facing the player\n    Actions\n      - Other opens second menu for other parts\n      - RMB Other opens the config menu\n    Other\n      - Hands, LMB and RMB based on visual position from front\n      - Export & Load, Export takes the current positions and rotations of every\n        part, and packs it into the clipboard, Load takes the current clipboard\n        and sets positions and rotations from it\n    Using Pose Editor\n        After selecting a part, turn your attention to the GUI in the top left\n        corner, this shows the button format, currently there are 2\n          - Home Block, (1), the Insert, Home, Page Up, Delete, End, and Page \n            Down keys act as adjusters, while the arrow keys are settings\n          - Laptop, (2), the arrow keys plus / and right shift act as adjusters\n            while, \",\", \".\", right Alt, and right Ctrl are settings\n        Adjusters, change the rotation and position in increments\n        Settings\n          - Change mode, changes between position and rotation\n          - Scale, toggles the size of adjustments\n          - Gumball, toggles the Gumball on and off\n          - Update, sends a ping to the server with the current adjustments\n        Gumball, a tool to roughly show how something will be adjusted\n\nWarnings\n  - Not guaranteed to work with some mods, especially any that affect the way\n    armor and the player are rendered\n  - Figura is client side, this means that anyone without the mod\n    will not see anything different. Additionally, because of the way\n    actions and movement is synced, any animations that are playing may not\n    sync if a player joins during one, I'd recommend reloading your avatar\n    every once in a while.\n\nMore Information in script_help.lua")
end


--[[
Figura Settings
    This avatar isn't complex, any settings should be fine, although I can
    guarantee it will work with "Action Wheel Mode : Hold"
    Avatar Keybinds
      - Print Help (default "F6"), this prints help to your local chat
      - Pose Editor (default "F7"), this toggles the pose editor
      - End Animations (default "Right Mouse Button"), when the action wheel
        is open, pressing this key will cause any poses to end

Action Wheel
    By default set to "B" in Figura, reccomend changing to a mouse button
    Actions
      - Wave, plays the wave emote, you're left arm will wave
      - Three on Demand Animations, see "script" settings for these
      - Emotes, opens the emotes menu
      - Poses, opens the poses menu, scroll to access the rest of the animations
      - Config, opens the config menu and all of its special aspects
      - Play Last, will play the most recent animation
    Other
      - Quick End, press the "End Animations" button, to end active animation

Config Menu
    A moderate array of settings
    Actions
      - Secondary Facial Expression, switches to the second face
      - Eye, scroll to select the active eye mode, "Auto" animates the face
        while the others hold specific settings
      - Pose Editor, toggles the pose editor
      - Cape, toggles the cape
      - Blood, scroll to select the active blood mode, "Auto" will change
        blood based on health, other settings hold specific textures
      - Armor, opens the armor menu
          - Helmet
          - Chestplate
          - Leggings
          - Boots
          - ModCompat, scroll to select the armor render mode
              - "Figura" will use KattArmor to apply dress armor and breast 
                armor, and will use figura's renderer
              - "Figura - Modelparts" disables KattArmor, hides the breast, but
                continues to use figura's renderer
              - "Vanilla" switches to vanilla armor and hides the breast, 
                vanilla armor hides itself during animations 
                (can be bugged with pose editor)
              - "Vanilla + Breast" reenables the breast for certain stylistic 
                choices
          - Pivots, toggles whether or not to use figura's item renderer
      - Emoticons, adds a little emote above your head, left click to enable, 
        right click to disable, scroll to select emote

Pose Editor
    A tool for making poses or editing animation poses on the fly, select a
    part to edit, then rotate and position it to your liking, the names of
    actions are based on the actual part name, their position on the wheel is
    based on their position in space relative to facing the player
    Actions

       [Body ] [Head ]
       [     ] [     ]

    [Left ]       [Right]
    [ Arm ]       [ Arm ]

    [Left ]       [Right]
    [ Leg ]       [ Leg ]

       [Exit ] [Other]
       [     ] [Confi]

      - Other opens second menu for other parts
      - RMB Other opens the config menu

    Other

       [Retur] [Dress]
       [  n  ] [     ]

    [Expor]       [Breas]
    [Load ]       [  t  ]

    [Hands]       [Root ]
    [     ]       [     ]

       [Elytr] [Cape ]
       [  a  ] [     ]

      - Hands, LMB and RMB based on visual postion from front
      - Export & Load, Export takes the current postions and rotations of every
        part, and packs it into the clipboard, Load takes the current clipboard
        and sets positions and rotations from it

    Using Pose Editor
        After selecting a part, turn your attention to the GUI in the top left
        corner, this shows the button format, currently there are 2
          - Home Block, (1), the Insert, Home, Page Up, Delete, End, and Page 
            Down keys act as adjusters, while the arrow keys are settings
          - Laptop, (2), the arrow keys plus / and right shift act as adjusters
            while, ",", ".", right Alt, and right Ctrl are settings
        Adjusters, change the rotation and position in increments
        Settings
          - Change mode, changes between position and rotation
          - Scale, toggles the size of adjustments
          - Gumball, toggles the Gumball on and off
          - Update, sends a ping to the server with the current adjustments
        Gumball, a tool to roughly show how something will be adjusted

Script Configurations
    Most settings are found in the main script file, although some are found in
    poses and emotes, other changes are all found in script
    Settings
      - Colors, rbg percent values, GREEN and RED are the colors used in most
        toggles, HOVER is the color when hovering over action wheel sections
      - DRESS, if true, the legs are hidden, dress is shown, and everything
        related to the dress is activated
      - PE_KEYBOARD, which keyboard to use, currently 1 or 2, see Pose Editor
      - PE_SCALE, how big to make the pose editor GUI
      - ARMOR_HELMET, enable the helmet by default
      - ARMOR_CHESTPLATE, enable the chestplate by default
      - ARMOR_LEGGINGS, enable leggings by default
      - ARMOR_BOOTS, enable boots by default
      - ARMOR_SETTTING, choose which ModCompat to use, see Config
      - CAPE, enable the cape by default
      - EYES, choose which eye setting to use, see Config 
      - BLOOD, choose which blood setting to use, see Config 
    Quick Animations, ctrl f for "-- Actions", the first four "local action = "
    are the quick access animations, they take the following form
        local action = main_page:newAction(x)
            :title("NAME")
            :item("ICON") 
            :hoverColor(HOVER)
            :onLeftClick(pings.ANIMATION)
      - NAME is a word to use when hovered over
      - ICON is an item id, like "minecraft:bell" or "minecraft:diamond_sword"
      - HOVER is not involved here
      - ANIMATION is the name of the animation to use, see script_poses_page
        for list
    More Pose Editor Keyboards, just ask me, this is not easy to explain

Textures
  - "skin.png", the skin, labelled UV map will come eventually
  - "skin_e.png", the emissive layer
  - "extra.png", the layer for various extra parts of the model, currently
    only dress
  - "extra_e.png",
  - "other_textures/blood_lvl_X.png", the blood textures for the skin.png, can
    be changed if they look weird for certain skins
  - "other_textures/extra_blood_lvl_X.png", the blood textures for extra.png, 
    can be changed if they look weird for certain skins
  - "other_textures/cape.png", the cape, elytra, and emoticon textures
  - "other_textures/cape_e.png", emissives for cape.png
  - "other_textures/icons.png", icons for the pose editor
  - "other_textures/techinical.png", various assets for the pose editor

Warnings
  - Not guarenteed to work with some mods, espically any that affect the way
    armor and the player are rendered
  - Figura is client side, this means that anyone without the mod
    will not see anything different. Additionally, because of the way
    actions and movement is synced, any animations that are playing may not
    sync if a player joins during one, I'd recommend reloading your avatar
    every once in a while.
--]]