local map = ...

StarSteam = Particle:extend ()

function StarSteam:new ()
    StarSteam.super.new (self)
    
    self.id = 31
    self.color = {251/255, 194/255, 124/255, 1}
    self.invincible = false
    self.density = 1
    
    return self
end


-- Used to check the particle's condition and act accordingly
function StarSteam:update (x, y)
    if self.turnOver == false then
        local rng = math.random ()
        
        if rng < 0.01 then
            map:delete (x, y)
            map.grid[x][y] = Shine ()
        elseif map:moveUp (x, y) == false then
            rng = math.random ()
            
            if rng < 0.45 and map:moveLeft (x, y) then
                
            elseif rng >= 0.9 and map:moveRight (x, y) then
                
            end
        end
        
		self.turnOver = true
	end
end