
-- A Track has an array of Daemon (close -> far)

Track = { }
function Track:create(t)
  t.daemons = {}
  setmetatable(t, self)
  self.__index = self
  return t
end

function Track:update(dt)
end
