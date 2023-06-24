local map = ...

Slime = Particle:extend ()

function Slime:new ()
    Slime.super.new (self)
    
    self.id = 42
    self.color = {0 + math.random (0, 45) / 255, 210/255 + math.random (0, 45) / 255, 65/255 + math.random (0, 45) / 255, 1}
    self.invincible = false
    self.flammable = true
    self.density = 9
    self.turnOver = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Slime:update (x, y)
    if self.turnOver == false then
        -- Some interesting behavior happens when the slime doesn't check for other slime particles...
        -- I will try to recreate this in JASG2. Just remove the map:getID checks to do it.
        if map:isValid (x + 1, y) == true then
            if map.grid[x + 1][y].hot == false and map.grid[x + 1][y].invincible == false and map:getID (x + 1, y) ~= 42 then
                map.grid[x + 1][y] = Slime ()
            end
        end
        if map:isValid (x - 1, y) == true then
            if map.grid[x - 1][y].hot == false and map.grid[x - 1][y].invincible == false and map:getID (x - 1, y) ~= 42 then
                map.grid[x - 1][y] = Slime ()
            end
        end
        if map:isValid (x, y + 1) == true then
            if map.grid[x][y + 1].hot == false and map.grid[x][y + 1].invincible == false and map:getID (x, y + 1) ~= 42 then
                map.grid[x][y + 1] = Slime ()
            end
        end
        if map:isValid (x, y - 1) == true then
            if map.grid[x][y - 1].hot == false and map.grid[x][y - 1].invincible == false and map:getID (x, y - 1) ~= 42 then
                map.grid[x][y - 1] = Slime ()
            end
        end
        
        self.color = {0 + math.random (0, 45) / 255, 210/255 + math.random (0, 45) / 255, 65/255 + math.random (0, 45) / 255, 1}
        
        map:moveDown (x, y)
        
		self.turnOver = true
	end
end