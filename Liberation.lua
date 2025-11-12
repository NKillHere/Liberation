-- Welcome to the pit. If you're here to contribute, do send a pull request on github.com/NKillHere/Liberation. Thanks in advance.
-- If you're here to copy code, follow the GPLv3 license terms.

-- |Libraries|

-- |Constants|
local named_hitgroups = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg","right leg", "neck", "?", "gear"}
-- |Variables|
local global_vars = {
    local_player = nil,
    in_jump = false,
}

local promokillsays = {
    "Flying free and hitting heads with Liberation | github.com/NKillHere/Liberation",
    "Stacking bodies high as a skyscraper with Liberation | github.com/NKillHere/Liberation",
    "Mad? No worries script is free | github.com/NKillHere/Liberation",
    "Free yourself from pasted paid scripts with Liberation | github.com/NKillHere/Liberation",
    "Sending everyone to Jesus with Liberation | github.com/NKillHere/Liberation",
    "Making everyone so tilted admins ban me with Liberation | github.com/NKillHere/Liberation",
    "Sending people to Valhalla with Liberation | github.com/NKillHere/Liberation",
    "Head's harder to hit than a Snipe with Liberation's help | github.com/NKillHere/Liberation",
    "Life's so easy with Liberation | github.com/NKillHere/Liberation",
    "I push like Rambo but remain unharmed | github.com/NKillHere/Liberation",
    "Dodging bullets like Neo with Liberation | github.com/NKillHere/Liberation"
}
local trashkillsays = {
    "When you see me in your esp you shit yourself",
    "bot_difficulty 5",
    "bot_kick and you're still here",
    "de_$troyed",
    "de_struction",
    "cs_tutorial01 but for hvh should exist for you"
    "paste user down",
    "buddha mode $",
    "did you say something, I can't hear you over the sound of my 100% winrate",
    "2kd+ with no sweat",
    "?",
    "You alright mate?",
    "What the fuck were you thinking?",
    "You stop believing that your cheat can carry you when you see me",
    "There's a void where your brain should be",
    "How are you still breathing with that iq of yours?",
    "Do stupid shit, win stupid prizes. Big Surprise.",
    "Go join hvh academy, you fucking suck",
    "IQ?",
    "You're so retarded I think you might be inbred, get a DNA test.",
    "You're such an ape, you're either a negroid or have been huffing lead paint",
    "Gloat that you have a pasted lua, but it will never save you",
    "Let's be honest here, you're fucking stupid. I have no idea how you are breathing."
}
local funkillsays = {
    "Here you go Uncle Dave, happy fucking birthday!",
    "Here's some lead for you to recycle!", "Here's your tax relief!",
    "I AM the law! heheheh",
    "I'm sorry, apperantly I'm feeling a little psychotic this morning!",
    "I suppose it would've been more politically correct to kill the women and the minorities first!",
    "Just call me Doctor Euthanasia!", "Close enough!",
    "I hope the bitch appreciates what trouble I've been through",
    "Mission accomplished! With extreme prejudice!",
    "Only my weapon understands me.",
    "Please don't think I'm a bigot, I kill races equally!",
    "Mmm smells like chicken.", "So THAT's what that does.",
    "That can't be good.",
    "That's gonna leave a mark.",
    "That's the ticket.",
    "The gene pool is stagnant, and I'm the Minister of Chlorine!",
    "Video games don't kill people, I do.",
    "Wouldn't it be safe to say your family tree is a mobius loop?",
    "Yeah, that's what they all say.",
    "Guns dont kill people, I do",
    "You got blood on my suit.",
    "That helmet of yours is a nice bowl for your brains!",
    "Somebody stole my donuts, and your all gonna pay!",
    "See ya maaaaaate!",
    "Juan.",
    "I hope nobody's taping this!",
    "I will send you to Jesus",
    "ℍ𝔼'𝕊 𝔻𝕌𝕄ℙ𝕀ℕ𝔾! 𝔹𝕎𝔸ℍ𝔸ℍ𝔸 (◣_◢)",
    "(◣_◢)",
    "𝕡𝕙𝕚𝕝𝕚𝕡𝟘𝟙𝟝 𝕔𝕒𝕞𝕖 𝕥𝕠 𝕞𝕪 𝕕𝕠𝕠𝕣 𝕝𝕒𝕤𝕥 𝕟𝕚𝕘𝕙𝕥 𝕒𝕟𝕕 𝕥𝕠𝕝𝕕 𝕞𝕖: 'FATALITY is best' 𝕒𝕟𝕕 𝕀 𝕤𝕒𝕚𝕕 'ok king👑' (◣_◢) ",
    "𝕖𝕧𝕖𝕣𝕪𝕥𝕚𝕞𝕖 𝕚𝕕𝕚𝕠𝕥 𝕔𝕠𝕞𝕡𝕒𝕣𝕖 𝕞𝕖 𝕛𝕦𝕤𝕥 𝕣𝕖𝕞𝕖𝕞𝕓𝕖𝕣 𝕚𝕞 𝕠𝕡𝕡𝕠𝕤𝕚𝕥𝕖 𝕦𝕚𝕕 𝕕𝕠𝕨𝕟 𝕜𝕕 𝕦𝕡 (◣_◢)",
    "HvH Highlights #7000 feat. (insert paste here)"
}
local menu = {
    tab = ui.new_combobox("LUA", "A", "Tabs", {"Visuals", "Misc"}),

    --     antiaim = {
    --         mode = ui.new_combobox ("LUA", "A", "Anti-aim mode", {
    --             "Off",
    --             "Recommended",
    --             "Builder"
    --         }),
    --         state = ui.new_combobox ("LUA", "A", "Anti-aim state", {
    --             "Global",
    --             "Stand",
    --             "Move",
    --             "Slow walk",
    --             "Air",
    --             "Air crouch",
    --             "Crouching",
    --             "Sneaking"
    --         })
    --         states = {
    --             global = {
    --                 toggle = ui.new_checkbox("LUA", "A", "[Global] Toggle")
    --                 pitch = ui.new_combobox("LUA", "A", "[Global] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Global] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Global] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Global] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Global] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Global] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Global] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Global] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Global] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Global] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Global] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Global] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Global] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Global] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Global] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },           
    --             stand = {
    --                 override = ui.new_checkbox("LUA", "A", "[Stand] Override"),
    --                 pitch = ui.new_combobox("LUA", "A", "[Stand] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Stand] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Stand] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Stand] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Stand] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Stand] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Stand] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Stand] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Stand] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Stand] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Stand] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Stand] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Stand] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Stand] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Stand] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             move = {
    --                 override = ui.new_checkbox("LUA", "A", "[Move] Override"),
    --                 pitch = ui.new_combobox("LUA", "A", "[Move] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Move] Custom pitch", -89, 89, 0, true, "°"),
    --                  yaw_base = ui.new_combobox("LUA", "A", "[Move] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Move] Yaw", { "Off", "Backwards", "Spin" }),
    --                  yaw_add = ui.new_slider("LUA", "A", "[Move] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Move] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                  yaw_jitter_offset = ui.new_slider("LUA", "A", "[Move] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Move] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Move] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Move] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Move] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Move] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Move] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Move] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Move] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             slow_walk = {
    --                     override = ui.new_checkbox("LUA", "A", "[Slow walk] Override"),
    --                     pitch = ui.new_combobox("LUA", "A", "[Slow walk] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                     custom_pitch = ui.new_slider("LUA", "A", "[Slow walk] Custom pitch", -89, 89, 0, true, "°"),
    --                     yaw_base = ui.new_combobox("LUA", "A", "[Slow walk] Yaw base", { "Local view", "At targets" }),
    --                     yaw = ui.new_combobox("LUA", "A", "[Slow walk] Yaw", { "Off", "Backwards", "Spin" }),
    --                     yaw_add = ui.new_slider("LUA", "A", "[Slow walk] Yaw add", -180, 180, 0, true, "°"),
    --                     yaw_jitter = ui.new_combobox("LUA", "A", "[Slow walk] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                     yaw_jitter_offset = ui.new_slider("LUA", "A", "[Slow walk] Jitter offset", -180, 180, 0, true, "°"),
    --                     body_yaw = ui.new_combobox("LUA", "A", "[Slow walk] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                     body_yaw_delta = ui.new_slider("LUA", "A", "[Slow walk] Body yaw delta", -60, 60, 0, true, "°"),
    --                     defensive_enable = ui.new_checkbox("LUA", "A", "[Slow walk] Defensive enable"),
    --                     defensive_pitch = ui.new_combobox("LUA", "A", "[Slow walk] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                     defensive_custom_pitch = ui.new_slider("LUA", "A", "[Slow walk] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                     defensive_yaw = ui.new_combobox("LUA", "A", "[Slow walk] Defensive yaw", { "Off", "Spin", "Random" }),
    --                     defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Slow walk] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                     defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Slow walk] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             air = {
    --                 override = ui.new_checkbox("LUA", "A", "[Air] Override"),
    --                 pitch = ui.new_combobox("LUA", "A", "[Air] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Air] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Air] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Air] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Air] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Air] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Air] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Air] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Air] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Air] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Air] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Air] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Air] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Air] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Air] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             air_crouch = {
    --                 override = ui.new_checkbox("LUA", "A", "[Air crouch] Override"),
    --                 pitch = ui.new_combobox("LUA", "A", "[Air crouch] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Air crouch] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Air crouch] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Air crouch] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Air crouch] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Air crouch] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Air crouch] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Air crouch] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Air crouch] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Air crouch] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Air crouch] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Air crouch] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Air crouch] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Air crouch] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Air crouch] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             crouch = {
    --                 override = ui.new_checkbox("LUA", "A", "[Crouch] Override"),
    --                 pitch = ui.new_combobox("LUA", "A", "[Crouch] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Crouch] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Crouch] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Crouch] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Crouch] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Crouch] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Crouch] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Crouch] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Crouch] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Crouch] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Crouch] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Crouch] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Crouch] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Crouch] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Crouch] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --             sneaking = {
    --                 toggle = ui.new_checkbox("LUA", "A", "[Sneaking] Toggle),
    --                 pitch = ui.new_combobox("LUA", "A", "[Sneaking] Pitch", { "Off", "Down", "Up", "Custom" }),
    --                 custom_pitch = ui.new_slider("LUA", "A", "[Sneaking] Custom pitch", -89, 89, 0, true, "°"),
    --                 yaw_base = ui.new_combobox("LUA", "A", "[Sneaking] Yaw base", { "Local view", "At targets" }),
    --                 yaw = ui.new_combobox("LUA", "A", "[Sneaking] Yaw", { "Off", "Backwards", "Spin" }),
    --                 yaw_add = ui.new_slider("LUA", "A", "[Sneaking] Yaw add", -180, 180, 0, true, "°"),
    --                 yaw_jitter = ui.new_combobox("LUA", "A", "[Sneaking] Yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 yaw_jitter_offset = ui.new_slider("LUA", "A", "[Sneaking] Jitter offset", -180, 180, 0, true, "°"),
    --                 body_yaw = ui.new_combobox("LUA", "A", "[Sneaking] Body yaw", { "Off", "Opposite", "Jitter", "Static" }),
    --                 body_yaw_delta = ui.new_slider("LUA", "A", "[Sneaking] Body yaw delta", -60, 60, 0, true, "°"),
    --                 defensive_enable = ui.new_checkbox("LUA", "A", "[Sneaking] Defensive enable"),
    --                 defensive_pitch = ui.new_combobox("LUA", "A", "[Sneaking] Defensive pitch", { "Off", "Down", "Up", "Custom" }),
    --                 defensive_custom_pitch = ui.new_slider("LUA", "A", "[Sneaking] Defensive custom pitch", -89, 89, 0, true, "°"),
    --                 defensive_yaw = ui.new_combobox("LUA", "A", "[Sneaking] Defensive yaw", { "Off", "Spin", "Random" }),
    --                 defensive_yaw_jitter = ui.new_combobox("LUA", "A", "[Sneaking] Defensive yaw jitter", { "Off", "Offset", "Center", "Random", "Skitter" }),
    --                 defensive_yaw_jitter_offset = ui.new_slider("LUA", "A", "[Sneaking] Defensive jitter offset", -180, 180, 0, true, "°"),
    --             },
    --         },
    --         edge_yaw = ui.new_hotkey("LUA", "A", "Edge yaw", false, 0),
    --         anim_breakers = ui.new_multiselect("LUA", "A", "Animation Breaker(s)", {"Pitch zero on land", "Static legs in air", "Leg Jitter"})
    --     },
    visuals = {
        viewmodel_changer = ui.new_checkbox("LUA", "A", "Viewmodel changer"),
        viewmodel_x = ui.new_slider("LUA", "A", "Viewmodel X", -100, 100, 1,
                                    true, "°"),
        viewmodel_y = ui.new_slider("LUA", "A", "Viewmodel Y", -100, 100, 1,
                                    true, "°"),
        viewmodel_z = ui.new_slider("LUA", "A", "Viewmodel Z", -100, 100, 1,
                                    true, "°"),
        viewmodel_fov = ui.new_slider("LUA", "A", "Viewmodel FOV", -10, 10, 0,
                                      true),
        aspect_ratio = ui.new_checkbox("LUA", "A", "Aspect ratio"),
        aspect_ratio_value = ui.new_slider("LUA", "A", "Aspect ratio value", 0,
                                           400, 0, true, "%")
    },
    misc = {
        killsay = ui.new_checkbox("LUA", "A", "Killsay"),
        killsay_types = ui.new_multiselect("LUA", "A", "Killsay Types", {"Promotional", "Trashtalk", "Fun"}),
        clantag = ui.new_checkbox("LUA", "A", "Clantag"),
        logs = ui.new_checkbox("LUA", "A", "Logs"),
        log_types = ui.new_multiselect("LUA", "A", "Log Types", {"Hit", "Miss"}),
        hit_text = ui.new_label("LUA", "A", "Hit Color"),
        hit_color = ui.new_color_picker("LUA", "A", "Hit Color", 104, 255, 104,
                                        1),
        miss_text = ui.new_label("LUA", "A", "Miss Color"),
        miss_color = ui.new_color_picker("LUA", "A", "Miss Color", 255, 104,
                                         104, 1)
    }
}
-- |Visibility|
-- local function update_visibility(value)
-- ui.set_visible(menu.antiaim.edge_yaw, value == "Anti-aim")
-- ui.set_visible(menu.antiaim.anim_breakers, value == "Anti-aim") I'll get it to it later, visibility for it is going to be a bitch & 1/2 -NKill

-- local builder_on = value == "Anti-aim" and ui.get(menu.antiaim.mode) == "Builder"
-- ui.set_visible(menu.antiaim.state, builder_on) 
-- local current_state = ui.get(menu.antiaim.state)
local function visibility(value)
    ui.set_visible(menu.visuals.viewmodel_changer, value == "Visuals")
    ui.set_visible(menu.visuals.viewmodel_x, value == "Visuals" and ui.get(menu.visuals.viewmodel_changer))
    ui.set_visible(menu.visuals.viewmodel_y, value == "Visuals" and ui.get(menu.visuals.viewmodel_changer))
    ui.set_visible(menu.visuals.viewmodel_z, value == "Visuals" and ui.get(menu.visuals.viewmodel_changer))
    ui.set_visible(menu.visuals.viewmodel_fov, value == "Visuals" and ui.get(menu.visuals.viewmodel_changer))
    ui.set_visible(menu.visuals.aspect_ratio, value == "Visuals")
    ui.set_visible(menu.visuals.aspect_ratio_value, value == "Visuals" and ui.get(menu.visuals.aspect_ratio))

    ui.set_visible(menu.misc.killsay, value == "Misc")
    ui.set_visible(menu.misc.killsay_types, value == "Misc" and ui.get(menu.misc.killsay))
    ui.set_visible(menu.misc.clantag, value == "Misc")
    ui.set_visible(menu.misc.logs, value == "Misc")
    ui.set_visible(menu.misc.log_types, value == "Misc" and ui.get(menu.misc.logs))
    ui.set_visible(menu.misc.hit_text, value == "Misc" and ui.get(menu.misc.log_types) == "Hit")
    ui.set_visible(menu.misc.hit_color, value == "Misc" and ui.get(menu.misc.log_types) == "Hit")
    ui.set_visible(menu.misc.miss_text, value == "Misc" and ui.get(menu.misc.log_types) == "Miss")
    ui.set_visible(menu.misc.miss_color, value == "Misc" and ui.get(menu.misc.log_types) == "Miss")
end

ui.set_callback(menu.tab, function(value) visibility(ui.get(menu.tab)) end)

ui.set_callback(menu.visuals.viewmodel_changer,function(value) visibility(ui.get(menu.tab)) end)
ui.set_callback(menu.visuals.aspect_ratio,function(value) visibility(ui.get(menu.tab)) end)

ui.set_callback(menu.misc.killsay, function(value) visibility(ui.get(menu.tab)) end)
ui.set_callback(menu.misc.logs, function(value) visibility(ui.get(menu.tab)) end)
ui.set_callback(menu.misc.log_types, function(value) visibility(ui.get(menu.tab)) end)

visibility(ui.get(menu.tab))
-- |References|

local refs = {
    menu_color = ui.reference("MISC", "Settings", "Menu color") 
}

-- |The working bits|
--  [Visuals]

-- if ui.get(menu.visuals.aspect_ratio) then
--     local aspect_ratio_value = ui.get(menu.visuals.aspect_ratio_value)
--     client.set_cvar("r_aspectratio", aspect_ratio_value / 100)
-- end

-- if not entity.is_alive(entity.get_local_player) then
--     return
-- end

--  [Misc]

local old_tag_string = nil
local can_reset = false

local anim_txt = {"✰ ", "✰ ⚝","✰ L", "✰ L⚝", "✰ Li", "✰ Li⚝", "✰ Lib", "✰ Lib⚝", "✰ Libe", "✰ Libe⚝",
 "✰ Liber", "✰ Liber⚝", "✰ Libera", "✰ Libera⚝","✰ Liberat","✰ Liberat⚝", "✰ Liberati", "✰ Liberati⚝",
 "✰ Liberatio", "✰ Liberatio⚝","✰ Liberation", "✰ Liberation ", "✰ Liberation ", "✰ Liberatio⚝", "✰ Liberatio",
 "✰ Liberati⚝", "✰ Liberati", "✰ Liberat⚝", "✰ Liberat", "✰ Libera⚝", "✰ Libera", "✰ Liber⚝", "✰ Liber",
 "✰ Libe⚝","✰ Libe", "✰ Lib⚝", "✰ Lib", "✰ Li⚝", "✰ Li", "✰ L⚝", "✰ L","✰ ⚝", "✰ ", "✰ "}

function clantag()
    if ui.get(menu.misc.clantag) then
        local curtime = math.floor((globals.curtime()) * 5)
        local tag_string = anim_txt[curtime % #anim_txt + 1]
        if tag_string ~= old_tag_string then
            client.set_clan_tag(tag_string)
            old_tag_string = tag_string
            can_reset = true
        end
    else
        if can_reset then
            client.set_clan_tag(" ")
            can_reset = false
        end
    end
end
-- local topromokillsays = 0
-- local function trashtalktest()
--     if topromokillsays then tpromokillsays = promokillsays end
-- end


local trashtalk = {}
local function trashtalk(e)
    if not ui.get(menu.misc.killsay) then return end
    if ui.get(menu.misc.killsay_types) == "Promotional" then
        trashtalk = promokillsays
    elseif ui.get(menu.misc.killsay_types) == "Fun" then
        trashtalk = funkillsays
    elseif ui.get(menu.misc.killsay_types) == "Trashtalk" then
        trashtalk = trashkillsays
    end
    
    -- trashtalk = {table.unpack(ttrashkillsays),table.unpack(tfunkillsays), table.unpack(tpromokillsays)}

    local attacker, victim = client.userid_to_entindex(e.attacker), client.userid_to_entindex(e.userid)
    if attacker == global_vars.local_player and entity.is_enemy(victim) then
        client.exec("say ", trashtalk[math.random(1, #trashtalk)])
    end
end

local logs = {
    intended_dmg = 0,
    intended_hitgroup = nil,
    tp = nil,
    bt = 0,
    goodornot = ""
}

local function extractor(e)
    logs.bt = e.backtrack
    logs.intended_hitgroup = named_hitgroups[e.hitgroup + 1]
    logs.intended_dmg = e.damage
    logs.tp = e.teleported
    -- if logs.tp == nil then logs.tp = "false" end

    time_to_ticks = function(e)
        return math.floor(0.5 + (logs.bt / globals.tickinterval()))
    end
    -- print(intended_hitgroup)
end

local r, g, b = ui.get(refs.menu_color)
liberation_console = client.color_log(r, g, b, "Liberation •\0")
-- HIT AND MISS LOG DON'T WORK PROPERLY
local function hit(e)
    local intended_txt = ""
    local hitgroup_name = named_hitgroups[e.hitgroup + 1] or '?'
    local hitgroup_txt = ("in the " .. hitgroup_name)
    if hitgroups == "generic" then hitgroup_txt = ("in " .. named_hitgroups) end

    if not ui.get(menu.misc.logs, "Hit") then return end
    logs.goodornot = "✓"
    if logs.intended_dmg ~= e.damage and e.damage < 100 and entity.get_prop(e.target, 'm_iHealth') == 100 then logs.goodornot = "‼" end
    local aleph = (", Intended hitbox: ".. logs.intended_hitgroup)
    if logs.intended_dmg ~= e.damage and e.damage < 100 and entity.get_prop(e.target, 'm_iHealth') == 100 then intended_txt = string.format("[Intended damage: %s]", logs.intended_dmg, aleph) 
    end
    if logs.intended_hitgroup ~= e.hitgroup and e.damage < 100 and entity.get_prop(e.target, 'm_iHealth') == 100 then intended_txt = string.format("[Intended damage: %s%s]", logs.intended_dmg, aleph) 
    end

    client.log(string.format("[%s] Hit %s %s, dealing %s damage(%s health left)%s(tp: %s)(hc: %d, bt: %st(%sms))", logs.goodornot, entity.get_player_name(e.target), hitgroup_txt, e.damage, entity.get_prop(e.target, 'm_iHealth'), intended_txt, logs.tp, e.hit_chance, time_to_ticks(logs.bt), logs.bt)) -- sorry for the length
end

local function miss(e)

    if not ui.get(menu.misc.logs, "Miss") then return end
    local hitgroup_name = named_hitgroups[e.hitgroup + 1] or '?'
    local missreason = e.reason
    if missreason == "?" then
        missreason = "correction" -- stopping skeet from lying, one fix at a time
    end
        client.log(string.format("[✗] Missed %s's %s due to %s(tp: %s)(hc: %d, bt: %st(%sms)", entity.get_player_name(e.target), hitgroup_name, missreason, logs.tp, e.hit_chance, time_to_ticks(logs.bt), logs.bt))
end

-- |Callbacks|

-- local function on_setup_command(cmd)
local function on_paint()
    global_vars.local_player = entity.get_local_player()
    if not global_vars.local_player then 
        return
    end
end
local function on_setup_command(cmd)
    clantag(cmd)
end

local local_player = entity.get_player_name(entity.get_local_player())
if local_player == "unknown" then local_player = "Player" end

local function on_shutdown()
    client.set_clan_tag("")
    client.log(string.format(" See you next time, %s.", local_player))
end
client.set_event_callback("paint_ui", on_paint)
client.set_event_callback("setup_command", on_setup_command)
client.set_event_callback("aim_fire", extractor)
client.set_event_callback("aim_miss", miss)
client.set_event_callback("player_death", trashtalk)
client.set_event_callback("aim_hit", hit)
client.set_event_callback("shutdown", on_shutdown)
client.log(string.format(" Fully loaded, %s. Welcome to Liberation.", local_player))
