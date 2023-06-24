local map = ...

Goll = Particle:extend ()

function Goll:new ()
    Goll.super.new (self)
    
    local rng = math.random (0, 30) / 100
    
    self.id = 3
    self.color = {129/255 - rng, 92/255 - rng, 49/255 - rng, 1}
    self.invincible = false
    self.density = 18
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Goll:update (x, y)
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