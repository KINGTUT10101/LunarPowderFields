local map = ...

CarbonDioxide = Particle:extend ()

function CarbonDioxide:new ()
    CarbonDioxide.super.new (self)
    
    self.id = 33
    self.color = {79/255, 83/255, 70/255, 1}
    self.invincible = false
    self.density = 2
    
    return self
end


-- Used to check the particle's condition and act accordingly
function CarbonDioxide:update (x, y)
    if self.turnOver == false then
        local rng = math.random ()
        
        if rng < 0.05 then
            map:delete (x, y)
        elseif map:moveUp (x, y) == false then
            rng = math.random ()
            
            if rng < 0.42 and map:moveLeft (x, y) then
                
            elseif rng >= 0.84 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end