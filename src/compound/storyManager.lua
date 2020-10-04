local lunajson = require "lib/lunajson/lunajson"
local inspect = require "lib/inspect"

-- The StoryManager is a way to manage chains of dialogue in stories.


StoryManager = {
  -- See res/compound.json for dialogue.
  -- Each key is an array of { "who": "<character name>", "text": "<dialogue" }
  -- which should be displayed sequentially.
  stories = {},

  -- The key of the current story, e.g. "welcome"
  currentStory = nil,

  -- A table of the current line in the story, e.g. { "who": "???", "text": "Hi" }
  currentLine = nil,

  -- An index into the current story.
  storyIndex = nil,
}

StoryManager.load = function()
  local json = love.filesystem.read("string", "res/compound.json")
  StoryManager.stories = lunajson.decode(json)
end

-- Sets StoryManager.currentStory to a key of res/compound.json
-- And loads the first line
StoryManager.chooseStory = function()
  -- TODO we will need a way to look at the game state and determine what the story should be
  StoryManager.currentStory = "welcome"
  StoryManager.advance()

  if debug then
    print(string.format("Loaded story %s", StoryManager.currentStory))
  end
end

-- Move the current story to the next line.
-- Returns the next index or nil if there are no more lines
StoryManager.advance = function()
  local nextIndex = nil
  
  if StoryManager.currentStory == nil then
    return nil
  end

  local currentLines = StoryManager.stories[StoryManager.currentStory]
  if currentLines == nil then
    print(string.format("Couldn't find lines for story %s", StoryManager.currentStory))
    return nil
  end

  if StoryManager.currentIndex == nil then
    nextIndex = 1
  elseif StoryManager.currentIndex == table.getn(currentLines) then
    nextIndex = nil
  else
    nextIndex = StoryManager.currentIndex + 1
  end

  if nextIndex == nil then
    StoryManager.currentLine = nil
    StoryManager.currentIndex = nil
  else
    local nextLine = currentLines[nextIndex]
    StoryManager.currentLine = nextLine
    StoryManager.currentIndex = nextIndex
  end

  if debug then
    print(string.format("Loaded story %s line %d", currentStory, nextIndex or "nil"))
  end

  return StoryManager.currentIndex
end