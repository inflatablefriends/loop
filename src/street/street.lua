

-- The Street has an array of Track (left -> right)
Street = { }
function Street:create(s)
  s = s or { tracks = {} }
  setmetatable(s, self)
  self.__index = self

   -- NB in world coordinates
  self.cam = Camera:create()

  self.trackWidth = 0

  return s
end

function Street:addTrack(arg)
  local track = Track:create(arg)
  table.insert(self.tracks, track)

  -- the street goes from 10 - 90
  self.trackWidth = (winWidth * 0.8) / table.getn(self.tracks)
  self.trackCount = table.getn(self.tracks)

  return track
end

-- Convert street coordinates into a 3d vector from 0, 0
function Street:streetTo3d(vec3)

  -- divide width into 100 units
  local x = (vec3.x * self.trackWidth) - (self.trackWidth / 2) -- centre of the track

  -- window axis is from top left corner
  -- street z ~= -winz
  -- again divide into 100 units
  local zUnit = winHeight / 100
  local z = (zUnit * vec3.z) + (zUnit / 2)

  -- y is offset along the track
  local yUnit = winWidth / 10
  local y = yUnit * vec3.y

  return vec3((winWidth * 0.1) + x, y, winHeight - z)
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

  table.insert(self.tracks[2].daemons, Daemon:create("dude", 5))
  table.insert(self.tracks[4].daemons, Daemon:create("dude", 8))
  table.insert(self.tracks[3].daemons, Daemon:create("dude", 15))
end

function Street:update(dt)
  for i = 1, self.trackCount do
    local track = self.tracks[i]
    track:update(dt)
  end
end

function Street:draw()
  for i = 1, self.trackCount do
    local track = self.tracks[i]    

    local ht = self.trackWidth / 2
    local posc = self:streetTo3d(vec3(i, 0, 0))
    tas = self.cam:projectToScreen(vec3(posc.x - ht, posc.y, posc.z ))
    tds = self.cam:projectToScreen(vec3(posc.x + ht, posc.y, posc.z ))

    local posy = self:streetTo3d(vec3(i, 4000, 0))
    tbs = self.cam:projectToScreen(vec3(posy.x - ht, posy.y, posy.z ))
    tcs = self.cam:projectToScreen(vec3(posy.x + ht, posy.y, posy.z ))

    local cOffset = (i - self.trackCount) * 0.04;
    love.graphics.setColor(0.6 + cOffset, 0.6 + cOffset, 0.6 + cOffset)
    love.graphics.polygon("fill", {
      tas.x, tas.y,
      tbs.x, tbs.y,
      tcs.x, tcs.y,
      tds.x, tds.y,
    });

    if debug then
      print(string.format("%d close %d %d far %d %d", i, posc.x, posc.y, posy.x, posy.y))
      print(string.format("%d close %d %d far %d %d", i, tas.x, tas.y, tbs.x, tbs.y))
    end
  end

  for i = 1, self.trackCount do
    local track = self.tracks[i]    

    for di = 1, table.getn(track.daemons) do
      local daemon = track.daemons[di]
      local pos = self:streetTo3d(vec3(i, daemon.y, 0))
      daemon:draw(self.cam, pos)
    end
  end
end
