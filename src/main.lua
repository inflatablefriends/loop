require "street/_"

function love.load()
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
  if key == "escape" then love.event.quit() end
end

function love.draw()
  -- print(table.getn(street.tracks))
  street:draw()
end
