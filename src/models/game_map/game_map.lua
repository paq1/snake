local tile_map = require("src/models/tile_map")
local game_map_data = require("src/models/game_map/game_map_data")
local game_map = {}

function game_map.create()
    local carte = {}
    carte.grid = {}
    carte.apples = {}
    carte.data = game_map_data
    local tile_size = game_map_data.tile_size
    for l = 0, 16-1 do
        local line = {}
        for c = 0, 16-1 do
            table.insert(line, tile_map.create(c * tile_size, l * tile_size))
        end
        table.insert(carte.grid, line)
    end
    return carte
end

return game_map