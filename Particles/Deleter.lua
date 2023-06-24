local map = ...

Deleter = Particle:extend ()

function Deleter:new ()
    Deleter.super.new (self)
    
    self.id = 16
    self.color = {0.25, 0.25, 0.25, 1}
    self.invincible = true
    self.density = 20
    self.clonable = false
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Deleter:update (x, y)
    if self.turnOver == false then
		map:delete (x + 1, y)
		map:delete (x - 1, y)
		map:delete (x, y + 1)
		map:delete (x, y - 1)
        
		self.turnOver = true
	end
end