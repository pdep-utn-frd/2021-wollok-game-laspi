import wollok.game.*
import interface.*
import extras.*

object diego inherits Visual (position = new Position(x = 10, y = 10)) {

	var property yerba = 0
	var property copas = 3
	var property estatico = false
	var property direccion = "Der"
	
	override method image() = "diegote" + direccion + ".png" 
	
	method move(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

	method colisionarCon(personajeQueDaYerba) {
		yerba = (yerba + personajeQueDaYerba.yerbaQueLeOtorga()).min(999)
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