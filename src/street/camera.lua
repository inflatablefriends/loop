
-- Vec3 = { x = 0, y = 0, z = 0}
-- function Vec3:create(v)
--   v = v or { x = 0, y = 0, z = 0 }
--   setmetatable(v, self)
--   self.__index = self
--   return v
-- end

Camera = {}
function Camera:create(position)
  if (position == nil) then error("Camera:create needs a position") end

  c = {}
  setmetatable(c, self)
  self.__index = self

  c.position = position
  c.theta = { math.rad(-90), 0, 0 } -- rotation
  c.e = { winWidth / 2, winHeight / 2, winWidth / 2} -- fov?

  return c
end

-- V3 to origin of image plane from camera

-- See https://en.wikipedia.org/wiki/3D_projection#Mathematical_formula
function Camera:projectToScreen(vec3)
  -- V3 from point to camera
  local cx, cy, cz = self.position[1], self.position[2], self.position[3]
  local x, y, z = vec3[1] - cx, vec3[2] - cy, vec3[3] - cz
	local ox, oy, oz = self.theta[1], self.theta[2], self.theta[3]
  local ex, ey, ez = self.e[1], self.e[2], self.e[3]
  
	local dx = cos(oy) * (sin(oz) * y + cos(oz) * x) - sin(oy) * z
	local dy = sin(ox) * (cos(oy) * z + sin(oy) * (sin(oz) * y + cos(oz) * x)) + cos(ox) * (cos(oz) * y - sin(oz) * x)
	local dz = cos(ox) * (cos(oy) * z + sin(oy) * (sin(oz) * y + cos(oz) * x)) - sin(ox) * (cos(oz) * y - sin(oz) * x)

	local bx = ((ez * dx) / dz) + ex
	local by = ((ez * dy) / dz) + ey

	return { bx, by }
end
