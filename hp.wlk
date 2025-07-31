object sombreroSeleccionador {
  var property magosGryffindor = []
  var property magosSlytherin = []
  var property magosRavenclaw = []
  var property magosHufflepuff = []
  
  method seleccionarCasa(mago) {
    if (gryffindor.cumpleCriterios(mago)) {
      self.magosGryffindor().add(mago)
      mago.casa("Gryffindor")
      return "Gryffindor"
    } else if (slytherin.cumpleCriterios(mago)) {
      self.magosSlytherin().add(mago)
      mago.casa("Slytherin")
      return "Slytherin"
    } else if (ravenclaw.cumpleCriterios(mago)) {
      self.magosRavenclaw().add(mago)
      mago.casa("Ravenclaw")
      return "Ravenclaw"
    } else {
      self.magosHufflepuff().add(mago)
      mago.casa("Hufflepuff")
      return "Hufflepuff"
    }
  }

  method sonDeMismaCasa(mago1, mago2) {
    return mago1.casa() == mago2.casa()
  }
}


///// MAGOS /////

class Mago {
  var property iq
  var property pelo = "" 
  var property sangre = ""
  var property seguidores = []
  var property casa = "ninguna"
  var property vida = 1000
  var property energia = 1000
  var property poderDeSuVarita
  var property hechizosAprendidos = []

  method inteligenciaPromedio() {
    return self.iq() < 120 
    && self.iq() >= 80
  }

  method muyInteligente() {
    return self.iq() >= 120
  }

  method puedeSeguirA(mago) {
    return (mago.casa() == self.casa()
    && (mago.iq() > self.iq() 
    || mago.esFamoso())
    && mago != self)
  }

  method seguirA(mago) {
    if (self.puedeSeguirA(mago)) {
      mago.seguidores().add(self)
      return
    } else {
      return "No puede seguir a este mago"
    }
  }

  method estaMuerto() {
    return self.vida() == 0
  }

  method esFamoso() {
    return self.seguidores().size() > 3 
  }

  method puedeAprenderHechizo(hechizo) {
    return (hechizo.tipo() == "sanador" 
    && self.esFamoso())
  }

  method aprender(hechizo) = self.hechizosAprendidos().add(hechizo) 

  method lanzarHechizoA(hechizo, mago) {
    if (!self.estaMuerto() && self.energia() >= hechizo.energiaAGastar()) {
      if (hechizo.tipo() == "sanador" || hechizo.tipo() == "combate") {
        self.energia(self.energia() - hechizo.energiaAGastar())
        
        if (hechizo.tipo() == "sanador") {
          if (self.puedeAprenderHechizo(hechizo)) {
            mago.recibirHechizo(hechizo)
          }
        } else if (hechizo.tipo() == "combate") {
          mago.vida(mago.vida() - (5 * hechizo.coeficiente() + self.poderDeSuVarita()))
        }
      } else { //hechizo.tipo() == "imperdonable"
        hechizo.x(self)
        self.energia(self.energia() - hechizo.energiaAGastar())
        mago.vida(mago.vida() - 2 * hechizo.energiaAGastar())
      }
      
      if (self.hechizosAprendidos().min({h => h.energiaAGastar()}) == hechizo) {
        return "El mago lanzó  hechizo con éxito y gastó la menor energía posible"
      } else {
        return "El mago lanzó hechizo con éxito"
      }

    } else {
      return "El hechizo no se pudo realizar"
    }
  }

  method recibirHechizo(hechizo) {
    if (hechizo.tipo() == "sanador" 
    && !self.estaMuerto()) {
      self.vida(self.vida() + hechizo.energiaAGastar() * 2)
      return
    } else {
      return "El mago está muerto"
    }
  }

}

///// CASAS /////

object gryffindor {

  method cumpleCriterios(mago) {
    return (mago.inteligenciaPromedio() 
    || mago.pelo() == "pelirojo")
  }

}

object slytherin {

  method cumpleCriterios(mago) {
    return (mago.sangre() != "sucia")
  }

}

object ravenclaw {

  method cumpleCriterios(mago) {
    return mago.muyInteligente()
  }

}

///// HECHIZOS /////
class HechizoSanador {
  const property energiaAGastar
  const property tipo = "sanador"
  var property lanzador = ""
}

class HechizoCombate {
  const property energiaAGastar = 200
  const property coeficiente 
  const property tipo = "combate"
  var property lanzador = ""
}

class HechizoImperdonable {
  const property tipo = "imperdonable"
  const property coeficiente
  var property energiaAGastar = 0

  method x(mago) {
    self.energiaAGastar(self.coeficiente() - 4 * mago.seguidores().size())
  }
}