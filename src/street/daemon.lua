local anim8 = require "lib/anim8"

-- A Daemon represents the player, an object, another character, o anything else on the road
-- - Each Daemon records its own offset (y) within its track

Daemon = { }
function Daemon:create(type, y)
  if type == nil then error("Daemon needs a type") end
  if y == nil then error("Daemon needs an offset") end

  d = {}
  setmetatable(d, self)
  self.__index = self
  
  d.type = type
  d.y = y

  if d.type == "dude" or d.type == "player" then
    d.image = love.graphics.newImage("res/lildude.png")
    local grid = anim8.newGrid(16, 18, d.image:getWidth(), d.image:getHeight())
    d.animation = anim8.newAnimation(grid("1-6",1), 0.1)
  end

  return d
end

function Daemon:update(dt)
  if self.type == "dude" or self.type == "player" then
    self.animation:update(dt)
  end
end

function Daemon:draw(street, pos)
  pos = pos:sub(vec3(street.trackWidth / 2, 0, 0))
  local uv = street.cam:projectToScreen(pos)
  local scale = 1 * (1 + (1000 / (pos.y - street.cam.position.y)))

  if self.type == "marker" and debug then
    love.graphics.setColor(0.9, 0, 0)
    love.graphics.circle("fill", uv.x, uv.y, scale)
  elseif self.type == "dude" or self.type == "player" then
    scale = scale * 2
    self.animation:draw(self.image, uv.x, uv.y - (scale * 16), 0, scale, scale)
  end
end
