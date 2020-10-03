

-- The Street has an array of Track (left -> right)
Street = { }
function Street:create(s)
  s = s or { tracks = {} }
  setmetatable(s, self)
  self.__index = self

   -- NB in world coordinates
  self.cam = Camera:create{ winWidth / 2, -500, 800 }

  self.trackWidth = 0

  return s
end

function Street:addTrack(arg)
  table.insert(self.tracks, Track:create(arg))

  -- the street goes from 10 - 90
  self.trackWidth = (winWidth * 0.8) / table.getn(self.tracks)

  return self.tracks[table.getn(self.tracks)]
end

function Street:getTrackWidth()
  return 
end

-- Convert street coordinates into a 3d vector from 0, 0
function Street:streetTo3d(streetX, streetY, streetZ)

  -- divide width into 100 units
  local x = (streetX * self.trackWidth) - (self.trackWidth / 2) -- centre of the track

  -- window axis is from top left corner
  -- street z ~= -winz
  -- again divide into 100 units
  local zUnit = winHeight / 100
  local z = (zUnit * streetZ) + (zUnit / 2)

  -- y is offset along the track
  local yUnit = winWidth / 10;
  local y = yUnit * streetY

  return (winWidth * 0.1) + x, y, winHeight - z
end

-- Turn world coordinates into pixel coordinates in the window
function Street:project(streetX, streetY, streetZ)
  local x, y, z = self:streetTo3d(streetX, streetY, streetZ) 
  local u, v = self.cam:projectToScreen(x, y, z)

  if debug then
    love.graphics.print(string.format("{%d, %d, %d}", x, y, z), u, v)
  end
  
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

    u, v = self:project(i, 0, 0)

    for di = 1, table.getn(track.daemons) do
      local daemon = track.daemons[di]
      u, v = self:project(i, daemon.y, 0)
    end
  end
end
