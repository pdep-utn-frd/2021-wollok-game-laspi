import wollok.game.*
import elementos.* 

object config {
	     
		method colicionarCon(){
		game.whenCollideDo(cirujano,{algo=>algo.consecuencia()
		})
		game.onTick(1000, "movimiento",{ fantasma1.movete() })
		game.onTick(500, "movimiento",{ fantasma2.movete() })
		game.onTick(200, "movimiento", {fantasma3.movete() })
		
	}
	method configuracionDeTeclas(){
		keyboard.up().onPressDo{cirujano.move(cirujano.position().up(1))
			cirujano.direccion("Sube1")
			}
		
		keyboard.down().onPressDo{cirujano.move(cirujano.position().down(1))
			cirujano.direccion("Baja1")}
		
		keyboard.left().onPressDo{ cirujano.move(cirujano.position().left(1))  
				cirujano.direccion("Izq1")}
		
		keyboard.right().onPressDo{ cirujano.move(cirujano.position().right(1))
				cirujano.direccion("Der1")}
		
		keyboard.r().onPressDo{ if (game.hasVisual(fin)) {	//para continuar el juego apretar S
				fin.retry()}
				if (game.hasVisual(ganaste)){
					ganaste.retry()
				}

		}
		
		keyboard.s().onPressDo{ if (game.hasVisual(fin)) {	//para continuar el juego apretar S
				fin.gameOver()}
				if (game.hasVisual(ganaste)){
					ganaste.gameOver()
				}

		}
}
}

