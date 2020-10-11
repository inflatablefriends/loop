
dyRate = 1500

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
  elseif key == "w" and self.speed < 1000 then
    self.dy = dyRate
  end
end

function Player:update(dt)
  if self.animation ~= nil then
    self.animation:update(dt)
  end

  if not love.keyboard.isDown("w") then
    self.dy = 0
  end

  if self.dy > 0 then
    self.speed = self.speed + (self.dy * dt)
  elseif self.speed > 1 then
    self.speed = self.speed - (dyRate * 3 * dt)
  else
    self.speed = 0
  end

  self.position = self.position:add(vec3(0, (self.speed * dt), 0))

  if debug then
    print(string.format("%d %d", self.dy, self.speed))
  end
end
 
