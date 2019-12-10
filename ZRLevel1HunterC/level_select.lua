-----------------------------------------------------------------------------------------
--
-- level_select.lua
-- Created by: Hunter Connolly
-- Date: November 19, 2019
-- Description: This is the level select screen of the game, it is where
--the user chooses the level they would like to enter
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )
local widget = require( "widget" )

-- Name the Scene
sceneName = "level_select"
------------------------------------------------------------------------------------------

-- create Scene Object
local scene = composer.newScene( sceneName )

------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
------------------------------------------------------------------------------------------

local level2Button
local backButton
------------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
------------------------------------------------------------------------------------------
-- When the backButton is clicked this function is called 
local function MainMenuTransition( )
    composer.gotoScene( "main_menu", {effect = "slideLeft", time = 500 })
end

local function Level2Transition( )
    composer.gotoScene( "level2_screen", {effect = "flipFadeOutIn", time = 500})
end

local function Level1Transition( )
    composer.gotoScene( "level1_screen", {effect = "fade", time = 500})
end
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- creating the background
    bkg_image = display.newImage("Images/LevelSelectScreen@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight    

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Creating the level 1 button
   level1Button = widget.newButton(
        {
            -- set the x and y position
            x = display.contentWidth*1/4,
            y = display.contentHeight/2,

            -- insert the image
            defaultFile = "Images/Level1ButtonUnpressedHunter@2x.png",
            overFile = "Images/Level1ButtonPressedHunter@2x.png",

            -- when the button is released it will go to the level 1 screen
            onRelease = Level2Transition

        })

    level1Button.width = 250
    level1Button.height = 250
   
   -- Creating the level 2 button
   level2Button = widget.newButton(
        {
            -- set the x and y position
            x = display.contentWidth/2,
            y = display.contentHeight/2,

            -- insert the image
            defaultFile = "Images/Level2ButtonUnpressedHunter@2x.png",
            overFile = "Images/Level2ButtonPressedHunter@2x.png",

            -- when the button is released it will go to the level 1 screen
            onRelease = Level2Transition

        })
   
   level2Button.width = 250
   level2Button.height =250

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
    sceneGroup:insert( level2Button )
    sceneGroup:insert( level1Button )

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

