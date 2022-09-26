--Biblioteca de funções úteis

function in_table(needle,haystack)
    check = false
    for k,v in pairs(haystack) do
        if(v == needle) then
            check = true
        end
    end
    return check
end

function key_exists(needle, haystack)
    local check = false
    for k, v in pairs(haystack) do
        if(k == needle) then
            check = true
        end
    end
    return check
end

--Pega a chave da table na posição needle (int)
function get_key(needle, haystack)
    local index = get_keys(haystack)
    return index[needle]
end

function get_keys(haystack)
    local index={}
    for k,v in pairs(haystack) do
        index[v]=k
    end
    return index
end


function log(str, data)
    if(data ~= nil) then
        print(str, dump(data))
    else
        print(str)
    end
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end