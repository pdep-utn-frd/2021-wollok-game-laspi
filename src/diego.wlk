import wollok.game.*	//me permite trabajar con las librerias de wollok game
import interface.*
import extras.*

object diego inherits Visual (position = new Position(x = 10, y = 10)) {	//defino el objeto Diego y establezco su posición

	var property yerba = 0		//variables propias de Diego yerba que junta
	var property copas = 3		//copas que tiene, similitud con vidas
	var property estatico = false	//diego no es estatico sino que se va a mover por el universo

	
	override method image() = "diego"  + ".png" //le asigno una imagen a diego
	
	method move(nuevaPosicion) {	//metodo que define la posicion de diego
		self.position(nuevaPosicion)
	}

	method colisionarCon(personajeQueDaYerba) {
		yerba = (yerba + personajeQueDaYerba.yerbaQueLeOtorga()).min(500) //metodo que define con quien colisiona diego para conseguir yerba
	}

	method caer() {
		if (!estatico) {
			self.position(new Position(x = self.position().x().limitBetween(1.5, 23), y = (self.position().y() - 1).limitBetween(0, 11)))
		}
	}
	
	method moverse(){	
		return !estatico and !game.hasVisual(fin)
	}
}