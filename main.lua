local carte = require("src/models/game_map/game_map")
local game_map_service = require("src/services/game_map_service")

local sn = require("src/models/snake/snake")
local snake_service = require("src/services/snake_service")

local timer = 0
local fps = 0
local nb_frames = 0
local game_map = {}
local snake = {}
local camera = {}

function love.load()
    game_map = carte.create()
    snake = sn.create({ x = 0, y = 0 })
    camera = {w = 0, h = 0}
end

function love.update(dt)
    timer = timer + dt
    nb_frames = nb_frames + 1
    if timer > 1.0 then
        fps = nb_frames
        nb_frames = 0
        timer = 0
    end

    snake_service.update(snake, dt, game_map)
end

function love.draw()
    game_map_service.draw(game_map, camera)
    snake_service.draw(snake, game_map, camera)
    draw_fps(fps)
end


function draw_fps(fps)
    love.graphics.print("fps : "..fps, 0, love.graphics.getHeight() -32)
end