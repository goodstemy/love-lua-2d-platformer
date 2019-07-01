Player = Object:extend()

local isAttack = false
local direction
local lastDirection = 'right'
local activeFrame
local currentFrame = 1
local elapsedTime = 0
local width = 85
local height = 80
local totalFrames = {
	leftMovementTotalFrames = 8,
	rightMovementTotalFrames = 8,
	standRightTotalFrames = 5,
	standLeftTotalFrames = 5,
	attackLeftTotalFrames = 9,
	attackRightTotalFrames = 9,
}
local currentTotalFrames = 0
local horizontalFramesPaddings = {10, 105, 202, 299, 395, 490, 585, 680, 775}

function Player:new()
	self.image = love.graphics.newImage('assets/Player/player.png')
	loadFrames(self.image)
end

function Player:draw(x, y)
	love.graphics.draw(self.image, activeFrame, x, y, 0, 1.5, 1.5)
end

function Player:move(dt)
	print('move', isAttack, direction)

	if isAttack then
		direction = 'left'
		currentTotalFrames = totalFrames.attackLeftTotalFrames
	elseif love.keyboard.isDown('left') then
		direction = 'left'
		lastDirection = direction
		currentTotalFrames = totalFrames.leftMovementTotalFrames
	elseif love.keyboard.isDown('right') then
		direction = 'right'
		lastDirection = direction
		currentTotalFrames = totalFrames.rightMovementTotalFrames
	else
		direction = nil
		currentTotalFrames = totalFrames.standLeftTotalFrames
	end

	move(dt)
end

function Player:attack()
	isAttack = true
	currentFrame = 1
end

function move(dt)
	elapsedTime = elapsedTime + dt

	if elapsedTime > 0.075 then
		if currentFrame < currentTotalFrames then
			currentFrame = currentFrame + 1
		else
			currentFrame = 1
		end
		if direction == 'left' and isAttack then
			activeFrame = attackLeftFrames[currentFrame]
		elseif direction == 'left' then
			activeFrame = leftMovementFrames[currentFrame]
		elseif direction == 'right' then
			activeFrame = rightMovementFrames[currentFrame]
		else
			if lastDirection == 'left' then
				activeFrame = standLeftFrames[currentFrame]
			else
				activeFrame = standRightFrames[currentFrame]
			end
		end

		if isAttack and currentFrame == totalFrames.attackLeftTotalFrames then
			isAttack = false
		end
		elapsedTime = 0
	end
end

function loadFrames(playerImage)
	loadLeftFrames(playerImage)
	loadRightFrames(playerImage)
	loadStandRightFrames(playerImage)
	loadStandLeftFrames(playerImage)
	loadAttackLeftFrames(playerImage)
	activeFrame = standRightFrames[currentFrame]
end

function loadLeftFrames(playerImage)
	local verticalPadding = 1052
	leftMovementFrames = {}

	for i=1, totalFrames.leftMovementTotalFrames do
		leftMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadRightFrames(playerImage)
	local verticalPadding = 91
	rightMovementFrames = {}

	for i=1, totalFrames.rightMovementTotalFrames do
		rightMovementFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadStandRightFrames(playerImage)
	local verticalPadding = -3
	standRightFrames = {}

	for i=1, totalFrames.standRightTotalFrames do
		standRightFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadStandLeftFrames(playerImage)
	local verticalPadding = 957
	standLeftFrames = {}

	for i=1, totalFrames.standLeftTotalFrames do
		standLeftFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadAttackLeftFrames(playerImage)
	local verticalPadding = 1245
	attackLeftFrames = {}

	for i=1, totalFrames.attackLeftTotalFrames do
		attackLeftFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end

function loadAttackRightFrames(playerImage)
	local verticalPadding = 289
	attackRightFrames = {}

	for i=1, totalFrames.attackRightTotalFrames do
		attackLeftFrames[i] = love.graphics.newQuad(horizontalFramesPaddings[i], verticalPadding, width, height, playerImage:getDimensions())
	end
end
