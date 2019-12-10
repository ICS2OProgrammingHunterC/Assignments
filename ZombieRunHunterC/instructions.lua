-----------------------------------------------------------------------------------------
--
-- instructions.lua
-- Created by: Hunter Connolly
-- Date: November 19, 2019
-- Description: This is the instructions screen of the game
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )
local widget = require( "widget" )

-- Name the Scene
sceneName = "instructions"
------------------------------------------------------------------------------------------

-- create Scene Object
local scene = composer.newScene( sceneName )

------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------
-- When the backButton is clicked this function is called 
local function MainMenuTransition( )
    composer.gotoScene( "main_menu", {effect = "slideLeft", time = 500 })
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    --creating the background
    bkg_image = display.newImage("Images/InstructionsScreenNate.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight    

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()
   

    --Creating the back BUTTON
    backButton = widget.newButton(
        {
            -- set the x and y position
            x = display.contentWidth*0.2/2,
            y = display.contentHeight*2.8/3,

            -- insert the image
            defaultFile = "Images/BackButtonUnpressedNate.png",
            overFile = "Images/BackButtonPressedNate.png",

            -- when the button is released it will go to the level 1 screen
            onRelease = MainMenuTransition

        })


    -----------------------------------------------------------------------------------------

    -- Associating button widgets with this scene
    sceneGroup:insert( backButton )

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

