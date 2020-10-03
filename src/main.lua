require "street/_"

-- global variable to toggle display of debugging info
debug = false

function love.load()
  winWidth, winHeight = love.graphics.getDimensions()
  street = Street:create()
  street:load()
end

function love.update(dt)
  local move = 10;

  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    street.cam.position[1] = street.cam.position[1] - move;
  end

  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    street.cam.position[1] = street.cam.position[1] + move;
  end

  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    street.cam.position[2] = street.cam.position[2] + move;
  end

  if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    street.cam.position[2] = street.cam.position[2] - move;
  end

  if love.keyboard.isDown("w") then
    street.cam.position[3] = street.cam.position[3] + move;
  end

  if love.keyboard.isDown("s") then
    street.cam.position[3] = street.cam.position[3] - move;
  end
end


function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  elseif key == "#" then
    debug = not debug
    print(string.format("win: {%d, %d}", winWidth, winHeight));
    print(string.format("cam: {%d, %d, %d}", street.cam.position[1], street.cam.position[2], street.cam.position[3]))
  end
end

function love.draw()
  street:draw()
end
