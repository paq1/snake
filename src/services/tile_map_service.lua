local tile_map_service = {}

function tile_map_service.draw(tile, cam, tile_size)
    local haut_gauche = {tile.x + cam.w, tile.y + cam.h}
    local haut_droite = {tile.x + tile_size + cam.w, tile.y + cam.h}
    local bas_droite = {tile.x + tile_size + cam.w, tile.y - tile_size + cam.h}
    local bas_gauche = {tile.x + cam.w, tile.y - tile_size + cam.h}
    local points = concat({}, concat(haut_gauche, concat(haut_droite, concat(bas_droite, concat(bas_gauche, haut_gauche)))))
    love.graphics.line(points)
end

function concat(l1, l2)
    local new_list = {}
    table.foreach(l1, function(k, v) table.insert(new_list, v) end)
    table.foreach(l2, function(k, v) table.insert(new_list, v) end)
    return new_list
end

return tile_map_service