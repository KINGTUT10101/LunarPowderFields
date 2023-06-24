local map = ...

Allnium = Particle:extend ()

function Allnium:new ()
    Allnium.super.new (self)
    
    self.id = 13
    self.color = {142/255, 176/255, 146/255, 1}
    self.invincible = false
    self.density = 20
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Allnium:update (x, y)
    if self.turnOver == false then
		-- Turns to rust if exposed to shine
        if map:getID (x + 1, y) == 21 and math.random () < 0.01 then
            map:delete (x, y)
            map.grid[x][y] = Rust ()
        end
        if map:getID (x - 1, y) == 21 and math.random () < 0.01 then
            map:delete (x, y)
            map.grid[x][y] = Rust ()
        end
        if map:getID (x, y - 1) == 21 and math.random () < 0.01 then
            map:delete (x, y)
            map.grid[x][y] = Rust ()
        end
        
		self.turnOver = true
	end
end