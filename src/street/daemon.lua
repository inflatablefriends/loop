
-- A Daemon represents the player, an object, another character, o anything else on the road
-- - Each Daemon records its own offset within its track

Daemon = { }
function Daemon:create(d)
  d = d or {}
  d.parent = self
  d.y = 0
  return d 
end
