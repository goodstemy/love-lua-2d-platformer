Shadow = Object:extend()

function Shadow:new(obj)
	castShadowObject = obj
	self.x = castShadowObject.x
	self.y = castShadowObject.y
	self.width = castShadowObject.image:getWidth()
	self.height = castShadowObject.image:getHeight()
end

function Shadow:update()
	if castShadowObject.x ~= self.x or castShadowObject.y ~= self.y then
		self.x = castShadowObject.x
		self.y = castShadowObject.y
	end
end

function Shadow:draw()
	love.graphics.setColor(10/255, 10/255, 10/255, 0.2)
	-- TODO: Make shadow center dynamic
	love.graphics.ellipse('fill', self.x + 23, self.y + 55, self.width / 2.5, self.height / 5.5)
	love.graphics.setColor(1, 1, 1, 1)
end