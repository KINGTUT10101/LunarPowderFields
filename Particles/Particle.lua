local map = ...

Particle = Object:extend ()

function Particle:new ()
    self.id = -1
    self.color = {0, 0, 0, 0}
    self.invincible = false
    self.flammable = false
    self.turnOver = false
    self.density = 0
    self.hot = false
    self.clonable = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Particle:update (x, y)
    if self.turnOver == false then
		
		self.turnOver = true
	end
end


-- Renders the particle on the map
function Particle:draw (x, y)
    love.graphics.setColor (self.color)
    love.graphics.rectangle ("fill", (x - 1) * 2 + 1, (y - 1) * 2 + 1, 2, 2)
end