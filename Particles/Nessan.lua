local map = ...

Nessan = Particle:extend ()

function Nessan:new ()
    Nessan.super.new (self)
    
    self.id = 25
    self.color = {80/255, 230/255, 195/255, 1}
    self.invincible = false
    self.flammable = true
    self.density = 4
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Nessan:update (x, y)
    if self.turnOver == false then
        if map:moveDown (x, y) == false then
            local rng = math.random ()
            
            if rng < 0.33 and map:moveLeft (x, y) then
                
            elseif rng >= 0.66 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end