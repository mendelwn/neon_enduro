Audio = Class{}



function Audio:init()
    --MUSICA
    --Credits: TeknoAxe - https://www.youtube.com/c/teknoaxe
    self.BGM = {
        love.audio.newSource('sound/bgm/Dance_of_the_Dystopian.mp3', 'static'),
        love.audio.newSource('sound/bgm/Interceptor.mp3', 'static'),
        love.audio.newSource('sound/bgm/Run_at_Midnight.mp3', 'static'),
        love.audio.newSource('sound/bgm/Source_Code_Synthwave.mp3', 'static'),
    }

    self.SFX = {
        ['crash_back'] = love.audio.newSource('sound/sfx/crash_back.wav', 'static'),
        ['crash_side'] = love.audio.newSource('sound/sfx/crash_side.wav', 'static'),
        ['engine_idle'] = love.audio.newSource('sound/sfx/engine_idle.wav', 'static'),
        ['engine_low'] = love.audio.newSource('sound/sfx/engine_low.wav', 'static'),
        ['engine_med'] = love.audio.newSource('sound/sfx/engine_med.wav', 'static'),
        ['engine_high'] = love.audio.newSource('sound/sfx/engine_high.wav', 'static'),
        ['engine_max'] = love.audio.newSource('sound/sfx/engine_max.wav', 'static'),
        ['drpassby1'] = love.audio.newSource('sound/sfx/drpassby1.wav', 'static'),
        ['drpassby2'] = love.audio.newSource('sound/sfx/drpassby2.wav', 'static'),
        ['drpassby3'] = love.audio.newSource('sound/sfx/drpassby3.wav', 'static'),
        ['drpassby4'] = love.audio.newSource('sound/sfx/drpassby4.wav', 'static'),
    }
end

function Audio:update(dt)
    local engine = 'idle'
    if Jogador.acelerando then
        if velocidade == 60 then
            engine = 'max'
        elseif velocidade >= 40 then
            engine = 'high'
        elseif velocidade >= 20 then
            engine = 'med'
        elseif velocidade >= 0 then
            engine = 'low'
        end
    end
    if(velocidade > 0 or Jogador.acelerando) then
        if Jogador.acelerando then
            Audio:playsound(self.SFX['engine_' .. engine], true)
        else
        end
    end

end


function Audio:playsound(audio,loop)
    loop = loop == nil and false or loop
    audio:setLooping(loop)
    audio:play()
end