local map = ...

Grobben = Particle:extend ()

function Grobben:new (lifeforce)
    Grobben.super.new (self)
    
    local rng = math.random (0, 38) / 255
    
    self.id = 15
    self.color = {108/255 - rng, 172/255 - rng, 182/255 - rng, 1}
    self.flammable = true
    self.invincible = false
    self.density = 20
    self.lifeforce = lifeforce or math.random (3, 6)
    
    return self
end


-- Used to check the particle's condition and act accordingly
function Grobben:update (x, y)
    if self.turnOver == false then
		local rng = math.random ()
        
        -- Grows onto adjacent tiles if it still has lifeforce left
        if self.lifeforce > 0 and rng < 0.1 then
            xrng = math.random (-1, 1)
            yrng = math.random (-1, 1)
            if map:isClear (x + xrng, y + yrng) == true then
                self.lifeforce = self.lifeforce - 1
                map.grid[x + xrng][y + yrng] = Grobben (self.lifeforce)
            end
        end
        
        -- Absorbs shine and uses it to extend its lifeforce
        if self.lifeforce <= 10 and map:getID (x + 1, y) == 21 then
            map:delete (x + 1, y)
            self.lifeforce = self.lifeforce + 1
        end
        if self.lifeforce <= 10 and map:getID (x - 1, y) == 21 then
            map:delete (x - 1, y)
            self.lifeforce = self.lifeforce + 1
        end
        if self.lifeforce <= 10 and map:getID (x, y + 1) == 21 then
            map:delete (x, y + 1)
            self.lifeforce = self.lifeforce + 1
        end
        if self.lifeforce <= 10 and map:getID (x, y - 1) == 21 then
            map:delete (x, y - 1)
            self.lifeforce = self.lifeforce + 1
        end
        
        -- Secretes nessan around itself
        -- Absorbs water and uses it to extend its lifeforce
        if map:getID (x + 1, y) == 0 and math.random () < 0.001 then
            map:delete (x + 1, y)
            map.grid[x + 1][y] = Nessan ()
        end
        if map:getID (x - 1, y) == 0 and math.random () < 0.001 then
            map:delete (x - 1, y)
            map.grid[x - 1][y] = Nessan ()
        end
        if map:getID (x, y + 1) == 0 and math.random () < 0.001 then
            map:delete (x, y + 1)
            map.grid[x][y + 1] = Nessan ()
        end
        if map:getID (x, y - 1) == 0 and math.random () < 0.001 then
            map:delete (x, y - 1)
            map.grid[x][y - 1] = Nessan ()
        end
        
		self.turnOver = true
	end
end