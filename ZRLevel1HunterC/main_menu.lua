-----------------------------------------------------------------------------------------
--
-- main_menu.lua
-- Created by: Hunter Connolly
-- Date: November 11, 2019
-- Description: This is the Main Menu screen of the game.
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Use Widget Library
local widget = require( "widget")
-- Name the Scene
sceneName = "main_menu"

-- Create Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------------------------------

local bkg_image
local playButton
local instructionsButton

local muteButton
local unmuteButton

-----------------------------------------------------------------------------------------
--LOCAL SOUNDS
-----------------------------------------------------------------------------------------

-- the background music
local bkgMusic = audio.loadSound("Sounds/bkgMusic.mp3")
local bkgMusicChannel = audio.play( bkgMusic, {channel = 1, loops = -1} )

-----------------------------------------------------------------------------------------
--GLOBAL VARIABLES
-----------------------------------------------------------------------------------------
soundOn = true

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

--Creating transition Function to when going to credits screen
local function CreditsTransition( )
    composer.gotoScene( "credits_screen", {effect = "slideLeft", time = 500 })
end
-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function LevelSelectTransition( )
    composer.gotoScene( "level_select", {effect = "zoomOutInFade", time = 500})
    audio.stop(bkgMusicChannel)
end    

-- INSERT LOCAL FUNCTION DEFINITION THAT GOES TO INSTRUCTIONS SCREEN 
--------------------------------------------------------------------------------------------
--creating the transition to the instructions screen
local function InstructionsTransition()
    composer.gotoScene("instructions", {effect = "slideRight", time = 500})
end
--------------------------------------------------------------------------------------------
--function for when the user wants to mute sound
local function Mute(touch)
    if(touch.phase == "ended") then
        
        --pause the sound
        bkgMusicChannel = audio.pause(bkgMusic)
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

--------------------------------------------------------------------------------------------

-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    --------------------------------------------------------------------------------------------
    --BACKGROUND IMAGES
    -----------------------------------------------------------------------------------------
    bkg_image = display.newImage("Images/MainMenuNate.png")
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight    



    --------------------------------------------------------------------------------------------
    --Creating the mute button
    muteButton = display.newImageRect("Images/MuteButtonUnpressedHunterC.png", 200, 200)
    muteButton.x = display.contentWidth*2/16
    muteButton.y = display.contentHeight*4/8
    muteButton.isVisible = true

    --------------------------------------------------------------------------------------------
    --Creating the unmute button
    unmuteButton = display.newImageRect("Images/MuteButtonPressedHunterC.png", 200, 200)
    unmuteButton.x = display.contentWidth*2/16
    unmuteButton.y = display.contentHeight*4/8
    unmuteButton.isVisible = false

    --------------------------------------------------------------------------------------------
    --BUTTON WIDGETS
    -----------------------------------------------------------------------------------------

    --Creating the play BUTTON
    playButton = widget.newButton(
        {
            -- set the x and y position
            x = display.contentWidth*14/16,
            y = display.contentHeight*4/8,

            -- insert the image
            defaultFile = "Images/PlayButtonUnpressedHunterC.png",
            overFile = "Images/PlayButtonPressedHunterC.png",

            -- when the button is released it will go to the level 1 screen
            onRelease = LevelSelectTransition

        })


    -----------------------------------------------------------------------------------------

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = display.contentWidth*14/16,
            y = display.contentHeight*6.5/8,

            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedNate.png",
            overFile = "Images/CreditsButtonPressedNate.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
    
    --scale the button to be half the original size

    ---------------------------------------------------------------------------------------------------
    -- creating instructions button
    instructionsButton = widget.newButton(
        {
            --set its position on the screen relative to the screen size
            x = display.contentWidth*2/16,
            y = display.contentHeight*6.5/8,

            -- set the size 

            -- Insert the images here
            defaultFile = "Images/InstructionsButtonUnpressedNate.png",
            overFile = "Images/InstructionsButtonPressedNate.png",

            -- When the button is released, call the Credits transition function
            onRelease = InstructionsTransition
        } )
    --scale the button to be half the original size

    
    -----------------------------------------------------------------------------------------
    

    -- Associating display objects with this scene 
    sceneGroup:insert( bkg_image )
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )


end -- function scene:create( event )

--------------------------------------------------------------------------------------------

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

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        muteButton:removeEventListener("touch", Mute)
        unmuteButton:removeEventListener("touch", Unmute)
        
        audio.stop(bkgMusic)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------   
end 

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
