local apple_mod = require("src/models/apple/apple")

local spawner_apple = {}

-- cree une pomme sans prendre en compte la postion se snake
function spawner_apple.spawn(game_size)
    local nb_cols = game_size.w
    local nb_rows = game_size.h

    local l = math.random(1, nb_rows)
    local c = math.random(1, nb_cols)

    return apple_mod.create({x = c, y = l})
end

return spawner_apple