//PUNTO 1
class EspacioUrbano{
  //const nombre
  var property valuacion
  const superficie
  var property tieneVallado
  const trabajosRealizados = [] //tiene una lista de trabajos y cada trabajo

  method esGrande() = superficie > 50 && self.condicionParticularEsGrande()
  method condicionParticularEsGrande()

//no hace falta pero no esta mal 
  method esVerde()

  method esLimpiable()

  method esMasLindo(){ 
    valuacion = valuacion * 1.10
  }

  method aumentarValuacion(valuacionQueAumenta) {
    valuacion += valuacionQueAumenta    
  }

  method agregarTrabajo(trabajo){ //esto agrega trabajos a la lista 
    trabajosRealizados.add(trabajo)
  }
}

class Plaza inherits EspacioUrbano{
  const cantidadDeCanchas

  override method condicionParticularEsGrande() = cantidadDeCanchas > 2
  override method esVerde() = cantidadDeCanchas == 0
  override method esLimpiable() = true 
}

class Plazoleta inherits EspacioUrbano{
  //const superficieSinCesped
  const procerHomenajeado
  
  override method condicionParticularEsGrande() = (procerHomenajeado == "San Martín" ) && tieneVallado
  override method esVerde() = false
  override method esLimpiable() = false
}

class Anfiteatro inherits EspacioUrbano{
  const capacidad
  //const tamanioEscenario

  override method condicionParticularEsGrande() = capacidad > 500
  override method esVerde() = false
  override method esLimpiable() = self.esGrande()
}

class Multiespacio inherits EspacioUrbano{
  const espacios = []

  override method condicionParticularEsGrande() = espacios.all{espacio => espacio.esGrande()}
  
  override method esVerde() = espacios.size() > 3

  override method esLimpiable() = false
}

//PUNTO 2
class Persona {
  var property profesion

  method trabaja(espacio){
    profesion.trabaja(espacio, self) //cuando una persona trabaja en un espacio
  } 
}

class Profesion{
  var property valorPorHora = 100

  method trabaja(espacio, persona){ //traba una persona en un espacio realiza todo esto
    self.validarTrabajo(espacio)  
    self.realizarTrabajo(espacio)
    self.agregarFichaTrabajo(espacio, persona)
  }

  method agregarFichaTrabajo(espacio, persona){
    const trabajo = new Trabajo(
        fecha = new Date(), //preguntar si es asi
        persona = persona,
        duracion = self.duracionTrabajo(espacio),
        costo = self.costo(espacio)
    )

    espacio.agregarTrabajo(trabajo) //agrega el trabajo a la lista 
  }
  method validarTrabajo(espacio)
  method realizarTrabajo(espacio) 

  method costo(espacio) = valorPorHora * self.duracionTrabajo(espacio) //el costo depende de la profesion porque el unico que cambia es el jardinero 
  method duracionTrabajo(espacio) //duracion

  method esTrabajoHeavy(espacio) = self.costo(espacio) > 10000

  //method costo()
}
//cerrajero
object cerrajero inherits Profesion{
  override method validarTrabajo(espacio){
    if (espacio.tieneVallado()) throw new DomainException(message = "El Espacio tiene vallado")
  }
  
  override method realizarTrabajo(espacio){
    espacio.tieneVallado(true)
  }

  override method duracionTrabajo(espacio) = if(espacio.esGrande()) 5 else 3

//agrego el metodo es trabajo heavy
  override method esTrabajoHeavy(espacio) = super(espacio) || self.duracionTrabajo(espacio) > 5 //para no repetir codigo se usa el super
   
}

//jardinero
object jardinero inherits Profesion{
  override method validarTrabajo(espacio){
    if(!espacio.esVerde()) throw new DomainException(message = "El espacio no es verde")
  }
  override method realizarTrabajo(espacio){
    espacio.esMasLindo()
  }
  
  override method costo(espacio) = 2500

  override method duracionTrabajo(espacio) = espacio.superficie().div(10)
}

//jardinero
object encargado inherits Profesion{
  override method validarTrabajo(espacio){
    if(!espacio.esLimpiable()) throw new DomainException(message = "El espacio no es limpiable")
  }

  override method realizarTrabajo(espacio){
    espacio.aumentarValuacion(5000)
  }

  override method duracionTrabajo(espacio) = 8
} 

class Trabajo{
  const fecha
  const persona
  const duracion
  const costo
}
