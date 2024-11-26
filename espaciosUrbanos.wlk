class EspacioUrbano{
  const nombre
  var property valuacion
  const superficie
  var property tieneVallado

  method esGrande() = superficie > 50 && self.condicionParticularEsGrande()
  method condicionParticularEsGrande()
}

class Plaza inherits EspacioUrbano{
  const cantidadDeCanchas

  override method condicionParticularEsGrande() = cantidadDeCanchas > 2
}

class Plazoleta inherits EspacioUrbano{
  //const superficieSinCesped
  const procerHomenajeado
  
  override method condicionParticularEsGrande() = (procerHomenajeado == "San Martin" ) && tieneVallado
}

class Anfiteatro inherits EspacioUrbano{
  const capacidad
  // tamanioEscenario

  override method condicionParticularEsGrande() = capacidad > 500
}


class Multiespacio inherits EspacioUrbano{
  const espacios = []

  override method condicionParticularEsGrande() = espacios.all{espacio => espacio.esGrande()}
}