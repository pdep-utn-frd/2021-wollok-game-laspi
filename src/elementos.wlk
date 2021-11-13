import wollok.game.*
import config.*

class Posiciones{
	var property position
}
object cirujano inherits Posiciones( position = game.at(5,0)) {
	
	var property direccion = "Sube1"
	
	method image() = "cirujano" + direccion + ".png"
	
	method move(nuevaPosicion){
		self.position(nuevaPosicion)
	}
}

object puerta inherits Posiciones ( position = game.at(7,7)) {
	
	method image() = "puerta1.png"
	
	method consecuencia(){

		niveles.segundoNivel()
		 
	}
	
}
object puerta2 inherits Posiciones ( position = game.at(12,4)){
	method image() = "puerta2.png"
	
	method consecuencia(){
			niveles.tercerNivel()
	}
}

object puerta3 inherits Posiciones ( position = game.at(12,4)){
	method image() = "puerta3.png"
	
	method consecuencia(){
		
		game.removeVisual(cirujano)
		game.removeVisual(enfermera)
		ganaste.finDelJuego()

	}
}

object habitacion11{
	method image()="level1.png"
	method position()=game.at(0,0)
}
object segundoNivel{
	method image()="level2.png"
	method position()=game.at(0,0)
}

object tercerNivel{
	method image()="nivel3.png"
	method position()=game.at(0,0)
}

object doctor inherits Posiciones(position=game.at(1,6)){
	method image()="doctor.png"
	
	method consecuencia(){
		self.position(game.at(12,3))
	}
}

object enfermera inherits Posiciones(position=game.at(1,6)){
	method image()="enfermera.png"
	
	method consecuencia(){
		self.position(game.at(12,3))
	}
}
object niveles{
	
	method primerNivel(){      
		game.clear()
		game.title("Haunted Hospital")
		game.width(13)
		game.height(8)
		game.ground("fondo.png")
		game.addVisual(habitacion11)
		game.addVisualCharacter(cirujano) 
		game.addVisual(fantasma1)
		game.addVisual(llave)
		game.addVisual(fantasma2)
		game.addVisual(fantasma3)
	
	config.colicionarCon()
	config.configuracionDeTeclas()
	}

method segundoNivel(){
	
		game.clear()
		game.width(13)
		game.height(8)
		game.ground("fondo.png")
		game.addVisual(segundoNivel)
		
		if (!game.hasVisual(cirujano)){
			game.addVisualCharacter(cirujano)
			cirujano.position(game.at(1,4))
		}
		
		game.addVisual(fantasma1)
		game.addVisual(llave2)
		game.addVisual(fantasma2)
		game.addVisual(fantasma3)
		game.addVisual(doctor)
		
		fantasma1.position(game.at(1,2))
		fantasma2.position(game.at(3,4))
		fantasma3.position(game.at(1,2))
	
		

	config.colicionarCon()
	config.configuracionDeTeclas()
	}
	
	method tercerNivel(){
	
		game.clear()
		game.width(13)
		game.height(8)
		game.ground("fondo.png")
		game.addVisual(tercerNivel)
		
		if (!game.hasVisual(cirujano)){
			game.addVisualCharacter(cirujano)
			cirujano.position(game.at(1,4))
		}
		
		game.addVisual(fantasma1)
		game.addVisual(llave3)
		game.addVisual(fantasma2)
		game.addVisual(fantasma3)
		game.addVisual(enfermera)
		
		fantasma1.position(game.at(1,2))
		fantasma2.position(game.at(3,4))
		fantasma3.position(game.at(1,2))
	
		

	config.colicionarCon()
	config.configuracionDeTeclas()
	}
}

class Fantasma{

	const numero 
	const posicionY
	
	var property position = game.at(1,posicionY)
	
	
	
	method movete(){
	const x = 0.randomUpTo(game.width()).truncate(0)
    const y = numero
    position = game.at(x,y)
    } 
    
    method consecuencia(){
    	game.removeTickEvent("movimiento")
    	game.removeVisual(cirujano)
    	fin.finDelJuego()
    }
	
}
object fantasma1 inherits Fantasma(numero = 1, posicionY = 1)  {
	
	method image() = "fantasma1.png"
	
}

object fantasma2 inherits Fantasma(numero = 3, posicionY= 3){
	method image() = "fantasma2.png"
	

 }

object fantasma3 inherits Fantasma(numero = 5, posicionY = 5){
	
	method image() = "fantasma3.png"
	

}

object llave inherits Posiciones ( position = game.at(7,4)) {
	
	method image() = "llave1.png"
	
	method consecuencia(){
		game.removeVisual(self)
		game.addVisual(puerta)
	}
}

object llave2 inherits Posiciones ( position = game.at(5,4)){
	
	method image() = "llave1.png"
	
	method consecuencia(){
		game.removeVisual(self)
		game.addVisual(puerta2)
	}
}

object llave3 inherits Posiciones ( position = game.at(5,4)){
	
	method image() = "llave3.png"
	
	method consecuencia(){
		game.removeVisual(self)
		game.addVisual(puerta3)
	}  
}

object ganaste inherits Posiciones ( position = game.at(2,1)){
	
	method image() = "win.png"
	
		method finDelJuego(){
			game.addVisual(self)
		}
		method retry(){
			
		game.clear()
		game.width(13)
		game.height(8)
		game.ground("segundoNivel.png")
		game.addVisual(habitacion11)
	
		
		
		if (!game.hasVisual(llave)){
			game.addVisual(llave)
		}
		if (!game.hasVisual(cirujano)){
			game.addVisual(cirujano)
		}
		if (!game.hasVisual(fantasma1)){
			game.addVisual(fantasma1)
		}
		if (!game.hasVisual(fantasma2)){
			game.addVisual(fantasma2)
		}
		if (!game.hasVisual(fantasma3)){
			game.addVisual(fantasma3)
		}
		game.onTick(1000, "movimiento",{ fantasma1.movete() })
		game.onTick(500, "movimiento",{ fantasma2.movete() })
		game.onTick(200, "movimiento", {fantasma3.movete() })
		
		config.colicionarCon()
		config.configuracionDeTeclas()
}
	
		method gameOver(){
		game.stop()
	}

}

object fin inherits Posiciones ( position = game.at(2,1)){
	
	method image() = "gameOver.png"
	
	method finDelJuego(){
		game.addVisual(self)
	}
	
	method retry(){
		if (game.hasVisual(habitacion11)){
		
		game.removeVisual(self)
		game.addVisual(cirujano)
		cirujano.position(game.at(5,1))
		
		if (!game.hasVisual(llave)){
			game.addVisual(llave)
		}
		
		game.onTick(1000, "movimiento",{ fantasma1.movete() })
		game.onTick(500, "movimiento",{ fantasma2.movete() })
		game.onTick(200, "movimiento", {fantasma3.movete() })
	}
	if (game.hasVisual(segundoNivel)){
		
		game.removeVisual(self)
		if (!game.hasVisual(cirujano)){
			game.addVisual(cirujano)
			cirujano.position(game.at(5,1))
		}
		if (!game.hasVisual(llave2)){
			game.addVisual(llave2)
		}
		if (!game.hasVisual(doctor)){
			game.addVisual(doctor)
			doctor.position(game.at(1,6))
		}
		if (!game.hasVisual(fantasma1)){
			game.addVisual(fantasma1)
		}
		if (!game.hasVisual(fantasma2)){
			game.addVisual(fantasma2)
		}
		if (!game.hasVisual(fantasma3)){
			game.addVisual(fantasma3)
		}
		
		config.colicionarCon()
		config.configuracionDeTeclas()
	
		game.onTick(1000, "movimiento",{ fantasma1.movete() })
		game.onTick(500, "movimiento",{ fantasma2.movete() })
		game.onTick(200, "movimiento", {fantasma3.movete() })
	}
	if (game.hasVisual(tercerNivel)){
		
		game.removeVisual(self)
		if (!game.hasVisual(cirujano)){
			game.addVisual(cirujano)
			cirujano.position(game.at(5,1))
		}
		if (!game.hasVisual(llave3)){
			game.addVisual(llave3)
		}
		if (!game.hasVisual(enfermera)){
			game.addVisual(enfermera)
			doctor.position(game.at(1,6))
		}
		if (!game.hasVisual(fantasma1)){
			game.addVisual(fantasma1)
		}
		if (!game.hasVisual(fantasma2)){
			game.addVisual(fantasma2)
		}
		if (!game.hasVisual(fantasma3)){
			game.addVisual(fantasma3)
		}
		
		config.colicionarCon()
		config.configuracionDeTeclas()
	
		game.onTick(1000, "movimiento",{ fantasma1.movete() })
		game.onTick(500, "movimiento",{ fantasma2.movete() })
		game.onTick(200, "movimiento", {fantasma3.movete() })
	}
}
	method gameOver(){
		game.stop()
	}
	
	
}