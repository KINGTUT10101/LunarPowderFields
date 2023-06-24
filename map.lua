local map = {
    grid = {},
    width = 31,
    height = 28,
}


-- Clears the map and fills it with air particles
function map:reset ()
    for i = 1, self.width do
        self.grid[i] = {}
        for j = 1, self.height do
            self.grid[i][j] = Space ()
        end
    end
end


-- Checks if a certain position on the map is clear for another particle to move into
function map:isClear (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        local targetPos = self.grid[x][y]
        -- Checks if the space is clear and if the particle isn't the same type
        if targetPos.id == 0 then
            result = true
        end
    end
    
    return result
end


-- Checks if a certain position on the map is valid
function map:isValid (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        result = true
    end
    
    return result
end


-- Returns the ID of a particle on the map or nil if it doesn't exist
function map:getID (x, y)
    local result = nil
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        result = self.grid[x][y].id
    end
    
    return result
end


-- Deletes a particle at the specified position
function map:delete (x, y, force)
    force = force or false
    
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        local targetPos = self.grid[x][y]
        -- Checks if the block is invincible or if brute force mode is enabled
        if force == true or targetPos.invincible == false then
            self.grid[x][y] = Space ()
            result = true
        end
    end
    
    return result
end


-- Lights a particle on fire, which will replace it with a fire particle
function map:ignite (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        local targetPos = self.grid[x][y]
        -- Checks if the particle if flammable
        if targetPos.flammable == true then
            self.grid[x][y] = Fire ()
            result = true
        end
    end
    
    return result
end


function map:moveTo (x, y, nx, ny)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y > 0 and x <= self.width and y <= self.height then
        -- Checks if the new space is valid
        if nx > 0 and ny > 0 and nx <= self.width and ny <= self.height then
            local nextPos = self.grid[nx][ny]
            -- Checks if the space is clear and if the particle isn't the same type
            if nextPos.id == 0 and nextPos.id ~= self.grid[x][y].id then
                self.grid[nx][ny] = map.grid[x][y]
                self:delete (x, y, true)
                result = true
            end
        end
    end
    
    return result
end


-- Moves a particle up on the map
function map:moveUp (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y - 1 > 0 and x <= self.width and y - 1 <= self.height then
        -- Checks if the space is less dense than the current particle
        if self.grid[x][y - 1].density < self.grid[x][y].density then
            self.grid[x][y], self.grid[x][y - 1] = self.grid[x][y - 1], self.grid[x][y]
            result = true
        end
    end
    
    return result
end


-- Moves a particle down on the map
function map:moveDown (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x > 0 and y + 1 > 0 and x <= self.width and y + 1 <= self.height then
        -- Checks if the space is less dense than the current particle
        if self.grid[x][y + 1].density < self.grid[x][y].density then
            self.grid[x][y], self.grid[x][y + 1] = self.grid[x][y + 1], self.grid[x][y]
            result = true
        end
    end
    
    return result
end


-- Moves a particle left on the map
function map:moveLeft (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x - 1 > 0 and y > 0 and x - 1 <= self.width and y <= self.height then
        -- Checks if the space is less dense than the current particle
        if self.grid[x - 1][y].density < self.grid[x][y].density then
            self.grid[x][y], self.grid[x - 1][y] = self.grid[x - 1][y], self.grid[x][y]
            result = true
        end
    end
    
    return result
end


-- Moves a particle right on the map
function map:moveRight (x, y)
    local result = false
    
    -- Checks if the space is valid
    if x + 1 > 0 and y > 0 and x + 1 <= self.width and y <= self.height then
        -- Checks if the space is less dense than the current particle
        if self.grid[x + 1][y].density < self.grid[x][y].density then
            self.grid[x][y], self.grid[x + 1][y] = self.grid[x + 1][y], self.grid[x][y]
            result = true
        end
    end
    
    return result
end


return map