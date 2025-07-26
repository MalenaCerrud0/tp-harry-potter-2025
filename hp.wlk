object sombreroSeleccionador {
  var property magosGryffindor = []
  var property magosSlytherin = []
  var property magosRavenclaw = []
  var property magosHufflepuff = []
  
  method seleccionarCasa(mago) {
    if (gryffindor.cumpleCriterios(mago)) {
      self.magosGryffindor().add(mago)
      mago.casa("gryffindor")
      return "Gryffindor"
    } else if (slytherin.cumpleCriterios(mago)) {
      self.magosSlytherin().add(mago)
      mago.casa("slytherin")
      return "Slytherin"
    } else if (ravenclaw.cumpleCriterios(mago)) {
      self.magosRavenclaw().add(mago)
      mago.casa("ravenclaw")
      return "Ravenclaw"
    } else {
      self.magosHufflepuff().add(mago)
      mago.casa("hufflepuff")
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
    return self.iq()<120 
    && self.iq()>80
  }

  method muyInteligente() {
    return self.iq() > 120
  }

  method puedeSeguir(mago) {
    return (mago.casa() == self.casa()
    && mago.iq() > self.iq() 
    && mago.esFamoso()
    && mago != self)
  }

  method seguirOtroMago(mago) {
    if (self.puedeSeguir(mago)) {
      mago.seguidores().add(self)
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
    if (!self.estaMuerto() && self.energia() >= hechizo.energia()) {
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
        self.energia(self.energia() - hechizo.x(self))
        mago.vida(mago.vida() - 2 * hechizo.x(self))
      }
      
      if (self.hechizosAprendidos().min({h => h.energiaAGastar()}) == hechizo) {
        return "El mago lanzó este hechizo con éxito y gastó la menor energía posible"
      } else {
        return "El mago lanzó este hechizo con éxito"
      }

    } else {
      self.error("El hechizo no se pudo realizar")
    }
  }

  method recibirHechizo(hechizo) {
    if (hechizo.tipo() == "sanador" 
    && !self.estaMuerto()) {
      self.vida(self.vida() + hechizo.energiaAGastar() * 2)
    } else {
      self.error("El mago está muerto")
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
}

class HechizoCombate {
  const property energiaAGastar = 200
  const property coeficiente 
  const property tipo = "combate"

}

class HechizoImperdonable {
  const property tipo = "imperdonable"
  const property coeficiente
  var property lanzador = ""

  method x() = self.coeficiente() - 4 * lanzador.seguidores().size()

  method energiaAGastar() = self.x()
}
