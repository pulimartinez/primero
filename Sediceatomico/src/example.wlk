object springfield{
	var vientos = 10
	var riqueza = 0.9
	var densidadEnergetica = 20
	var listaDeCentrales = [centralAtomicaBurns,centralDeCarbon,centralEolica]
	
	method vientos(){
		return vientos
	}
	
	method riqueza(){
		return riqueza
	}
	method densidadEnergetica(){
		return densidadEnergetica
	}
	
	 method centralesContaminantes(){
	 	return listaDeCentrales.filter({
	 		central => central.contaminacion()
	 		})
	 }
	 method centralContaminantes(){
	 	return self.centralesContaminantes().head()
	 }
	method estaEnElHorno(){
		return self.produceMasDe50() or self.sonTodasContaminantes()
		}
		
	method produceMasDe50 (){
		return (self.centralesContaminantes()).all({
			central => central.masDel50()
		})
			}
		
	method masDel50(central){
		return central.produccionEnergetica() > 0.5
	}
	method sonTodasContaminantes(){
		return listaDeCentrales.all({
			central => central.contaminacion() 
		})
	}
	method sumarLasProduccionesEnergeticas(){
		return listaDeCentrales.sum({
			central => central.produccionEnergetica()
		})
	}
	method cubrioSusNecesidades(){
		return self.sumarLasProduccionesEnergeticas() > self.densidadEnergetica()
	}
	
	method centralQueMasProduce(){
		return listaDeCentrales.max({
			central=> central.produccionEnergetica()
		})
	}
	  
}

object albuquerque {
	var caudal = 150
	var listaCentral = [centralHidroelectrica]
	
	method caudal(){
	return caudal
	}
	
	method centralQueMasProduce(){
		return listaCentral.max({
			central=> central.produccionEnergetica()
		})
	}
		}

object centralHidroelectrica {
	
	method produccionEnergetica(){
		return 2 * albuquerque.caudal()
	}
}

object centralAtomicaBurns{
	var varilla = 10
	method produccionEnergetica () {
		return 0.1 * self.varilla()
		 }
	method varilla(){
		return varilla
	}
	method contaminacion (){
		return self.varilla() == 20 
	}
	method masDel50(){
		return self.produccionEnergetica() > 0.5
	}
}

object centralDeCarbon{
	var toneladas = 20
	method produccionEnergetica (){
		return 0.5 + self.toneladas() * springfield.riqueza()
	}
	method contaminacion(){
		return true
	}
	method toneladas(){
		return toneladas
	}
	method masDel50(){
		return self.produccionEnergetica() > 0.5
	}
		
}
object turbina1{
	method produccionTurbina(){
	 return 0.2 * springfield.vientos()
	} 
}
object centralEolica {
	var listaTurbinas = [turbina1]

	method produccionEnergetica (){
	return listaTurbinas.sum({turbina => turbina.produccionTurbina()})
	}
	
	method contaminacion(){
		return false
	}
	method masDel50(){
		return self.produccionEnergetica() > 0.5
	}
	
}