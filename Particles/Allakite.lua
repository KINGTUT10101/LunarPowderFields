local map = ...

Allakite = Particle:extend ()

function Allakite:new ()
    Allakite.super.new (self)
    
    local rng = math.random (0, 30) / 100
    
    self.id = 2
    self.color = {172/255 - rng, 195/255 - rng, 204/255 - rng, 1}
    self.invincible = false
    self.density = 3
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Allakite:update (x, y)
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