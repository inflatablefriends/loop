
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
  local move = 10;

  -- pan camera x (left/right)
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    street.cam.position.x = clamp(street.cam.position.x - move, 0, winWidth);
  end

  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    street.cam.position.x = clamp(street.cam.position.x + move, 0, winWidth);
  end

  -- pan camera y (forward/back)
  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    street.cam.position.y = math.min(0, street.cam.position.y + move);
  elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    street.cam.position.y = math.min(0, street.cam.position.y - move);
  end

  -- pan camera z (up/down)
  if love.keyboard.isDown("r") then
    street.cam.position.z = math.min(0, street.cam.position.z + move);
  elseif love.keyboard.isDown("f") then
    street.cam.position.z = math.min(0, street.cam.position.z - move);
  end

  if street ~= nil then
    street:update(dt)
  end
end


function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "#" then
    debug = not debug
    print(string.format("win: {%d, %d}", winWidth, winHeight));
    print(string.format("cam: {%d, %d, %d}", street.cam.position:unpack()))
  end
end

function love.draw()
  street:draw()
end
