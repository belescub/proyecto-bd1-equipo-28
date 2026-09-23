## Análisis de normalización

## 1FN
La primera forma normal ya se cumple: está contemplada en las tablas definidas.

## 2FN
En la entidad **INCLUYE** aparece el atributo "id_venta", que ya está presente en **DETALLE_VENTA**. Por eso es redundante: en **INCLUYE** depende solo de una parte de la clave primaria compuesta, y no de la clave completa, lo que no contempla la 2FN. Además, "id_venta" no guarda relación con la entidad **SABOR**, así que su lugar corresponde únicamente a **DETALLE_VENTA**.

**Decisión:** eliminar "id_venta" de INCLUYE y dejarlo solo en DETALLE_VENTA.

## 3FN
La relación directa entre **VENTAS** y **VENDEDOR** genera una dependencia transitiva. VENTAS ya llega al vendedor a través de su atributo no clave "id_apertura_caja", que permite obtener el "id_vendedor":

VENTAS → id_apertura_caja → id_vendedor

Al existir ese camino, la relación directa VENTAS → VENDEDOR es redundante y viola la 3FN.

**Decisión:** eliminar la relación directa VENTAS → VENDEDOR y conservar el vínculo a través de APERTURA_CAJA.