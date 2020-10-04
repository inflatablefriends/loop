local newdecoder = require 'lib/lunajson/lunajson/decoder'
local newencoder = require 'lib/lunajson/lunajson/encoder'
-- If you need multiple contexts of decoder and/or encoder,
-- you can require lunajson.decoder and/or lunajson.encoder directly.
return {
	decode = newdecoder(),
	encode = newencoder(),
}
