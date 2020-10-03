

Track = { }
function Track:create(t)
  t = t or {}
  t.parent = self
  t.objects = {}
  return t
end

Daemon = { }
function Daemon:create(d)
  d = d or {}
  d.parent = self
  d.y = 0
  return d 
end

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
