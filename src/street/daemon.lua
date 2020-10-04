
-- A Daemon represents the player, an object, another character, o anything else on the road
-- - Each Daemon records its own offset (y) within its track

Daemon = { }
function Daemon:create(type, y)
  if type == nil then error("Daemon needs a type") end
  if y == nil then error("Daemon needs an offset") end

  d = {}
  setmetatable(d, self)
  self.__index = self
  
  d.type = type
  d.y = y
  return d
end


function Daemon:draw()
  if self.type == "litter" then
    -- TODO draw an image of some litter

  elif self.type == "animal" then
    -- TODO draw an image of some animal

  elif self.type == "child" then
    -- TODO draw an image of some child
  
  elif self.type == "person" then
    -- TODO draw an image of some person
  end


end