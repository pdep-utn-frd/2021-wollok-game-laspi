import wollok.game.*
import interface.*
import diego.*

class Visual {		//defino la clase visual 

	var property position		//llamo a la posicion e imagen del personaje 
	var property image

	method teEncontro() {		//defino el metodo si ese personaje me encuentra 
	}

	method mover() {
		const x = 1.randomUpTo(game.width()).truncate(0)
		const y = 1.randomUpTo(game.height() - 1).truncate(0) 
		position = game.at(x, y)
	}

}

class DanYerba inherits Visual {		//defino la clase que me permite ganar paquetes de yerba 

	var property yerbaQueLeOtorga		//necesito definir la variable yerba que le den a diego

	override method teEncontro() {		//metodo que evalua si se encuentra con un personaje, comprueba el total de yerba juntados si es menor me da yerba
		self.comprobarSiGana()
		self.darYerba()
	}

	method darYerba() {
		diego.yerba((diego.yerba() + self.yerbaQueLeOtorga()).min(200))		//metodo que me da yerba , puedo juntar hasta 500
		game.removeVisual(self)
	}

	method comprobarSiGana() {		//metodo comprobar si gana con el total de paquetes de yerba juntados
		if ((diego.yerba() + self.yerbaQueLeOtorga()) >= 200) {
			fin.finDelJuego()		//si cumple , fin del juego
		}
	}

}

//personajes que me dan yerba 

const ruggeri = new DanYerba(position = new Position(x = 1, y = 8), image = "ruggeri.png", yerbaQueLeOtorga = 100) //defino al subcapitan y le asigno posicion

const messi = new DanYerba(position = new Position(x = 8, y = 4), image = "messi.png", yerbaQueLeOtorga = 150)	//defino a messi y le asigno posicion 

const banderaArgentina = new DanYerba(position = new Position(x = 14, y = 2), image = "banderaArgentina.png", yerbaQueLeOtorga = 25) //defino bandera y le asigno posicion 

const balonOro = new DanYerba(position = new Position(x = 20, y = 1), image = "balonOro.png", yerbaQueLeOtorga = 50) //defino balon de oro y asigno posicion 



//defino clase que me permite que me quiten paquetes de yerba 

class QuitanYerba inherits Visual {		
	var property yerbaQueLeQuita = 25	//cantidad de paquetes que restan 

	override method teEncontro() {	//igual que al dar yerba defino el metodo que me permite encontrarme con el personaje que me va a restar los paquetes 
		self.quitarYerba()
	}

	method quitarYerba() {	//igual que al dar yerba, defino el metodo que me quita los paquetes
		diego.yerba((diego.yerba() - self.yerbaQueLeQuita()).max(0))
		game.say(self, "Voy a esconder los paquetes de yerba jaja")
	}

}

//personajes que me quitan yerba 

const misterBean = new QuitanYerba(position = new Position(x = 22, y = 6), image = "misterBean.png")	//defino a mister bean y le asigno posicion 

const peter = new QuitanYerba(position = new Position(x = 19, y = 8), image = "peter.png")	//defino a peter y le asigno posicion 



//defino la clase mortal que es la que evalua la direccion tanto del asteroide como del cometa 

class Mortal inherits Visual {		
	var property direccion = "Der"
	
	override method teEncontro() {		//si choco contra eso se termina el juego
		fin.finDelJuego()
	}

}

//personajes que me hacen perder !

object asteroide inherits Mortal  {		//defino asteoride que llama a mortal 

	override method position() = new Position(x = diego.position().x().min(25), y = 0)	//le asigno posicion 

	override method image() = "asteroide" + direccion + ".png"		//le asigno imagen 
}

object cometa inherits Mortal {		//defino la clase cometa que llama a mortal para finalizar el juego 

	override method position() = new Position(x = diego.position().x().min(24), y = 12)	//le asigno posicion 	

	override method image() = "cometa" + direccion + ".png"	//le asigno imagen y variable direccion que me permite que el cometa vaya y venga. 
	//define derecha e izquierda por la misma razon cuando diego se mueve tanto para la derecha como para la izquierda el objeto hace lo mismo
}



//defino la clase paralizador 

class Paralizador inherits Visual {		

	const tiempo	//evalua la constante tiempo ya que depende de cuanto tiempo debo estar paralizado

	override method teEncontro() {		//defino el metodo encontrar , si me encuentro con un personaje que me paraliza 
		diego.estatico(true)
		game.schedule(tiempo, { diego.estatico(false)}) 	//analizo el tiempo y dejo a diego estatico 
		game.say(self, "cuidado! la roca te produce cansancio")	//mensaje que arroja la piedra
	}

}

class Paralizador2 inherits Visual {		//clase paralizador2 pero funciona con la bandera 

	const tiempo	//evalua la constante tiempo 

	override method teEncontro() {	//metodo encontrar objeto que me paraliza
		diego.estatico(true)		//si lo econtré dejo a diego estático 
		game.schedule(tiempo, { diego.estatico(false)})	//y cuando pase ese tiempo ya no va a estar mas estatico
		game.say(self, "te agarraron de la camiseta, te atrasan 3 seg")	//mensaje que arroja la bandera 
	}

}

//personajes que me paralizan 

const banderaBrasilera = new Paralizador2(position = new Position(x = 5, y = 4), image = "banderaBrasilera.png", tiempo = 3000) //defino bandera brasilera

const sustancia = new Paralizador(position = new Position(x = 8, y = 2), image = "sustancia.png", tiempo = 2000) 	//defino la sustancia y la posicion 



//defino el objeto yerba , la posicion y le asigno una imagen 

object yerba inherits DanYerba (position = new Position(x = 1, y = 1), image = "yerba.png", yerbaQueLeOtorga = 10) {

	override method teEncontro() { 	//si me encuentro con la yerba, 
		self.comprobarSiGana()		//compruebo si gano con el metodo 
	diego.colisionarCon(self)		//y llamo a la colision 
		self.mover()		
	}

}

class QuitanCopa inherits Visual {	//defino la clase quitar copa

	override method teEncontro() {	//si me encuentro con un personaje que me quite una copa 
		self.quitarCopa()	//llamo al metodo quitar copa
	}

	method quitarCopa() {		//defino el metodo quitar copa 
		diego.copas(diego.copas() - 1)	//resto las copas de 1
		game.say(self, "Esta copa es mia!!") //cualquier personaje que me quite la copa mandará este mensaje 
		if (diego.copas() == 0) {
			game.removeTickEvent("GRAVEDAD")
			game.addVisual(fin)
		}
	}

}


//personajes que me quitan copas

const banderaInglesa = new QuitanCopa(position = new Position(x = 15, y = 11), image = "banderaInglesa.png") //defino bandera inglesa y le asigno posicion

const brasileroCapoeira = new QuitanCopa(position = new Position(x = 15, y = 5), image = "brasileroCapoeira.png")	//defino brasilero y le asigno posicion

object ronaldino inherits QuitanCopa (position = new Position(x = 13, y = 9), image = "ronaldino.png") {	//defino el objeto ronaldino y le asigno posicion

	override method teEncontro() {
		self.quitarCopa()
		self.mover()
	}

}

//defino objeto bilardo y le asigno posicion e imagen 

object bilardo inherits Visual (position = new Position(x = 5, y = 9), image = "bilardo.png") {

	method darCopa() {	//bilardo me da una copa por eso defino el metodo dar copa
		if (diego.copas() < 3) {	//si tengo menos de 3 copas me la otorga 
			diego.copas(diego.copas() + 1) //sumo las copas de a una 
			game.say(self, "Ganaste una copa del mundo !!")	//me avisa bilardo que gane una copa 
		} else {
			game.say(self, "No podes tener mas de 3 copas pibe")	//si tengo 3 copas me dice que no puede darme otra 
		}
		self.mover()
	}

	override method teEncontro() {
		self.darCopa()
	}

}

object extraterrestre inherits Visual (position = new Position(x = 9, y = 8), image = "extraterrestre.png") { 	//defino el objeto extraterrestre 

	override method teEncontro() {		//si me encuentro con el extraterrestre 
		diego.yerba(0)
		game.say(self, "mm que es eso? ET querer yerba")		
	}

}

