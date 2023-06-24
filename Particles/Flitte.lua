local map = ...

Flitte = Particle:extend ()

function Flitte:new ()
    Flitte.super.new (self)
    
    self.id = 41
    self.color = {50/255, 13/255, 61/255, 1}
    self.invincible = false
    self.density = 5
    self.health = 15
    self.flammable = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Flitte:update (x, y)
    if self.turnOver == false then
        -- Comsumes nearby nessan and has a chance to reproduce
        if map:getID (x + 1, y) == 25 then
            map:delete (x + 1, y)
            
            if math.random () < 0.1 then
                map.grid[x + 1][y] = Flitte ()
            end
        end
        if map:getID (x - 1, y) == 25 then
            map:delete (x - 1, y)
            if math.random () < 0.1 then
                map.grid[x - 1][y] = Flitte ()
            end
        end
        if map:getID (x, y + 1) == 25 then
            map:delete (x, y + 1)
            if math.random () < 0.1 then
                map.grid[x][y + 1] = Flitte ()
            end
        end
        if map:getID (x, y - 1) == 25 then
            map:delete (x, y - 1)
            if math.random () < 0.1 then
                map.grid[x][y - 1] = Flitte ()
            end
        end
        
        -- Checks if it has space to breathe
        if map:getID (x + 1, y) ~= 0 and map:getID (x - 1, y) ~= 0 and map:getID (x, y + 1) ~= 0 and map:getID (x, y - 1) ~= 0 then
            self.health = self.health - 1
        end
        
        -- Moves the flitte around the map randomly
        local rng = math.random ()
        
        if rng < 0.65 then
            rng = math.random (1, 4)
            
            if rng == 1 then
                map:moveUp (x, y)
            elseif rng == 2 then
                map:moveDown (x, y)
            elseif rng == 3 then
                map:moveLeft (x, y)
            elseif rng == 4 then
                map:moveRight (x, y)
            end
        end
        
        -- Checks if the flitte is still alive
        if self.health <= 0 then
            map:delete (x, y)
            map.grid[x][y] = Corpse ()
        end
        
		self.turnOver = true
	end
end