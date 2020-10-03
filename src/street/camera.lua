
Camera = {}
function Camera:create(position)
  -- if (position == nil) then error("Camera:create needs a position") end

  c = {}
  setmetatable(c, self)
  self.__index = self

  c.position = vec3(winWidth / 2, -500, 800)
  c.theta = vec3(math.rad(-90), 0, 0) -- rotation
  c.e = vec3(winWidth / 2, winHeight / 2, winWidth / 2) -- fov?

  return c
end

-- V3 to origin of image plane from camera

-- See https://en.wikipedia.org/wiki/3D_projection#Mathematical_formula
function Camera:projectToScreen(pos)
  -- V3 from point to camera
  local x, y, z = pos:sub(self.position):unpack()
	local ox, oy, oz = self.theta:unpack()
  local ex, ey, ez = self.e:unpack()
  
	local dx = cos(oy) * (sin(oz) * y + cos(oz) * x) - sin(oy) * z
	local dy = sin(ox) * (cos(oy) * z + sin(oy) * (sin(oz) * y + cos(oz) * x)) + cos(ox) * (cos(oz) * y - sin(oz) * x)
	local dz = cos(ox) * (cos(oy) * z + sin(oy) * (sin(oz) * y + cos(oz) * x)) - sin(ox) * (cos(oz) * y - sin(oz) * x)

	local bx = ((ez * dx) / dz) + ex
	local by = ((ez * dy) / dz) + ey

	return vec2(bx, by)
end
