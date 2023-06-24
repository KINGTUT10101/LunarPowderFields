local map = ...

LunarDust = Particle:extend ()

function LunarDust:new ()
    LunarDust.super.new (self)
    
    local rng = math.random (0, 20) / 100
    
    self.id = 1
    self.color = {116/255 - rng, 126/255 - rng, 156/255 - rng, 1}
    self.invincible = false
    self.density = 10
    
    return self
end


-- Used to check the particle's condition and act accordingly
function LunarDust:update (x, y)
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