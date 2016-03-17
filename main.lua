---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

local globals = require( "globals" )
local composer = require( "composer" )
local coronium = require( "mod_coronium" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

-- This function gets called when the user opens a notification or one is received when the app is open and active.
-- Change the code below to fit your app's needs.
function DidReceiveRemoteNotification(message, additionalData, isActive)
    if (additionalData) then
        if (additionalData.discount) then
            native.showAlert( "Discount!", message, { "OK" } )
            -- Take user to your app store
        elseif (additionalData.actionSelected) then -- Interactive notification button pressed
            native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
        elseif (additionalData.shop) then
            store.purchase("remove_ads")
        elseif (additionalData.like) then
            if(not system.openURL("fb://page/1083605381668906")) then
                system.openURL("http://www.facebook.com/opressoroculos")
            end
        elseif (additionalData.update) then   
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.oculosopressor")
        elseif(additionalData.minigame) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.minigameracer")
        end
    else
        native.showAlert("OneSignal Message", message, { "OK" } )
    end
end

local OneSignal = require("plugin.OneSignal")
OneSignal.Init("326db8a3-0864-4a20-ae44-f9af74fd9f89", "125948127213", DidReceiveRemoteNotification)

local function selectCallback( event )
    local result = event.result
    print(result)
    if result ~= nil then
        print( "tem" )
        globals.player = 
        {
            facebookId = result[1].facebookId,
            userId = result[1].userId,
            pushToken = result[1].pushToken,
            name = result[1].name,
            first_name = result[1].first_name,
            last_name = result[1].last_name,
            age_range = result[1].age_range,
            link = result[1].link,
            gender = result[1].gender,
            locale = result[1].locale,
            pictureUrl = result[1].pictureUrl,
            timezone = result[1].timezone,
            updated_time = result[1].updated_time,
        }
        print( result[1].facebookId,result[1].userId, result[1].name )
        composer.gotoScene( "mainmenu", "fade", 500 )

    else
        print( "não tem" )
        composer.gotoScene( "login", "fade", 500 )
        
    end
end

local function selecionar(  )
    coronium:run("selectGuessPlayer",globals.player,selectCallback)    
end

function IdsAvailable(userId, pushToken)
    print("userId:" .. userId)
    globals.player.userId = userId
    if (pushToken) then -- nil if there was a connection issue or on iOS notification permissions were not accepted.
        print("pushToken:" .. pushToken)
        globals.player.pushToken = pushToken 
    end
    selecionar()
end

if system.getInfo("platformName") ~= "Win" then
    OneSignal.IdsAvailableCallback(IdsAvailable)
else
    globals.player.userId = "BBBBB"
    globals.player.pushToken = "TTTTT"
    selecionar()
end

