local carte = require("src/models/game_map")
local game_map_service = require("src/services/game_map_service")
local timer = 0
local fps = 0
local nb_frames = 0
local game_map = {}
local camera = {}

function love.load()
    game_map = carte.create()
    camera = {w = love.graphics.getWidth() / 4, h = love.graphics.getHeight() / 4}
end

function love.update(dt)
    timer = timer + dt
    nb_frames = nb_frames + 1
    if timer > 1.0 then
        fps = nb_frames
        nb_frames = 0
        timer = 0
    end
end

function love.draw()
    game_map_service.draw(game_map, camera)
    draw_fps(fps)
end


function draw_fps(fps)
    love.graphics.print("fps : "..fps, 0, 0)
end