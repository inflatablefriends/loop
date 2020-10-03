
-- A Track has an array of Daemon (close -> far)

Track = { }
function Track:create(t)
  t.daemons = {}
  setmetatable(t, self)
  self.__index = self
  return t
end

function Track:update(dt)
  for i = 1, table.getn(self.daemons) do
    local daemon = self.daemons[i]
    daemon:update(dt)
  end
end

function Track:draw()
  print(self.index)
  for daemon = 1, table.getn(self.daemons) do
    print(daemon.index)
  end
end