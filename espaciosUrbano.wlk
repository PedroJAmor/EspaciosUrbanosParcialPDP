//PUNTO 1
class EspacioUrbano{
  const nombre
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

  method agregarTrabajo(trabajo){
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
  const superficieSinCesped
  const procerHomenajeado
  
  override method condicionParticularEsGrande() = (procerHomenajeado == "San Martín" ) && tieneVallado
  override method esVerde() = false
  override method esLimpiable() = false
}

class Anfiteatro inherits EspacioUrbano{
  const capacidad
  const tamanioEscenario

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

  method trabaja(espacio, persona){
    self.validarTrabajo(espacio)  
    self.realizarTrabajo(espacio)
    self.agregarFichaTrabajo(espacio, persona)
  }

  method agregarFichaTrabajo(espacio, persona)
  method validarTrabajo(espacio)
  method realizarTrabajo(espacio) 

  method costo(espacio) = valorPorHora * self.duracionTrabajo(espacio)
  method duracionTrabajo(espacio) //dura

  //method costo()
}

object cerrajero inherits Profesion{
  override method validarTrabajo(espacio){
    if (espacio.tieneVallado()) throw new DomainException(message = "El Espacio tiene vallado")
  }
  
  override method realizarTrabajo(espacio){
    espacio.tieneVallado(true)
  }

  override method agregarFichaTrabajo(espacio, persona){
    
  }

  override method duracionTrabajo(espacio) = if(espacio.esGrande()) 5 else 3
   
}

object jardinero inherits Profesion{
  override method validarTrabajo(espacio){
    if(!espacio.esVerde()) throw new DomainException(message = "El espacio no es verde")
  }
  override method realizarTrabajo(espacio){
    espacio.esMasLindo()
  }
  
  override method agregarFichaTrabajo(espacio, persona){

  }

  override method costo(espacio) = 2500
  override method duracionTrabajo(espacio) = espacio.superficie().div(10)
}
object encargado inherits Profesion{
  override method validarTrabajo(espacio){
    if(!espacio.esLimpiable()) throw new DomainException(message = "El espacio no es limpiable")
  }

  override method realizarTrabajo(espacio){
    espacio.aumentarValuacion(5000)
  }

  override method agregarFichaTrabajo(espacio, persona){

  }

  override method duracionTrabajo(espacio) = 8
} 

class Trabajo{
  const fecha
  const persona

}