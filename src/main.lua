require "street/_"

function love.load()
  street = Street:create()

  for trackIndex = 1, 7 do
    track = street:addTrack{ index = trackIndex }
  end

end

function love.update(dt)
  local move = 10;

  if love.keyboard.isDown("a") then
    street.cam.position[1] = street.cam.position[1] - move;
  end

  if love.keyboard.isDown("d") then
    street.cam.position[1] = street.cam.position[1] + move;
  end

  if love.keyboard.isDown("w") then
    street.cam.position[2] = street.cam.position[2] + move;
  end

  if love.keyboard.isDown("s") then
    street.cam.position[2] = street.cam.position[2] - move;
  end
end


function love.keypressed(key)
  if key == "escape" then love.event.quit() end
end

function love.draw()
  -- print(table.getn(street.tracks))
  street:draw()
end
