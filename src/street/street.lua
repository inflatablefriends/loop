

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
  local track = Track:create(arg)
  table.insert(self.tracks, track)

  -- the street goes from 10 - 90
  self.trackWidth = (winWidth * 0.8) / table.getn(self.tracks)
  self.trackCount = table.getn(self.tracks)

  return track
end

function Street:getTrackWidth()
  return 
end

-- Convert street coordinates into a 3d vector from 0, 0
function Street:streetTo3d(vec3)

  -- divide width into 100 units
  local x = (vec3[1] * self.trackWidth) - (self.trackWidth / 2) -- centre of the track

  -- window axis is from top left corner
  -- street z ~= -winz
  -- again divide into 100 units
  local zUnit = winHeight / 100
  local z = (zUnit * vec3[3]) + (zUnit / 2)

  -- y is offset along the track
  local yUnit = winWidth / 10;
  local y = yUnit * vec3[2]

  return {(winWidth * 0.1) + x, y, winHeight - z}
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
    local posc = self:streetTo3d{i, 0, 0}
    tas = self.cam:projectToScreen{ posc[1] - ht, posc[2], posc[3] }
    tds = self.cam:projectToScreen{ posc[1] + ht, posc[2], posc[3] }

    local posy = self:streetTo3d{i, 4000, 0}
    tbs = self.cam:projectToScreen{ posy[1] - ht, posy[2], posy[3] }
    tcs = self.cam:projectToScreen{ posy[1] + ht, posy[2], posy[3] }

    local cOffset = (i - self.trackCount) * 0.04;
    love.graphics.setColor(0.6 + cOffset, 0.6 + cOffset, 0.6 + cOffset)
    love.graphics.polygon("fill", {
      tas[1], tas[2],
      tbs[1], tbs[2],
      tcs[1], tcs[2],
      tds[1], tds[2],
    });

    if debug then
      print(string.format("%d close %d %d far %d %d", i, posc[1], posc[2], posy[1], posy[2]))
      print(string.format("%d close %d %d far %d %d", i, tas[1], tas[2], tbs[1], tbs[2]))
    end
  end

  for i = 1, self.trackCount do
    local track = self.tracks[i]    

    for di = 1, table.getn(track.daemons) do
      local daemon = track.daemons[di]
      local pos = self:streetTo3d{i, daemon.y, 0}
      daemon:draw(self.cam, pos)
    end
  end
end
