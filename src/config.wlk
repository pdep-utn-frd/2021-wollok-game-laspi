import wollok.game.*
import interface.*
import extras.*
import diego.*

object config {

	method configuracionDeTeclas() {
		keyboard.up().onPressDo{ if (diego.moverse()) {
				diego.move(diego.position().up(1))
			}
		}
		keyboard.down().onPressDo{ if (diego.moverse()) {
				diego.move(diego.position().down(1))
			}
		}
		keyboard.left().onPressDo{ if (diego.moverse()) {
				diego.move(diego.position().left(1))
				diego.direccion("Izq")
				asteroide.direccion("Izq")
				cometa.direccion("Izq")
			}
		}
		keyboard.right().onPressDo{ if (diego.moverse()) {
				diego.move(diego.position().right(1))
				diego.direccion("Der")
				asteroide.direccion("Der")
				cometa.direccion("Der")
			}
		}
		keyboard.s().onPressDo{ if (game.hasVisual(fin)) {
				fin.continuar()
			}
		}
		keyboard.n().onPressDo{ if (game.hasVisual(fin)) {
				fin.terminar()
			}
		}
		keyboard.p().onPressDo { if (!diego.estatico()) {pausa.inicio()}	
		}
		keyboard.space().onPressDo {if (diego.estatico()) (pausa.quitar())
		}
	}

	method colisiones() {
		game.onCollideDo(diego, { unPersonaje => unPersonaje.teEncontro()})
		game.onTick(500, "GRAVEDAD", {diego.caer()})
		game.schedule(1000, { game.sound("musicaUniverso.mp3").play()
		game.onTick(149000, "musica", { game.sound("musicaUniverso.mp3").play()})
		})
	}

}

