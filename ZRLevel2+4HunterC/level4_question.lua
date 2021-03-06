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
sceneName = "level4_question"

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
local function BackToLevel4() 
    composer.hideOverlay("crossFade", 400 )
    
    ResumeLevel4()
end 


--Function for when the user gets the answer correct it will display a text saying correct and will dissappear after 1.5 seconds
local function HideCorrect()
    correctObject.isVisible = false
    BackToLevel4( )
end

local function HideIncorrect()
    incorrectObject.isVisible = false
    BackToLevel4( )
end

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
        

        incorrectSoundChannel = audio.play(incorrectSound)

        --display the inocrrect object
        incorrectObject.isVisible = true

        incorrectObject.text = "Incorrect! The correct answer\nis " .. answerText.text .. "."

        timer.performWithDelay(1500, HideIncorrect)
    end 
end

--checking to see if the user pressed the right answer and bring them back to level 1
local function TouchListenerWrongAnswer2(touch)
    
    if (touch.phase == "ended") then

        incorrectSoundChannel = audio.play(incorrectSound)

        incorrectObject.text = "Incorrect! The correct answer\nis " .. answerText.text 


        incorrectObject.isVisible = true
        timer.performWithDelay(1500, HideIncorrect)


        
    end 
end

local function TouchListenerWrongAnswer3(touch)
    
    if (touch.phase == "ended") then

        incorrectSoundChannel = audio.play(incorrectSound)

        incorrectObject.text = "Incorrect! The correct answer\nis " .. answerText.text 


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
    questionSelection = math.random (1,9)

    if(questionSelection == 1) then

        --Make the question
        questionText.text = "Plants use energy from the\n________ to make food"

        --creating answer text
        answerText.text = "Sun"
        
        --creating wrong answers
        wrongText1.text = "Oxygen"
        wrongText2.text = "Soil"
        wrongText3.text = "Water"

    elseif(questionSelection == 2)then

        --Making the question
        questionText.text = "Which of these is a part\n of a Plant?"

        answerText.text = "Stem"

        --creating wrong answers
        wrongText1.text = "Stick"
        wrongText2.text = "Oxygen"
        wrongText3.text = "Sun"
    elseif(questionSelection == 3) then

        --making the question
        questionText.text = "The plant parts that take \nin water and minerals from the\nsoil are?"

        -- creating the answer
        answerText.text = "Roots"

        -- creating the wrong answer
        wrongText1.text = "Stem"
        wrongText2.text = "Leaves"
        wrongText3.text = "Flower"
    elseif(questionSelection == 4)then

        --Creating the question
        questionText.text = "What is the first stage in\nthe growth of many plants??"

        -- creating the answer
        answerText.text = "Seeds"

        -- creating the wrong answer
        wrongText1.text = "Oxygen"
        wrongText2.text = "Water"
        wrongText3.text = "Photosynthesis"
    elseif(questionSelection == 5)then

        --create the question
        questionText.text = "Photosynthesis is how plants\nmake their own ________?"

        -- create the answer 
        answerText.text = "Food"

        wrongText1.text = "Water"
        wrongText2.text = "Roots"
        wrongText3.text = "Seeds"
    elseif(questionSelection == 6) then

        --create the question
        questionText.text = "An average size tree can\nprovide enough wood to make\nhow many pencils?"

        -- create the answer
        answerText.text ="170,000"

        -- create the wrong answer
        wrongText1.text = "30,000"
        wrongText2.text = "250,000"
        wrongText3.text = "150,000"
    elseif(questionSelection == 7)then

        --create the question
        questionText.text = "What percent of plant life is\nfound in the ocean?"

        answerText.text = "85%"

        wrongText1.text = "25%"
        wrongText2.text = "43%"
        wrongText3.text = "10%"
    elseif(questionSelection == 8)then

        --create the question
        questionText.text = "What is the total number of plant\nspecies identified?"

        answerText.text = "300,000+"

        wrongText1.text = "100,000"
        wrongText2.text = "250,000"
        wrongText3.text = "200,000"
    elseif(questionSelection == 9)then
        --create the question
        questionText.text = "What is 1 thing a plant needs\nto survive?"

        answerText.text = "Air"

        wrongText1.text = "MoonLight"
        wrongText2.text = "Wood"
        wrongText3.text = "Candy"
    elseif(questionSelection == 10)then
        --create the question
        questionText.text = "What is 1 thing a plant needs\nto survive?"

        answerText.text = "Sun"

        wrongText1.text = "MoonLight"
        wrongText2.text = "Wood"
        wrongText3.text = "Dirt"
    elseif(questionSelection == 11)then
        --create the question
        questionText.text = "What is 1 thing a plant needs\nto survive?"

        answerText.text = "Water"

        wrongText1.text = "Sand"
        wrongText2.text = "Wood"
        wrongText3.text = "Dirt"
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
    cover:setFillColor(0/255, 102/255, 0/255)

    -- create the question text object
    questionText = display.newText("", display.contentCenterX, display.contentCenterY*3/8, Arial, 50)

    -- create the answer text object & wrong answer text objects
    answerText = display.newText("", X1, Y2, Arial, 40)
    answerText.anchorX = 0
    wrongText1 = display.newText("", X2, Y2, Arial, 40)
    wrongText1.anchorX = 0
    wrongText2 = display.newText("", X1, Y1, Arial, 40)
    wrongText2.anchorX = 0
    wrongText3 = display.newText("", X2, Y1, Arial, 40)
    wrongText3.anchorX = 0

    correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*1.1/3, Arial, 40)
    correctObject.isVisible = false
    correctObject:setFillColor(0,1,0)

    incorrectObject = display.newText("Incorrect", display.contentWidth/2, display.contentHeight*1.1/3, Arial, 40)
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