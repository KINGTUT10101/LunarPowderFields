local button = ...

button:addGroup ("infoMenu")

button:addButton ("infoMenu", 4, 44, 12, 12, function () gameState = "particleMenu" end)
button:addButton ("infoMenu", 48, 44, 12, 12, function () gameState = "inGame" end)

return 