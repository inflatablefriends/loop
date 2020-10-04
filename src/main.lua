require "global_utils"
require "compound/_"
require "street/_"

local compound
local street
local game_mode
local game_controller

function changeGameMode(newMode)
  game_mode = newMode
  if newMode == "compound" then
    game_controller = compound
  elseif newMode == "street" then
    game_controller = street
  end
end

function love.load()
  winWidth, winHeight = love.graphics.getDimensions()
  compound = Compound:create()
  compound:load()
  street = Street:create()
  street:load()

  changeGameMode("compound")
end

function love.update(dt)
  if game_controller ~= nil then
    game_controller:update(dt)
  end
end

function love.keypressed(key)
  if debug then
    print(string.format("key: %s", key))
  end

  if key == "escape" then
    love.event.quit()
  elseif key == "#" then
    debug = not debug
    print(string.format("win: {%d, %d}", winWidth, winHeight))
  end

  if game_controller ~= nil then
    game_controller:keypressed(key)
  end
end

function love.draw()
  if game_controller ~= nil then
    game_controller:draw(dt)
  end
end
