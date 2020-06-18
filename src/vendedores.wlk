class Vendedor {

	const certificaciones = []
	var property modoDeOperar
	
	method agregarCertificacion(certificacion) {
		certificaciones.add(certificacion)
	}

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
	
	
	
	method esInfluyente(ciudad) {
		return self.puedeTrabajar(ciudad) and self.esFamoso()
	}
	
	method esFamoso() {
		return modoDeOperar.esFamoso(self)
	}
	
	method algunaCeritificacionConMasDe(puntaje) {
		return certificaciones.any({certificacion => certificacion.puntos() > puntaje})
	}
	
	method tieneAfinidad(centro) {
		return self.puedeTrabajar(centro.ciudad())
	}
	
	method esCandidato(centro) {
		return self.esVersatil() and self.tieneAfinidad(centro)
	}
	
	method certificacionesSobreProductos() {
		return certificaciones.filter({certificacion => certificacion.esSobreProducto()})
	}
	
	method esPersonaFisica() {
		return true
	}

}

// State-less: No tienen estado
object insistente {
	method esFamoso(vendedor) { return vendedor.esFirme() }
}

object practico {
	method esFamoso(vendedor) { return vendedor.esVersatil() and vendedor.algunaCeritificacionConMasDe(10) }
}


// HERENCIA [tipo de vendedor]: 
//  - Solo tenemos un tiro. Subclase por tipo de vendedor, entonces no puedo subclasear por ninguna otra cualidad.
//  - Hay solamente un objeto implicado, el método llokup hace la magia.
//  - No se puede camiar la naturaleza del objeto.

// COMPOSICION (Strategy) [modo de operar]: 
//  - Reificar (modelar) con otros objetos y usar polimorfismo. Tener otra jerarquía
//  - Hay por lo menos 2 objetos involucrados: el principal y el compuesto.
//  - Se puede cambiar el comportamiento en runtime.

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

	override method tieneAfinidad(centro) {
		return super(centro) and self.existeCiudadConSucursalQueNoPuedeCubrir(centro)
	}
	
	method existeCiudadConSucursalQueNoPuedeCubrir(centro) {
		return cudadesConSucursales.any({ ciudad => not centro.puedeCubrir(ciudad) })
	}
	
	override method esPersonaFisica() {
		return false
	}
}



class CentroDeDistribucion {
	const property ciudad
	const vendedores = []
	
	method contratar(vendedor) {
		self.validarNoEstaContratado(vendedor)
		vendedores.add(vendedor)
	}
	
	method validarNoEstaContratado(vendedor) {
		if (vendedores.contains(vendedor)) {
			self.error("El vendedor ya se encuentra en el centro")
		}
	}
	
	method vendedorEstrella() {
		return vendedores.max({vendedor => vendedor.puntajeTotal() })
	}
	
	method puedeCubrir(_ciudad) {
		return vendedores.any({vendedor => vendedor.puedeTrabajar(_ciudad) })
	}
	
	method vendedoresGenericos() {
		return vendedores.filter({vendedor => not vendedor.esInfluyente(ciudad) })
	}
	
	method esRobusto() {
		return self.cantVendedoresFirmes() >= 3
	}
	
	method cantVendedoresFirmes() {
		return vendedores.count({vendedor => vendedor.esFirme() })
	}
	
	method repartirCertificacion(certificacion) {
		vendedores.forEach({vendedor => vendedor.agregarCertificacion(certificacion) })
	}
}



object clienteInseguro {
	method puedeSerAtendido(vendedor) {
		return vendedor.esVersatil() and vendedor.esFirme()
	}
}

object clienteDetallista {
	method puedeSerAtendido(vendedor) {
		return vendedor.certificacionesSobreProductos().size() >= 3
	}
}

object clienteHumanista {
	method puedeSerAtendido(vendedor) {
		return vendedor.esPersonaFisica()
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

