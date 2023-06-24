local map = ...

Space = Particle:extend ()

function Space:new ()
    Space.super.new (self)
    
    self.id = 0
    self.color = {0, 0, 0, 1}
    self.invincible = true
    self.density = 0
    self.clonable = false
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Space:update (x, y)
    if self.turnOver == false then
        --map:moveDown (x, y)
        
		self.turnOver = true
	end
end