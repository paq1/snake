local tile_map_service = require("src/services/tile_map_service")
local spawner_apple = require("src/services/game_map/spawner_apple")
local game_map_data = require("src/models/game_map/game_map_data")

local game_map_service = {}

function game_map_service.update(game_map, dt)
    game_map_service.spawn_apple(game_map)
end

function game_map_service.draw(game_map, cam)
    draw_grid(game_map, cam)
    draw_apples(game_map.apples, game_map.data.tile_size, cam)
end

function game_map_service.spawn_apple(game_map)
    if #game_map.apples == 0 then
        print("creation")
        table.insert(game_map.apples, spawner_apple.spawn(game_map.data.size))
        print(game_map.apples[1].position.x)
    end
end

-- on supprime la premiere pomme de la liste
function game_map_service.delete_apple(game_map)
    if #game_map.apples > 0 then
        table.remove(game_map.apples, 1)
    end
end

function draw_grid(game_map, cam)
    local nb_line = #game_map.grid
    local nb_column = #game_map.grid[1]
    for l = 1, nb_line do
        for c = 1, nb_column do
            local tile = game_map.grid[l][c]
            tile_map_service.draw(tile, cam, game_map_data.tile_size)
        end
    end
end

function draw_apple(apple, tile_size, cam)
    local col = apple.position.x
    local row = apple.position.y
    local x = col * tile_size
    local y = row * tile_size
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill", x + cam.w, y + cam.h, tile_size, tile_size)
    love.graphics.setColor(255,255,255)
end

function draw_apples(apples, tile_size, cam)
    for k in pairs(apples) do
        local apple = apples[k]
        draw_apple(apple, tile_size, cam)
    end
end

return game_map_service