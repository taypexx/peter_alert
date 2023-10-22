local ui = require("ui")
local audio = require("audio")
local corepath = sys.currentdir
local soundpath = corepath.."\\sfx\\"

local fart = sys.File(soundpath.."fart.mp3")
local sus = sys.File(soundpath.."sus.mp3")
local birdsong = sys.File(soundpath.."bird_song.mp3")
local stupid_n = sys.File(soundpath.."you_stupid_n.mp3")
local i_hate_n = sys.File(soundpath.."i_hate_n.mp3")
local money = sys.File(soundpath.."money.mp3")
local who_cares = sys.File(soundpath.."who_cares.mp3")

local peters = 0
local mainwin

local randomPeter
    randomPeter = {
        function ()
            audio.play(i_hate_n)
            ui.info("I hate n","Peter Alert")
        end,
        function ()
            audio.play(sus)
            local result = ui.confirm("i need money. give me money","Peter Alert")
            if result == "yes" then
                audio.play(money)
                ui.msg("givememoney givememoney givememoney givememoney")
            elseif result == "no" then
                audio.play(stupid_n)
                ui.msg("you stupid n")
            elseif result == "cancel" then
                randomPeter[2]()
            end
        end,
        function ()
            audio.play(fart)
            local result = ui.confirm("do you need money","Peter Alert")
            if result == "yes" then
                audio.play(who_cares)
                ui.msg("oh my god. who the HELL cares")
                audio.play(money)
                ui.msg("givememoney givememoney givememoney givememoney")
            elseif result == "no" then
                audio.play(stupid_n)
                ui.msg("you stupid n")
                audio.play(money)
                ui.msg("givememoney givememoney givememoney givememoney")
            elseif result == "cancel" then
                randomPeter[3]()
            end
        end
        
    }

function CreatePeter()
    peters = peters + 1
    local win = ui.Window("Peter Alert", "single", 300, 200)
    if peters == 1 then
        win:center()
        mainwin = win
    else
        win.x = mainwin.x + math.random(10,400)*((-1)^math.random(1,2))
        win.y = mainwin.y + math.random(10,400)*((-1)^math.random(1,2))
    end
    win:loadicon(corepath.."/peter.ico")

    function win:onClose()
        audio.play(sus)
        ui.warn("How dare you close peter alert","Peter Alert")
        audio.play(sus)
        ui.warn("You are going to be executed.","Peter Alert")
        audio.play(birdsong)
        for i=1,15 do
            ui.msg("BIRD IS THE WORD","Peter Alert")
            audio.play(sus)
            sleep(100)
        end
        audio.play(stupid_n)
        ui.info("you stupid n","Peter Alert")
        sleep(1000)
    end
    
    local ok = ui.Button(win, "OK", 115, 150,75,30)
    local peter = ui.Picture(win, "peter.png", 100,25)
    
    function peter:onClick()
        randomPeter[math.random(1,#randomPeter)]()
    end
    
    function ok:onClick()
        CreatePeter()
    end
    
    audio.play(fart)
    ui.msg("Peter Alert","Peter Alert")
    audio.play(sus)
    ui.run(win) 
end

CreatePeter()