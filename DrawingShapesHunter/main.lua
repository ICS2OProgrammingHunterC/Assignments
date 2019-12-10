-- Title: DrawingShapes
-- Name: Hunter Connolly
-- Course: ICS2O

--hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the background color
display.setDefault("background", 102/255, 0/255, 204/255)

-- draw the pentagon
local vPentagon =  {-100,-100,100,-100,140,60,0,140,-140,60} 
local Pentagon = display.newPolygon( 175, 192, vPentagon)

--draw the trapezoid
local vTrapezoid = {-70,-110,70,-110,150,110,-150,110}
local Trapezoid = display.newPolygon( 768, 192, vTrapezoid)

-- draw a triangle
local vtriangle = {0,-110,110,110,-110,110}
local triangle = display.newPolygon( 175, 600, vtriangle)

--draw a quadrilateral
local vQuadrilateral = {-60,-60,0,-30,60,-60,0,60}
local quadrilateral = display.newPolygon (175, 384, vQuadrilateral)

-- draw a hexagon
local vHexagon = {-80,-80,80,-80,100,0,80,80,-80,80,-100,0}
local Hexagon = display.newPolygon ( 800, 600, vHexagon)
-------------------------------------------------------------------------
--PENTAGON
--set the color of the pentagon
Pentagon:setFillColor(51/255, 255/255, 51/255) 

--create the border
Pentagon.strokeWidth = 10

--set the border color
Pentagon:setStrokeColor(1,0,0)

local textObject
-- displays text on the screen at the position of x = 500 y = 500 with
-- a default font style and font siza of 50
textObject = display.newText("Pentagon", 175, 192, 'Comic Sans Ms', 45)

-- sets the color of the text
textObject:setTextColor(1,0,0)
-----------------------------------------------------------------------------
--TRAPEZOID
--set the color of the trapezoid
Trapezoid:setFillColor(51/255, 255/255, 51/255) 

--set the border
Trapezoid.strokeWidth = 10

--set the border color
Trapezoid:setStrokeColor(1,0,0)

local textObjectTrapezoid 
textObjectTrapezoid = display.newText("Trapezoid", 768, 192, 'Comic Sans Ms', 35)
textObjectTrapezoid:setTextColor(1,0,0)
----------------------------------------------------------------------------------
--TRIANGLE
--set the color of the triangle
triangle:setFillColor(51/255, 255/255, 51/255) 

--set the border
triangle.strokeWidth = 10

-- set the border color
triangle:setStrokeColor(1,0,0)

local textobjecttriangle
textobjecttriangle = display.newText("Triangle", 175, 650, 'Comic Sans Ms', 35 )
textobjecttriangle:setTextColor(1,0,0)

--find the area of the triangle
local trianglebase = 175
local heighttriangle = 150
local areaoftriangle
local areaText

areaoftriangle = trianglebase * heighttriangle / 2


--tell what the area of the triangle is
areaText = display.newText("The Area of the triangle with a base of \n" ..
	trianglebase .. " and a height of " .. heighttriangle .." is " .. 
	areaoftriangle .. " Pixels².", 0, 0, 'Comic Sans Ms', 25)

-- put the text next to the triangle
areaText.x = 475
areaText.y = 550

-- set the color of the text
areaText:setTextColor(51/255, 255/255, 51/255)
--------------------------------------------------------------------------------------------
--Quadrilateral
--set the color of the quadrilateral
quadrilateral:setFillColor(51/255, 255/255, 51/255) 

-- create the border
quadrilateral.strokeWidth = 10

-- set the border color
quadrilateral:setStrokeColor (1,0,0)
----------------------------------------------------------------------
-- hexagon
--set the color of the hexagon
Hexagon:setFillColor(51/255, 255/255, 51/255)

-- create the border
Hexagon.strokeWidth = 10

-- set the border color
Hexagon:setStrokeColor(1,0,0)

-- create the text
local TextHexagon = display.newText("Hexagon", 800, 600, 'Comic Sans Ms' , 35)

--set the color of the text
TextHexagon:setTextColor (1,0,0)




