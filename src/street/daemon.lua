
-- A Daemon represents the player, an object, another character, o anything else on the road
-- - Each Daemon records its own offset (z) within its track

Daemon = { }
function Daemon:create(type, z)
  if type == nil then error("Daemon needs a type") end
  if z == nil then error("Daemon needs an offset") end

  d = {}
  setmetatable(d, self)
  self.__index = self
  
  d.type = type
  d.z = z
  return d
end
