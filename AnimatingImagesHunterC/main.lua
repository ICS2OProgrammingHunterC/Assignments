-- Title: Aninamting Images
-- Name: Hunter C
-- Course: ICS2O
-- This program displays multiple imges that will then move in different directions

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)
------------------------------------------------------------------------------------
-- GLOBAL VARIABLES
----------------------------------------------------------------------------------
-- global variables
scrollSpeed = 3
scrollSpeed2 = 0.01
scrollSpeed3 = 7
scrollSpeed4 = 3
------------------------------------------------------------------------------
--BACKGROUNDS AND IMAGES
---------------------------------------------------------------------------------
-- display the background Image
local backgroundImage = display.newImageRect("Images/Background.jpg", 1028, 768)
backgroundImage.anchorX = 0
backgroundImage.anchorY = 0

-- display the wizard
local wizard = display.newImageRect("Images/Wizard.png", 250, 250)
--set the x y position
wizard.x = 227
wizard.y = 550

--display the ironMan image
local ironMan = display.newImageRect("Images/ironman.png", 200, 200)
--set the x y position
ironMan.x = 771
ironMan.y = 550

-- display the bird Images
local birds = display.newImageRect("Images/birds.png", 400, 150)
-- set the x and y positions
birds.x = 514
birds.y = 96
birds.alpha = 1

-- display the old man sitting down
local sittingMan = display.newImageRect("Images/sittingMan.png", 200, 250)
-- set the x and y position
sittingMan.x = 600
sittingMan.y = 480


-------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------


-- Function: MoveWizard
-- Input: this function accepts an event listener
-- Description: once the user starts the function the Wizard will begin 
-- growing in size and move off the creen towards the right side
local function MoveWizard(event)
	--add the scroll speed to the x-value of the wizard
	wizard.x = wizard.x + scrollSpeed
	-- make the wizard start growing in size
	wizard.xScale = wizard.xScale + scrollSpeed2
	wizard.yScale = wizard.yScale + scrollSpeed2
end

-- Function: MoveIronMan
-- Input: this function accecpts an event listener
-- Description: Once the user starts the event the iron man image will move 
-- diagonnally towards the left side of the screen
local function MoveIronMan(event)
	-- add the scroll speed to the x - y value
	ironMan.x = ironMan.x - scrollSpeed3
	ironMan.y = ironMan.y - scrollSpeed3
end

-- Function: MoveBirds
-- Input: this function accepts an event listener
-- description: once the function starts the birds will fade out and move to the left of the screen
local function MoveBirds(event)
	-- body
	birds.x = birds.x + scrollSpeed4
	birds.alpha = birds.alpha - 0.05
end

--Function: MoveSittingMan
-- Input: this function accepts an event listener
--Description: Once the function starts the sitting man will begin rotating and moving to the left of the screen
local function MoveSittingMan(event)
	sittingMan.x = sittingMan.x - scrollSpeed
	sittingMan:rotate(10)
	timer.performWithDelay(10000)
end
  
-------------------------------------------------------------------------
-- TEXT OBJECTS
---------------------------------------------------------------------------
-- create the text object
local introText = display.newText("Animating Images" .. 
	" By Hunter Connolly", 530, 192, 'Times New Roman', 50)
--text color
introText:setTextColor(0/255, 0/255, 153/255)

---------------------------------------------------------------------------------
-- EVENT LISTENERS
----------------------------------------------------------------------------------

Runtime:addEventListener("enterFrame", MoveWizard)

Runtime:addEventListener("enterFrame", MoveIronMan)

Runtime:addEventListener("enterFrame", MoveBirds)

Runtime:addEventListener("enterFrame", MoveSittingMan)

