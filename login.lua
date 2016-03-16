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
--local Database = require( "Database" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

-- Load scene with same root filename as this file
local scene = composer.newScene(  )

---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

    elseif phase == "did" then

        local btnLogin  = Botao.new("Login Facebook", 90)
        btnLogin:addEventListener( "tap", function (  )
            facebookLogin()
            local cont = 0

            timer1 = timer.performWithDelay( 1500, function (  )
                cont = cont + 1
                print( cont )
                if (globals.isCarregado == true) then
                    player = facebookPlayer()
                    local btnNome = Botao.new(player.name,80)
                    coronium:run("insertGuessPlayer",player)
                    timer.cancel( timer1 )
                elseif (globals.isCancelado == true) then
                    timer.cancel( timer1 )
                end     
            end , -1 )
        end )
        
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