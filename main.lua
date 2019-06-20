function love.load()
	Camera = require 'Camera'
	Object = require 'Classic'
	require 'Player'
	require 'Shadow'

	camera = Camera()
	player = Player()
	shadow = Shadow(player)

	camera:setFollowLerp(0.2)
end

function love.update(dt)
	camera:update(dt)
	camera:follow(player.x, player.y)

	player:move(dt)
	shadow:update()
end

function love.draw()
	love.graphics.setBackgroundColor(222/255, 222/255, 222/255, 100)

	camera:attach()

	shadow:draw()
	player:draw()

	love.graphics.rectangle('fill', 10, 10, 10, 10)

	camera:detach()
end
