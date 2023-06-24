local map = ...

Cloner = Particle:extend ()

function Cloner:new ()
    Cloner.super.new (self)
    
    self.id = 16
    self.color = {1, 1, 1, 1}
    self.invincible = true
    self.density = 20
    self.cloning = nil
    self.clonable = false
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Cloner:update (x, y)
    if self.turnOver == false then
        if self.cloning == nil then
            -- Checks adjacent tiles for a particle to clone
            if map:isValid (x + 1, y) == true and map.grid[x + 1][y].clonable == true then
                self.cloning = map:getID (x + 1, y)
            end
            if map:isValid (x - 1, y) == true and map.grid[x - 1][y].clonable == true then
                self.cloning = map:getID (x - 1, y)
            end
            if map:isValid (x, y + 1) == true and map.grid[x][y + 1].clonable == true then
                self.cloning = map:getID (x, y + 1)
            end
            if map:isValid (x, y - 1) == true and map.grid[x][y - 1].clonable == true then
                self.cloning = map:getID (x, y - 1)
            end
        else
            -- Clones the selected particle
            if map:getID (x + 1, y) == 0 then
                map.grid[x + 1][y] = particles[self.cloning] ()
            end
            if map:getID (x - 1, y) == 0 then
                map.grid[x - 1][y] = particles[self.cloning] ()
            end
            if map:getID (x, y + 1) == 0 then
                map.grid[x][y + 1] = particles[self.cloning] ()
            end
            if map:getID (x, y - 1) == 0 then
                map.grid[x][y - 1] = particles[self.cloning] ()
            end
        end
        
		self.turnOver = true
	end
end