
local cpml = require "lib/cpml"
require "street/_"

-- global variable to toggle display of debugging info
debug = false
cos = math.cos
sin = math.sin
vec2 = cpml.vec2
vec3 = cpml.vec3

function clamp(val, min, max)
  return math.max(min, math.min(val, max))
end

function love.load()
  winWidth, winHeight = love.graphics.getDimensions()
  street = Street:create()
  street:load()
end

function love.update(dt)

  if street ~= nil then
    street:update(dt)
  end
end


function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "#" then
    debug = not debug
    print(string.format("win: {%d, %d}", winWidth, winHeight))
  end

  if street ~= nil then
    street:keypressed(key)
  end
end

function love.draw()
  street:draw()
end
