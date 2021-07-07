import diego.*
import wollok.game.*
import extras.*

object fin inherits Visual(position = new Position(x = 5, y = 3)) {

	override method image() {
		if (diego.yerba() >= 999) 
			return 'campeon.png' 
		else 
			return 'cebollita.jpg'
	}

	method continuar() {
		game.onTick(500, "GRAVEDAD", {diego.caer()})
		diego.copas(3)
		diego.yerba(0)
		diego.position(game.at(10, 10))
		if (!game.hasVisual(ruggeri)) {
			game.addVisual(ruggeri)
		}
		if (!game.hasVisual(messi)) {
			game.addVisual(messi)
		}
		if (!game.hasVisual(banderaArgentina)) {
			game.addVisual(banderaArgentina)
		}
		yerba.position(game.at(1, 1))
		extraterrestre.position(game.at(9, 9))
		bilardo.position(game.at(7, 7))
		game.removeVisual(self)
	}

	method terminar() {
		game.schedule(900, {game.stop()})
	}

	method finDelJuego() {
		game.removeTickEvent("GRAVEDAD")
		game.addVisual(self)
	}

}

object pausa inherits Visual(position = new Position(x=0,y=0), image = "pausa.png") { 
	method inicio() {
		diego.estatico(true)
		diego.caer()
		game.removeTickEvent("GRAVEDAD")
		game.addVisual(self)
	}
	
	method quitar(){
		diego.estatico(false)	
		game.removeVisual(self)
		game.onTick(500, "GRAVEDAD", {diego.caer()})
	}
}

object copa inherits Visual(position = new Position(x=22,y=12)) { 

	override method image() = "copa" + diego.copas().toString() + ".png"

}


object unidad inherits Visual (position = new Position(x = 24, y = 11)) {

	override method image() = (diego.yerba() - (diego.yerba() / 10).truncate(0) * 10).toString() + ".png"

}

object decena inherits Visual (position = new Position(x = 23, y = 11)) {

	override method image() = if (diego.yerba() >= 100) {
		(((diego.yerba() - centena.c() * 100) / 10).truncate(0)).toString() + ".png"
	} else {
		(diego.yerba() / 10).truncate(0).toString() + ".png"
	}

}

object centena inherits Visual (position = new Position(x = 22, y = 11)) {

	override method image() = self.c().toString() +	".png"

	method c() = (diego.yerba() / 100).truncate(0)

}

const logoYerba = new Visual(position = new Position(x=21,y=11), image = "logoYerba.png")
