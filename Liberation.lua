-- Welcome to the pit. If you're here to contribute, do send a pull request on github.com/NKillHere/Liberation. Thanks in advance.
-- If you're here to copy code, follow the GPLv3 license terms.

-- |Libraries|


local lapi_check, lapi = pcall(require "gamesense/lapi")
--@todo: apparently error isn't working, got to figure this shit out
-- if not lapi_check then
--     error("LAPI is required for this lua, download from https://github.com/Tony1337-bit/library")
-- end
local clipboard = require("gamesense/clipboard")
local vector = require("vector")

-- |Constants|

local NAMED_HITGROUPS = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg","right leg", "neck", "?", "gear"}
local PREFIX = "Liberation"
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


local menu = lui.group("LUA", "A")
local tabs = menu:combo("Tab", "Main", "Visuals", "Misc")


-- [Main]


local menu_color = ui.reference("MISC", "Settings", "Menu color") 

menu:label("Accent Color")
:visible(function()
    return tabs:get() == "Main"
end)

local accent_color = menu:color_picker("Accent Color", ui.get(menu_color))
    :visible(function()
        return tabs:get() == "Main"
    end)
    :callback(function(col)
        ui.set(menu_color, col:get())
    end)


-- [Visuals]


-- Watermark 

local function get_fps()
    if globals.frametime() > 0 then
        return math.ceil(1 / globals.frametime())
    end
    return 0
end

local watermark_switch = menu:switch("Watermark")
    :visible(function()
        return tabs:get() == "Visuals"
    end)
-- local watermark_types = menu:selectable("Watermark Addons", "Script Name", "Name", "FPS", "Ping", "Tick Rate", "Time(24h)")
--     :visible(function()
--         return tabs:get() == "Visuals" and watermark_switch:get()
--     end)
--     :callback(function()
--         local state = {}
--         local sname, name = "", ""
--         local map = {
--             ["Script Name"] = function()
--                 sname = "liberation" or ""
--             end
--             ["Name"] = function()
--                 name = utils.name() or ""
--             end
--             ["FPS"] = function()
--                 fps = get_fps() or ""
--             end
--             ["Ping"] = function()
--                 latency = math.ceil(client.latency() * 1000)
--             end
--             ["Tick Rate"] = function()
--                 tickrate = math.ceil(1 / globals.tickinterval())
--             end
--             ["Time(24h)"] = function()
--                 local time = {client.system_time()}
--             end
--             }
--     end)

local txt_r, txt_g, txt_b, txt_a = {255,255,255,255} -- lazy to find out how to pass values from two separate callbacks into 1 function, so this'll do just fine -NKill

local function watermark(bkg_r, bkg_g, bkg_b, bkg_a)
    if not watermark_switch:get() then
        return
    end
    local screen_size = vector(client.screen_size())
    local latency = math.ceil(client.latency() * 1000)
    local tickrate = math.ceil(1 / globals.tickinterval())
    local time = {client.system_time()}
    local formatted_time = string.format("%02d:%02d:%02d", time[1], time[2], time[3])
    local fps = get_fps()

    local watermark_txt = "liberation".. " | ".. utils.name().. " | ".. string.format("fps: %03d", fps).. " | ".. string.format("rtt: %dms", latency)..
    " | ".. string.format("rate: %d", tickrate).. " | ".. formatted_time
    
    local text_size = vector(renderer.measure_text(nil, watermark_txt))

    renderer.rectangle(screen_size.x - text_size.x - 20, 10, text_size.x + 10, text_size.y + 8, bkg_r, bkg_g, bkg_b, bkg_a)

    renderer.text(screen_size.x - text_size.x - 16, 13, txt_r, txt_g, txt_b, txt_a, "d", 0, watermark_txt)
end

local watermark_background = menu:label("Watermark Background")
    :visible(function()
        return tabs:get() == "Visuals" and watermark_switch:get()
    end)
local watermark_background_col = menu:color_picker("Watermark Background", {240,110,140,130})
    :visible(function()
        return tabs:get() == "Visuals" and watermark_switch:get()
    end)
    :add_callback("paint", function(self) 
        return watermark(self:get())
    end)

local watermark_text = menu:label("Watermark Text")
    :visible(function()
        return tabs:get() == "Visuals" and watermark_switch:get()
    end)
local watermark_text_col = menu:color_picker("Watermark Text", 240, 160, 180, 250)
    :visible(function()
        return tabs:get() == "Visuals" and watermark_switch:get()
    end)
    :callback(function(self)
        txt_r, txt_g, txt_b, txt_a = self:get()
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
        if not entity.is_alive(entity.get_local_player()) then
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

    if attacker ~= entity.get_local_player() then return end
    if not entity.is_enemy(victim) then return end

    local killsays = get_active_killsays()
    if #killsays == 0 then return end

    local msg = killsays[math.random(#killsays)]
    client.exec("say " .. msg)
end)

-- Clantag

local old_tag_string = nil
local can_reset = false
-- This could probably be optimized size-wise, I have no idea how however. -- NKill
local anim_txt = {"✰ ", "✰ _", "✰ _", "✰ L_", "✰ L_", "✰ Li_", "✰ Li_", "✰ Lib_", "✰ Lib_", "✰ Libe_", "✰ Libe_",
 "✰ Liber_", "✰ Liber_", "✰ Libera_", "✰ Libera_","✰ Liberat_","✰ Liberat_", "✰ Liberati_", "✰ Liberati_","✰ Liberatio_", 
 "✰ Liberatio_","✰ Liberation_", "✰ Liberation _", "✰ Liberation ", "✰ Liberation _", "✰ Liberation ", "✰ Liberation_",
 "✰ Liberatio_", "✰ Liberatio_","✰ Liberati_", "✰ Liberati_", "✰ Liberat_", "✰ Liberat_", "✰ Libera_", "✰ Libera_", "✰ Liber_", 
 "✰ Liber_", "✰ Libe_","✰ Libe_", "✰ Lib_", "✰ Lib_", "✰ Li_", "✰ Li_", "✰ L_", "✰ L_", "✰ _", "✰ _", "✰ "}

local clantag = menu:switch("Clantag", false)
    :visible(function()
        return tabs:get() == "Misc"
    end)
    :add_callback("setup_command", function()
        local curtime = math.floor((globals.curtime()) * 6 )
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
    utils.print(PREFIX, string.format("See you next time, %s.", utils.name()))
end)

utils.print(PREFIX, string.format("Fully loaded, %s. Welcome to Liberation.", utils.name()))