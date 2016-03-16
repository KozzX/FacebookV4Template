local sqlite3 = require( "sqlite3" )

-- Open "data.db". If the file doesn't exist, it will be created
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )   

-- Handle the "applicationExit" event to close the database
local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then              
        db:close()
    end
end

-- Set up the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS JOGADOR (
						id integer primary key, 
						facebookId text, 
						userId text
					);]]

print( tablesetup )
db:exec( tablesetup )

function primeiroJogo(  )
	local primeiro = true
	for row in db:nrows("SELECT id FROM JOGADOR WHERE id = 1") do
		primeiro = false
	end	
	return primeiro
end

function salvarFacebookId( facebookId )
	local tableupdate = [[UPDATE JOGADOR SET facebookId=']]..facebookId..[[' WHERE id = 1;]]
	print(tableupdate)
	db:exec( tableupdate )	
end

function salvarUserId( userId )
	local tableupdate = [[UPDATE JOGADOR SET userId=']]..userId..[[' WHERE id = 1;]]
	print(tableupdate)
	db:exec( tableupdate )	
end

function preencherTabelas(  )
	local tablefill = [[INSERT INTO JOGADOR VALUES(1, 'none', 'none');]]
	print( tablefill )
	db:exec( tablefill )
end

function buscarJogador( )
	local result = {}
	for row in db:nrows("SELECT facebookId, userId FROM JOGADOR WHERE id = 1") do
	    result = 
	    {
	    	facebookId=row.facebookId,
	    	userId=row.userId,
		}	    
	end
	return result
end

if primeiroJogo() then
	print( "primeiro" )
	preencherTabelas()
end



local tablesetup = [[DROP TABLE JOGADOR;]]
print( tablesetup )
--db:exec( tablesetup )

-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

