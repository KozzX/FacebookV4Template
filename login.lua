---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "Botao" )
local Facebook = require( "Facebook" )
local globals = require( "globals" )
local coronium = require( "mod_coronium" )
local Database = require( "Database" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

-- Load scene with same root filename as this file
local scene = composer.newScene(  )

---------------------------------------------------------------------------------
local function insertFacebookCallback( event )
    local result = event.result
    if result.affected_rows > 0 then
        globals.player.id = result.insert_id
        adicionarJogador(globals.player.id, globals.player.facebookId, globals.player.name)
        composer.gotoScene( "mainmenu", "fade", 500 ) 
    end
end

local function procuraFacebookCallback( event )
    local result = event.result
    print(result)
    if result ~= nil then
        print( "Facebook Tem" )
        globals.player.id = result[1].id 
        adicionarJogador(globals.player.id, globals.player.facebookId, globals.player.name)
        printPlayer()
        composer.gotoScene( "mainmenu", "fade", 500 ) 
    else
        print( "Não tem Facebok" )
        coronium:run("insertGuessPlayer", globals.player, insertFacebookCallback)
    end
end

local function textListener( event )

    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        
        print( event.target.text )

    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

local function localUser( event )
    printPlayer()
    local defaultField = native.newTextField( display.contentCenterX, display.contentCenterY/2, display.contentWidth, 30 )
    defaultField:addEventListener( "userInput", textListener )
    print( "text" )

    
end

local function facebookUser( event )
    facebookLogin()
    local cont = 0
    timer1 = timer.performWithDelay( 1500, function (  )
        cont = cont + 1
        print( cont )
        if (globals.isCarregado == true) then
            printPlayer()
            coronium:run("procuraFacebook", globals.player, procuraFacebookCallback)
            timer.cancel( timer1 )
        elseif (globals.isCancelado == true) then
            timer.cancel( timer1 )
        end  
    end, -1)
end

function scene:create( event )
    local sceneGroup = self.view
 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then

        local btnFacebook = Botao.new("Login Facebook", 50)
        local btnLocal    = Botao.new("Local User", 56)



        btnFacebook:addEventListener( "tap", facebookUser )
        btnLocal:addEventListener( "tap", localUser )

        

        sceneGroup:insert( btnFacebook )
        sceneGroup:insert( btnLocal )
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen

    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene