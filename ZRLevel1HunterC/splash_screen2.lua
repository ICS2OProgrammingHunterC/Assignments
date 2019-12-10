-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Hunter Connolly
-- Date: November 6, 2019
-- Description: This is the second splash screen of the game. It displays the 
-- company logo clearly for all users to see
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen2"

--load the physics
local physics = require("physics")


------------------------------------------------------------------------------------------

-- create Scene Object
local scene = composer.newScene( sceneName )

------------------------------------------------------------------------------------------
--LOCAL VARIABLES
------------------------------------------------------------------------------------------

local helicopter
local beam

------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
------------------------------------------------------------------------------------------
-- this function calls the screen to go to the main menu
local function gotoMainMenu()
    composer.gotoScene( "main_menu", {effect = "fade", time = 500 })

end



------------------------------------------------------------------------------------------
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 1, 1, 1)

	-- create the helicopter
    helicopter = display.newImage("Images/CompanyLogoHunter@2x.png", 250, 100)

    --set the x and y coordinates of the image
    helicopter.x = display.contentWidth/2
    helicopter.y = 0
 
    --scale the image to the proper size
    helicopter:scale(0.4,0.35)

    beam = display.newRect(0, 0, display.contentWidth, display.contentHeight*1/8)
    
    -- set the color of the beam to be invisible
    beam:setFillColor(1,1,1)

    --set the x and y positioning of the beam
    beam.x = display.contentWidth/2
    beam.y = display.contentHeight*7/8

    --make the beam the width of the screen
    beam.width = display.contentWidth

    sceneGroup:insert( helicopter )
    sceneGroup:insert( beam )
end

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
        -- start physics
        physics.start()
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then  
        -- add the physics
        
        physics.addBody(helicopter, {density = 2.0, friction = 0.5, bounce = 0.3, radius = 260})
        -- make the beam have physics
        physics.addBody(beam, "static", {friction = 0.5, bounce = 0.5})
        timer.performWithDelay(3000, gotoMainMenu)

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
        physics.removeBody(helicopter)
        -- make the beam have physics
        physics.removeBody(beam)


    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        physics.stop()
        timer.performWithDelay(3000, gotoMainMenu)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    helicopter.isVisible = false
    beam.isVisible = false
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



