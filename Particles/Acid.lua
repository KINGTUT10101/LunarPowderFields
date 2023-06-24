local map = ...

Acid = Particle:extend ()

function Acid:new ()
    Acid.super.new (self)
    
    self.id = 22
    self.color = {166/255, 203/255, 65/255, 1}
    self.invincible = false
    self.density = 5
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Acid:update (x, y)
    if self.turnOver == false then
        if map:moveDown (x, y) == false then
            local rng = math.random ()
            
            if rng < 0.5 and map:moveLeft (x, y) then
                
            elseif rng >= 0.5 and map:moveRight (x, y) then
                
            end
        end
        
        -- Deletes nearby particles and itself
        if map:getID (x + 1, y) ~= 22 and map:delete (x + 1, y) then
            map:delete (x, y)
        end
        if map:getID (x - 1, y) ~= 22 and map:delete (x - 1, y) then
            map:delete (x, y)
        end
        if map:getID (x, y + 1) ~= 22 and map:delete (x, y + 1) then
            map:delete (x, y)
        end       
        
		self.turnOver = true
	end
end