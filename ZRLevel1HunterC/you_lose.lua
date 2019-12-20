-----------------------------------------------------------------------------------------
--
-- you_lose.lua
-- Created by: Hunter Connolly
-- Date: November 6, 2019
-- Description: This is the losing screen of the game.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Use Widget Library
local widget = require( "widget")


-- Name the Scene
sceneName = "you_lose"
------------------------------------------------------------------------------------------

-- create Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------
local function MainMenuTransition ()
    composer.gotoScene("main_menu", {effect = "slideRight", time = 500 })
end

local function RestartTransition ()
    if(currentLevel == 2)then
        composer.gotoScene("level2_screen", {effect = "fade", time = 500 })
    elseif(currentLevel == 4)then
        composer.gotoScene("level4_screen", {effect = "fade", time = 500 })
    end
end
-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local youLoseSound = audio.loadSound("Sounds/lose.mp3")
local youLoseSoundChannel
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    --------------------------------------------------------------------------------------------
    --BACKGROUND IMAGES
    -----------------------------------------------------------------------------------------
    -- this is the background of the screen
    bkg_image = display.newImage("Images/YouLoseNate@2x.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight   

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()
    
    --------------------------------------------------------------------------------------------
    --BUTTON WIDGETS
    -----------------------------------------------------------------------------------------
    mainMenuButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth*0.5/5,
            y = display.contentHeight*7.5/8,

            -- Insert the images here
            defaultFile = "Images/MainMenuButtonUnpressedHunter@2x.png",
            overFile = "Images/MainMenuButtonPressedHunter@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = MainMenuTransition
        } )  
    -- change the size of the button
    mainMenuButton.width = 200
    mainMenuButton.height = 100

    sceneGroup:insert(mainMenuButton)

    restartButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth*4.5/5,
            y = display.contentHeight*7.5/8,

            -- Insert the images here
            defaultFile = "Images/RestartButtonUnpressedHunter@2x.png",
            overFile = "Images/RestartButtonPressedHunter@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = RestartTransition
        } )  
    -- change the size of the button
    restartButton.width = 200
    restartButton.height = 100

    sceneGroup:insert(restartButton)
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
        youLoseSoundChannel = audio.play(youLoseSound)
        
                
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

