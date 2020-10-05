

-- The Street has an array of Track (left -> right)
Street = { }
function Street:create(s)
  s = s or { tracks = {} }
  setmetatable(s, self)
  self.__index = self

  self.cam = Camera:create() -- NB in world coordinates  
  self.trackWidth = 0 -- width in pixels of the track
  self.world = wf.newWorld(0, 1000, true)
  self.daemons = {}

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

function Street:addDaemon(position, daemon)
  table.insert(self.daemons, daemon)
  daemon.position = self:streetTo3d(position)
end

function Street:load()  
  local groundLevel = self:streetTo3d(vec3(0,0,0))
  self.ground = self.world:newLineCollider(-2000, groundLevel.z, 2000, groundLevel.z)
  self.ground:setType('static')
  
  for trackIndex = 1, 7 do
    track = self:addTrack{ index = trackIndex }
  end

  -- Place some daemons so we can see how the camera's working
  for x = 1, table.getn(self.tracks) do
    local track = self.tracks[x]
    
    for y = 1, 50 do
      self:addDaemon(vec3(x, y, 0), Daemon:create("marker"))
    end
  end

  self:addDaemon(vec3(4, 0, 0), Player:create())
  self:addDaemon(vec3(2, 5, 0), Daemon:create("dude"))
  self:addDaemon(vec3(3, 15, 0), Daemon:create("dude"))
  self:addDaemon(vec3(4, 8, 0), Daemon:create("dude"))
end

function Street:update(dt)
  local move = 10

  -- pan camera x (left/right)
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    self.cam.position.x = clamp(self.cam.position.x - move, 0, winWidth)
  end

  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    self.cam.position.x = clamp(self.cam.position.x + move, 0, winWidth)
  end

  -- pan camera y (forward/back)
  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    self.cam.position.y = self.cam.position.y + move
  elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    self.cam.position.y = self.cam.position.y - move
  end

  -- pan camera z (up/down)
  if love.keyboard.isDown("r") then
    self.cam.position.z = math.max(0, self.cam.position.z + move)
  elseif love.keyboard.isDown("f") then
    self.cam.position.z = math.max(0, self.cam.position.z - move)
  end

  for i = 1, self.trackCount do
    local track = self.tracks[i]
    track:update(dt)
  end

  for j = 1, table.getn(self.daemons) do
    local daemon = self.daemons[j]
    daemon:update(dt)

    if daemon.position.y == 0 and daemon.body == nil then
      daemon:addToWorld(self)
    end
  end

  self.world:update(dt)
end

function Street:keypressed(key)  
  if key == "#" then
    print(string.format("cam: {%d, %d, %d}", self.cam.position:unpack()))
  end

  for j = 1, table.getn(self.daemons) do
    local daemon = self.daemons[j]
    daemon:keypressed(key)
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

    -- if debug then
    --   print(string.format("%d close %d %d far %d %d", i, posc.x, posc.y, posy.x, posy.y))
    --   print(string.format("%d close %d %d far %d %d", i, tas.x, tas.y, tbs.x, tbs.y))
    -- end
  end

  
  for j = 1, table.getn(self.daemons) do
    local daemon = self.daemons[j]
    daemon:draw(self)
  end

  if debug then
    self.world:draw()
  end
end
