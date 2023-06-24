local map = ...

Ash = Particle:extend ()

function Ash:new ()
    Ash.super.new (self)
    
    local rng = math.random (0, 10) / 100
    
    self.id = 5
    self.color = {134/255 - rng, 126/255 - rng, 116/255 - rng, 1}
    self.invincible = false
    self.density = 10
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Ash:update (x, y)
    if self.turnOver == false then
        if map:moveDown (x, y) == false then
            if map:isClear (x - 1, y) and map:isClear (x - 1, y + 1) then
                map:moveTo (x, y, x - 1, y + 1)
            elseif map:isClear (x + 1, y) and map:isClear (x + 1, y + 1) then
                map:moveTo (x, y, x + 1, y + 1)
            end
        end
        
		self.turnOver = true
	end
end