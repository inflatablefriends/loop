-- Assorted global helper functions and variables
wf = require 'lib/windfield'
inspect = require "lib/inspect"

local cpml = require "lib/cpml"

debug = false
cos = math.cos
sin = math.sin
vec2 = cpml.vec2
vec3 = cpml.vec3

function clamp(val, min, max)
  return math.max(min, math.min(val, max))
end

