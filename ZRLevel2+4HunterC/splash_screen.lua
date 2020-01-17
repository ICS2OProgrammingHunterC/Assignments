-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Hunter Connolly
-- Date: November 6, 2019
-- Description: This is the splash screen of the game. It displays the 
-- company logo that spins across the screen
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"
------------------------------------------------------------------------------------------

-- create Scene Object
local scene = composer.newScene( sceneName )

------------------------------------------------------------------------------------------

-- the local variables for this scene
local helicopter
local scrollXSpeed = 3
local scrollYSpeed = -8
local wooshSounds = audio.loadSound("Sounds/helicopter.mp3")
local wooshSoundsChannel

------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------
-- The function that moves the helicopter across the screen
local function moveHelicopter()
    helicopter.x = helicopter.x + scrollXSpeed
    helicopter.y = helicopter.y + scrollYSpeed
    --make the image rotate
    helicopter:rotate(40)
end

-- This is the funstion that goes to the second splash screen
local function gotoSplash_Screen2()
    composer.gotoScene( "splash_screen2", {effect = "fromTop", time = 500} )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 1, 1, 1)

    -- Insert the beetleship image
    helicopter = display.newImageRect("Images/CompanyLogoHunter@2x.png", 450, 300)

    -- set the initial x and y position of the beetleship
    helicopter.x = display.contentWidth/2
	helicopter.y = 768

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( helicopter )

end -- function scene:create( event )


-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- start the splash screen music
        wooshSoundsChannel = audio.play(wooshSounds )

        -- Call the moveBeetleship function as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", moveHelicopter)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 3000, gotoSplash_Screen2)    
                
    end
end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  
        -- stop the jungle sounds channel for this screen
        audio.stop(wooshSoundsChannel)
        Runtime:removeEventListener("enterFrame", moveHelicopter)

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        
  

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

