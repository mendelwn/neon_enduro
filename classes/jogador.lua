Jogador = Class{}

SPRITE = love.graphics.newImage('img/srpites.png')

function Jogador:init()
    self.x = 232
    self.y = 270

    self.POSSIBLE_WIDTH = {
        ['reta'] = 48,
        ['curva_fraca'] = 54,
        ['curva_forte'] = 59
    }
    self.width = self.POSSIBLE_WIDTH.reta
    self.height = 28

    self.SPRITE_OFFSET = {
        ['reta'] = {
            love.graphics.newQuad(6,4,48,28,SPRITE),
            love.graphics.newQuad(74,4,48,28,SPRITE)
        },
        ['curva_fraca'] = {
            love.graphics.newQuad(4,39,54,28,SPRITE),
            love.graphics.newQuad(71,39,54,28,SPRITE)
        },
        ['curva_forte'] = {
            love.graphics.newQuad(4,74,59,28,SPRITE),
            love.graphics.newQuad(71,74,59,28,SPRITE)
        }
    }
    self.state = 'reta'

    --Distancia percorrida entre um frame da animação para outro
    self.dist_percorrida = 0

    self.animation_sprite = 1
    self.anim_counter = 0

    --States do Jogador:
    self.acelerando = false
    self.direita = false
    self.esquera = false
    self.brecando = false
    self.direcao = 0
end

function Jogador:update(dt)
    self.dist_percorrida = self.dist_percorrida + velocidade * dt

    self:selecionar_imagem(dt)

    self.width = self.POSSIBLE_WIDTH[self.state]

    Jogador:modifica_movimento(dt)
end

function Jogador:render()
    local x = self.x
    if self.direcao == -1 then
        x = self.x + self.width
    end
    local dir = 1
    if(self.direcao == -1) then
        dir = self.direcao
    end

    log('self.state ' .. self.state .. ' self.animation_sprite ' .. self.animation_sprite)

    love.graphics.draw(SPRITE,
        self.SPRITE_OFFSET[self.state][self.animation_sprite], --QUAD
        x, --x
        self.y, --y
        0, --Rotation
        dir, --espelhar x como o padrão é esquerda 1 e dir -1
        1 --espelhar y
    )
end

function Jogador:selecionar_imagem(dt)
    self.state = 'reta'
    --Carro parado n vira
    if(velocidade > 0) then
        if(Fundo.state ~= 'reta') then
            if(self.direcao == Fundo.direcao) then
                self.state = 'curva_forte'
            else
                self.state = 'curva_fraca'
            end
        elseif math.abs(self.direcao) == 1 then
            self.state = 'curva_fraca'
        end
    end

    --velocidade max = 50 ? 100? 1000?
    --Decidindo qual será o sprite de animação de acordo com a velocidade atual
    if(velocidade > 0) then
        local limit = (MAX_SPEED / velocidade)
        self.anim_counter = self.anim_counter + (velocidade * dt)
        if self.anim_counter >= limit then
            self.anim_counter = 0
            self.animation_sprite = self.animation_sprite == 1 and 2 or 1
        end
    end
end

function Jogador:input()
    --Modificando a constante de aceleração:
    if self.brecando == false and self.acelerando then
        aceleracao = ACEL
    elseif self.brecando then
        aceleracao = BRK
    else
        aceleracao = 0
    end

    self.direcao = 0
    if self.esquerda == false and self.direita then
        self.direcao = -1
    elseif self.direita == false and self.esquerda then
        self.direcao = 1
    end
end

function Jogador:modifica_movimento(dt)
    Jogador:input()

    --Atrito de .0001 leva 2,8 minutos para parar o carro na reta
    local modificadores = {
        ['reta'] = {
            ['x_accel'] = 1, ['atrito'] = .01
        },
        ['curva'] = {
            ['x_accel'] = 1.2, ['atrito'] = .03
        },
    }

    --Modificando a velocidade
    velocidade = velocidade + (aceleracao * dt)
    if(velocidade > 0) then
        velocidade = velocidade - (modificadores[Fundo.state]['atrito'] * dt)
    end

    local CENTRIPETA = 40
    --Dirigindo na virada
    if math.abs(self.direcao) == 1 and velocidade > 0 then
        --Virada NORMAL
        local virada = 80
        if Fundo.state ~= 'reta' then
            if self.direcao ~= 0 and Fundo.direcao == self.direcao then
                virada = virada + modificadores[Fundo.state]['x_accel']
            else
                virada = virada + CENTRIPETA * modificadores[Fundo.state]['x_accel']
                velocidade = velocidade - modificadores[Fundo.state]['atrito']
            end
        end
        self.x = self.x + virada * self.direcao * -1 * dt
    end

    --virada sem dirigir
    if Fundo.state ~= 'reta' then
        self.x = self.x + Fundo.direcao * CENTRIPETA * modificadores[Fundo.state]['x_accel'] * dt
        velocidade = velocidade - modificadores[Fundo.state]['atrito']
    end

    --Se bate no limite da estrada
    if(self.x <= 145) then
        velocidade = velocidade - 2
        self.x = 155
    end
    if(self.x >= 320) then
        velocidade = velocidade - 2
        self.x = 315
    end


    --Se bate atras de um carro

    --Se bate do lado do carro

    --Se um carro bate nele


    --Limite máximo de velocidade
    velocidade = velocidade >= MAX_SPEED and MAX_SPEED or velocidade
    velocidade = velocidade < 0 and 0 or velocidade

end