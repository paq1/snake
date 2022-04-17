local tile_map_service = require("src/services/tile_map_service")

local game_map_service = {}

function game_map_service.draw(game_map, cam)
    local nb_line = #game_map
    local nb_column = #game_map[1]
    for l = 1, nb_line do
        for c = 1, nb_column do
            local tile = game_map[l][c]
            tile_map_service.draw(tile, cam)
        end
    end
end

return game_map_service