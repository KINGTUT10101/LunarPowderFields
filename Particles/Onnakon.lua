local map = ...

Onnakon = Particle:extend ()

function Onnakon:new ()
    Onnakon.super.new (self)
    
    self.id = 14
    self.color = {138/255, 54/255, 31/255, 1}
    self.invincible = false
    self.density = 20
    self.hot = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Onnakon:update (x, y)
    if self.turnOver == false then
		-- Ignites adjacent particles
        map:ignite (x + 1, y)
        map:ignite (x - 1, y)
        map:ignite (x, y + 1)
        map:ignite (x, y - 1)
        
        -- Turns water into steam
        if map:getID (x + 1, y) == 21 then
            map:delete (x + 1, y)
            map.grid[x + 1][y] = StarSteam ()
        end
        if map:getID (x - 1, y) == 21 then
            map:delete (x - 1, y)
            map.grid[x - 1][y] = StarSteam ()
        end
        if map:getID (x, y + 1) == 21 then
            map:delete (x, y + 1)
            map.grid[x][y + 1] = StarSteam ()
        end
        if map:getID (x, y - 1) == 21 then
            map:delete (x, y - 1)
            map.grid[x][y - 1] = StarSteam ()
        end
        
        
        -- Turns lunar cheese into molten
        if map:getID (x + 1, y) == 11 then
            map:delete (x + 1, y)
            map.grid[x + 1][y] = Molten ()
        end
        if map:getID (x - 1, y) == 11 then
            map:delete (x - 1, y)
            map.grid[x - 1][y] = Molten ()
        end
        if map:getID (x, y + 1) == 11 then
            map:delete (x, y + 1)
            map.grid[x][y + 1] = Molten ()
        end
        if map:getID (x, y - 1) == 11 then
            map:delete (x, y - 1)
            map.grid[x][y - 1] = Molten ()
        end
        
		self.turnOver = true
	end
end