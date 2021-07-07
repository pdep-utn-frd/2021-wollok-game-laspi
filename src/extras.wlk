import wollok.game.*
import interface.*
import diego.*

class Visual {

	var property position
	var property image

	method teEncontro() {
	}

	method mover() {
		const x = 1.randomUpTo(game.width()).truncate(0)
		const y = 1.randomUpTo(game.height() - 1).truncate(0)
		position = game.at(x, y)
	}

}

class DanYerba inherits Visual {

	var property yerbaQueLeOtorga

	override method teEncontro() {
		self.comprobarSiGana()
		self.darYerba()
	}

	method darYerba() {
		diego.yerba((diego.yerba() + self.yerbaQueLeOtorga()).min(999))
		game.removeVisual(self)
	}

	method comprobarSiGana() {
		if ((diego.yerba() + self.yerbaQueLeOtorga()) >= 999) {
			fin.finDelJuego()
		}
	}

}

const ruggeri = new DanYerba(position = new Position(x = 1, y = 8), image = "ruggeri.png", yerbaQueLeOtorga = 100)

const messi = new DanYerba(position = new Position(x = 8, y = 4), image = "messi.png", yerbaQueLeOtorga = 150)

const banderaArgentina = new DanYerba(position = new Position(x = 14, y = 2), image = "banderaArgentina.png", yerbaQueLeOtorga = 25)

const balonOro = new DanYerba(position = new Position(x = 20, y = 1), image = "balonOro.png", yerbaQueLeOtorga = 50)

class QuitanYerba inherits Visual {

	var property yerbaQueLeQuita = 25

	override method teEncontro() {
		self.quitarYerba()
	}

	method quitarYerba() {
		diego.yerba((diego.yerba() - self.yerbaQueLeQuita()).max(0))
		game.say(self, "Has perdido paquetes de yerba")
	}

}

const misterBean = new QuitanYerba(position = new Position(x = 22, y = 6), image = "misterBean.png")

const peter = new QuitanYerba(position = new Position(x = 19, y = 8), image = "peter.png")

class Mortal inherits Visual {
	var property direccion = "Der"
	
	override method teEncontro() {
		fin.finDelJuego()
	}

}

object asteroide inherits Mortal  {

	override method position() = new Position(x = diego.position().x().min(25), y = 0)

	override method image() = "asteroide" + direccion + ".png"
}

object cometa inherits Mortal {

	override method position() = new Position(x = diego.position().x().min(24), y = 12)

	override method image() = "cometa" + direccion + ".png"
}


class Paralizador inherits Visual {

	const tiempo

	override method teEncontro() {
		diego.estatico(true)
		game.schedule(tiempo, { diego.estatico(false)})
		game.say(self, "cuidado! la sustancia te produce cansancio perdes 3 seg")
	}

}

class Paralizador2 inherits Visual {

	const tiempo

	override method teEncontro() {
		diego.estatico(true)
		game.schedule(tiempo, { diego.estatico(false)})
		game.say(self, "Agarraste la bandera Brasilera perdes 2seg por traición")
	}

}

const banderaBrasilera = new Paralizador2(position = new Position(x = 5, y = 4), image = "banderaBrasilera.png", tiempo = 3000)

const sustancia = new Paralizador(position = new Position(x = 8, y = 2), image = "sustancia.png", tiempo = 2000)

object yerba inherits DanYerba (position = new Position(x = 1, y = 1), image = "yerba.png", yerbaQueLeOtorga = 10) {

	override method teEncontro() {
		self.comprobarSiGana()
	diego.colisionarCon(self)
		self.mover()
	}

}

class QuitanCopa inherits Visual {

	override method teEncontro() {
		self.quitarCopa()
	}

	method quitarCopa() {
		diego.copas(diego.copas() - 1)
		game.say(self, "PERDISTE UNA COPA, ESTA COPA ES MIA !")
		if (diego.copas() == 0) {
			game.removeTickEvent("GRAVEDAD")
			game.addVisual(fin)
		}
	}

}

const banderaInglesa = new QuitanCopa(position = new Position(x = 15, y = 11), image = "banderaInglesa.png")

const brasileroCapoeira = new QuitanCopa(position = new Position(x = 15, y = 5), image = "brasileroCapoeira.png")

object ronaldino inherits QuitanCopa (position = new Position(x = 13, y = 9), image = "ronaldino.png") {

	override method teEncontro() {
		self.quitarCopa()
		self.mover()
	}

}

object bilardo inherits Visual (position = new Position(x = 5, y = 9), image = "bilardo.png") {

	method darCopa() {
		if (diego.copas() < 3) {
			diego.copas(diego.copas() + 0.5)
			game.say(self, "Ganaste una copa del mundo !!")
		} else {
			game.say(self, "No podes tener mas de 3 copas")
		}
		self.mover()
	}

	override method teEncontro() {
		self.darCopa()
	}

}

object extraterrestre inherits Visual (position = new Position(x = 9, y = 8), image = "extraterrestre.png") {

	override method teEncontro() {
		diego.yerba(0)
	}

}

