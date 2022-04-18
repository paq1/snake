local keyboard_service = {}

function keyboard_service.is_down(key, ...)
    return love.keyboard.isDown(key, ...)
end

return keyboard_service