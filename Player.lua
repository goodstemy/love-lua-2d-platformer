Player = Object:extend()

local direction
local activeFrame
local currentFrame = 1
local elapsedTime = 0

function Player:new()
	loadLeftFrames()
	loadRightFrames()
	loadUpFrames()
	loadDownFrames()
	self.image = love.graphics.newImage('assets/Standing/down.png')
	self.x = 100
	self.y = 100
	self.speed = 100
end

function Player:draw()
	if direction == 'left' then
		love.graphics.draw(leftMovementImage, activeFrame, self.x, self.y, 0, 1.5, 1.5)
	elseif direction == 'right' then
		love.graphics.draw(rightMovementImage, activeFrame, self.x, self.y, 0, 1.5, 1.5)
	elseif direction == 'up' then
		love.graphics.draw(upMovementImage, activeFrame, self.x, self.y, 0, 1.5, 1.5)
	elseif direction == 'down' then
		love.graphics.draw(downMovementImage, activeFrame, self.x, self.y, 0, 1.5, 1.5)
	else
		love.graphics.draw(self.image, self.x, self.y, 0, 1.5, 1.5)
	end
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
		direction = 'left'
		move(dt)
	elseif love.keyboard.isDown('right') then
		player.x = player.x + player.speed * dt
		direction = 'right'
		move(dt)
	elseif love.keyboard.isDown('up') then
		player.y = player.y - player.speed * dt
		direction = 'up'
		move(dt)
	elseif love.keyboard.isDown('down') then
		player.y = player.y + player.speed * dt
		direction = 'down'
		move(dt)
	end
end

function move(dt)
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0.15 then
		if currentFrame < 4 then
			currentFrame = currentFrame + 1
		else
			currentFrame = 1
		end
		if direction == 'left' then
			activeFrame = leftMovementFrames[currentFrame]
		elseif direction == 'right' then
			activeFrame = rightMovementFrames[currentFrame]
		elseif direction == 'up' then
			activeFrame = upMovementFrames[currentFrame]
		elseif direction == 'down' then
			activeFrame = downMovementFrames[currentFrame]
		end
		elapsedTime = 0
	end
end

function loadLeftFrames()
	leftMovementFrames = {}
	leftMovementImage = love.graphics.newImage('assets/Running/left.png')
	leftMovementFrames[1] = love.graphics.newQuad(0, 0, 22, 40, leftMovementImage:getDimensions())
	leftMovementFrames[2] = love.graphics.newQuad(22, 0, 22, 40, leftMovementImage:getDimensions())
	leftMovementFrames[3] = love.graphics.newQuad(44, 0, 22, 40, leftMovementImage:getDimensions())
	leftMovementFrames[4] = love.graphics.newQuad(66, 0, 22, 40, leftMovementImage:getDimensions())
	activeFrame = leftMovementFrames[currentFrame]
end

function loadRightFrames()
	rightMovementFrames = {}
	rightMovementImage = love.graphics.newImage('assets/Running/right.png')
	rightMovementFrames[1] = love.graphics.newQuad(0, 0, 22, 40, rightMovementImage:getDimensions())
	rightMovementFrames[2] = love.graphics.newQuad(22, 0, 22, 40, rightMovementImage:getDimensions())
	rightMovementFrames[3] = love.graphics.newQuad(44, 0, 22, 40, rightMovementImage:getDimensions())
	rightMovementFrames[4] = love.graphics.newQuad(66, 0, 22, 40, rightMovementImage:getDimensions())
	activeFrame = rightMovementFrames[currentFrame]
end

function loadUpFrames()
	upMovementFrames = {}
	upMovementImage = love.graphics.newImage('assets/Running/up.png')
	upMovementFrames[1] = love.graphics.newQuad(0, 0, 22, 40, upMovementImage:getDimensions())
	upMovementFrames[2] = love.graphics.newQuad(22, 0, 22, 40, upMovementImage:getDimensions())
	upMovementFrames[3] = love.graphics.newQuad(44, 0, 22, 40, upMovementImage:getDimensions())
	upMovementFrames[4] = love.graphics.newQuad(66, 0, 22, 40, upMovementImage:getDimensions())
	activeFrame = upMovementFrames[currentFrame]
end

function loadDownFrames()
	downMovementFrames = {}
	downMovementImage = love.graphics.newImage('assets/Running/down.png')
	downMovementFrames[1] = love.graphics.newQuad(0, 0, 22, 40, downMovementImage:getDimensions())
	downMovementFrames[2] = love.graphics.newQuad(22, 0, 22, 40, downMovementImage:getDimensions())
	downMovementFrames[3] = love.graphics.newQuad(44, 0, 22, 40, downMovementImage:getDimensions())
	downMovementFrames[4] = love.graphics.newQuad(66, 0, 22, 40, downMovementImage:getDimensions())
	activeFrame = downMovementFrames[currentFrame]
end