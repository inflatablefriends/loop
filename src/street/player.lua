
Player = Daemon:create("player", 0)
function Player:create()
  return self
end

function Player:keypressed(key)
  if key == "space" then
    local x, y = self.body:getLinearVelocity()
    if (y > -10) then
      self.body:applyLinearImpulse(0, -25000)
    end
  end
end

function Player:update(dt)
  if self.animation ~= nil then
    self.animation:update(dt)
  end
end
 
