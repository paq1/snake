local sn = require("src/models/snake/snake")
local Direction = require("src/models/direction/direction")
local game_map_data = require("src/models/game_map/game_map_data")
local keyboard_service = require("src/services/keyboard/keyboard_service")
local game_map_service = require("src/services/game_map/game_map_service")

local snake_service = {}
snake_service.timer = 0
snake_service.next_dir = Direction.DROITE

function snake_service.update(snake, dt, game_map)
    avance(snake, dt, game_map)
    snake_eat_apple_update(snake, game_map)
end

function snake_service.draw(snake, game_map, camera)
    local tile_size = game_map_data.tile_size
    local x = snake.position.x * tile_size
    local y = snake.position.y * tile_size

    love.graphics.rectangle("fill", x, y, tile_size, tile_size)
end

function avance(snake, dt, game_map)
    snake_service.timer = snake_service.timer + dt

    -- gestion changement de direction
    if keyboard_service.is_down("z", "d", "s", "q") then
        snake_service.next_dir = deplacement_keyboard(snake)
    end

    if snake_service.timer > snake.vitesse then
        snake.direction = snake_service.next_dir
        local nouvelle_pos = nouvelle_position(snake, dt, game_map)
        snake.position = nouvelle_pos
        snake_service.timer = 0
    end
end

-- retourne la position sur la map de la tete du snake
function nouvelle_position(snake, dt, game_map)
    local direction = snake.direction

    if direction == Direction.HAUT then
        return { x = snake.position.x, y = snake.position.y - 1 }
    end
    if direction == Direction.DROITE then
        return { x = snake.position.x + 1, y = snake.position.y }
    end
    if direction == Direction.BAS then
        return { x = snake.position.x, y = snake.position.y + 1 }
    end
    if direction == Direction.GAUCHE then
        return { x = snake.position.x - 1, y = snake.position.y }
    end

end

-- retourne la nouvelle direction que doit prendre le snake en fonctiuon de la touche du clavier préssée
function deplacement_keyboard(snake)
    if keyboard_service.is_down("z") then
        if snake.direction ~= Direction.BAS then
            return Direction.HAUT
        else
            return Direction.BAS
        end
    end
    if keyboard_service.is_down("d") then
        if snake.direction ~= Direction.GAUCHE then
            return Direction.DROITE
        else
            return Direction.GAUCHE
        end
    end
    if keyboard_service.is_down("s") then
        if snake.direction ~= Direction.HAUT then
            return Direction.BAS
        else
            return Direction.HAUT
        end
    end
    if keyboard_service.is_down("q") then
        if snake.direction ~= Direction.DROITE then
            return Direction.GAUCHE
        else
            return Direction.DROITE
        end
    end
end

function snake_eat_apple_update(snake, game_map)
    if #game_map.apples > 0 then
        local apple = game_map.apples[1]
        if is_snake_collide_with_apple(snake, apple) then
            game_map_service.delete_apple(game_map)
        end
    end
end

function is_snake_collide_with_apple(snake, apple)
    return snake.position.x == apple.position.x and snake.position.y == apple.position.y
end

return snake_service