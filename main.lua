--Libs

push = require 'lib/push'
require 'lib/util'
Class = require 'lib/class'

--Classes
require('classes/fundo')
require('classes/jogador')
require('classes/input')
require('classes/audio')

--setup seed random
math.randomseed(os.time())

--Constants
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 448
WINDOW_WIDTH = 1366
WINDOW_HEIGHT = 768


local boot_sequence = 1
local BOOTS_SEQ_TEXT = {
    'I', 'IN', 'INI', 'INIC', 'INICIA', 'INICIAN', 'INICIAND', 'INICIANDO', 'INICIANDO.','INICIANDO..', 'INICIANDO...'
}
local start = love.timer.getTime()

--Global Vars
ACEL = 5
BRK = -.4
aceleracao = 0

MAX_SPEED = 60
velocidade = 0

console = ''
title = ''

function love.resize(w, h)
    push:resize(w, h)
end

function love.load()
    current_bgm = 1

    neon = love.graphics.newFont('neon.ttf', 48)
    computer = love.graphics.newFont('LazenbyCompLiquid.ttf', 12)

	--love.graphics.setDefaultFilter('nearest', 'linear')

	love.window.setTitle('NeonEnduro')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    Fundo = Fundo()
    Jogador = Jogador()
    Audio = Audio()

end

function love.update(dt)
    --Splash Screen
    if boot_sequence > 0 then
        local timediff = (love.timer.getTime() - start) * 5 --3
        boot_sequence = math.ceil(timediff)
        console = BOOTS_SEQ_TEXT[boot_sequence] ~= nil and BOOTS_SEQ_TEXT[boot_sequence] or ''
        if(timediff > 12) then
            Audio:playsound(Audio.BGM[current_bgm], true)

            boot_sequence = 0
            console = 'Aperte Enter para começar'
            title = 'Neon Enduro'
        end
    end

    Fundo:update(dt)
    Jogador:update(dt)
    Audio:update(dt)

end

function love.draw()
    love.graphics.reset()
    love.graphics.clear(0, 0, .02, 1)
    push:start()

    Fundo:render()
    Jogador:render()


    --Console
    if console ~= '' then
        love.graphics.setColor(0,.9,0)
        love.graphics.setFont(computer)
        love.graphics.printf('Console: \r\n' .. console, VIRTUAL_WIDTH - 200, 0, VIRTUAL_WIDTH, 'left')
    end

    --Title
    if title ~= '' then
        love.graphics.setColor(.32,.32,.65)
        love.graphics.setFont(neon)
        love.graphics.printf(title, 10, 90, VIRTUAL_WIDTH, 'center')
    end

    push:finish()
end

