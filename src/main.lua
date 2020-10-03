require "street"

function love.load()
  street = Street:create()
  for trackIndex = 1, 7 do
    track = street:addTrack{ index = trackIndex }
  end
end

function love.update(dt)
end

function love.draw()
  print(table.getn(street.tracks))
  -- love.graphics.print(street.tracks, 400, 300)

end
