local test = require("src/test")
local timer = 0
local fps = 0
local nb_frames = 0
local game_map = {}
local camera = {}

function love.load()
    print(" -- loading OK")
    test.toto()
    game_map = load_map()
    camera = {w = love.graphics.getWidth() / 4, h = love.graphics.getHeight() / 4}
end

function love.update(dt)
    timer = timer + dt
    nb_frames = nb_frames + 1
    if timer > 1.0 then
        print("1 seconde de plus")
        fps = nb_frames
        nb_frames = 0
        timer = 0
    end
end

function love.draw()
    love.graphics.print("Hello World!", 300, 300)
    draw_map(game_map, camera)
    draw_fps(fps)
end


function draw_fps(fps)
    love.graphics.print("fps : "..fps, 0, 0)
end

function load_map()
    local carte = {}
    for l = 0, 16-1 do
        local line = {}
        for c = 0, 16-1 do
           table.insert(line, create_tile(c * 16, l * 16))
        end
        table.insert(carte, line)
    end
    return carte
end

function create_tile(x, y)
    return {x = x, y = y}
end

function draw_map(carte, cam)
    local nb_line = #carte
    local nb_column = #carte[1]
    for l = 1, nb_line do
        for c = 1, nb_column do
            local tile = carte[l][c]
            if tile == nil then
                print("nil")
            else
                draw_tile(tile, cam)
            end
        end
    end
end


function draw_tile(tile, cam)
    local haut_gauche = {tile.x + cam.w, tile.y + cam.h}
    local haut_droite = {tile.x + 16 + cam.w, tile.y + cam.h}
    local bas_droite = {tile.x + 16 + cam.w, tile.y - 16 + cam.h}
    local bas_gauche = {tile.x + cam.w, tile.y - 16 + cam.h}
    local points = concat({}, concat(haut_gauche, concat(haut_droite, concat(bas_droite, concat(bas_gauche, haut_gauche)))))
    love.graphics.line(points)
end

function concat(l1, l2)
    local new_list = {}
    table.foreach(l1, function(k, v) table.insert(new_list, v) end)
    table.foreach(l2, function(k, v) table.insert(new_list, v) end)
    return new_list
end