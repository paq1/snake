local tile_map = require("src/models/tile_map")

local game_map = {}

function game_map.create()
    local carte = {}
    for l = 0, 16-1 do
        local line = {}
        for c = 0, 16-1 do
            table.insert(line, tile_map.create(c * 16, l * 16))
        end
        table.insert(carte, line)
    end
    return carte
end

return game_map