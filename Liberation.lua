-- Welcome to the pit. If you're here to contribute, do send a pull request on github.com/NKillHere/Liberation. Thanks in advance.
-- If you're here to copy code, follow the GPLv3 license terms.

-- |Libraries|


local lapi = require "gamesense/lapi" or error("LAPI is required for this lua, download from https://github.com/Tony1337-bit/library")
local clipboard = require("gamesense/clipboard")
local vector = require("vector")

-- |Constants|

local NAMED_HITGROUPS = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg","right leg", "neck", "?", "gear"}
local PREFIX = "Liberation"
local DIRECTORY = filesystem.get_game_directory() 
local USER_NAME = utils.name()
local SCREEN_SIZE = vector(client.screen_size())
local MID_SCREEN = vector(SCREEN_SIZE.x /2, SCREEN_SIZE.y / 2)
local LOCAL_PLAYER = entity.get_local_player()

-- | References |
-- This is actually structured, it goes from visual/audio stuff(menu color/hitsound), Aimbot functions, Anti-aim stuffs
local refs = {
    menu_color = ui.reference("MISC", "Settings", "Menu color"),
    default_hitsound = ui.reference("Visuals", "Player ESP", "Hit marker sound"),
    min_dmg = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    min_dmg_ovr = {ui.reference("RAGE", "Aimbot", "Minimum damage override")}, -- [1] is checkbox, bool, [2] is the keybind state, bool and [3] is the value, int
    double_tap = {ui.reference("RAGE", "Aimbot", "Double tap")},
    hide_shots = {ui.reference("AA", "Other", "On shot anti-aim")},
    freestanding = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    fake_duck = ui.reference("RAGE", "Other", "Duck peek assist")
}

-- |Variables|

local promo_killsays = {
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
local trash_killsays = {
    "When you see me on your esp you shit yourself",
    "bot_difficulty 5",
    "bot_kick and you're still here",
    "de_$troyed",
    "de_struction",
    "cs_tutorial01 but for hvh should exist for you",
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
    "You're such an ape, you're either a negroid or have been huffing lead paint for the past 10 years",
    "Gloat that you have a pasted lua, but it will never save you",
    "Let's be honest here, you're fucking stupid. I have no idea how you are breathing."
}
local fun_killsays = {
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
    "Guns dont kill people, I do.",
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
local custom_killsays = {}
filesystem.add_search_path(filesystem.get_game_directory(), "csgo", 0) -- I really have no clue what this does, if it breaks it's on me. -NKill

local menu = lui.group("LUA", "A")
local side_menu = lui.group("LUA", "B")
local tabs = menu:combo("Tab", "Main", "Visuals", "Misc")
-- [Main]


menu:label("Accent Color")
:visible(function()
    return tabs:get() == "Main"
end)

local accent_color = menu:color_picker("Accent Color", ui.get(refs.menu_color))
    :visible(function()
        return tabs:get() == "Main"
    end)
    :add_callback("paint_ui", function(col)
        ui.set(refs.menu_color, col:get())
    end)


-- [Visuals]


-- Widgets, contains Watermark and Spectator list(for now) in that order

-- Watermark subsection
local function get_fps()
    if globals.frametime() > 0 then
        return math.ceil(1 / globals.frametime())
    end
    return 0
end

local widget_switch = menu:switch("Widgets")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
local widget_types = menu:selectable("Widget Types", "Watermark", "Spectators list", "Indicators")
    :visible(function()
    return tabs:get() == "Visuals" and widget_switch:get()
    end)
    
local watermark_types = menu:selectable("Watermark Addons", "Script Name", "Name", "FPS", "Ping", "Tick Rate", "Time(24h)")
    :visible(function() 
        return tabs:get() == "Visuals" and widget_types:get("Watermark") and widget_switch:get()
    end)

local watermark_map = function()
    local state = {}
    if watermark_types:get("Script Name") then
        table.insert(state, "liberation")
    end
    if watermark_types:get("Name") then
        table.insert(state, USER_NAME)
    end
    if watermark_types:get("FPS") then
        local watermark_fps = string.format("fps: %03d", get_fps())
        table.insert(state, watermark_fps)
    end
    if watermark_types:get("Ping") then
        local ping = math.ceil(client.real_latency() * 1000)
        if math.ceil(client.latency() * 1000) == 0 then
            ping = 0 
        end
        local watermark_ping = string.format("rtt: %dms", ping)
        table.insert(state, watermark_ping)
    end
    if watermark_types:get("Tick Rate") then
        local watermark_tickrate = string.format("rate: %d", math.ceil(1 / globals.tickinterval()))
        table.insert(state, watermark_tickrate)
    end
    if watermark_types:get("Time(24h)") then
        local time = {client.system_time()}
        local watermark_time = string.format("%02d:%02d:%02d", time[1], time[2], time[3])
        table.insert(state, watermark_time)
    end

    return #state > 0 and table.concat(state, " | " or "Liberation")
end

local function watermark(check, bkg_c, txt_c)
    if not check then
        return
    end
    local bkg_r, bkg_g, bkg_b, bkg_a = bkg_c:get()
    local txt_r, txt_g, txt_b, txt_a = txt_c:get()

    local watermark_txt = watermark_map()
    if watermark_txt == false then
        watermark_txt = "liberation"
    end
    local text_size = vector(renderer.measure_text("d", watermark_txt))

    renderer.rectangle(SCREEN_SIZE.x - text_size.x - 20, 10, text_size.x + 10, text_size.y + 8, bkg_r, bkg_g, bkg_b, bkg_a)

    renderer.text(SCREEN_SIZE.x - text_size.x - 15, 13, txt_r, txt_g, txt_b, txt_a, "d", 0, watermark_txt)
end

local widget_background = menu:label("Widget Background")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)
local widget_background_col = menu:color_picker("Watermark Background", 240,110,140,130)
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)

local widget_text = menu:label("Widget Text")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)
local widget_txt_col = menu:color_picker("Watermark Text", 240, 160, 180, 250)
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)

-- Spectator subsection
local spectator_x = menu:slider("Spectator X", 0, SCREEN_SIZE.x, SCREEN_SIZE.x / 4, true, "px")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Spectators list")
    end)
local spectator_y = menu:slider("Spectator Y", 0, SCREEN_SIZE.y, SCREEN_SIZE.y / 4, true, "px")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Spectators list")
    end)

local function get_spectators()
    local spectators = {}
    local local_player = entity.get_prop(LOCAL_PLAYER, "m_hObserverTarget")

    ent = 1
    for ent = 1, 65 do
        local target_player = entity.get_prop(ent, "m_hObserverTarget")
        
        if target_player == local_player then
            local spectator = entity.get_player_name(ent)
            table.insert(spectators, {spectator = spectator, ent = ent})
        end
    end
    return spectators
end

local function spectators_list(check, bkg_c, txt_c)
    if not check then
        return
    end

    local bkg_r, bkg_g, bkg_b, bkg_a = bkg_c:get()
    local txt_r, txt_g, txt_b, txt_a = txt_c:get()
    local spectators = get_spectators()
    local spectator_txt = "Spectators"
    local text_size = vector(renderer.measure_text("d", spectator_txt))
    -- x,y, width, height, r,g,b,a(I am fucking sick of looking on the docs constantly)
    renderer.rectangle(spectator_x:get() - text_size.x - 40, spectator_y:get(), text_size.x + 80, text_size.y + 8, bkg_r, bkg_g, bkg_b, bkg_a)
    renderer.text(spectator_x:get() - text_size.x - 0, spectator_y:get() + 3, txt_r, txt_g, txt_b, txt_a, "d", 0, spectator_txt)
    renderer.text(spectator_x:get() - text_size.x, spectator_y:get() - 20, 255,255,255,255, "d", 0, spectators)
end

--Indicator subsection
-- local indicator_types = menu:selectable("Indicator Types", "List", "Under crosshair")
--     :visible(function()
--     return tabs:get() == "Visuals" and widget_types:get("Indicators") and widget_switch:get()
--     end)
-- menu:label("Indicator under crosshair color")
--     :visible(function()
--     return tabs:get() == "Visuals" and widget_types:get("Indicators") and indicator_types:get("Under crosshair") and widget_switch::get()
--     end)
-- local indicator_crosshair_color = menu:color_picker("Indicator under crosshair color", accent_color:get())
--     :visible(function()
--     return tabs:get() == "Visuals" and widget_types:get("Indicators") and indicator_types:get("Under crosshair") and widget_switch:get()
--     end)

-- local function get_indicators() --the rendering will have to be done through a for loop within the draw function to set the Y axis, this SHOULD work, if not I got another method -NKill
--     local crosshair_indicators = {}
--     local indicators = {}
--     if ui.get(refs.min_dmg_ovr[2]) then
--         local new_dmg = ui.get(refs.min_dmg_ovr)
--         table.insert(crosshair_indicators, "DMG")
--         table.insert(indicators, "Minimum Damage: ".. new_dmg)
--     end
--     if ui.get(refs.edge_yaw) then
--         table.insert(crosshair_indicators, "EDGE")
--         table.insert(indicators, "Edge Yaw")
--     elseif ui.get(refs.freestanding[2]) then
--         table.insert(crosshair_indicators, "FS")
--         table.insert(indicators, "Freestanding")
--     end
--     if ui.get(refs.fake_duck) then
--         table.insert(crosshair_indicators, "FD")
--         table.insert(indicators, "Fake Duck")
--     elseif ui.get(refs.double_tap[2]) then
--         table.insert(crosshair_indicators, "DT")
--         table.insert(indicators, "Double Tap")
--     elseif ui.get(refs.hide_shots[2]) then
--         table.insert(crosshair_indicators, "HS")
--         table.insert(indicators, "Hide Shots")
--     end
-- end
-- local function crosshair_indicator() -- Will do later
-- end

events.paint:set(function()
    watermark(widget_types:get("Watermark"), widget_background_col, widget_txt_col)
    spectators_list(widget_types:get("Spectators list"), widget_background_col, widget_txt_col)
end)

-- Aspect Ratio + its value that is visible only when switch is on

local aspect_ratio = menu:switch("Aspect Ratio")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
    :callback(function(obj)
        cvar.r_aspectratio:set_float(obj:get() and 0)
    end)
aspect_ratios = {[177] = '16:9',[161] = '16:10',[150] = '3:2',[133] = '4:3',[125] = '5:4'}

local aspect_ratio_value = menu:slider("Aspect Ratio Value", 0, 250, 150, true, false, 1, aspect_ratios)
    :visible(function()
        return aspect_ratio:get() and tabs:get() == "Visuals"
    end)
    :callback(function(obj)
        if not entity.is_alive(LOCAL_PLAYER) then
            return
        end
        client.set_cvar("r_aspectratio", obj:get() / 100)
    end)

-- Viewmodel changer switch which reveals x, y, z and fov(in that order)
-- @note: QoL to reset to default if user wants to, tho if he reloads the lua it'll save over, tough shit!


pre_change_x = cvar.viewmodel_offset_x:get_float()
pre_change_y = cvar.viewmodel_offset_y:get_float()
pre_change_z = cvar.viewmodel_offset_z:get_float()
pre_change_fov = cvar.viewmodel_fov:get_float()

local viewmodel_cache = {
    x = 0,
    y = 0,
    z = 0,
    fov = 0
}

local viewmodel_changer = menu:switch("Viewmodel Changer")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
    :callback(function(obj)
        if not obj:get() then 
            client.set_cvar("viewmodel_offset_x", pre_change_x)
            client.set_cvar("viewmodel_offset_y", pre_change_y)
            client.set_cvar("viewmodel_offset_z", pre_change_z)
            client.set_cvar("viewmodel_fov", pre_change_fov)
        elseif viewmodel_cache.x > 0 or viewmodel_cache.y > 0 or viewmodel_cache.z > 0 or viewmodel_cache.fov > 0 then
            client.set_cvar("viewmodel_offset_x", viewmodel_cache.x)
            client.set_cvar("viewmodel_offset_y", viewmodel_cache.y)
            client.set_cvar("viewmodel_offset_z", viewmodel_cache.z)
            client.set_cvar("viewmodel_fov", viewmodel_cache.fov)
        end
    end)

local viewmodel_x = menu:slider("Viewmodel X", -500, 500, pre_change_x, true, nil, 0.01)
    :visible(function()
        return viewmodel_changer:get() and tabs:get() == "Visuals"
    end)

    :callback(function(test)
        viewmodel_cache.x = test:get() / 100
        client.set_cvar("viewmodel_offset_x", test:get() / 100)
    end)

local viewmodel_y = menu:slider("Viewmodel Y", -500, 500, pre_change_y, true, nil, 0.01)
    :visible(function()
        return viewmodel_changer:get() and tabs:get() == "Visuals"
    end)
    :callback(function(obj)
        viewmodel_cache.y = obj:get() / 100
        client.set_cvar("viewmodel_offset_y", obj:get() / 100) 
    end)

local viewmodel_z = menu:slider("Viewmodel Z", -500, 500, pre_change_z, true, nil, 0.01)
    :visible(function()
        return viewmodel_changer:get() and tabs:get() == "Visuals"
    end)
    :callback(function(obj)
        viewmodel_cache.z = obj:get() / 100
        client.set_cvar("viewmodel_offset_z", obj:get() / 100)
    end)

local viewmodel_fov = menu:slider("Viewmodel FOV", 50, 120, pre_change_fov, true)
    :visible(function()
        return viewmodel_changer:get() and tabs:get() == "Visuals"
    end)
    :callback(function(self)
        viewmodel_cache.fov = self:get()
        client.set_cvar("viewmodel_fov", self:get())
    end)


-- [Misc]

-- Hitsound on hit and on kill Not working due to playing sounds being a mess -NKill

-- if not filesystem.is_directory(DIRECTORY.."liberation/sounds", "csgo")
--     then 
--         utils.print(PREFIX, "Liberation directory does not exist, creating...")
--         filesystem.create_directory("liberation/sounds", "csgo")
-- else 
--     filesystem.add_search_path(DIRECTORY.."liberation/sounds", "sounds", 1)
-- end
-- local function hitsound_refresh() -- Still doesn't showcase for some fucking reason, have to ask mobby what the fuck this does then
--     hitsounds = filesystem.list_files(filesystem, DIRECTORY.."liberation/sounds")
--     return hitsounds
-- end

-- local hitsound_choice = ""
-- local killsound_choice = ""
-- local hitsound_list_choice = ""
-- local killsound_list_choice = ""

-- local hitsound_switch = menu:switch("Custom Hitsound")
--     :visible(function()
--         return tabs:get() == "Misc"
--     end)
-- local hitsound_types = side_menu:selectable("Hitsound types", {"On hit", "On kill"})
--     :visible(function()
--         return hitsound_switch:get() and tabs:get() == "Misc"
--     end)
--     :add_callback("player_death", function(e)
--         if e:get() == "On kill" or killsound_list_choice == "" then
--             return
--         end

--         local attacker = client.userid_to_entindex(e.attacker)
--         local victim = client.userid_to_entindex(e.userid)
    
--         if attacker ~= LOCAL_PLAYER then 
--             return 
--         end
--         if not entity.is_enemy(victim) then 
--             return 
--         end
--         ui.set(refs.default_hitsound, false)
--         can = filesystem.open(DIRECTORY.."liberation/sounds", "r", "hitsounds")
--             --Figure out playing sounds, easiest way is to convince Mobby to add sound playing due to usefulness in luas
--         filesystem.close(can)
--     end)
-- local hitsound_name = side_menu:list("Hitsounds", hitsound_refresh())
--     :visible(function()
--         return hitsound_switch:get() and tabs:get() == "Misc"
--     end)
--     :callback(function(choice)
--         hitsound_list_choice = choice:get()
--     end)
-- local hitsound_refresh = side_menu:button("Refresh hitsounds", 
--     function()
--         hitsound_refresh()
--     end)
--     :visible(function()
--         return tabs:get() == "Misc" and hitsound_switch:get()
--     end)
-- local hitsound_button = side_menu:button("Select as Hitsound", function()
--         ui.set(refs.default_hitsound, false)
--         hitsound_choice = hitsound_list_choice
--     end)
--     :visible(function()
--         return tabs:get() == "Misc" and hitsound_types:get("On hit") and hitsound_switch:get()
--     end)
-- local killsound_button = side_menu:button("Select as Killsound",function()
--         killsound_choice = killsound_list_choice
--     end)
--     :visible(function()
--         return tabs:get() == "Misc" and hitsound_types:get("On kill") and hitsound_switch:get()
--     end)

-- Logs

local logs = {
    intended_dmg = 0,
    intended_hitgroup = nil,
    tp = false,
    bt = nil
}

local logs_switch = menu:switch("Logs")
    :visible(function()
        return tabs:get() == "Misc"
    end)
    :add_callback("aim_fire", function(obj, e) -- obj is the switch state
        logs.bt = math.floor(globals.tickcount() - e.tick)
        logs.intended_hitgroup = NAMED_HITGROUPS[e.hitgroup + 1]
        logs.intended_dmg = e.damage
        logs.tp = e.teleported
        return logs.bt, logs.intended_hitgroup, logs.intended_dmg, logs.tp
    end)
    :add_callback("aim_hit", function(obj, e)
        entity_hp = entity.get_prop(e.target, 'm_iHealth')

        local hitgroup_name = NAMED_HITGROUPS[e.hitgroup + 1] or '?'
        hitgroup_txt = ("in the ".. hitgroup_name)
        if hitgroup_name == "generic" or "gear" then
            hitgroup_txt = ("in ".. hitgroup_name)
        end
        mismatch_check = "✔"
        intended_txt = ""

        if e.damage ~= logs.intended_dmg and logs.intended_dmg >= entity_hp and e.damage < entity_hp or ui.get(refs.min_dmg_ovr[2]) and e.damage < ui.get(refs.min_dmg_ovr[3]) then -- This SHOULD be correct, but do make a PR if smth is wrong -NKill
            logs.mismatch_check = "‼"
            print("DEBUG: intended hg: ", logs.intended_hitgroup, " | ", "intended dmg:", logs.intended_dmg) -- I have NO fucking clue why this isn't working properly, this debug feature will stick until then
            intended_txt = string.format("[Intended damage: %d]", logs.intended_dmg)
            if logs.intended_hitgroup ~= e.hitgroup then
                intended_txt = string.format("[Intended damage: %d, %s]", logs.intended_dmg, logs.intended_hitgroup)
            end
        end

        utils.print(PREFIX, string.format("[%s] Hit %s %s, dealing %d damage(%d health left) %s (tp: %s | hc: %d%% | bt: %dt [%dms])",
        mismatch_check, entity.get_player_name(e.target), hitgroup_txt, e.damage, entity_hp, intended_txt, logs.tp, e.hit_chance, logs.bt,
        math.floor(totime(logs.bt) * 1000)))
    end)
    :add_callback("aim_miss", function(obj, e)
        local hitgroup_name = NAMED_HITGROUPS[e.hitgroup + 1] or '?'
        local missreason = e.reason
            if missreason == "?" then
                missreason = "resolver" -- nice try skeet
            end

        utils.print(PREFIX, string.format("[X] Missed %s's %s due to %s (tp: %s | hc: %d%% | bt:%st [%dms])", 
        entity.get_player_name(e.target), hitgroup_name, missreason, logs.tp, e.hit_chance, logs.bt, math.floor(totime(logs.bt) * 1000)))
    end)

-- Overengineered Killsay

local function custom_killsay_import()
    local clipboard_text = clipboard.get()

    if not clipboard_text or clipboard_text == "" then
        utils.print(PREFIX, "Clipboard is empty.")
        return
    end

    local valid, data = pcall(json.parse, clipboard_text)

    if not valid or type(data) ~= "table" then
        utils.print(PREFIX, "Invalid format, please check your clipboard for mistakes.")
        utils.print(PREFIX, "An example of a correct list is: [\"example 1\", \"example 2\"]")
        utils.print(PREFIX, "For more information, please check the official github.")
        return
    end
 
    for i = 1, #data do
        if type(data[i]) ~= "string" then
            utils.print(PREFIX, "Invalid format, all killsays must be strings.")
            return
        end
    end

    utils.print(PREFIX, "Successfully imported ".. #data.. " killsays.")
    return data
end

local killsay_switch = menu:switch("Killsay", false)
    :visible(function()
       return tabs:get() == "Misc"
end)
local killsay_types = menu:selectable("Killsay Types", {"Promotional", "Trashtalk", "Fun", "Custom"})
    :visible(function()
        return killsay_switch:get() and tabs:get() == "Misc"
end)
local custom_killsay = menu:button("Import Custom Killsay List", function()
        custom_killsays = custom_killsay_import()
    end)
    :visible(function()
        return killsay_switch:get() and tabs:get() == "Misc" and killsay_types:get("Custom")
    end)

local function table_contains(tbl, val)
    for i = 1, #tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end

local function get_active_killsays()
    local active = {}
    local selected = killsay_types:get()

    if table_contains(selected, "Promotional") then
        for _, v in ipairs(promo_killsays) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Trashtalk") then
        for _, v in ipairs(trash_killsays) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Fun") then
        for _, v in ipairs(fun_killsays) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Custom") then
        for _, v in ipairs(custom_killsays) do
            active[#active + 1] = v
        end
    end

    return active
end

client.set_event_callback("player_death", function(e)
    local attacker = client.userid_to_entindex(e.attacker)
    local victim = client.userid_to_entindex(e.userid)

    if attacker ~= LOCAL_PLAYER then return end
    if not entity.is_enemy(victim) then return end

    local killsays = get_active_killsays()
    if #killsays == 0 then return end

    local msg = killsays[math.random(#killsays)]
    client.exec("say " .. msg)
end)

-- Clantag

local old_tag_string = nil
local can_reset = false

local function create_clantag_animation()
    local anim = {}

    local text, prefix = "Liberation", "✰ "
    local cursor = {"_", " ", "_", " "}

    for i = 0, #text do
        if i > 0 then
            table.insert(anim, prefix .. text:sub(1, i) .. "_")
        else
            table.insert(anim, prefix .. "_")
        end
    end

    for _, pos in ipairs(cursor) do 
        table.insert(anim, prefix .. text .. pos) end

    table.insert(anim, prefix .. text .. " ")
    table.insert(anim, prefix .. text .. "_")

    for i = #text, 1, -1 do
        table.insert(anim, prefix .. text:sub(1, i - 1) .. "_")
    end

    table.insert(anim, prefix)
    return anim
end

local anim_txt = create_clantag_animation()
local clantag = menu:switch("Clantag", false)
    :visible(function()
        return tabs:get() == "Misc"
    end)
    :callback(function(e)
        if e:get() == false then
            client.set_clan_tag("")
        end
    end)
    :add_callback("setup_command", function()
        local curtime = math.floor((globals.curtime()) * 3)
        local tag_string = anim_txt[curtime % #anim_txt + 1]
        if tag_string ~= old_tag_string then
            client.set_clan_tag(tag_string)
            old_tag_string = tag_string
            can_reset = true
                if can_reset then
                    client.set_clan_tag(" ")
                    can_reset = false
                end
        end
    end)
-- on shutdown fixing and print on full load


events.shutdown:set(function()
    client.set_cvar("r_aspectratio", 0)
    client.set_cvar("viewmodel_offset_x", 1)
    client.set_cvar("viewmodel_offset_y", 1)
    client.set_cvar("viewmodel_offset_z", -1.5)
    client.set_cvar("viewmodel_fov", 60)
    client.set_clan_tag("")
    ui.set(refs.default_hitsound, true)
    utils.print(PREFIX, string.format("See you next time, %s.", USER_NAME))
end)

utils.print(PREFIX, string.format("Fully loaded, %s. Welcome to Liberation.", USER_NAME))