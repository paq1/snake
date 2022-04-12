local test = require("src/test")
local timer = 0
function love.load()
    print(" -- loading OK")
    test.toto()
end

function love.update(dt)
    timer = timer + dt
    if timer > 1.0 then
        print("1 seconde de plus")
        timer = 0
    end
end

function love.draw()
    love.graphics.print("Hello World!", 300, 300)
end