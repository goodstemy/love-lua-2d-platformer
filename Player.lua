Player = Object:extend()

local direction
local lastDirection = 'right'
local activeFrame
local currentFrame = 1
local elapsedTime = 0
local width = 65
local height = 45
local totalFrames = {
	leftMovementTotalFrames = 8,
	rightMovementTotalFrames = 8,
	standRightTotalFrames = 5,
	standLeftTotalFrames = 5,
}
local currentTotalFrames = 0
local horizontalFramesPaddings = {15, 110, 207, 304, 400, 495, 590, 685}

function Player:new()
	self.image = love.graphics.newImage('assets/Player/player.png')
	self.x = 100
	self.y = 100
	self.speed = 100
	loadFrames(self.image)
end

function Player:draw()
	love.graphics.draw(self.image, activeFrame, self.x, self.y, 0, 1.5, 1.5)
end

function Player:move(dt)
	if love.keyboard.isDown('up') and love.keyboard.isDown('left') then
		player.y = player.y - player.speed * dt
		player.x = player.x - player.speed * dt
		direction = 'left'
		lastDirection = direction
		currentTotalFrames = totalFrames.leftMovementTotalFrames
	elseif love.keyboard.isDown('up') and love.keyboard.isDown('right') then
		player.y = player.y - player.speed * dt
		player.x = player.x + player.speed * dt
		direction = 'right'
		lastDirection = direction
		currentTotalFrames = totalFrames.rightMovementTotalFrames
	elseif love.keyboard.isDown('down') and love.keyboard.isDown('left') then
		player.y = player.y + player.speed * dt
		player.x = player.x - player.speed * dt
		direction = 'left'
		lastDirection = direction
		currentTotalFrames = totalFrames.leftMovementTotalFrames
	elseif love.keyboard.isDown('down') and love.keyboard.isDown('right') then
		player.y = player.y + player.speed * dt
		player.x = player.x + player.speed * dt
		direction = 'right'
		lastDirection = direction
		currentTotalFrames = totalFrames.rightMovementTotalFrames
	elseif love.keyboard.isDown('left') then
		player.x = player.x - player.speed * dt
		direction = 'left'
		lastDirection = direction
		currentTotalFrames = totalFrames.leftMovementTotalFrames
	elseif love.keyboard.isDown('right') then
		player.x = player.x + player.speed * dt
		direction = 'right'
		lastDirection = direction
		currentTotalFrames = totalFrames.rightMovementTotalFrames
	elseif love.keyboard.isDown('up') then
		player.y = player.y - player.speed * dt
		if lastDirection == 'left' then
			direction = 'left'
			currentTotalFrames = totalFrames.leftMovementTotalFrames
		elseif lastDirection == 'right' then
			direction = 'right'
			currentTotalFrames = totalFrames.rightMovementTotalFrames
		end
	elseif love.keyboard.isDown('down') then
		player.y = player.y + player.speed * dt
		if lastDirection == 'left' then
			direction = 'left'
			currentTotalFrames = totalFrames.leftMovementTotalFrames
		elseif lastDirection == 'right' then
			direction = 'right'
			currentTotalFrames = totalFrames.rightMovementTotalFrames
		end
	else
		direction = nil
		currentTotalFrames = totalFrames.standLeftTotalFrames
	end

	move(dt)
end

function move(dt)
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0.075 then
		if currentFrame < currentTotalFrames then
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
		else
			if lastDirection == 'left' then
				activeFrame = standLeftFrames[currentFrame]
			else
				activeFrame = standRightFrames[currentFrame]
			end
		end
		elapsedTime = 0
	end
end

function loadFrames(playerImage)
	loadLeftFrames(playerImage)
	loadRightFrames(playerImage)
	loadStandRightFrames(playerImage)
	loadStandLeftFrames(playerImage)
	activeFrame = standRightFrames[currentFrame]
end

function loadLeftFrames(playerImage)
	local verticalPadding = 1075
	leftMovementFrames = {}

	for i=1, totalFrames.leftMovementTotalFrames do
		leftMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadRightFrames(playerImage)
	local verticalPadding = 116
	rightMovementFrames = {}

	for i=1, totalFrames.rightMovementTotalFrames do
		rightMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadStandRightFrames(playerImage)
	local verticalPadding = 20
	standRightFrames = {}

	for i=1, totalFrames.standRightTotalFrames do
		standRightFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadStandLeftFrames(playerImage)
	local verticalPadding = 980
	standLeftFrames = {}

	for i=1, totalFrames.standLeftTotalFrames do
		standLeftFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end
