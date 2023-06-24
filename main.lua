-- Loads the libraries
local button = require ("Libraries.button")
local push = require ("Libraries.push")
Object = require ("Libraries.classic")

-- Declares / initializes the local variables
local map = require ("map")
local lastUpdate = 0
local gamePaused = false
local tickSpeed = 1/8

local graphics = {
    icon = {},
    name = {},
    info = {},
    other = {},
}

local music = {}
local currentTrack

local mouseX, mouseY, mapX, mapY
local nearestX = 0
local nearestY = 0

local inspectMode = false


-- Declares / initializes the global variables
particles = {}
selected = {}
selectedParticle = "lunarDust"
hoveredParticle = nil
gameState = "mainMenu"

-- Defines the functions
local keyTracker = {}
-- This algorithm will choose a random value from a table without repeating the same value twice
local function keyNoRepeats (table)
    keyTracker[table] = keyTracker[table] or {}
    
    -- Picks the next element of the table
    local lastKey = keyTracker[table]
    keyTracker[table] = math.random (1, #table)
    -- Checks for repeats
    if keyTracker[table] == lastKey then
        keyTracker[table] = (keyTracker[table] - 1 == 0) and keyTracker[table] + 1 or keyTracker[table] - 1
    end
    
    return keyTracker[table]
end


function love.load ()
    -- Seeds the random number generator
    math.randomseed(os.time())
    
    -- Sets the image filter and line style so the graphics aren't blurry
    love.graphics.setDefaultFilter ("nearest", "nearest")
    love.graphics.setLineStyle ("rough")
    
    -- Sets up push
    push:setupScreen(64, 64, 768, 768, {pixelperfect = true})
    
    -- Loads the particles
    love.filesystem.load ("Particles/Particle.lua") (map)
    local particlesFolder = love.filesystem.getDirectoryItems ("Particles")
    for k, v in pairs (particlesFolder) do
        -- Requires a file in the aforementioned folder with the file name appened on
        love.filesystem.load ("Particles/" .. v) (map)
    end
    particles = {
        [0] = Space,
        [1] = LunarDust,
        [2] = Allakite,
        [3] = Goll,
        [4] = Rust,
        [5] = Ash,
        [6] = Corpse,
        [11] = LunarCheese,
        [12] = Wallmite,
        [13] = Allnium,
        [14] = Onnakon,
        [15] = Grobben,
        [16] = Cloner,
        [17] = Deleter,
        [21] = Shine,
        [22] = Acid,
        [23] = Molten,
        [24] = Fizzfoz,
        [25] = Nessan,
        [31] = StarSteam,
        [32] = Oxygen,
        [33] = CarbonDioxide,
        [41] = Flitte,
        [42] = Slime,
        [51] = Fire,
    }
    selected = {
        space = Space,
        lunarDust = LunarDust,
        allakite = Allakite,
        goll = Goll,
        rust = Rust,
        ash = Ash,
        corpse = Corpse,
        lunarCheese = LunarCheese,
        wallmite = Wallmite,
        allnium = Allnium,
        onnakon = Onnakon,
        grobben = Grobben,
        cloner = Cloner,
        deleter = Deleter,
        shine = Shine,
        acid = Acid,
        molten = Molten,
        fizzfoz = Fizzfoz,
        nessan = Nessan,
        starSteam = StarSteam,
        oxygen = Oxygen,
        carbonDioxide = CarbonDioxide,
        flitte = Flitte,
        slime = Slime,
        fire = Fire,
    }
    inspect = {
        [0] = "space",
        [1] = "lunarDust",
        [2] = "allakite",
        [3] = "goll",
        [4] = "rust",
        [5] = "ash",
        [6] = "corpse",
        [11] = "lunarCheese",
        [12] = "wallmite",
        [13] = "allnium",
        [14] = "onnakon",
        [15] = "grobben",
        [16] = "cloner",
        [17] = "deleter",
        [21] = "shine",
        [22] = "acid",
        [23] = "molten",
        [24] = "fizzfoz",
        [25] = "nessan",
        [31] = "starSteam",
        [32] = "oxygen",
        [33] = "carbonDioxide",
        [41] = "flitte",
        [42] = "slime",
        [51] = "fire",
    }
    
    -- Loads the particle icons
    local imgs = love.filesystem.getDirectoryItems ("Graphics/Icons")
    for _, v in pairs (imgs) do
        graphics.icon[v:sub (1, -9)] = love.graphics.newImage("Graphics/Icons/" .. v)
    end
    
    -- Loads the particle names
    imgs = love.filesystem.getDirectoryItems ("Graphics/Names")
    for _, v in pairs (imgs) do
        graphics.name[v:sub (1, -9)] = love.graphics.newImage("Graphics/Names/" .. v)
    end
    
    -- Loads the particle infos
    imgs = love.filesystem.getDirectoryItems ("Graphics/Info")
    for _, v in pairs (imgs) do
        graphics.info[v:sub (1, -9)] = love.graphics.newImage("Graphics/Info/" .. v)
    end
    
    -- Loads the other graphics
    graphics.other.confirmIcon = love.graphics.newImage("Graphics/confirmIcon.png")
    graphics.other.cancelIcon = love.graphics.newImage("Graphics/cancelIcon.png")
    graphics.other.creditsInfo = love.graphics.newImage("Graphics/creditsInfo.png")
    graphics.other.controlsInfo = love.graphics.newImage("Graphics/controlsInfo.png")
    graphics.other.mainMenu = love.graphics.newImage("Graphics/mainMenu.png")
    
    -- Loads the buttons
    local buttonsFolder = love.filesystem.getDirectoryItems ("Buttons")
    for k, v in pairs (buttonsFolder) do
        -- Requires a file in the aforementioned folder with the file name appened on
        love.filesystem.load ("Buttons/" .. v) (button)
    end
    
    -- Loads the music
    local musicFolder = love.filesystem.getDirectoryItems ("Music")
	for k, v in pairs (musicFolder) do
		music[k] = love.audio.newSource ("Music/" .. v, "stream")
	end
    currentTrack = music[keyNoRepeats (music)]
    
    -- Initializes the map
    map:reset ()
end


function love.update (dt)
	-- Sets the mouse and coordinates variables
	mouseX, mouseY = love.mouse.getPosition ()
    mouseX, mouseY = push:toGame (mouseX, mouseY)
	nearestX = (mouseX - 1) - ((mouseX - 1) % 2)
	nearestY = (mouseY - 1) - ((mouseY - 1) % 2)
    mapX = nearestX / 2 + 1
    mapY = nearestY / 2 + 1
    
    if mapX > 31 then
        mapX = 31
    elseif mapX < 1 then
        mapX = 1
    end
    
    if mapY > 28 then
        mapY = 28
    elseif mapY < 1 then
        mapY = 1
    end
    
    -- Plays the background music
	if currentTrack:isPlaying () == false then
		currentTrack = music[keyNoRepeats (music)]
		love.audio.play (currentTrack)
	end
    
    -- **IN GAME**
    if gameState == "inGame" then
        -- Places particles while LMB is pressed
        if love.mouse.isDown (1) and map:getID (mapX, mapY) == 0 then
            map.grid[mapX][mapY] = selected[selectedParticle] ()
        end
        
        -- Removes particles while RMB is pressed
        if love.mouse.isDown (2) then
            map:delete (mapX, mapY, true)
        end
        
        -- Picks particles while MMB is pressed
        if love.mouse.isDown (3) and map:getID (mapX, mapY) ~= 0 then
            selectedParticle = inspect[map:getID (mapX, mapY)]
            inspectMode = false
        end
        
        -- Executes the nested code every game tick
        lastUpdate = lastUpdate + dt
        if lastUpdate >= tickSpeed and gamePaused == false then
            -- Executes each particle's actions
            for i = 1, map.width do
                local xAxis = map.grid[i]
                for j = 1, map.height do
                    xAxis[j]:update (i, j)
                end
            end
            
            -- Sets the turnOver property back to false for all the particles
            for i = 1, map.width do
                local xAxis = map.grid[i]
                for j = 1, map.height do
                    xAxis[j].turnOver = false
                end
            end
            
            lastUpdate = 0
        end
        
        -- Shows the name of the particle under the mouse is inspect mode is enabled
        if inspectMode == true then
            hoveredParticle = inspect[map:getID (mapX, mapY)]
        end
    -- **PARTICLE MENU**
    elseif gameState == "particleMenu" then
        hoveredParticle = nil
        button:whenHovered ("particleMenu", mouseX, mouseY)
    end
end


-- The game's native resolution needs to be 64x64
function love.draw()
    push:start ()
        -- **MAIN MENU**
        if gameState == "mainMenu" then
            -- Draws the text and logo
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.other.mainMenu, 0, 0)
        -- **IN GAME**
        elseif gameState == "inGame" then
            -- Draws the background
            love.graphics.setColor (121/255, 121/255, 121/255, 1)
            love.graphics.rectangle ("fill", 0, 0, 64, 64)
            
            if gamePaused == true then
                love.graphics.setColor (251/255, 242/255, 54/255, 1)
                love.graphics.rectangle ("line", 1, 1, 63, 63)
            end
            
            -- Renders the particles in the map
            for i = 1, map.width do
                local xAxis = map.grid[i]
                for j = 1, map.height do
                    xAxis[j]:draw (i, j, 0, 0)
                end
            end
            
            -- Shows the currently selected particle or the hovered particle if inspect mode is enabled
            if inspectMode == true then
                love.graphics.setColor (1, 0, 0, 1)
                love.graphics.draw (graphics.name[hoveredParticle], 1, 57)
            else
                love.graphics.setColor (1, 1, 1, 1)
                love.graphics.draw (graphics.name[selectedParticle], 1, 57)
            end
        -- **PARTICLE MENU**
        elseif gameState == "particleMenu" then
            -- Draws the background
            love.graphics.setColor (121/255, 121/255, 121/255, 1)
            love.graphics.rectangle ("fill", 2, 2, 60, 56)
            
            -- Draws the particle icons
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.icon.lunarDust, 4, 5)
            love.graphics.draw (graphics.icon.lunarCheese, 16, 5)
            love.graphics.draw (graphics.icon.shine, 28, 5)
            love.graphics.draw (graphics.icon.starSteam, 40, 5)
            love.graphics.draw (graphics.icon.fizzfoz, 52, 5)
            
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.icon.acid, 4, 19)
            love.graphics.draw (graphics.icon.oxygen, 16, 19)
            love.graphics.draw (graphics.icon.carbonDioxide, 28, 19)
            love.graphics.draw (graphics.icon.wallmite, 40, 19)
            love.graphics.draw (graphics.icon.allnium, 52, 19)
            
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.icon.molten, 4, 33)
            love.graphics.draw (graphics.icon.allakite, 16, 33)
            love.graphics.draw (graphics.icon.goll, 28, 33)
            love.graphics.draw (graphics.icon.cloner, 40, 33)
            love.graphics.draw (graphics.icon.deleter, 52, 33)
            
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.icon.onnakon, 4, 47)
            love.graphics.draw (graphics.icon.grobben, 16, 47)
            love.graphics.draw (graphics.icon.nessan, 28, 47)
            love.graphics.draw (graphics.icon.flitte, 40, 47)
            love.graphics.draw (graphics.icon.slime, 52, 47)
            
            -- Shows the particle that the mouse is hovering over
            if hoveredParticle ~= nil then
                love.graphics.setColor (1, 1, 1, 1)
                love.graphics.draw (graphics.name[hoveredParticle], 1, 58)
            end
        -- **INFO MENU**
        elseif gameState == "infoMenu" then
            inspectMode = false
            
            -- Draws the background
            love.graphics.setColor (121/255, 121/255, 121/255, 1)
            love.graphics.rectangle ("fill", 2, 2, 60, 56)
            
            -- Draws the buttons
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.other.cancelIcon, 4, 44)
            love.graphics.draw (graphics.icon[selectedParticle], 24, 40, _, 2, 2)
            love.graphics.draw (graphics.other.confirmIcon, 48, 44)
            
            -- Draws the info text
            love.graphics.draw (graphics.info[selectedParticle], 2, 2)
            
            -- Shows the currently selected particle
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.name[selectedParticle], 1, 58)
        -- **CREDITS MENU**
        elseif gameState == "creditsMenu" then
            -- Draws the background
            love.graphics.setColor (121/255, 121/255, 121/255, 1)
            love.graphics.rectangle ("fill", 2, 2, 60, 56)
            
            -- Draws the info text
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.other.creditsInfo, 0, 0)
        -- **CONTROLS MENU**
        elseif gameState == "controlsMenu" or gameState == "firstControls" then
            -- Draws the background
            love.graphics.setColor (121/255, 121/255, 121/255, 1)
            love.graphics.rectangle ("fill", 2, 2, 60, 56)
            
            -- Draws the info text
            love.graphics.setColor (1, 1, 1, 1)
            love.graphics.draw (graphics.other.controlsInfo, 0, 0)
        end
    push:finish ()
end


function love.keypressed (pressedKey)
	-- Resets the map table
	if pressedKey == "r" then
		map:reset (map.mode)
        inspectMode = false
	end
    
    -- Enters the particle menu
	if pressedKey == "tab" then
		if gameState == "particleMenu" then
            gameState = "inGame"
        else
            gameState = "particleMenu"
        end
	end
    
    -- Enters the credits menu
    if pressedKey == "y" then
        if gameState == "creditsMenu" then
            gameState = "inGame"
        else
            gameState = "creditsMenu"
        end
    end
    
    -- Enters the controls menu
    if pressedKey == "/" then
        if gameState == "controlsMenu" then
            gameState = "inGame"
        else
            gameState = "controlsMenu"
        end
    end

    -- Pauses the game
    if pressedKey == "space" and gameState == "inGame" then
        gamePaused = not gamePaused
    end
    
    -- Exits the game
    if pressedKey == "escape" then
        love.event.quit()
    end
    
    -- Toggles inspect mode
    if pressedKey == "i" then
        inspectMode = not inspectMode
    end
    
    -- Skips the main menu
    if gameState == "mainMenu" then
        gameState = "firstControls"
    elseif gameState == "firstControls" then
        gameState = "inGame"
    end
end


function love.mousereleased (x, y)
    if gameState == "particleMenu" then
        button:whenClicked ("particleMenu", push:toGame (x, y))
    elseif gameState == "infoMenu" then
        button:whenClicked ("infoMenu", push:toGame (x, y))
    end
end