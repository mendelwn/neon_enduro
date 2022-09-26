Fundo = Class{}

local ESTRADA_IMG = {
    ['reta'] = love.graphics.newImage('img/estrada1.png'),
    ['curva'] = love.graphics.newImage('img/estrada2.png')
}

local animation_timer = 5

function Fundo:init()
    self.x = 0
    self.y = VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3

    self.width = ESTRADA_IMG['reta'].width
    self.height = ESTRADA_IMG['reta'].height

    --usada pra inverter nas curvas
    self.direcao = 1 -- direção q a estrada curva 1 para esquerda e -1 p direita

    --usado pra definir se estamos na reta, animando ou na curva
    self.STATES = {
        'reta', 'curva'
    }
    self.state = self.STATES[1]

    --Distancia percorrida entre um frame da animação para outro
    self.dist_percorrida = 0
    --Distancia pro prox ponto de animação
    self.DIST_ANIMACAO = 70
    --Dist pra prox reta ou pra prox curva - será RANDOM
    self.dist_prox_anim = 200

    self.animation_direction = 1
end

function Fundo:update(dt)
    self.dist_percorrida = self.dist_percorrida + velocidade * dt

    --Muda o estado caso necessário
    if self.dist_percorrida >= self.dist_prox_anim then
        self.dist_prox_anim = math.random(100, 200)
        self.state = self.STATES[math.random(2)]
        self.direcao = 0
        if(self.state ~= 'reta') then
            self.direcao = math.random(1,10) % 2 == 0 and 1 or -1
        end
        self.dist_percorrida = 0
    end

end

function Fundo:render()
    local img = ESTRADA_IMG[self.state]
    local dir = self.direcao < 0 and -1 or 1
    local x = 0
    if(self.direcao == -1) then
        x = VIRTUAL_WIDTH
    end

    love.graphics.draw(img,
            x, --x
            5, --y
            0, -- rotation
            dir, --espelhar x
            1) -- espelhar y
end
