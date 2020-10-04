# "Project L.A. Sue"

AKA "Project Ben Biri"

Game for Ludum Dare 47 - "Stuck in a loop"

# Setup

1. Install Love2d https://love2d.org/#download
2. (Windows) add "C:\Program Files\LOVE" to your path - [guide](https://www.howtogeek.com/118594/how-to-edit-your-system-path-for-easy-command-line-access/)

## VSCode

In VSCode, press <key>F4</key> then choose "Launch game".


# Lua reference

## Lua packages

Copy files into `/src/lib` then reference them with `require "lib/<package>"

## Lua classes

[Reference](https://www.lua.org/pil/16.2.html)

Create a class with

```lua
MyClass = { }
function MyClass:create()
  instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end
```

extend a class with

```lua
SubClass = MyClass:create()
```

add a method to your class with

```lua
function Class:foo()
  print("Hello world");
end

-- Methods on subclasses will be used instead of the method on the parent class.
function SubClass:bar()
  self.foo()
end

```

call methods with `:` 

```lua
local instance = SubClass:create()
instance:bar() -- This will print "Hello world"
```

set and define properties with `.` 

```lua
instance.prop = "hi"
print(instance.prop)
```

