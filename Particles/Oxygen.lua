local map = ...

Oxygen = Particle:extend ()

function Oxygen:new ()
    Oxygen.super.new (self)
    
    self.id = 32
    self.color = {191/255, 242/255, 255/255, 1}
    self.invincible = false
    self.flammable = true
    self.density = 3
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Oxygen:update (x, y)
    if self.turnOver == false then
        if map:moveUp (x, y) == false then
            local rng = math.random ()
            
            if rng < 0.5 and map:moveLeft (x, y) then
                
            elseif rng >= 0.5 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end