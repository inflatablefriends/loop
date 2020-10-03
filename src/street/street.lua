
-- The Street has an array of Track (left -> right)
Street = { }
function Street:create(s)
  s = s or { tracks = {} }
  setmetatable(s, self)
  self.__index = self

  self.cam = Camera:create{ 50, 50, 0 }

  return s
end

function Street:addTrack(arg)
  table.insert(self.tracks, Track:create(arg))
  return self.tracks[table.getn(self.tracks)]
end

-- Convert street coordinates into a 3d vector from 0, 0
function Street:streetTo3d(streetX, streetY, streetZ)
  local winWidth, winHeight = love.graphics.getDimensions()

  -- divide width into 100 units
  local xUnit = winWidth / 100
  local xTrackWidth = (xUnit * 80) / table.getn(self.tracks) -- the street goes from 10 - 90
  local x = (streetX * xTrackWidth) + (xTrackWidth / 2) -- centre of the track

  -- window axis is from top left corner
  -- street z ~= -winz
  -- again divide into 100 units
  local zUnit = winHeight / 100
  local z = (zUnit * streetZ) + (zUnit / 2)

  -- y is offset along the track
  local yUnit = xUnit * 10;
  local y = yUnit * streetY

  return (xUnit * 10) + x, y, winHeight - z
end

function Street:streetToScreen(streetX, streetY, streetZ)
  local x, y, z = self:streetTo3d(streetX, streetY, streetZ)
  local u, v = self.cam:projectToScreen(x, y, z)
  return u, v
end

function Street:load()
  
  for trackIndex = 1, 7 do
    track = street:addTrack{ index = trackIndex }
  end

  -- Place some daemons so we can see how the camera's working
  for x = 1, table.getn(self.tracks) do
    local track = self.tracks[x]
    
    for y = 1, 50 do
      local marker = Daemon:create("marker", y)
      table.insert(track.daemons, marker)
    end
  end
end

function Street:draw()
  local u, v -- screen coordinates

  for i = 1, table.getn(self.tracks) do
    local track = self.tracks[i]    

    u, v = self:streetToScreen(i, 0, 0)
    love.graphics.print(i, u, v)

    for di = 1, table.getn(track.daemons) do
      local daemon = track.daemons[di]
      u, v = self:streetToScreen(i, daemon.y, 0)
      love.graphics.print(string.format("%d.%d", i, di), u, v)
    end

  end
end
