local button = {
    group = {}
}


function button:addButton (group, x, y, w, h, clicked, hovered)
    local tempTable = {
        x = x,
        y = y,
        w = w,
        h = h,
        clicked = clicked,
        hovered = hovered or function () end,
    }
    
    table.insert (self.group[group], tempTable)
end


function button:addGroup (group)
    self.group[group] = {}
end


function button:whenClicked (group, mx, my, ...)
    local result
    
    for _, v in pairs (self.group[group]) do
        if mx >= v.x and mx <= v.x + v.w and my >= v.y and my <= v.y + v.h then
            result = v.clicked (...)
        end
    end
    
    return result
end


function button:whenHovered (group, mx, my, ...)
    local result
    
    for k, v in pairs (self.group[group]) do
        if mx >= v.x and mx <= v.x + v.w and my >= v.y and my <= v.y + v.h then
            result = v.hovered (...)
        end
    end
    
    return result
end


return button