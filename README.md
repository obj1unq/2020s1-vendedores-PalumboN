# Vendedores y centros de distribución

López y López es una empresa de distribución de productos de consumo masivo, que se distribuyen en ciudades repartidas por toda la geografía nacional. 

Su organización está basada en **centros de distribución**. Cada centro trabaja con distintos **vendedores**.

Se nos pide desarrollar un modelo de los centros, los vendedores, y la relación entre ellos.


## Vendedores
López y López recluta vendedores de tres tipos:
- **Vendedor fijo**: se sabe en qué ciudad vive.
- **Viajante**: cada viajante está habilitado para trabajar en algunas provincias, se sabe cuáles son.
- **Comercio corresponsal**: son comercios que tienen sucursales en distintas ciudades. Se sabe, para cada comercio corresponsal, en qué ciudades tiene sucursales.

De cada ciudad debemos registrar en qué provincia está, y de cada provincia, la población.

De cada vendedor, se tiene detalle de las **certificaciones** que posee.
Cada certificación otorga una cantidad de _puntos_. Algunas certificaciones son sobre productos, otras no. 

Desarrollar un modelo de vendedores que permita consultar:
- dada una ciudad, si un vendedor _puede trabajar_ en esa ciudad. Para ello se debe cumplir que tenga alguna certificación ó una condición depende del tipo de vendedor, como se indica a continuación
	- _vendedor fijo_: debe ser la ciudad en la que vive.
	- _viajante_: la ciudad debe estar en una provincia en la que está habilitado.
	- _comercio corresponsal_: debe ser una ciudad en la que tiene sucursal.
- si un vendedor _es versátil_. Las condiciones son: que tenga al menos tres certificaciones, que tenga al menos una sobre productos, y al menos una que no sea sobre productos.
- si un vendedor _es firme_. La condición es que el puntaje total que le otorgan sus certificaciones sea mayor o igual a 30.

<br>

## Vendedor influyente
Agregar al modelo la capacidad de indicar si un vendedor _es influyente_ en una ciudad. Esto implica que el vendedor puede trabajar en dicha ciudad y, además, _es famoso_. Un vendedor es famoso dependiendo del modo de operar que use:
- _inisistente_: los vendedores insistentes bastan con ser firmes para ser famosos.
- _práctico_: los vendedores prácticos deben ser versátiles y tener alguna certificación con más de 10 puntos.
 
<br>

## Centros de distribución
Agregar al modelo los **centros de distribución**, de cada uno se sabe en qué ciudad está, y con qué vendedores trabaja.

Debe poder _agregarse_ un vendedor a un centro. Si el vendedor ya está registrado para el centro, debe generarse un error.

Debe poder consultarse, para un centro de distribución:
- el _vendedor estrella_, que es el que tiene mayor puntaje total por certificaciones.
- si _puede cubrir_, o no, una ciudad dada. La condición es que al menos uno de los vendedores registrados pueda trabajar en esa ciudad.
- la colección de _vendedores genéricos_ registrados. Un vendedor se considera genérico si no es influyente.
- si _es robusto_, la condición es que al menos 3 de sus vendedores registrados sea firme.

<br>

## Repartir certificación
Agregar la posibilidad de indicarle a un centro de distribución que _reparta una certificación_ dada. El centro debe agregar esa certificación a cada uno de sus vendedores registrados.

<br>

## Afinidad, vendedor candidato
Agregar al modelo la _afinidad_ que un vendedor puede tener por un centro de distribución, y la noción de _vendedor candidato_ para un centro.

Para un vendedor, se dice que _tiene afinidad_ con un centro de distribución, si el vendedor puede trabajar en la ciudad en la que está el centro. 
Para los comercios correspondientes se agrega una condición adicional: que haya al menos una ciudad en la que el comercio tiene sucursales, y que el centro no puede cubrir.

Además, un vendedor es _candidato_ para un centro si: es versátil, y tiene afinidad por el centro.

<br>

## Clientes
Agregar al modelo los **clientes** de López y López. 
Lo único que debe resolverse es si un cliente _puede ser atendido_ por un determinado vendedor. La condición depende de las características del cliente:
- **cliente inseguro**: el vendedor debe ser versátil y firme.
- **cliente detallista**: el vendedor debe tener, al menos, tres certificaciones sobre productos.
- **cliente humanista**: el vendedor debe ser una _persona física_. Los vendedores fijos y los viajantes son personas físicas, los comercios corresponsales no.
