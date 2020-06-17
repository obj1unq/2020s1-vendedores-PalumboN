class Vendedor {

	const certificaciones = []

	// Patrón: Template method. Sirve cuando tengo un algoritmo que implica una lógica general y otra particular.
	method puedeTrabajar(ciudad) {
		return self.tieneCertificacion() or self.cumpleCondicionParaTrabajar(ciudad)
	}

//	Esto sería para usarlo con super(ciudad), pero terminaríamos repitiendo un poco de lógica
//	method puedeTrabajar(ciudad) {
//		return self.tieneCertificacion() 
//	}
	method tieneCertificacion() {
		return not certificaciones.isEmpty()
	}

	method cumpleCondicionParaTrabajar(ciudad) // Método abstracto
	
	method esVersatil() {
		return 	self.tieneVariasCertificaciones() and  
				self.tieneCertificacionDeProducto() and  
				self.tieneCertificacionDeNoProducto()
	}
	
	method tieneVariasCertificaciones() {
		return certificaciones.size() >= 3 
	}
	
	method tieneCertificacionDeProducto() {
		return certificaciones.any({certificacion => certificacion.esSobreProducto()})
	}
	
	method tieneCertificacionDeNoProducto() {
		return certificaciones.any({certificacion => not certificacion.esSobreProducto()})
	}
	
	method esFirme() {
		return self.puntajeTotal() >= 30
	}
	
	method puntajeTotal() {
		return certificaciones.sum({certificacion => certificacion.puntos()}) 
	}

}

class VendedorFijo inherits Vendedor {

	const ciudadDondeVive

//	override method puedeTrabajar(ciudad) { return super(ciudad) or self.cumpleCondicionParaTrabajar(ciudad) }

	override method cumpleCondicionParaTrabajar(ciudad) {
		return ciudadDondeVive == ciudad
	}

}

class VendedorViajante inherits Vendedor {

	const provinciasHabilitadas = []

//	override method puedeTrabajar(ciudad) { return super(ciudad) or self.cumpleCondicionParaTrabajar(ciudad) }

	override method cumpleCondicionParaTrabajar(ciudad) {
		return provinciasHabilitadas.contains(ciudad.provincia())
	}

}

class ComercioCorresponsal inherits Vendedor {

	const cudadesConSucursales = []

//	override method puedeTrabajar(ciudad) { return super(ciudad) or self.cumpleCondicionParaTrabajar(ciudad) }

	override method cumpleCondicionParaTrabajar(ciudad) {
		return cudadesConSucursales.contains(ciudad)
	}

}




class Certificacion {

	const property puntos = 0
	const property esSobreProducto = false

}

class Ciudad {

	const property provincia

}

class Provicia {

	const poblacion

}

