-----------------------------------------------------------------------------------------
--
-- level2_screen.lua
-- Created by: Hunter Connolly
-- Date: Nov. 12, 2019
-- Description: This is the level 2 screen of the game.
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )

-- load physics
local physics = require("physics")

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg_image

local platform1
local platform2
local platform3
local platform4

local zombie1
local zombie2
local zombie3

local zombie2ScrollSpeed = 2
local zombie1ScrollSpeed = 4
local zombie3ScrollSpeed = 1

local portal
local portalPlatform

local zombie1platform
local zombie2platform


local character

local heart1
local heart2
local numLives = 2

local rArrow 
local uArrow
local lArrow

local motionx = 0
local RSPEED = 7
local LSPEED = -7
local LINEAR_VELOCITY = -275
local GRAVITY = 15

local leftW 
local topW
local floor
local rightW

local key1
local key2
local key3
local theBall

local questionsAnswered = 0

local pauseButton

-----------------------------------------------------------------------------------------
-- SOOUNDS
-----------------------------------------------------------------------------------------
local painSound = audio.loadSound("Sounds/agony.mp3")
local painSoundChannel

local coinSound = audio.loadSound("Sounds/coin.wav")
local coinSoundChannel

local bkgMusic = audio.loadStream("Sounds/action.mp3")
local bkgMusicChannel

-----------------------------------------------------------------------------------------
-- LOCAL SCENE FUNCTIONS
----------------------------------------------------------------------------------------- 
 
-- When right arrow is touched, move character right
local function right (touch)
    motionx = RSPEED
    character.xScale = 1
end

-- When left arrow is touched, move character left
local function left (touch)
    motionx = LSPEED
    character.xScale = -1
end

-- When up arrow is touched, add vertical so it can jump
local function up (touch)
    if (character ~= nil) then
        character:setLinearVelocity( 0, LINEAR_VELOCITY )
    end
end

-- Move character horizontally
local function movePlayer (event)
    character.x = character.x + motionx
end
 
-- Stop character movement when no arrow is pushed
local function stop (event)
    if (event.phase =="ended") then
        motionx = 0
    end
end

local function WinScreenTransition( )
    composer.gotoScene("you_win")
end

local function PauseTransition( )
    composer.showOverlay("pause")
    character.isVisible = false
end

local function YouLoseTransition()
    composer.gotoScene( "you_lose" )
end

local function AddArrowEventListeners()
    rArrow:addEventListener("touch", right)
    uArrow:addEventListener("touch", up)
    lArrow:addEventListener("touch", left)
end

local function RemoveArrowEventListeners()
    rArrow:removeEventListener("touch", right)
    uArrow:removeEventListener("touch", up)
    lArrow:removeEventListener("touch", left)
end

local function AddRuntimeListeners()
    Runtime:addEventListener("enterFrame", movePlayer)
    Runtime:addEventListener("touch", stop )
end

local function RemoveRuntimeListeners()
    Runtime:removeEventListener("enterFrame", movePlayer)
    Runtime:removeEventListener("touch", stop )
end


local function ReplaceCharacter()
    character = display.newImageRect("Images/Character1@2x.png", 100, 150)
    character.x = display.contentWidth * 0.5 / 8
    character.y = display.contentHeight  * 2.5 / 3
    character.width = 65
    character.height = 105
    character.myName = "Character1"

    -- intialize horizontal movement of character
    motionx = 0

    -- add physics body
    physics.addBody( character, "dynamic", { density=0, friction=0.5, bounce=0, rotation=0 } )

    -- prevent character from being able to tip over
    character.isFixedRotation = true

    -- add back arrow listeners
    AddArrowEventListeners()

    -- add back runtime listeners
    AddRuntimeListeners()
end

local function MakeKeysVisible()
    key1.isVisible = true
    key2.isVisible = true
end

local function MakeHeartsVisible()
    heart1.isVisible = true
    heart2.isVisible = true
end



local function MoveZombies()
    -- move zombie2 back and forth on the platform
    zombie2.x = zombie2.x + zombie2ScrollSpeed
    if( zombie2.x > 320)then
        zombie2ScrollSpeed = -zombie2ScrollSpeed
    elseif( zombie2.x < 190) then
        zombie2ScrollSpeed = -zombie2ScrollSpeed
    end

    zombie1.x = zombie1.x + zombie1ScrollSpeed
    if( zombie1.x >940)then
        zombie1ScrollSpeed = -zombie1ScrollSpeed
    elseif( zombie1.x < 820) then
        zombie1ScrollSpeed = -zombie1ScrollSpeed
    end

    zombie3.x = zombie3.x + zombie3ScrollSpeed
    if( zombie3.x > 1024)then
        zombie3ScrollSpeed = -zombie3ScrollSpeed
    elseif(zombie3.x < 567)then
        zombie3ScrollSpeed = -zombie3ScrollSpeed
    end

end

local function MovePortal()
    portal:rotate(10)
end

local function Mute(touch)
    if(touch.phase == "ended") then
        
        --pause the sound
        bkgMusicChannel = audio.pause(bkgMusic)
        painSoundChannel = audio.pause(painSound)
        coinSoundChannel = audio.pause(coinSound)
        soundOn = false
        --hide the mute button
        muteButton.isVisible = false
        --make the unmute button isVisible
        unmuteButton.isVisible = true
    end
end

--function for when the user wants to unmute sound
local function Unmute(touch)
    if(touch.phase == "ended") then
        
        --pause the sound
        bkgMusicChannel = audio.resume(bkgMusic)
        soundOn = true
        --hide the mute button
        muteButton.isVisible = true
        --make the unmute button isVisible
        unmuteButton.isVisible = false
    end
end


local function onCollision( self, event )
    -- for testing purposes
    --print( event.target )        --the first object in the collision
    --print( event.other )         --the second object in the collision
    --print( event.selfElement )   --the element (number) of the first object which was hit in the collision
    --print( event.otherElement )  --the element (number) of the second object which was hit in the collision
    --print( event.target.myName .. ": collision began with " .. event.other.myName )

    if ( event.phase == "began" ) then

        

        if  (event.target.myName == "zombie1") or 
            (event.target.myName == "zombie2") or
            (event.target.myName == "zombie3")then


            --pain sound
            painSoundChannel = audio.play(painSound)
            
            -- remove runtime listeners that move the character
            RemoveArrowEventListeners()
            RemoveRuntimeListeners()

            -- remove the character from the display
            display.remove(character)

            -- decrease number of lives
            numLives = numLives - 1

            if (numLives == 1) then
                -- update hearts
                heart1.isVisible = true
                heart2.isVisible = false
                timer.performWithDelay(200, ReplaceCharacter) 

            elseif (numLives == 0) then
                -- update hearts
                heart1.isVisible = false
                heart2.isVisible = false
                timer.performWithDelay(200, YouLoseTransition)
            end
        end

        if  (event.target.myName == "key1") or
            (event.target.myName == "key2") or
            (event.target.myName == "key3") then

            --play the coin sound
            coinSoundChannel = audio.play(coinSound)

            -- get the ball that the user hit
            theBall = event.target

            -- stop the character from moving
            motionx = 0

            -- make the character invisible
            character.isVisible = false

            -- show overlay with math question
            composer.showOverlay( "level2_question", { isModal = true, effect = "fade", time = 100})

            -- Increment questions answered
            questionsAnswered = questionsAnswered + 1
        end

        if (event.target.myName == "portal") then
            --check to see if the user has answered 5 questions
            if (questionsAnswered == 3) then
                -- after getting 3 questions right, go to the you win screen
                WinScreenTransition()
            end
        end        

    end
end


local function AddCollisionListeners()
    -- if character collides with ball, onCollision will be called    
    key1.collision = onCollision
    key1:addEventListener( "collision" )
    key2.collision = onCollision
    key2:addEventListener( "collision" )
    key3.collision = onCollision
    key3:addEventListener( "collision" )

    zombie1.collision = onCollision
    zombie1:addEventListener( "collision" )
    zombie2.collision = onCollision
    zombie2:addEventListener( "collision" )
    zombie3.collision = onCollision
    zombie3:addEventListener( "collision" )

    portal.collision = onCollision
    portal:addEventListener( "collision" )
end

local function RemoveCollisionListeners()

    key1:removeEventListener( "collision" )
    key2:removeEventListener( "collision" )
    key3:removeEventListener( "collision" )

    zombie1:removeEventListener( "collision" )
    zombie2:removeEventListener( "collision" )
    zombie3:removeEventListener( "collision" )

    portal:addEventListener( "collision" )


end

local function AddPhysicsBodies()
    --add to the physics engine
    physics.addBody( platform1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform3, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( platform4, "static", { density=1.0, friction=0.3, bounce=0.2 } )


    physics.addBody(leftW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(topW, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(floor, "static", {density=1, friction=0.3, bounce=0.2} )
    physics.addBody(rightW, "static", {density=1, friction=0.3, bounce=0.2} )


    physics.addBody(key1, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(key2, "static",  {density=0, friction=0, bounce=0} )
    physics.addBody(key3, "static",  {density=0, friction=0, bounce=0} )

    physics.addBody( zombie1platform, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( zombie2platform, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody( zombie1, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( zombie2, "static", { density=1.0, friction=0.3, bounce=0.2 } )
    physics.addBody( zombie3, "static", { density=1.0, friction=0.3, bounce=0.2 } )

    physics.addBody(portal, "static", {density=1, friction=0.3, bounce=0.2})
    physics.addBody(portalPlatform, "static", {density=1, friction=0.3, bounce=0.2})


end

local function RemovePhysicsBodies()
    physics.removeBody(platform1)
    physics.removeBody(platform2)
    physics.removeBody(platform3)
    physics.removeBody(platform4)

    physics.removeBody(leftW)
    physics.removeBody(topW)
    physics.removeBody(floor)
    physics.removeBody(rightW)

    physics.removeBody(zombie1)
    physics.removeBody(zombie2)
    physics.removeBody(zombie3)

    physics.removeBody(zombie1platform)
    physics.removeBody(zombie2platform)

    physics.removeBody(portal)
    physics.removeBody(portalPlatform)

 
end

-----------------------------------------------------------------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------------------------------------------------------------

function ResumeLevel2()

    -- make character visible again
    character.isVisible = true
    
    if (questionsAnswered > 0) then
        if (theBall ~= nil) and (theBall.isBodyActive == true) then
            physics.removeBody(theBall)
            theBall.isVisible = false
        end
    end

end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- Insert the background image
    bkg_image = display.newImageRect("Images/Level2ScreenHunter@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentWidth / 2 
    bkg_image.y = display.contentHeight / 2

    -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    
    
    -- Insert the platforms
    platform1 = display.newImageRect("Images/Level1PlatformHunter.png", 200, 50)
    platform1.x = display.contentWidth * 0.7 / 8
    platform1.y = display.contentHeight * 1.6 / 4
        
    sceneGroup:insert( platform1 )

    platform2 = display.newImageRect("Images/Level1PlatformHunter.png", 175, 50)
    platform2.x = display.contentWidth* 1.2 /2
    platform2.y = display.contentHeight * 1.4/ 4
        
    sceneGroup:insert( platform2 )

    platform3 = display.newImageRect("Images/Level1PlatformHunter.png", 180, 50)
    platform3.x = display.contentWidth *3.8 / 5
    platform3.y = display.contentHeight * 3.8 / 5
        
    sceneGroup:insert( platform3 )

    platform4 = display.newImageRect("Images/Level1PlatformHunter.png", 180, 50)
    platform4.x = display.contentWidth *4.3 / 5
    platform4.y = display.contentHeight * 2.5/ 5
        
    sceneGroup:insert( platform4 )
    
    zombie1 = display.newImageRect("Images/Zombie@2x.png", 75, 125)
    zombie1.x = display.contentWidth * 4.3 / 5
    zombie1.y = display.contentHeight * 1.95 / 5
    zombie1.myName = "zombie1"
        
    sceneGroup:insert( zombie1)

    zombie1platform = display.newImageRect("Images/Level1PlatformHunter.png", 200, 50)
    zombie1platform.x = display.contentWidth * 3.5 / 8
    zombie1platform.y = display.contentHeight * 3 / 5
        
    sceneGroup:insert(zombie1platform)

    zombie2 = display.newImageRect("Images/Zombie@2x.png", 75, 125)
    zombie2.x = display.contentWidth * 2 / 8   
    zombie2.y = display.contentHeight * 3.15 / 5
    zombie2.myName = "zombie2"
        
    sceneGroup:insert( zombie2 )

    zombie2platform = display.newImageRect("Images/Level1PlatformHunter.png", 200, 50)
    zombie2platform.x = display.contentWidth * 2/ 8
    zombie2platform.y = display.contentHeight * 3.7/ 5
        
    sceneGroup:insert( zombie2platform)

    zombie3 = display.newImageRect("Images/Zombie@2x.png", 75, 125)
    zombie3.x = 700  
    zombie3.y = 695
    zombie3.myName = "zombie3"

    sceneGroup:insert( zombie3 )

    --Creating the mute button
    muteButton = display.newImageRect("Images/MuteButtonUnpressedHunterC.png", 200, 200)
    muteButton.x = 740
    muteButton.y = 120
    muteButton.isVisible = true
    muteButton.width = 75
    muteButton.height = 75

    sceneGroup:insert( muteButton )

    --------------------------------------------------------------------------------------------
    --Creating the unmute button
    unmuteButton = display.newImageRect("Images/MuteButtonPressedHunterC.png", 200, 200)
    unmuteButton.x = 740
    unmuteButton.y = 120
    unmuteButton.isVisible = false
    unmuteButton.width = 75
    unmuteButton.height = 75

    sceneGroup:insert( unmuteButton )


    portalPlatform = display.newImageRect("Images/Level1PlatformHunter.png", 250, 50)
    portalPlatform.x = display.contentWidth * 1.8 / 2
    portalPlatform.y = display.contentHeight *0.5 / 2

    sceneGroup:insert( portalPlatform )

    --insert the portal
    portal = display.newImage("Images/PortalNate@2x.png", 50, 50)
    portal.x = display.contentWidth* 4.5 / 5
    portal.y = display.contentHeight * 0.6/ 5
    portal.width = 125
    portal.height = 125
    portal.myName = "portal"


    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( portal )

    -- Insert the Hearts
    heart1 = display.newImageRect("Images/HeartHunter@2x.png", 80, 80)
    heart1.x = 50
    heart1.y = 50
    heart1.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart1 )

    heart2 = display.newImageRect("Images/HeartHunter@2x.png", 80, 80)
    heart2.x = 130
    heart2.y = 50
    heart2.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( heart2 )

    --Insert the right arrow
    rArrow = display.newImageRect("Images/RightArrowUnpressed@2x.png", 100, 50)
    rArrow.x = display.contentWidth * 9.2 / 10
    rArrow.y = display.contentHeight * 9.5 / 10
   
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rArrow)

    --Insert the left arrow
    uArrow = display.newImageRect("Images/UpArrowUnpressed@2x.png", 50, 100)
    uArrow.x = display.contentWidth * 8.2 / 10
    uArrow.y = display.contentHeight * 8.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( uArrow)

    -- insert the left arrow
    lArrow = display.newImageRect("Images/LeftArrowUnpressed@2x.png", 100, 50)
    lArrow.x = display.contentWidth * 7.2 / 10
    lArrow.y = display.contentHeight * 9.5 / 10

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( lArrow )    

    --WALLS--
    leftW = display.newLine( 0, 0, 0, display.contentHeight)
    leftW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( leftW )

    rightW = display.newLine( 0, 0, 0, display.contentHeight)
    rightW.x = display.contentCenterX * 2
    rightW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( rightW )

    topW = display.newLine( 0, 0, display.contentWidth, 0)
    topW.isVisible = true

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( topW )

    floor = display.newImageRect("Images/Floor@2x.png", 1024, 100)
    floor.x = display.contentCenterX
    floor.y = display.contentHeight * 1.05
    
    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( floor )

    --key1
    key1 = display.newImageRect ("Images/KeyObjectNate@2x.png", 100, 70)
    key1.x = 780
    key1.y = 520
    key1.myName = "key1"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( key1 )

    --key2
    key2 = display.newImageRect ("Images/KeyObjectNate@2x.png", 100, 70)
    key2.x = 100
    key2.y = 250
    key2.myName = "key2"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( key2 )

    key3 = display.newImageRect ("Images/KeyObjectNate@2x.png", 100, 70)
    key3.x = display.contentWidth * 3 / 5
    key3.y = display.contentHeight * 1.35 / 5
    key3.myName = "key3"

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( key3 )

    -----------------------------------------------------------------------------------------
    -- WIDGETS
    -----------------------------------------------------------------------------------------

    --create the pause button
    pauseButton = widget.newButton(
    {
        --setting the position
        x = 740,
        y = 50,

        -- creating the button
        defaultFile = "Images/PauseButtonUnpressed.png",
        overFile = "Images/PauseButtonPressedHunter.png",

        onRelease = PauseTransition
    } )

    sceneGroup:insert( pauseButton )

    pauseButton.width = 60
    pauseButton.height = 60

end --function scene:create( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then

        -- Called when the scene is still off screen (but is about to come on screen).
    -----------------------------------------------------------------------------------------
        -- start physics
        physics.start()

        -- set gravity
        physics.setGravity( 0, GRAVITY )

    elseif ( phase == "did" ) then

        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

        numLives = 2
        questionsAnswered = 0
        bkgMusicChannel = audio.play( bkgMusic, {channel = 1, loops = -1} )


        -- make all Keys visible
        MakeKeysVisible()

        -- make all hearts visible
        MakeHeartsVisible()

        -- add physics bodies to each object
        AddPhysicsBodies()

        -- add collision listeners to objects
        AddCollisionListeners()

        -- create the character, add physics bodies and runtime listeners
        ReplaceCharacter()

        Runtime:addEventListener("enterFrame", MovePortal)
        Runtime:addEventListener("enterFrame", MoveZombies)
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", Unmute)



    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        RemoveCollisionListeners()
        RemovePhysicsBodies()

        physics.stop()
        RemoveArrowEventListeners()
        RemoveRuntimeListeners()
        display.remove(character)

        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
        Runtime:removeEventListener("enterFrame", MovePortal)
        Runtime:removeEventListener("enterFrame", MoveZombies)

        audio.stop(bkgMusicChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.

end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene