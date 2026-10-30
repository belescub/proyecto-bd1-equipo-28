**Triggers**

**Definición**: Los triggers son bloques de código que se ejecutan automáticamente cuando ocurre un evento  específico en una tabla o vista de una base de datos, como insertar, eliminar o modificar un registro. A diferencia de un procedimiento común, nadie lo invoca sino que se activa solo cada vez que se modifica la tabla a la que están asociados. En este proyecto realizamos el trigger de tipo AFTER que se ejecutan después de que el cambio se realizó.

Dentro del trigger, SQL Server dispone de 2 tablas virtuales: inserted (para nuevos registros o valores actualizados) y deleted (para registros eliminados o valores antiguos) que al compararlos el trigger detecta que cambio se realizó.

El **objetivo** **principal** es la trazabilidad, es decir, contar con un historial de los cambios realizados en la información permitiendo así conocer qué operación se realizó, cuando ocurrió, que usuario lo realizó y cuáles eran los valores anteriores y los nuevos.

**Ventajas:** 

1- Trazabilidad: permite guardar y consultar los cambios realizados en los registros de la base de datos, quién los realizó y cuándo.

2- Automatización: el registro se genera siempre sin depender de que el usuario lo haga.

3- Conservación del valor anterior: una modificación común sobrescribe el dato y la auditoría conserva el valor que ya había.

**Aplicaciones:**

1- Historial: Guarda los registros modificados o eliminados en una tabla de respaldo para cumplir con las normativas de seguridad o financieras.

2- Monitoreo de datos sensibles: registra las modificaciones en tablas importantes como las de precios de productos, stock o salarios.

3- Control: identifica anomalías, errores o comportamientos no autorizados mediante el registro de operaciones DML críticas.

4- Sincronización de datos: replica de forma inmediata los cambios de una tabla principal a una tabla de respaldo.

Aplicando al sistema de ventas ICE\_SQL:  

En la heladería tenemos el precio de cada presentación (tabla PRECIO) que determina el importe de todas las ventas y el stock de cada producto (tablas PRODUCTO) que determina qué se puede vender, si alguien llegara a modificarlos el sistema debe de responder quién lo hizo, cuando y el valor anterior. Para eso, implementamos 2 tablas de auditoría (auditoría\_Precio y auditoria\_Producto) y 2 triggers (trg\_Precio\_Auditoria, trg\_Producto\_Auditoria).

Ambos triggers se disparan ante INSERT, UPDATE y DELETE, cada registro guarda además la fecha y hora con SYSDATETIME(), el usuario con SUSER\_SNAME() y el tipo de operación. Solo se audita cuando hay un cambio real por ejemplo si modificamos el precio y dejamos el mismo valor entonces no se genera un registro. Las tablas de auditoría no tienen FK hacia las tablas originales para que el historial se conserve aunque el registro original se elimine.

Por ejemplo: al modificar el precio de “vaso chico” de $2500 a $2800 entonces el trigger genera automáticamente un registro con la operación UPDATE precio\_anterior =2500.00, precio\_nuevo = 2800.00, la fecha y hora del cambio y el usuario que lo realizó. De esa misma forma trabaja si el stock de un producto baja de 20 a 15, ambos valores quedan registrados.



