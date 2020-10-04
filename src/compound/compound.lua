
-- The Compound is a safe haven to settle down for the night
Compound = { }
function Compound:create()
  s = { }
  setmetatable(s, self)
  self.__index = self

  return s
end

function Compound:load()
  StoryManager.load()
  StoryManager.chooseStory()
end

-- N.B This function is only called when game_mode == "compound"
function Compound:update(dt)
end

function Compound:keypressed(key)
  if key == "space" then
    local lineIndex = StoryManager.advance()
    if (lineIndex == nil) then
      changeGameMode("street")
    end
  end
end

function Compound:draw()
  -- TODO make this display better
  if StoryManager.currentLine ~= nil then
    love.graphics.print(StoryManager.currentLine.who)
    love.graphics.print(StoryManager.currentLine.text, 0, 40)
  end

end
