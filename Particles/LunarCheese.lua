local map = ...

LunarCheese = Particle:extend ()

function LunarCheese:new ()
    LunarCheese.super.new (self)
    
    local rng = math.random (0, 20) / 100
    
    self.id = 11
    self.color = {200/255 - rng, 200/255 - rng, 57/255 - rng, 1}
    self.invincible = false
    self.density = 20
    
    return self
end


-- Used to check the particle's condition and act accordingly
function LunarCheese:update (x, y)
    if self.turnOver == false then
		
		self.turnOver = true
	end
end