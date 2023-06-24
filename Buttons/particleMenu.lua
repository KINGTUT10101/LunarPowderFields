local button = ...

button:addGroup ("particleMenu")

button:addButton ("particleMenu", 4, 5, 8, 8, function () selectedParticle = "lunarDust"; gameState = "infoMenu" end, function () hoveredParticle = "lunarDust" end)
button:addButton ("particleMenu", 16, 5, 8, 8, function () selectedParticle = "lunarCheese"; gameState = "infoMenu" end, function () hoveredParticle = "lunarCheese" end)
button:addButton ("particleMenu", 28, 5, 8, 8, function () selectedParticle = "shine"; gameState = "infoMenu" end, function () hoveredParticle = "shine" end)
button:addButton ("particleMenu", 40, 5, 8, 8, function () selectedParticle = "starSteam"; gameState = "infoMenu" end, function () hoveredParticle = "starSteam" end)
button:addButton ("particleMenu", 52, 5, 8, 8, function () selectedParticle = "fizzfoz"; gameState = "infoMenu" end, function () hoveredParticle = "fizzfoz" end)

button:addButton ("particleMenu", 4, 19, 8, 8, function () selectedParticle = "acid"; gameState = "infoMenu" end, function () hoveredParticle = "acid" end)
button:addButton ("particleMenu", 16, 19, 8, 8, function () selectedParticle = "oxygen"; gameState = "infoMenu" end, function () hoveredParticle = "oxygen" end)
button:addButton ("particleMenu", 28, 19, 8, 8, function () selectedParticle = "carbonDioxide"; gameState = "infoMenu" end, function () hoveredParticle = "carbonDioxide" end)
button:addButton ("particleMenu", 40, 19, 8, 8, function () selectedParticle = "wallmite"; gameState = "infoMenu" end, function () hoveredParticle = "wallmite" end)
button:addButton ("particleMenu", 52, 19, 8, 8, function () selectedParticle = "allnium"; gameState = "infoMenu" end, function () hoveredParticle = "allnium" end)

button:addButton ("particleMenu", 4, 33, 8, 8, function () selectedParticle = "molten"; gameState = "infoMenu" end, function () hoveredParticle = "molten" end)
button:addButton ("particleMenu", 16, 33, 8, 8, function () selectedParticle = "allakite"; gameState = "infoMenu" end, function () hoveredParticle = "allakite" end)
button:addButton ("particleMenu", 28, 33, 8, 8, function () selectedParticle = "goll"; gameState = "infoMenu" end, function () hoveredParticle = "goll" end)
button:addButton ("particleMenu", 40, 33, 8, 8, function () selectedParticle = "cloner"; gameState = "infoMenu" end, function () hoveredParticle = "cloner" end)
button:addButton ("particleMenu", 52, 33, 8, 8, function () selectedParticle = "deleter"; gameState = "infoMenu" end, function () hoveredParticle = "deleter" end)

button:addButton ("particleMenu", 4, 47, 8, 8, function () selectedParticle = "onnakon"; gameState = "infoMenu" end, function () hoveredParticle = "onnakon" end)
button:addButton ("particleMenu", 16, 47, 8, 8, function () selectedParticle = "grobben"; gameState = "infoMenu" end, function () hoveredParticle = "grobben" end)
button:addButton ("particleMenu", 28, 47, 8, 8, function () selectedParticle = "nessan"; gameState = "infoMenu" end, function () hoveredParticle = "nessan" end)
button:addButton ("particleMenu", 40, 47, 8, 8, function () selectedParticle = "flitte"; gameState = "infoMenu" end, function () hoveredParticle = "flitte" end)
button:addButton ("particleMenu", 52, 47, 8, 8, function () selectedParticle = "slime"; gameState = "infoMenu" end, function () hoveredParticle = "slime" end)