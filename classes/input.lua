local INPUT_STATES = {
    ['acelerador'] = {
        ['GAMEPAD_ACTIONS'] = { 'a', 'x', 'rightshoulder' },
        ['KEYBORD_ACTIONS'] = {'space','up','w','kp8'},
        ['MOUSE_ACTIONS'] = {'1'}
    },
    ['direita'] = {
        ['GAMEPAD_ACTIONS'] = {'dpright', 'triggerright'},
        ['KEYBORD_ACTIONS'] = {'d','right','kp6'}
    },
    ['esquerda'] = {
        ['GAMEPAD_ACTIONS'] = {'dpleft', 'triggerleft'},
        ['KEYBORD_ACTIONS'] = {'a','left','kp4'}
    },
    ['breque'] = {
        ['GAMEPAD_ACTIONS'] = {'b', 'y', 'leftshoulder'},
        ['KEYBORD_ACTIONS'] = {'lshift','s','down','kp2'},
        ['MOUSE_ACTIONS'] = {'1'}
    }
}


function love.keypressed(key)
    if in_table(key, INPUT_STATES.breque.KEYBORD_ACTIONS) then
        Jogador.brecando = true
    elseif in_table(key, INPUT_STATES.acelerador.KEYBORD_ACTIONS) then
        Jogador.acelerando = true
    end
    if in_table(key, INPUT_STATES.direita.KEYBORD_ACTIONS) then
        log('direita')
        Jogador.direita = true
    end
    if in_table(key, INPUT_STATES.esquerda.KEYBORD_ACTIONS) then
        log('esquerda')
        Jogador.esquerda = true
    end

    if key == 'escape' then
        love.quit()
    end
end

function love.keyreleased(key)
    if in_table(key, INPUT_STATES.breque.KEYBORD_ACTIONS) then
        Jogador.brecando = false
    end
    if in_table(key, INPUT_STATES.acelerador.KEYBORD_ACTIONS) then
        Jogador.acelerando = false
    end
    if in_table(key, INPUT_STATES.direita.KEYBORD_ACTIONS) then
        Jogador.direita = false
    end
    if in_table(key, INPUT_STATES.esquerda.KEYBORD_ACTIONS) then
        Jogador.esquerda = false
    end
end

function love.gamepadpressed(controller,button)
    if in_table(key, INPUT_STATES.breque.GAMEPAD_ACTIONS) then
        Jogador.brecando = true
    end
    if in_table(key, INPUT_STATES.acelerador.GAMEPAD_ACTIONS) then
        Jogador.acelerando = true
    end
    if in_table(key, INPUT_STATES.direita.GAMEPAD_ACTIONS) then
        Jogador.direita = true
    end
    if in_table(key, INPUT_STATES.esquerda.GAMEPAD_ACTIONS) then
        Jogador.esquerda = true
    end
end

function love.gamepadreleased(controller,button)
    if in_table(key, INPUT_STATES.breque.GAMEPAD_ACTIONS) then
        Jogador.brecando = false
    end
    if in_table(key, INPUT_STATES.acelerador.GAMEPAD_ACTIONS) then
        Jogador.acelerando = false
    end
    if in_table(key, INPUT_STATES.direita.GAMEPAD_ACTIONS) then
        Jogador.direita = false
    end
    if in_table(key, INPUT_STATES.esquerda.GAMEPAD_ACTIONS) then
        Jogador.esquerda = false
    end
end

function love.gamepadaxis(controller,direcion,movement)
    --if temporario - melhor fazer inline o movement
    if direcion == 'righty' then
        if movement > 0 then
            Jogador.acelerando = true
            Jogador.brecando = false
        elseif(movement < 0) then
            Jogador.brecando = true
            Jogador.acelerando = false
        else
            Jogador.acelerando = false
            Jogador.brecando = false
        end
    end
    if direcion == 'leftx' then
        if movement > 0 then
            Jogador.direita = true
            Jogador.esquerda = false
        elseif(movement < 0) then
            Jogador.esquerda = true
            Jogador.direita = false
        else
            Jogador.direita = false
            Jogador.esquerda = false
        end
    end
end

function love.mousepressed(x,y,button)
    if(button == 1) then
        Jogador.acelerando = true
    elseif(button == 2) then
        Jogador.brecando = true
    end
end

function love.mousereleased(x,y,button)
    if(button == 1) then
        Jogador.acelerando = false
    elseif(button == 2) then
        Jogador.brecando = false
    end
end
