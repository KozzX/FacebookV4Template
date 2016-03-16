local widget = require( "widget" )

function new( texto,y )
	local options = {
		x=display.contentCenterX,
		y=display.contentHeight / 100 * y,
		width=display.contentWidth / 100 * 60,
		height=display.contentHeight / 100 * 5,
		label=texto,
		labelColor = { default={1,1,1}, over={0,0,0} },
		emboss=true,
		fontSize=25,
		labelAlign="center",
		font=native.systemFont,
		shape="roundedRect",
		cornerRadius=5,
		fillColor = { default={0.5,0.5,0.5}, over={0.3,0.3,0.3} },
		--strokeColor = { default={0,0,0}, over={0,0,0} },
		--strokeWidth = 3
	}
	local botao = widget.newButton( options )
	botao:scale( 0, 0 )
	transition.scaleTo( botao, {xScale=1,yScale=1,time=100} )
	
	return botao
end

return {
	new = new
}
