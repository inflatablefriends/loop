
dyRate = 1500

Tile = Daemon:create("Tile", 0)
function Tile:create()
  return self
end

function Tile:keypressed(key)
end

function Tile:update(dt)
  if self.animation ~= nil then
    self.animation:update(dt)
  end
end

function Tile:draw(dt)
  if self.animation ~= nil then
    self.animation:update(dt)
  end
  
  local uv = street.cam:projectToScreen(self.position)
  
  if self.type == "marker" then
    love.graphics.setColor(0.9, 0, 0)
    love.graphics.circle("fill", uv.x, uv.y, scale)
  else
end
 
