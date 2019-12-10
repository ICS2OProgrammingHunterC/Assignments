-----------------------------------------------------------------------------------------
--
-- level2_question.lua
-- Created by: Hunter Connolly
-- Date: November 13, 2019
-- Description: This is the level 2 question screen of the game. 

-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Libraries
local composer = require( "composer" )
local widget = require( "widget" )
local physics = require( "physics")


-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "level2_question"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- The local variables for this scene
local questionText

local questionSelection

local answerText 
local wrongText1
local wrongText2
local wrongText3

local answerPosition = 1
local bkg
local cover

local X1 = display.contentWidth*2/7
local X2 = display.contentWidth*4/7
local Y1 = display.contentHeight*1/2
local Y2 = display.contentHeight*5.5/7

local textTouched = false

local correctObject
local incorrectObject

-----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------
local correctSound = audio.loadSound("Sounds/correct.mp3")
local correctSoundChannel

local incorrectSound = audio.loadSound("Sounds/incorrect.mp3")
local incorrectSoundChannel 

-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------


--making transition to next scene
local function BackToLevel2() 
    composer.hideOverlay("crossFade", 400 )
  
    ResumeLevel2()
end 


--Function for when the user gets the answer correct it will display a text saying correct and will dissappear after 1.5 seconds
local function HideCorrect()
    correctObject.isVisible = false
    BackToLevel2( )
end

local function HideIncorrect()
    incorrectObject.isVisible = false
    BackToLevel2( )
end

-----------------------------------------------------------------------------------------
--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerAnswer(touch)

    if (touch.phase == "ended") then
        
        correctObject.isVisible = true
        -- play the correct sound 
        correctSoundChannel = audio.play(correctSound)
        timer.performWithDelay(1500, HideCorrect)    
    end 
end


--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer(touch)
    
    if (touch.phase == "ended") then
        
        BackToLevel2( )

        incorrectSoundChannel = audio.play(incorrectSound)

        incorrectObject.isVisible = true
        timer.performWithDelay(1500, HideIncorrect)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    
    if (touch.phase == "ended") then

        BackToLevel2( )

        incorrectSoundChannel = audio.play(incorrectSound)

        incorrectObject.isVisible = true
        timer.performWithDelay(1500, HideIncorrect)


        
    end 
end

local function TouchListenerWrongAnswer3(touch)
    
    if (touch.phase == "ended") then

        BackToLevel2( )

        incorrectSoundChannel = audio.play(incorrectSound)

        incorrectObject.isVisible = true
        timer.performWithDelay(1500, HideIncorrect)
        
    end 
end


--adding the event listeners 
local function AddTextListeners ( )
    answerText:addEventListener( "touch", TouchListenerAnswer )
    wrongText1:addEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:addEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:addEventListener( "touch", TouchListenerWrongAnswer3)
end

--removing the event listeners
local function RemoveTextListeners()
    answerText:removeEventListener( "touch", TouchListenerAnswer )
    wrongText1:removeEventListener( "touch", TouchListenerWrongAnswer)
    wrongText2:removeEventListener( "touch", TouchListenerWrongAnswer2)
    wrongText3:removeEventListener( "touch", TouchListenerWrongAnswer3)
end

local function DisplayQuestion()
    --creating random numbers
    questionSelection = math.random (1,7)

    if(questionSelection == 1) then

        --Make the question
        questionText.text = "What is the Smallest Planet\nin our solar System?"

        --creating answer text
        answerText.text = "Mercury"
        
        --creating wrong answers
        wrongText1.text = "Pluto"
        wrongText2.text = "Mars"
        wrongText3.text = "Earth"

    elseif(questionSelection == 2)then

        --Making the question
        questionText.text = "What is the Biggest Planet\nin our solar System?"

        answerText.text = "Jupiter"

        --creating wrong answers
        wrongText1.text = "Mercury"
        wrongText2.text = "Mars"
        wrongText3.text = "Saturn"
    elseif(questionSelection == 3) then

        --making the question
        questionText.text = "What Planet is Closest to\nthe sun?"

        -- creating the answer
        answerText.text = "Mercury"

        -- creating the wrong answer
        wrongText1.text = "Venus"
        wrongText2.text = "Uranus"
        wrongText3.text = "Mars"
    elseif(questionSelection == 4)then

        --Creating the question
        questionText.text = "How many Planets are there\nin our Solor System?"

        -- creating the answer
        answerText.text = "8"

        -- creating the wrong answer
        wrongText1.text = "7"
        wrongText2.text = "11"
        wrongText3.text = "5"
    elseif(questionSelection == 5)then

        --create the question
        questionText.text = "What Planet is Farthest\nfrom the Sun?"

        -- create the answer 
        answerText.text = "Neptune"

        wrongText1.text = "Uranus"
        wrongText2.text = "Mars"
        wrongText3.text = "Venus"
    elseif(questionSelection == 6) then

        --create the question
        questionText.text = "The Sun is"

        -- create the answer
        answerText.text ="a Star"

        -- create the wrong answer
        wrongText1.text = "a Planet"
        wrongText2.text = "a Comet"
        wrongText3.text = "an Asteroid"
    elseif(questionSeelction == 7)then

        --create the question
        questionText.text = "Which of these is not a Planet?"

        answerText.text = "Pluto"

        wrongText1.text = "Venus"
        wrongText2.text = "Mars"
        wrongText3.text = "Jupiter"
    end
end




local function PositionAnswers()

    --creating random start position in a cretain area
    answerPosition = math.random(1,3)

    if (answerPosition == 1) then

        answerText.x = X1
        answerText.y = Y1
        
        wrongText1.x = X2
        wrongText1.y = Y1
        
        wrongText2.x = X1
        wrongText2.y = Y2

        wrongText3.x = X2
        wrongText3.y = Y2

        
    elseif (answerPosition == 2) then

        answerText.x = X1
        answerText.y = Y2
            
        wrongText1.x = X1
        wrongText1.y = Y1
            
        wrongText2.x = X2
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y2


    elseif (answerPosition == 3) then

        answerText.x = X2
        answerText.y = Y1
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y2
    elseif (answerPosition == 4) then

        answerText.x = X2
        answerText.y = Y2
            
        wrongText1.x = X1
        wrongText1.y = Y2
            
        wrongText2.x = X1
        wrongText2.y = Y1

        wrongText3.x = X2
        wrongText3.y = Y1
            
    end
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
    cover = display.newRoundedRect(display.contentCenterX, display.contentCenterY, display.contentWidth*0.8, display.contentHeight*0.95, 50 )
    --setting its colour
    cover:setFillColor(153/255, 0/255, 0/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 60)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 50)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 50)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X1, Y1, Arial, 50)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X2, Y1, Arial, 50)
    wrongText3.anchorX = 0

    correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*1/3, Arial, 50)
    correctObject.anchorX = 0
    correctObject.isVisible = false
    correctObject:setFillColor(0,1,0)

    incorrectObject = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*1/3, Arial, 50)
    incorrectObject.anchorX = 0
    incorrectObject.isVisible = false
    incorrectObject:setFillColor(1,0,0)
    -----------------------------------------------------------------------------------------

    -- insert all objects for this scene into the scene group
    sceneGroup:insert(bkg)
    sceneGroup:insert(cover)
    sceneGroup:insert(questionText)
    sceneGroup:insert(answerText)
    sceneGroup:insert(wrongText1)
    sceneGroup:insert(wrongText2)
    sceneGroup:insert(wrongText3)


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
        DisplayQuestion()
        PositionAnswers()
        AddTextListeners()
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
        RemoveTextListeners()
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