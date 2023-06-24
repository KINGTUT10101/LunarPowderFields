local map = ...

Molten = Particle:extend ()

function Molten:new ()
    Molten.super.new (self)
    
    self.id = 23
    self.color = {1, 28/255, 4/255, 1}
    self.invincible = false
    self.density = 6
    self.hot = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Molten:update (x, y)
    if self.turnOver == false then
        local cooled = false
        
        map:ignite (x + 1, y)
        map:ignite (x - 1, y)
        map:ignite (x, y + 1)
        map:ignite (x, y - 1)
        
        if map:getID (x + 1, y) == 21 then
            map:delete (x, y)
            map.grid[x][y] = LunarCheese ()
            map:delete (x + 1, y)
            map.grid[x + 1][y] = StarSteam ()
        end
        if map:getID (x - 1, y) == 21 then
            map:delete (x, y)
            map.grid[x][y] = LunarCheese ()
            map:delete (x - 1, y)
            map.grid[x - 1][y] = StarSteam ()
        end
        if map:getID (x, y + 1) == 21 then
            map:delete (x, y)
            map.grid[x][y] = LunarCheese ()
            map:delete (x, y + 1)
            map.grid[x][y + 1] = StarSteam ()
        end
        if map:getID (x, y - 1) == 21 then
            map:delete (x, y)
            map.grid[x][y] = LunarCheese ()
            map:delete (x, y - 1)
            map.grid[x][y - 1] = StarSteam ()
        end
            
        if cooled == false and map:moveDown (x, y) == false then
            local rng = math.random ()
            
            if rng < 0.25 and map:moveLeft (x, y) then
                
            elseif rng < 0.5 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end