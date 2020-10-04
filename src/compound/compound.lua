
-- The Compound is a safe haven to settle down for the night
Compound = { }
function Compound:create()
  s = { }
  setmetatable(s, self)
  self.__index = self

  s.message = "Hello from the compound. Press space to continue..."

  return s
end

function Compound:load()
end

function Compound:update(dt)
end

function Compound:keypressed(key)
  if key == "space" then
    changeGameMode("street")
  end
end

function Compound:draw()
  -- TODO make this display better
  love.graphics.print(self.message)
end
