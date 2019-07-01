function love.load()
	Camera = require 'Camera'
	Object = require 'Classic'
	require 'Player'
	require 'Shadow'

	camera = Camera()
	player = Player()

	camera:setFollowLerp(0.2)
	mainMusic = love.audio.newSource('assets/Music/main-theme.mp3', 'stream')
	mainMusic:setLooping(true)
	mainMusic:play()

	createWorld()
end

function love.update(dt)
	camera:update(dt)
	camera:follow(objects.player.body:getX(), objects.player.body:getY())

	player:move(dt)

	world:update(dt)

	if love.keyboard.isDown("right") then
		objects.player.body:setX(objects.player.body:getX() + 200 * dt)
	elseif love.keyboard.isDown("left") then
		objects.player.body:setX(objects.player.body:getX() - 200 * dt)
	end
end

function love.draw()
	love.graphics.setBackgroundColor(222/255, 222/255, 222/255, 100)

	-- camera:attach()

	player:draw(objects.player.body:getX(), objects.player.body:getY())

	-- camera:detach()

 	love.graphics.setColor(0.28, 0.63, 0.05)
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
 	love.graphics.setColor(1, 1, 1, 1)

	-- ONLY FOR DEBUG
	love.graphics.print("FPS: "..tostring(love.timer.getFPS()), 10, 10)
end

function love.keyreleased(key)
   if key == "escape" then
      love.event.quit()
   end

   print(key, canJump)
   if key == "space" and canJump then
		objects.player.body:applyForce(0, -15000)
   end
end

function createWorld()
	love.physics.setMeter(64) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

	objects = {}

	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) 
	objects.ground.shape = love.physics.newRectangleShape(650, 50)
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
	objects.ground.fixture:setUserData('Ground')

	objects.player = Player()
	objects.player.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
	objects.player.shape = love.physics.newEdgeShape(0, 0, 65, 65)
	objects.player.fixture = love.physics.newFixture(objects.player.body, objects.player.shape, 1)
	objects.ground.fixture:setUserData('Player')

	love.window.setMode(650, 650)

	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function beginContact(a, b, coll)
end

function endContact(fixture_a, fixture_b, call)
	canJump = false
end

function preSolve(a, b, coll)
	canJump = true
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end