local Direction = require("src/models/direction/direction")

local snake = {}

function snake.create(position)
    local sn = {}

    sn.direction = Direction.DROITE
    sn.position = position
    sn.vitesse = 0.2

    return sn
end

return snake