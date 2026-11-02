Indices
¿Qué es un índice?
Un índice es una estructura que utiliza SQL Server para encontrar datos de una tabla de manera más rápida. Funciona parecido al índice de un libro: permite buscar la información sin tener que revisar todo desde el principio.
¿Para qué sirven?
Sirven para mejorar las consultas, principalmente cuando buscamos registros por alguna columna o filtramos por un rango de valores, por ejemplo las ventas realizadas entre dos fechas.
Ventajas
- Permiten encontrar registros con menos lecturas de datos.
- Pueden reducir el tiempo de respuesta de las consultas.
- Son útiles para búsquedas, filtros y relaciones entre tablas.
- Ayudan cuando la base de datos empieza a tener muchos registros.
Desventajas
- Ocupan espacio adicional en la base de datos.
- Pueden hacer más lentas las operaciones INSERT, UPDATE y DELETE, porque SQL Server también tiene que mantener los índices.
- No conviene crear índices en todas las columnas sin analizar las consultas.

Tipos de índices utilizados
Índice agrupado (CLUSTERED): organiza los registros de la tabla según la clave del índice. Una tabla puede tener un solo índice agrupado.
Índice no agrupado (NONCLUSTERED): mantiene una estructura de búsqueda separada de los datos de la tabla. Puede haber varios por tabla.
Índice con cobertura: es un índice que tiene todas las columnas necesarias para resolver una consulta. En nuestro caso se utilizó fecha_venta como clave y se agregó importe con INCLUDE.
¿Cuándo conviene usarlos?
Conviene utilizarlos cuando una tabla tiene muchos registros y se hacen consultas frecuentes con filtros, como buscar ventas por fecha o consultar los productos vendidos. Antes de crearlos hay que revisar si ya existe alguno que cumpla la misma función.

