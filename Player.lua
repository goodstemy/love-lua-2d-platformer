Player = Object:extend()

local frames = {}

function Player:new()
	leftMovementImage = love.graphics.newImage('assets/Running/left.png')
	frames[1] = love.graphics.newQuad(0, 0, 20, 100, leftMovementImage:getDimensions())
	self.image = love.graphics.newImage('assets/Standing/down.png')
	self.x = 100
	self.y = 100
	self.speed = 100
end

function Player:draw()
	love.graphics.draw(leftMovementImage, frames[1], 10, 10, 0, 4, 4)
	-- love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
end

function Player:move(dt)
	if love.keyboard.isDown('up') and love.keyboard.isDown('left') then
		player.y = player.y - player.speed * dt
		player.x = player.x - player.speed * dt
	elseif love.keyboard.isDown('up') and love.keyboard.isDown('right') then
		player.y = player.y - player.speed * dt
		player.x = player.x + player.speed * dt
	elseif love.keyboard.isDown('down') and love.keyboard.isDown('left') then
		player.y = player.y + player.speed * dt
		player.x = player.x - player.speed * dt
	elseif love.keyboard.isDown('down') and love.keyboard.isDown('right') then
		player.y = player.y + player.speed * dt
		player.x = player.x + player.speed * dt
	elseif love.keyboard.isDown('left') then
		player.x = player.x - player.speed * dt
	elseif love.keyboard.isDown('right') then
		player.x = player.x + player.speed * dt
	elseif love.keyboard.isDown('up') then
		player.y = player.y - player.speed * dt
	elseif love.keyboard.isDown('down') then
		player.y = player.y + player.speed * dt
	end
end