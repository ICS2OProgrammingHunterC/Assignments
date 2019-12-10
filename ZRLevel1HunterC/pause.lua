-----------------------------------------------------------------------------------------
--
-- pause.lua
-- Created by: Hunter Connolly
-- Date: November 13, 2019
-- Description: This is the pause overlay of the game. 

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "pause"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local bkg
local cover

-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function InstructionsTransition( )
    composer.gotoScene("instructions", {effect = "slideUp", time = 500})
end

local function MainMenuTransition( )
    composer.gotoScene("main_menu", {effect = "slideRight", time = 500 })
end

local function BackToLevel2() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeLevel2()
end 

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view  

    -----------------------------------------------------------------------------------------
    --covering the other scene with a rectangle so it looks faded and stops touch from going through
    bkg = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --setting to a semi black colour
    bkg:setFillColor(0,0,0,0.5)

    -----------------------------------------------------------------------------------------
    --making a cover rectangle to have the background fully bolcked where the question is
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.5, display.contentHeight*0.7, 50 )
    --setting its colour
    cover:setFillColor(0/255, 0/255, 255/255)
    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)

    -----------------------------------------------------------------------------------------
    --WIDGETS
    -----------------------------------------------------------------------------------------
        instructionsButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*4/8,

            -- set the size 

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedNate.png",
            overFile = "Images/InstructionsButtonPressedNate.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } )   

        instructionsButton.width = 270
        instructionsButton.height = 140


        mainMenuButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*5.5/8,

            -- set the size 

            -- Insert the images here
            defaultFile = "Images/MainMenuButtonUnpressedHunter@2x.png",
            overFile = "Images/MainMenuButtonPressedHunter@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = MainMenuTransition
        } )  

        mainMenuButton.width = 270
        mainMenuButton.height = 140

        resumeButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth/2,
            y = display.contentHeight*2.5/8,

            -- Insert the images here
            defaultFile = "Images/ResumeButtonHunter@2x.png",
            overFile = "Images/ResumeButtonPressedHunter@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = BackToLevel2
        } )  

        resumeButton.width = 270
        resumeButton.height = 140


    sceneGroup:insert( mainMenuButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( resumeButton )

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

    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.

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
        --parent:resumeGame()
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
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