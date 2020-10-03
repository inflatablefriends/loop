
-- A Track has an array of Daemon (close -> far)

Track = { }
function Track:create(t)
  t = t or {}
  t.parent = self
  t.objects = {}
  return t
end
