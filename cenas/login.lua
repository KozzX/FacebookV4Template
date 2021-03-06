---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )


-- Load scene with same root filename as this file
local scene = composer.newScene(  )
local btnFacebook 
local btnLocal


---------------------------------------------------------------------------------
local function facebookUser( event )
    print( event.target )
    composer.gotoScene( "cenas.loading", { effect = "fade", time = 300, params={tipoLogin="facebook" } } )
end

local function localUser( event )
    print( event.target.name )
    composer.gotoScene( "cenas.cadastro", "slideLeft", 500 )    
end

function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        

    elseif phase == "did" then

        btnFacebook = Botao.newFacebook("Facebook", 50-6)
        btnLocal    = Botao.new("Local User", 50+6)

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
        btnFacebook:removeEventListener( "tap", facebookUser )
        btnLocal:removeEventListener( "tap", localUser )
        

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