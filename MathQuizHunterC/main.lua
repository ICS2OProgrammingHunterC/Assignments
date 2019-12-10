-- Title: Math Quiz
-- Name: Hunter Connolly
-- Course: ICS2O
--------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)

display.setDefault("background", 0, 0, 1)
-------------------------------------------------------------------------------------
-- LOCAL VARIABLES
---------------------------------------------------------------------------------------
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectObject
local points = 0
local pointsText
local livesText
local divQuestion
local youWin
local youLose
--variables for the timer
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer
local lives = 3
local heart1
local heart2
local heart3
----------------------------------------------------------------------------------
-- SOUNDS
---------------------------------------------------------------------------------------

-- correct sound
local correctSound = audio.loadSound( "Sounds/correct.mp3")
local correctSoundChannel
--incorrect sound
local incorrectSound = audio.loadSound( "Sounds/Wrong Buzzer Sound.mp3")
local incorrectSoundChannel

-- you lose sound
local youLoseSound = audio.loadSound("Sounds/YouLose.mp3")
local youLoseSoundChannel

--you win sound
local youWinSound = audio.loadSound("Sounds/youWin.mp3")
local youWinSoundChannel

-- background sound
local bkgSound = audio.loadStream("Elevator-music.mp3")
audio.play(bkgSound)
---------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------

local function AskQuestion()
	--generate a random number between 1 and 4
	randomOperator = math.random(1,6)

	--generate 4 random numbers
	randomNumber1 = math.random(1,20)
	randomNumber2 = math.random(1,20)

	--if the random operator is 1 then it is addition
	if (randomOperator == 1) then

		--calculate the correct answer 
		correctAnswer = randomNumber1 + randomNumber2 

		--create the question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
	elseif (randomOperator == 2) then
		--calclate the correct answer
		correctAnswer = randomNumber1 - randomNumber2

		-- create the question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
	elseif (randomOperator == 3) then
		-- generate random numbers between 1 and 10
		randomNumber5 = math.random(1,10)
		randomNumber6 = math.random(1,10)
		--calculate the correct answer
		correctAnswer = randomNumber5 * randomNumber6

		-- create the question in text object
		questionObject.text = randomNumber5 .. " x " .. randomNumber6 .. " = "
	elseif (randomOperator == 4) then
		-- generate the random numbers
		randomNumber3 = math.random(1,10)
		randomNumber4 = math.random(1,10)
		-- find the answer
		divQuestion = randomNumber3 * randomNumber4
		correctAnswer = divQuestion / randomNumber3 

		-- create the question object
		questionObject.text = divQuestion .. " ÷ " .. randomNumber3 .. " =  "
	elseif (randomOperator == 5) then
		randomNumber7 = math.random(1,10)
		randomNumber8 = math.random(1,3)
		-- find the answer
		correctAnswer = randomNumber7 ^ randomNumber8

		--create the question object
		questionObject.text = randomNumber7 .. " ^ " .. randomNumber8 .. " = "
	elseif (randomOperator == 6) then
		randomNumber9 = math.random(1,10)

		-- find the answer
		squareRoot = randomNumber9 * randomNumber9
		correctAnswer = squareRoot/randomNumber9

		-- display the question
		questionObject.text = "√" .. squareRoot
	end
end




local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
	
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()

end

local function HideRedX()
	redX.isVisible = false
	AskQuestion()
end

local function HideCheckmark()
	checkmark.isVisible = false
	AskQuestion()
end

local function NumericFieldListener( event )
	--user begins editing "numericField"
	if ( event.phase == "began" ) then

		--clear the text field
		event.target.text = ""
	elseif event.phase == "submitted" then
		-- when the answer is submitted ( enter key is pressed) set user input to users answer
		userAnswer = tonumber(event.target.text)

		--reset the timer
		secondsLeft = totalSeconds

		-- if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			--give a point if user gets the correct answer
			points = points + 1
			-- update it in the display object
			pointsText.text = "Number Correct: " .. points
			-- it tells the user that the answer is correct
			correctObject.isVisible = true
			timer.performWithDelay(1500, HideCorrect)
			--play correct sound
			correctSoundChannel = audio.play(correctSound)

			-- display the check mark

			-- clear the text field
			event.target.text = ""
	
		-- anything after the else means the answer is wrong
		else 
			-- Take away 1 life
			lives = lives - 1

			-- reset the timer
			secondsLeft = totalSeconds

			--it tells the user that the answer is incorrect
			timer.performWithDelay(1500, HideIncorrect)
			--play the incorrect sound
			incorrectSoundChannel = audio.play(incorrectSound)
			--clear the text field
			event.target.text = ""
			--display the x 
			redX.isVisible = true
			timer.performWithDelay(1500, HideRedX)
			incorrectObject = display.newText( "Incorrect, the correct answer is " .. correctAnswer  , display.contentWidth/2, display.contentHeight*2/3, nil, 50)
			incorrectObject:setTextColor(1,0,1)

			if (lives == 2) then 
				heart3.isVisible = false
			elseif (lives == 1) then
				heart2.isVisible = false
			elseif (lives == 0) then
				heart1.isVisble = false
			end
			

		end
		if (lives == 0) then
			youLose = display.newImageRect("Images/YouLose.png", 1024, 768)
			youLose.x = display.contentWidth/2
			youLose.y = display.contentHeight/2
			numericField.isVisible = false
			youLoseSoundChannel = audio.play(youLoseSound)
		elseif (points == 5)then
			youWin = display.newImageRect("Images/Youwin.jpg", 1024, 768)
			youWin.x = display.contentWidth/2
			youWin.y = display.contentHeight/2
			numericField.isVisible = false	
			youWinSoundChannel = audio.play(youWinSound)
		end
	end	
end

local function UpdateTime()

	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds
	clockText.text = secondsLeft .. ""


	if (secondsLeft == 0 ) then
		-- play the incorrect sound
		incorrectSoundChannel = audio.play(incorrectSound)
		--reset the number of seconds left 
		secondsLeft = totalSeconds
		lives = lives - 1
		AskQuestion()
		if (lives == 2) then 
			heart3.isVisible = false
		elseif (lives == 1) then
			heart2.isVisible = false
		elseif (lives == 0) then
			heart1.isVisble = false
		end
	end
end

-- function that calls the timer
local function StartTimer()
	--create a countdown timer that loops infinitely

	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-----------------------------------------------------------------------------------
--OBJECT CREATION
-------------------------------------------------------------------------------------------

-- displays a question and sets the color
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(1,0,1)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(1,0,1)
correctObject.isVisible = false

--create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

-- add the event listener for the numeric text field
numericField:addEventListener( "userInput", NumericFieldListener)

-- display the amount of points as a text object
pointsText = display.newText("Number Correct: " .. points, display.contentWidth*1/2, display.contentHeight*1/3, nil, 50)
pointsText:setTextColor(1,0,1)

-- create the checkmark for when the user gets the answer correct
checkmark = display.newImageRect("Images/checkmark.png", 150, 150)
checkmark.isVisible = false

-- create the red x for when the user get's the answer incorrect
redX = display.newImageRect("Images/red_x.png", 150, 150 )
redX.isVisible = false
redX.x = display.contentWidth*3/4
redX.y = display.contentHeight/2 

-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 125, 125)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 125, 125)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 125, 125)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7


-- add the clock text
clockText = display.newText("" .. secondsLeft, display.contentWidth*1/8, display.contentHeight*1/7, nil, 100)
clockText:setTextColor(1,0,1)

--------------------------------------------------------------------------------------
-- FUNCTION CALLS
--------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()
StartTimer()
UpdateTime()