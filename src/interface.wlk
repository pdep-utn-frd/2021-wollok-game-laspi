import diego.*
import wollok.game.*
import extras.*

object fin inherits Visual(position = new Position(x = 5, y = 3)) {	//objeto fin del juego , establezco la posicion de la imagen 

	override method image() {		//si diego junta 599 paquetes de yerba gana , sino es un cebollita 
		if (diego.yerba() >= 500) 
			return 'campeon.png' 	//imagen de capeon 
		else 
			return 'cebollita.jpg' 	//imagen de cebollita 
	}

	method continuar() {		//defino el metodo para poder continuar con el juego 
		game.onTick(500, "GRAVEDAD", {diego.caer()})	//diego afectado por la gravedad
		diego.copas(3)	//variables propias de diego con que inicializa - 3 copas
		diego.yerba(0)	//yerba en 0 paquetes
		diego.position(game.at(10, 10))		//la posicion inicial  de diego
		if (!game.hasVisual(ruggeri)) { 	//personajes que colisionan con diego a su favor y le dan yerba 
			game.addVisual(ruggeri)
		}
		if (!game.hasVisual(messi)) {
			game.addVisual(messi)
		}
		if (!game.hasVisual(banderaArgentina)) {
			game.addVisual(banderaArgentina)
		}
		yerba.position(game.at(1, 1))		//paquetes de yerba 
		extraterrestre.position(game.at(9, 9))
		bilardo.position(game.at(7, 7))
		game.removeVisual(self)
	}

	method terminar() {		//metodo que termina el juego 
		game.schedule(900, {game.stop()})
	}

	method finDelJuego() {		//fin del juego 
		game.removeTickEvent("GRAVEDAD")
		game.addVisual(self)
	}

}

object pausa inherits Visual(position = new Position(x=5,y=3), image = "pausa.jpg") { //objeto que me establece la pausa del juego y la posicion de la imagen
	method inicio() {
		diego.estatico(true)		//inicio de la pausa tiene que estar afectado por las propiedades del personaje 
		diego.caer()
		game.removeTickEvent("GRAVEDAD")
		game.addVisual(self)
	}
	
	method quitar(){		//final de la pausa tambien afectado por las propiedades del personaje 
		diego.estatico(false)	
		game.removeVisual(self)
		game.onTick(500, "GRAVEDAD", {diego.caer()})
	}
}

object copa inherits Visual(position = new Position(x=22,y=12)) { 		//defino el objeto copa

	override method image() = "copa" + diego.copas().toString() + ".png" 	//le asigno posicion e imagen a copa

}


object unidad inherits Visual (position = new Position(x = 24, y = 11)) {		//defino el objeto unidad, y le asigno posicion e imagen

	override method image() = (diego.yerba() - (diego.yerba() / 10).truncate(0) * 10).toString() + ".png"	

}

object decena inherits Visual (position = new Position(x = 23, y = 11)) {	//defino el objeto decena y le asigno posicion e imagen 

	override method image() = if (diego.yerba() >= 100) {
		(((diego.yerba() - centena.c() * 100) / 10).truncate(0)).toString() + ".png"
	} else {
		(diego.yerba() / 10).truncate(0).toString() + ".png"
	}

}

object centena inherits Visual (position = new Position(x = 22, y = 11)) {	//defino el objeto centena le asigno posicion e imagenes. Armo mi numero completo

	override method image() = self.c().toString() +	".png"

	method c() = (diego.yerba() / 100).truncate(0)

}

const logoYerba = new Visual(position = new Position(x=21,y=11), image = "logoYerba.png")	//a mi numero de 3 digitos lo defino como la cantidad de yerba
//que juntan y le asigno una imagen y posicion . Para eso defino el logo yerba . La ubicacion de la imagen esta coordinada con posicion 
//de la unidad, decena y centena 
