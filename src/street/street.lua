
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

-- Convert grid coordinates into a 3d vector from 0, 0
function Street:gridTo3d(streetX, streetY, streetZ)
  local winWidth, winHeight = love.graphics.getDimensions()

  -- divide width into 100 units
  local xUnit = winWidth / 100
  local xTrackWidth = (xUnit * 80) / table.getn(self.tracks) -- the street goes from 10 - 90
  local x = (streetX * xTrackWidth) + (xTrackWidth / 2) -- centre of the track

  -- window axis is from top left corner
  -- street y ~= -winy
  -- again divide into 100 units
  local yUnit = winHeight / 100
  local y = (yUnit * streetY) + (yUnit / 2)

  -- z is offset along the track
  local zUnit = xUnit;
  local z = zUnit * streetZ

  return (xUnit * 10) + x, winHeight - y, z
end


function Street:draw()
  for i = 1, table.getn(self.tracks) do
    local track = self.tracks[i]

    local x, y, z = self:gridTo3d(i, 0, 0)
    u, v = self.cam:projectToScreen(x, y, z)

    love.graphics.print(i, u, v)
  end
end
