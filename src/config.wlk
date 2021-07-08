import wollok.game.*
import interface.*
import extras.*
import diego.*

object config {		//defino el objeto de configuracion 

	method configuracionDeTeclas() {		//metodo que hara que mi personaje se mueva con el teclado
		keyboard.up().onPressDo{ if (diego.moverse()) {		//arriba teclado
				diego.move(diego.position().up(1))
			}
		}
		keyboard.down().onPressDo{ if (diego.moverse()) {	//abajo teclado
				diego.move(diego.position().down(1))
			}
		}
		keyboard.left().onPressDo{ if (diego.moverse()) {	//izquierda teclado
				diego.move(diego.position().left(1))
				asteroide.direccion("Izq")
				
			}
		}
		keyboard.right().onPressDo{ if (diego.moverse()) {	//derecha teclado
				diego.move(diego.position().right(1))
				asteroide.direccion("Der")
				
			}
		}
		keyboard.s().onPressDo{ if (game.hasVisual(fin)) {	//para continuar el juego apretar S
				fin.continuar()
			}
		}
		keyboard.n().onPressDo{ if (game.hasVisual(fin)) {	//para salir del juego apretar N
				fin.terminar()
			}
		}
		keyboard.p().onPressDo { if (!diego.estatico()) {pausa.inicio()}	//poner pausa en el juego
		}
		keyboard.space().onPressDo {if (diego.estatico()) (pausa.quitar())	//espacio 
		}
	}

	method colisiones() {		//metodo que me define las colisiones 
		game.onCollideDo(diego, { unPersonaje => unPersonaje.teEncontro()}) //si me encuentro con un personaje
		game.onTick(500, "GRAVEDAD", {diego.caer()})
		game.schedule(1000, { game.sound("musicaUniverso.mp3").play() //defino la musica de mi ambiente o universo
		game.onTick(149000, "musica", { game.sound("musicaUniverso.mp3").play()})
		})
	}

}

