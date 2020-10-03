
-- A Daemon represents the player, an object, another character, o anything else on the road
-- - Each Daemon records its own offset (z) within its track

Daemon = { }
function Daemon:create(type, y)
  if type == nil then error("Daemon needs a type") end
  if y == nil then error("Daemon needs an offset") end

  d = {}
  setmetatable(d, self)
  self.__index = self
  
  d.type = type
  d.y = y
  return d
end

function Daemon:draw(cam, posv3)
  if self.type == "marker" and debug then
    local uv = cam:projectToScreen(posv3)
    love.graphics.setColor(0.9, 0, 0)
    love.graphics.circle("fill", uv[1], uv[2], 1 * (1 + (1000 / (posv3[2] - cam.position[2]))))
  end
end
