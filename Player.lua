Player = Object:extend()

local direction
local activeFrame
local currentFrame = 1
local elapsedTime = 0
local width = 65
local height = 45
local horizontalFramesPaddings = {15, 110, 207, 304, 400, 495, 590, 685}

function Player:new()
	self.image = love.graphics.newImage('assets/Player/player.png')
	self.x = 100
	self.y = 100
	self.speed = 100
	loadFrames(self.image)
end

function Player:draw()
	if direction == 'left' then
		love.graphics.draw(self.image, activeFrame, self.x, self.y, 0, 1.5, 1.5)
	elseif direction == 'right' then
		love.graphics.draw(self.image, activeFrame, self.x, self.y, 0, 1.5, 1.5)
		love.graphics.rectangle('line', self.x, self.y, 55, 45)
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
	else
		direction = nil
	end
end

function move(dt)
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0.075 then
		if currentFrame < #rightMovementFrames then
			currentFrame = currentFrame + 1
		else
			currentFrame = 1
		end
		print(currentFrame)
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

function loadFrames(playerImage)
	loadLeftFrames(playerImage)
	loadRightFrames(playerImage)
	loadUpFrames(playerImage)
	loadDownFrames(playerImage)
end

function loadLeftFrames(playerImage)
	local totalMovementFrames = 8
	local verticalPadding = 1075
	leftMovementFrames = {}

	for i=1, totalMovementFrames do
		leftMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadRightFrames(playerImage)
	local totalMovementFrames = 8
	local verticalPadding = 116
	rightMovementFrames = {}

	for i=1, totalMovementFrames do
		rightMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
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