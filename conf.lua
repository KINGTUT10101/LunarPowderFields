function love.conf (t)
    t.window.title = "Lunar Powder Fields"
    t.window.icon = "Graphics/windowIcon.png"
    t.identity = "LPF"
    
    t.window.width = 64
    t.window.height = 64
    t.window.fullscreen = false
    t.window.vsync = 0
    
    t.window.highdpi = true
    t.window.usedpiscale = false
    
    t.modules.joystick = false
    t.modules.video = false
    t.accelerometerjoystick = false
    
    t.console = false
end