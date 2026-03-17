
-- Welcome to the pit. If you're here to contribute, do send a pull request on github.com/NKillHere/Liberation. Thanks in advance.
-- If you're here to copy code, follow the GPLv3 license terms.

-- |Information|
-- We(by that I mean me, NKill sadly) plan to change the way how functions, variables and constants are written to make them more easily legible about what they are.
-- Additionally, there will be some accepted shorthand forms to write the name of some common terms for ease-of-use, check the wiki for more information.
-- Constants will remain as SCREAMING_SNAKE_CASE, functions will be in PascalCase,
-- menu elements in camelCase(with it functioning kindaLikethis when 3 or more words are concerned) and variables in snake_case, which includes references.

-- |Libraries|

local lapi = require "gamesense/lapi" or error("LAPI is required for this lua, download from https://github.com/Tony1337-bit/library")
local clipboard = require("gamesense/clipboard")
local vector = require("vector")

-- |Constants|
-- Keep the Killsays always on the lowest part due to size

local NAMED_HITGROUPS = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg","right leg", "neck", "?", "gear"}
local PREFIX = "Liberation"
local DIRECTORY = filesystem.get_game_directory() 
local USER_NAME = utils.name()
local SCREEN_SIZE = vector(client.screen_size())
local MID_SCREEN = vector(SCREEN_SIZE.x /2, SCREEN_SIZE.y / 2)
local LOCAL_PLAYER = entity.get_local_player()
local PROMO_PHRASES = {
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
local TRASH_PHRASES = {
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
local FUN_PHRASES = {
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


-- | References |
-- This is actually structured, it goes from visual/audio stuff(menu color/hitsound), Aimbot functions, Anti-aim stuffs
local refs = {
    menu_color = ui.reference("MISC", "Settings", "Menu color"),
    default_indicators = ui.reference("Visuals", "Player ESP", "Hit marker"),
    default_hitsound = ui.reference("Visuals", "Player ESP", "Hit marker sound"),
    min_dmg = ui.reference("RAGE", "Aimbot", "Minimum damage"),
    min_dmg_ovr = {ui.reference("RAGE", "Aimbot", "Minimum damage override")}, -- [1] is checkbox, bool, [2] is the keybind state, bool and [3] is the value, int
    double_tap = {ui.reference("RAGE", "Aimbot", "Double tap")},
    hide_shots = {ui.reference("AA", "Other", "On shot anti-aim")},
    yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    freestanding = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    fake_duck = ui.reference("RAGE", "Other", "Duck peek assist")
}

-- |Variables|


-- [Visuals]
-- Viewmodel Changer
-- @note: QoL to reset to default if user wants to, tho if he reloads the lua it'll save over, tough shit!
preload_viewmodel_x_cache = cvar.viewmodel_offset_x:get_float()
preload_viewmodel_y_cache = cvar.viewmodel_offset_y:get_float()
preload_viewmodel_z_cache = cvar.viewmodel_offset_z:get_float()
preload_viewmodel_fov_cache = cvar.viewmodel_fov:get_float()

local viewmodel_cache = {
    x = 0,
    y = 0,
    z = 0,
    fov = 0
}

-- |Menu|
local mainMenu = lui.group("LUA", "A")
local sideMenu = lui.group("LUA", "B")
local tabs = mainMenu:combo("Tab", "Main", "Anti-Aim", "Visuals", "Misc")


-- [Main]
local welcomeMessage = mainMenu:label("Welcome to liberation, ".. USER_NAME)
    :visible(function()
        return tabs:get() == "Main"
    end)
local buildType = mainMenu:label("Build: Developer") -- Currently hardcoded, genuienly don't think I can do this in any other way lol, I'll have to make a separate branch for each type of releases.
    :visible(function()
        return tabs:get() == "Main"
    end)
local fluxerButton = mainMenu:button("Official Fluxer", function()
        panorama.open().SteamOverlayAPI.OpenExternalBrowserURL("https://fluxer.gg/iZez6vyQ")
    end)
    :visible(function()
        return tabs:get() == "Main"
    end)

mainMenu:label("Accent Color")
    :visible(function()
        return tabs:get() == "Main"
    end)
local accentColor = mainMenu:color_picker("Accent Color", ui.get(refs.menu_color))
    :visible(function()
        return tabs:get() == "Main"
    end)
    :callback(function(color)
        ui.set(refs.menu_color, color:get())
    end)


-- [Anti-Aim] 
-- Kind of a shell until I really get into writing the proper anti-aim, got some great ideas for defensive shenanigans and $tatic $upremacy

local edgeYaw = mainMenu:switch("Edge Yaw")
    :visible(function()
        return tabs:get() == "Anti-Aim"
    end)
local edgeYawhotkey = mainMenu:hotkey("a", true)
    :visible(function()
        return tabs:get() == "Anti-Aim"
    end)
    :add_callback("setup_command", function(bool) --Technically the most correct, if anyone wants to contribute use this event for hotkeys if :callback doesn't work
        ui.set(refs.edge_yaw, bool:get() and edgeYawhotkey:get())
    end)
-- local override_warning = mainMenu:label("Currently haven't tested, may break") -- It DID break. Multiple ways too. Caching is broken(no clue how to fix), direction yaw conflicts are messed up(table with insert at index 1, and whatever's at index 1 it sets as)
--     :visible(function()
--         return tabs:get() == "Anti-Aim"
--     end)

-- local yaw_cache, yaw_numcache, fs_cache, edge_yaw_cache = ui.get(refs.yaw[1]), ui.get(refs.yaw[2]), ui.get(refs.freestanding[2]), edge_yaw_hk:get()

-- local left_override = mainMenu:hotkey("Yaw left override")
--     :visible(function()
--         return tabs:get() == "Anti-Aim"
--     end)
-- local right_override = mainMenu:hotkey("Yaw right override")
--     :visible(function()
--         return tabs:get() == "Anti-Aim"
--     end)
-- local front_override = mainMenu:hotkey("Yaw front override")
--     :visible(function()
--         return tabs:get() == "Anti-Aim"
--     end)
-- local back_override = mainMenu:hotkey("Yaw back override")
--     :visible(function()
--         return tabs:get() == "Anti-Aim"
--     end)

-- events.setup_command:set(function() --bandaid fix and is inefficient, though it should work for now until further integration.
--     if not (left_override:get() or right_override:get() or front_override:get() or back_override:get()) then
--             yaw_cache, yaw_numcache, fs_cache, edge_yaw_cache = ui.get(refs.yaw[1]), ui.get(refs.yaw[2]), ui.get(refs.freestanding[2]), edge_yaw_switch:get() --@note: try ui.get with multiple arguements
--             ui.set(refs.yaw[1], yaw_cache)
--             ui.set(refs.yaw[2], yaw_numcache)
--             ui.set(refs.freestanding[2], fs_cache)
--             edge_yaw_hk:set(edge_yaw_cache)
--         return
--     end
-- local overrides = {}
--     if left_override:get() then
--         ui.set(refs.freestanding[2], false)
--         edge_yaw_switch:set(false)
--         table.insert(overrides, "left")
--         ui.set(refs.yaw[1], "180")
--         ui.set(refs.yaw[2], -90)
--     elseif right_override:get() then
--         ui.set(refs.freestanding[2], false)
--         edge_yaw_switch:set(false)
--         table.insert(overrides, "right")
--         ui.set(refs.yaw[1], "180")
--         ui.set(refs.yaw[2], 90)
--     elseif front_override:get() then
--         ui.set(refs.freestanding[2], false)
--         edge_yaw_switch:set(false)
--         table.insert(overrides, "front")
--         ui.set(refs.yaw[1], "180")
--         ui.set(refs.yaw[2], 180)
--     else
--         ui.set(refs.freestanding[2], false)
--         edge_yaw_switch:set(false)
--         print("BACK IS ON")
--         table.insert(overrides, "back")
--         ui.set(refs.yaw[1], "180")
--         ui.set(refs.yaw[2], 0)
--     end
-- end)

-- [Visuals]

-- Widgets, contains Watermark and Spectator list(for now) in that order

-- Watermark subsection
local function GetFPS()
    if globals.frametime() > 0 then
        return math.ceil(1 / globals.frametime())
    end
    return 0
end

local widgetSwitch = mainMenu:switch("Widgets")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
local widgetSypes = mainMenu:selectable("Widget Types", "Watermark", "Spectators list", "Keybinds List")
    :visible(function()
        return tabs:get() == "Visuals" and widgetSwitch:get()
    end)
    
local watermarkTypes = mainMenu:selectable("Watermark Addons", "Script name", "Name", "FPS", "Ping", "Tick rate", "Time(24h)")
    :visible(function() 
        return tabs:get() == "Visuals" and widget_types:get("Watermark") and widgetSwitch:get()
    end)

local WatermarkMap = function()
    local state = {}
    if watermarkTypes:get("Script name") then
        table.insert(state, "liberation")
    end
    if watermarkTypes:get("Name") then
        table.insert(state, USER_NAME)
    end
    if watermarkTypes:get("FPS") then
        local watermark_fps = string.format("fps: %03d", GetFPS())
        table.insert(state, watermark_fps)
    end
    if watermarkTypes:get("Ping") then
        local ping = math.ceil(client.real_latency() * 1000)
        if math.ceil(client.latency() * 1000) == 0 then
            ping = 0 
        end
        local watermark_ping = string.format("rtt: %dms", ping)
        table.insert(state, watermark_ping)
    end
    if watermarkTypes:get("Tick rate") then
        local watermark_tickrate = string.format("rate: %d", math.ceil(1 / globals.tickinterval()))
        table.insert(state, watermark_tickrate)
    end
    if watermarkTypes:get("Time(24h)") then
        local time = {client.system_time()}
        local watermark_time = string.format("%02d:%02d:%02d", time[1], time[2], time[3])
        table.insert(state, watermark_time)
    end

    return #state > 0 and table.concat(state, " | " or "Liberation")
end

local function Watermark(check, background_color, text_color)
    if not check then
        return
    end
    local bkg_r, bkg_g, bkg_b, bkg_a = background_color:get()
    local txt_r, txt_g, txt_b, txt_a = text_color:get()

    local watermark_txt = WatermarkMap()
    if watermark_txt == false then
        watermark_txt = "liberation"
    end
    local text_size = vector(renderer.measure_text("d", watermark_txt))

    renderer.rectangle(SCREEN_SIZE.x - text_size.x - 20, 10, text_size.x + 10, text_size.y + 8, bkg_r, bkg_g, bkg_b, bkg_a)

    renderer.text(SCREEN_SIZE.x - text_size.x - 15, 13, txt_r, txt_g, txt_b, txt_a, "d", 0, watermark_txt)
end

local widgetBackgroundlabel = mainMenu:label("Widget Background")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)
local widgetBackground = mainMenu:color_picker("Watermark Background", 240,110,140,130)
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)

local widgetTextlabel = mainMenu:label("Widget Text")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark" or "Spectator list" or "Keybinds List")
    end)
local widgetTxt = mainMenu:color_picker("Watermark Text", 240, 160, 180, 250)
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Watermark")
    end)

-- Spectator subsection
local spectatorX = mainMenu:slider("Spectator X", 0, SCREEN_SIZE.x, SCREEN_SIZE.x / 4, true, "px") -- REALLY gotta change this with the drag system soon..
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Spectators list")
    end)
local spectatorY = mainMenu:slider("Spectator Y", 0, SCREEN_SIZE.y, SCREEN_SIZE.y / 4, true, "px")
    :visible(function()
        return tabs:get() == "Visuals" and widget_types:get("Spectators list")
    end)
local function DrawSpectators(check, background_color, text_color)
    if not check then
        return
    end

    local spectators = {}
    local spectated = LOCAL_PLAYER
    for i = 1, globals.maxplayers() do
        if entity.get_classname(i) == 'CCSPlayer' then
            local target = entity.get_prop(i, 'm_hObserverTarget')
            local is_spectating = target ~= nil and target <= 64 and not entity.is_alive(i)
            if is_spectating then
                if spectators[target] == nil then
                    spectators[target] = {}
                end
                if i == LOCAL_PLAYER then
                    goto skip
                end
                table.insert(spectators[target], i)
                ::skip::
            end
        end
    end

    local bkg_r, bkg_g, bkg_b, bkg_a = background_color:get()
    local txt_r, txt_g, txt_b, txt_a = text_color:get()
    local spectator_txt = "Spectators"
    local text_size_main = vector(renderer.measure_text("d", spectator_txt))

    renderer.rectangle(spectatorX:get() - text_size_main.x, spectatorY:get(), text_size_main.x + 80, text_size_main.y + 8, bkg_r, bkg_g, bkg_b, bkg_a)
    renderer.text(spectatorX:get() - text_size_main.x + 40, spectatorY:get() + 3, txt_r, txt_g, txt_b, txt_a, "d", 0, spectator_txt)

    if entity.is_alive(LOCAL_PLAYER) then
        target = LOCAL_PLAYER
    else
        local spectated = entity.get_prop(LOCAL_PLAYER, 'm_hObserverTarget')
        if spectated ~= nil and spectated <= 65 then
            target = spectated
        end
    end

    if target == nil then return end
    local target_spectators = spectators[target]
    if target_spectators == nil then return end


    
    local spectators_x = spectatorX:get() - 38
    local spectators_y = spectatorY:get() + 24

    local height_addition = 0

    for _, index in pairs(target_spectators) do
        local name = entity.get_player_name(index)
        if not name then 
            goto continue 
        end

        local text_size_sub = vector(renderer.measure_text("d", name))
        if text_size_sub.y == 0 then goto continue end

        renderer.text(spectators_x, spectators_y + height_addition, 255, 255, 255, 255, "d", 0, name)

        height_addition = height_addition + (text_size_sub.y + 1)

        ::continue::
    end
end

--Crosshair indicator subsection
local crosshairSwitch = mainMenu:switch("Crosshair indicator")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
local indicatorCrosshaircolor = mainMenu:color_picker("Crosshair indicator color", accentColor:get())
    :visible(function()
        return tabs:get() == "Visuals"
    end)
local crosshairMain = mainMenu:combo("Main font", "Default", "Bold", "Pixel")
    :visible(function()
        return tabs:get() == "Visuals" and crosshair_switch:get()
    end)
local crosshairSub = mainMenu:combo("Sub font", "Default", "Bold", "Pixel")
    :visible(function()
        return tabs:get() == "Visuals" and crosshair_switch:get()
    end)
local crosshairCase = mainMenu:combo("Sub case", "Uppercase", "Lowercase")
    :visible(function()
        return tabs:get() == "Visuals" and crosshair_switch:get()
    end)

local minDmgindicator = mainMenu:combo("Minimum damage number", "None", "Default", "Bold", "Pixel")
    :visible(function()
        return tabs:get() == "Visuals"
    end)

local function DrawIndicators(check, color) 
    if not check then
        return
    end
    if not (entity.is_alive(LOCAL_PLAYER)) then
        return
    end
    local col_r, col_g, col_b, col_a = color:get()
    local crosshair_indicators = {}
    local height_decrease = 16
    local case = ""
    local main_flag = ""
    local sub_flag = ""
    local lib = "liberation"
    local indicators = {}
    local new_dmg_full = nil

    local function measure_txt(txt)
        return vector(renderer.measure_text(main_flag, txt))
    end
    local function scope_check(txt)
        if entity.get_prop(LOCAL_PLAYER, "m_bIsScoped") == 0 then
            return 0
        else
            string.gsub(main_flag, "c", "r")
            string.gsub(sub_flag, "c", "r")
            return measure_txt(txt).x / -1.75
        end
    end

    if crosshairMain:get() == "Default" then
        main_flag = "cd"
        renderer.text(MID_SCREEN.x - scope_check(lib), MID_SCREEN.y + height_decrease, col_r, col_g, col_b, col_a, main_flag, 0, lib)
    elseif crosshairMain:get() == "Bold" then
        main_flag = "cdb"
        renderer.text(MID_SCREEN.x - scope_check(lib), MID_SCREEN.y + height_decrease, col_r, col_g, col_b, col_a, main_flag, 0, lib)
    else
        main_flag = "-c"
        renderer.text(MID_SCREEN.x - scope_check(lib), MID_SCREEN.y + height_decrease, col_r, col_g, col_b, col_a, main_flag, 0, string.upper(lib))
    end
    if crosshairSub:get() == "Default" then
        sub_flag = "cd"
    elseif crosshairSub:get() == "Bold" then
        sub_flag = "cdb"
    else
        sub_flag = "-c" -- looks like ass with lowercase lmao
    end

    if ui.get(refs.fake_duck) then
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, "fakeduck")
        else
            table.insert(crosshair_indicators, "FD")
        end
        table.insert(indicators, "Fake Duck")
    elseif ui.get(refs.double_tap[2]) then
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, "doubletap")
        else
            table.insert(crosshair_indicators, "DT")
        end
        table.insert(indicators, "Double Tap")
    elseif ui.get(refs.hide_shots[2]) then
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, "hideshots")
        else
            table.insert(crosshair_indicators, "HS")
        end
        table.insert(indicators, "Hide Shots")
    end
    if ui.get(refs.edge_yaw) then
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, "edgeyaw")
        else
            table.insert(crosshair_indicators, "EDGE")
        end
        if ui.get(refs.default_indicators) then
        renderer.indicator(255, 255, 255, 200, "EDGE")
        end
        table.insert(indicators, "Edge Yaw")
    elseif ui.get(refs.freestanding[2]) then
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, "freestand")
        else
            table.insert(crosshair_indicators, "FS")
        end
        table.insert(indicators, "Freestanding")
    end
    if ui.get(refs.min_dmg_ovr[2]) then
        if ui.get(refs.min_dmg_ovr[3]) == 0 then
            new_dmg_full = "Auto"
        else
            new_dmg_full = ui.get(refs.min_dmg_ovr[3])
        end
        if crosshairCase:get() == "Lowercase" then
            table.insert(crosshair_indicators, 1, "damage")
        else
            table.insert(crosshair_indicators, 1, "DMG")
        end
        table.insert(indicators, "Minimum Damage: ".. new_dmg_full)
    end
    for n, e in ipairs(crosshair_indicators) do
        height_decrease = height_decrease + 11 -- Turns out shorthand math(+=) doesn't exist in lua
        
        renderer.text(MID_SCREEN.x - scope_check(e), MID_SCREEN.y + height_decrease, 255, 255, 255, 255, sub_flag, 0, e)
    end
end

local function DmgIndicator(check)
    if not check then
        return
    end
    if not (entity.is_alive(LOCAL_PLAYER)) then
        return
    end
    
    local flag = ""
    local alpha = 177
    local dmg = ui.get(refs.min_dmg)

    if minDmgindicator:get() == "Default" then
        flag = "cd"
    elseif minDmgindicator:get() == "Bold" then
        flag = "cdb"
    else
        flag = "-c"
    end
    if ui.get(refs.min_dmg_ovr[2]) then
        alpha = 255
        dmg = ui.get(refs.min_dmg_ovr[3])
    end
    renderer.text(MID_SCREEN.x + 12, MID_SCREEN.y - 9, 255, 255, 255, alpha, flag, 0, dmg)
end
-- local watermark_drag = drag.register({SCREEN_SIZE.x - text_size.x - 20, 10}, {text_size.x + 10, text_size.y + 8}, "Test", function(self))
-- gotta ask mobby about how drag works so I can implement it properly for UI elements, including crosshair indicator at some point

events.paint:set(function()
    Watermark(widget_types:get("Watermark"), widgetBackground, widgetTxt)
    DrawSpectators(widget_types:get("Spectators list"), widgetBackground, widgetTxt)
    DrawIndicators(crosshair_switch:get() or key, indicatorCrosshaircolor)
    DmgIndicator(minDmgindicator:get() ~= "None")
    -- edge_yaw_toggle(edge_yaw_switch:get(), edge_yaw_hk:get())
end)

-- Aspect Ratio + its value that is visible only when switch is on

local aspectRatio = mainMenu:switch("Aspect Ratio")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
    :callback(function(value)
        cvar.r_aspectratio:set_float(value:get() and 0)
    end)
aspect_ratios = {[177] = '16:9', [161] = '16:10', [150] = '3:2', [133] = '4:3', [125] = '5:4'}

local aspectRatiovalue = mainMenu:slider("Aspect Ratio Value", 0, 250, 150, true, false, 1, aspect_ratios)
    :visible(function()
        return aspectRatio:get() and tabs:get() == "Visuals"
    end)
    :callback(function(value)
        if not entity.is_alive(LOCAL_PLAYER) then
            return
        end
        client.set_cvar("r_aspectratio", value:get() / 100)
    end)

-- Viewmodel changer switch which reveals x, y, z and fov(in that order)

local viewmodelChanger = mainMenu:switch("Viewmodel Changer")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
    :callback(function(bool)
        if not bool:get() then 
            client.set_cvar("viewmodel_offset_x", preload_viewmodel_x_cache)
            client.set_cvar("viewmodel_offset_y", preload_viewmodel_y_cache)
            client.set_cvar("viewmodel_offset_z", preload_viewmodel_z_cache)
            client.set_cvar("viewmodel_fov", preload_viewmodel_fov_cache)
        elseif viewmodel_cache.x > 0 or viewmodel_cache.y > 0 or viewmodel_cache.z > 0 or viewmodel_cache.fov > 0 then
            client.set_cvar("viewmodel_offset_x", viewmodel_cache.x)
            client.set_cvar("viewmodel_offset_y", viewmodel_cache.y)
            client.set_cvar("viewmodel_offset_z", viewmodel_cache.z)
            client.set_cvar("viewmodel_fov", viewmodel_cache.fov)
        end
    end)

local viewmodelX = mainMenu:slider("Viewmodel X", -500, 500, viewmodel_x_cache, true, nil, 0.01)
    :visible(function()
        return viewmodelChanger:get() and tabs:get() == "Visuals"
    end)

    :callback(function(value)
        viewmodel_cache.x = value:get() / 100
        client.set_cvar("viewmodel_offset_x", value:get() / 100)
    end)

local viewmodelY = mainMenu:slider("Viewmodel Y", -500, 500, preload_viewmodel_y_cache, true, nil, 0.01)
    :visible(function()
        return viewmodelChanger:get() and tabs:get() == "Visuals"
    end)
    :callback(function(value)
        viewmodel_cache.y = value:get() / 100
        client.set_cvar("viewmodel_offset_y", value:get() / 100) 
    end)

local viewmodelZ = mainMenu:slider("Viewmodel Z", -500, 500, preload_viewmodel_z_cache, true, nil, 0.01)
    :visible(function()
        return viewmodelChanger:get() and tabs:get() == "Visuals"
    end)
    :callback(function(value)
        viewmodel_cache.z = value:get() / 100
        client.set_cvar("viewmodel_offset_z", value:get() / 100)
    end)

local viewmodelFOV = mainMenu:slider("Viewmodel FOV", 50, 120, preload_viewmodel_fov_cache, true)
    :visible(function()
        return viewmodelChanger:get() and tabs:get() == "Visuals"
    end)
    :callback(function(value)
        viewmodel_cache.fov = value:get()
        client.set_cvar("viewmodel_fov", value:get())
    end)


-- [Misc]

-- Hitsound on hit and on kill currently not working due to playing sounds being a mess -NKill

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

-- local hitsound_switch = mainMenu:switch("Custom Hitsound")
--     :visible(function()
--         return tabs:get() == "Misc"
--     end)
-- local hitsound_types = sideMenu:selectable("Hitsound types", {"On hit", "On kill"})
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
-- local hitsound_name = sideMenu:list("Hitsounds", hitsound_refresh())
--     :visible(function()
--         return hitsound_switch:get() and tabs:get() == "Misc"
--     end)
--     :callback(function(choice)
--         hitsound_list_choice = choice:get()
--     end)
-- local hitsound_refresh = sideMenu:button("Refresh hitsounds", 
--     function()
--         hitsound_refresh()
--     end)
--     :visible(function()
--         return tabs:get() == "Misc" and hitsound_switch:get()
--     end)
-- local hitsound_button = sideMenu:button("Select as Hitsound", function()
--         ui.set(refs.default_hitsound, false)
--         hitsound_choice = hitsound_list_choice
--     end)
--     :visible(function()
--         return tabs:get() == "Misc" and hitsound_types:get("On hit") and hitsound_switch:get()
--     end)
-- local killsound_button = sideMenu:button("Select as Killsound",function()
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

local logsSwitch = mainMenu:switch("Logs")
    :visible(function()
        return tabs:get() == "Misc"
    end)
    :add_callback("aim_fire", function(bool, e) -- bool is the switch state, e is the entity
        logs.bt = math.floor(globals.tickcount() - e.tick)
        logs.intended_hitgroup = NAMED_HITGROUPS[e.hitgroup + 1]
        logs.intended_dmg = e.damage
        logs.tp = e.teleported
        return logs.bt, logs.intended_hitgroup, logs.intended_dmg, logs.tp
    end)
    :add_callback("aim_hit", function(bool, e)
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
    :add_callback("aim_miss", function(bool, e)
        local hitgroup_name = NAMED_HITGROUPS[e.hitgroup + 1] or '?'
        local missreason = e.reason
            if missreason == "?" then
                missreason = "resolver" -- nice try skeet
            end

        utils.print(PREFIX, string.format("[X] Missed %s's %s due to %s (tp: %s | hc: %d%% | bt:%st [%dms])", 
        entity.get_player_name(e.target), hitgroup_name, missreason, logs.tp, e.hit_chance, logs.bt, math.floor(totime(logs.bt) * 1000)))
    end)

-- Overengineered Killsay

local function CustomKillsayImport()
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
 
    for index = 1, #data do
        if type(data[index]) ~= "string" then
            utils.print(PREFIX, "Invalid format, all killsays must be strings.")
            return
        end
    end

    utils.print(PREFIX, "Successfully imported ".. #data.. " killsays.")
    return data
end

local killsaySwitch = mainMenu:switch("Killsay", false)
    :visible(function()
       return tabs:get() == "Misc"
    end)
local killsayTypes = mainMenu:selectable("Killsay Types", {"Promotional", "Trashtalk", "Fun", "Custom"})
    :visible(function()
        return killsaySwitch:get() and tabs:get() == "Misc"
    end)
local customKillsay = mainMenu:button("Import Custom Killsay List", function()
        CUSTOM_PHRASES = CustomKillsayImport()
    end)
    :visible(function()
        return killsaySwitch:get() and tabs:get() == "Misc" and killsayTypes:get("Custom")
    end)

local function table_contains(tbl, val)
    for index = 1, #tbl do
        if tbl[index] == val then
            return true
        end
    end
    return false
end

local function GetActiveKillsays()
    local active = {}
    local selected = killsayTypes:get()

    if table_contains(selected, "Promotional") then
        for _, v in ipairs(PROMO_PHRASES) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Trashtalk") then
        for _, v in ipairs(TRASH_PHRASES) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Fun") then
        for _, v in ipairs(FUN_PHRASES) do
            active[#active + 1] = v
        end
    end

    if table_contains(selected, "Custom") then
        for _, v in ipairs(CUSTOM_PHRASES) do
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

    local killsays = GetActiveKillsays()
    if #killsays == 0 then return end

    local msg = killsays[math.random(#killsays)]
    client.exec("say " .. msg)
end)

-- Clantag

local old_tag_string = nil
local can_reset = false

local function CreateClantagAnimation()
    local anim = {}

    local text, prefix = "Liberation", "✰ "
    local cursor = {"_", " ", "_", " "}

    for index = 0, #text do
        if index > 0 then
            table.insert(anim, prefix .. text:sub(1, index) .. "_")
        else
            table.insert(anim, prefix .. "_")
        end
    end

    for _, pos in ipairs(cursor) do 
        table.insert(anim, prefix .. text .. pos) end

    table.insert(anim, prefix .. text .. " ")
    table.insert(anim, prefix .. text .. "_")

    for index = #text, 1, -1 do
        table.insert(anim, prefix .. text:sub(1, index - 1) .. "_")
    end

    table.insert(anim, prefix)
    return anim
end

local anim_txt = CreateClantagAnimation()
local clantagSwitch = mainMenu:switch("Clantag", false)
    :visible(function()
        return tabs:get() == "Misc"
    end)
    :callback(function(bool)
        if bool:get() == false then
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

-- Fast Ladder



-- on shutdown fixing and print on full load


events.shutdown:set(function()
    ui.set(refs.edge_yaw, false)
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