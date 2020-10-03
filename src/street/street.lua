
-- The Street has an array of Track (left -> right)
Street = { }
function Street:create(s)
  s = s or { tracks = {} }
  setmetatable(s, self)
  self.__index = self
  return s
end

function Street:addTrack()
  table.insert(self.tracks, Track:create())
  return self.tracks[self.tracks.length]
end
