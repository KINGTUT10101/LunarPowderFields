local map = ...

Fizzfoz = Particle:extend ()

function Fizzfoz:new ()
    Fizzfoz.super.new (self)
    
    self.id = 24
    self.color = {96/255, 75/255, 65/255, 1}
    self.invincible = false
    self.density = 5
    self.flammable = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Fizzfoz:update (x, y)
    if self.turnOver == false then
        local rng = math.random ()
        
        if rng < 0.018 and map:getID (x, y - 1) == 0 then
            map.grid[x][y - 1] = CarbonDioxide ()
        end
        
        if map:moveDown (x, y) == false then
            rng = math.random ()
            
            if rng < 0.5 and map:moveLeft (x, y) then
                
            elseif rng >= 0.5 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end