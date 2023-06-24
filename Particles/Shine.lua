local map = ...

Shine = Particle:extend ()

function Shine:new ()
    Shine.super.new (self)
    
    self.id = 21
    self.color = {255/255, 163/255, 50/255, 1}
    self.invincible = false
    self.density = 5
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Shine:update (x, y)
    if self.turnOver == false then
        if map:moveDown (x, y) == false then
            local rng = math.random ()
            
            if rng < 0.5 and map:moveLeft (x, y) then
                
            elseif rng >= 0.5 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end