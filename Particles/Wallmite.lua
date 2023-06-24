local map = ...

Wallmite = Particle:extend ()

function Wallmite:new ()
    Wallmite.super.new (self)
    
    self.id = 12
    self.color = {87/255, 42/255, 59/255, 1}
    self.invincible = true
    self.density = 20
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Wallmite:update (x, y)
    if self.turnOver == false then
		
		self.turnOver = true
	end
end