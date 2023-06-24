local map = ...

Fire = Particle:extend ()

function Fire:new ()
    Fire.super.new (self)
    
    self.id = 51
    self.color = {1, 156/255, 18/255, 1}
    self.flammable = false
    self.invincible = false
    self.density = 20
    self.turnOver = true
    self.health = math.random (8, 18)
    self.hot = true
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Fire:update (x, y)
    if self.turnOver == false then
		map:ignite (x + 1, y)
        map:ignite (x - 1, y)
        map:ignite (x, y + 1)
        map:ignite (x, y - 1)
        
        self.color = {1 - math.random (0, 20) / 100, 156/255 - math.random (0, 20) / 100, 30/255 - math.random (0, 10) / 100, 1}
        
        self.health = self.health - 1
        
        if self.health <= 0 then
            local rng = math.random ()
            
            map:delete (x, y, true)
            if rng < 0.25 then
                map.grid[x][y] = Ash ()
            elseif rng < 0.6 then
                map.grid[x][y] = CarbonDioxide ()
            end
        end
        
		self.turnOver = true
	end
end