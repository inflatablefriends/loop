local anim8 = require "lib/anim8"

-- A Daemon represents the player, an object, another character, o anything else on the road

Daemon = { }
function Daemon:create(type)
  if type == nil then error("Daemon needs a type") end

  d = {}
  setmetatable(d, self)
  self.__index = self
  
  d.type = type

  if d.type == "dude" or d.type == "player" then
    d.image = love.graphics.newImage("res/lildude.png")
    local grid = anim8.newGrid(16, 18, d.image:getWidth(), d.image:getHeight())
    d.animation = anim8.newAnimation(grid("1-6",1), 0.1)
    d.height = d.image:getHeight()
    d.width = d.image:getWidth()
  end

  return d
end

function Daemon:addToWorld(street)
  if self.type == "player" or self.type == "dude" then
    local topLeft = self.position:sub(vec3(self.width / 2, 0, self.height))
    self.body = street.world:newRectangleCollider(topLeft.x, 0, 32, 36)
    self.body:setMass(80)
  end
end

function Daemon:keypressed(key)
end

function Daemon:update(dt)
  if self.animation ~= nil then
    self.animation:update(dt)
  end
end

function Daemon:getPosition(street)
  local x, y, z = self.position:unpack()

  if self.body ~= nil then
    local physx, physz = self.body:getPosition()
    z = z - (physz - winHeight)
  end

  return vec3(x, y, z)
end

function Daemon:draw(street)
  local pos = self:getPosition(street);
  if pos == nil then
    return
  end

  local uv = street.cam:projectToScreen(pos)
  local scale = 1 * (1 + (1000 / (pos.y - street.cam.position.y)))

  if self.type == "marker" and debug then
    love.graphics.setColor(0.9, 0, 0)
    love.graphics.circle("fill", uv.x, uv.y, scale)
  else
    if self.image ~= nil and self.animation ~= nil then
      scale = scale * 2
      local xOffset = -street.trackWidth / 2
      local yOffset = -scale * self.height
      self.animation:draw(self.image, uv.x + xOffset, uv.y + yOffset, 0, scale, scale)
    end
  end
end
