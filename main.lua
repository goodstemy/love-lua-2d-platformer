function love.load()
	Camera = require 'Camera'
	Object = require 'Classic'
	require 'Player'
	require 'Shadow'

	camera = Camera()
	player = Player()
	shadow = Shadow(player)

	camera:setFollowLerp(0.2)
	mainMusic = love.audio.newSource('assets/Music/main-theme.mp3', 'stream')
	mainMusic:setLooping(true)
	mainMusic:play()

	world = love.physics.newWorld(0, 100)
	player.body = love.physics.newBody(world, 200, 200, 'dynamic')
	player.body:setMass(32)
	player.shape = love.physics.newPolygonShape(100, 100, 200, 100, 200, 200)
	player.fixture = love.physics.newFixture(player.body, player.shape)
end

function love.update(dt)
	camera:update(dt)
	camera:follow(player.x, player.y)

	player:move(dt)
	shadow:update()

	world:update(dt)
end

function love.draw()
	love.graphics.setBackgroundColor(222/255, 222/255, 222/255, 100)

	camera:attach()

	shadow:draw()
	x, y = player.body:getWorldPoints(player.shape:getPoints())
	print(x, y)
	player:draw(x, y)

	love.graphics.rectangle('fill', 10, 10, 10, 10)

	camera:detach()

	-- love.graphics.polygon('line', player.body:getWorldPoints(player.shape:getPoints()))

	-- ONLY FOR DEBUG
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
end
