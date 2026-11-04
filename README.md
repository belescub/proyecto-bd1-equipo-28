 <h1 align="center"><picture> Hola, Bienvenido al repo del Grupo 28! <img align="center"src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExdW9tcnM5MzJ3ZGZuOWZvbzR2ZjhyeW1oaDJuaDFtcTVxeXQ3ZTF2OSZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/w1OBpBd7kJqHrJnJ13/giphy.gif" width="50" alt="imagen">
</picture></h1>

## Sistema de Gestion de Venta de Helados "Ice SQL" 

 <h3><picture><img src = "https://github.com/7oSkaaa/7oSkaaa/blob/main/Images/about_me.gif?raw=true" width = 50px></picture> Sobre Nosotros</h3>

<picture> <img align="right" src="https://github.com/7oSkaaa/7oSkaaa/blob/main/Images/Right_Side.gif?raw=true" width = 250px></picture>

<h3> Integrantes</h3>

- Gómez Ingrid Micaela Itatí
- Escubilla Micaela Belén  
- Meza Arrúa Francisco
- Kaczuba Ivar Tobias
- Lencinas Mauricio Alberto

<h2><picture> <img align="left"src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZXlnZTl6d21veDd1ZHQzZ3c3cjBwbDhldmw2M2xuaWN6MjlmZnM4aSZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/SsCoYqz9fnS8cRERFq/giphy.gif" width="35" alt="imagen">
</picture>Descripcion del Proyecto</h2>

<picture> <img align="right" src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMmlyMmJmNjM4bmhkcWZpNjQwczMzZW1ycG01ODBqbnpwZ3ZyMjJ0diZlcD12MV9naWZzX3NlYXJjaCZjdD1n/FHSVRgD572LeQpSEBf/giphy.gif" width = 300px></picture>

Ice SQL es un sistema de gestión de base de datos relacional (desarrollado en SQL Server) orientado a la administración integral de una heladería comercial, tomando como modelo de negocio los procesos operativos de franquicias como Grido. El sistema está diseñado para abarcar el ciclo de vida completo del negocio: desde el registro de clientes, proveedores y productos, hasta el control transaccional de cajas, stock y facturación. 
<br clear="right">

<h3>Funcionalidades y Reglas de Negocio</h3>

El modelo de datos garantiza la integridad de las operaciones comerciales mediante las siguientes reglas:
 - Gestión de Cajas: Es condición obligatoria que el vendedor realice la apertura de su caja antes de poder procesar y registrar cualquier cobro.
 - Control de Inventario Automático: El sistema registra la disponibilidad y descuenta el stock de los productos automáticamente al confirmarse una transacción.
 - Historial de Precios: Al registrar una venta, se guarda el precio unitario exacto del producto en ese instante, evitando que actualizaciones futuras alteren el historial contable de ventas pasadas.
 - Personalización de Pedidos: Soporte para múltiples métodos de pago, presentaciones con cantidades específicas y combinaciones de uno o varios sabores por producto. 

<h3>Arquitectura y Tópicos Técnicos Avanzados </h3>

Para garantizar que la base de datos sea robusta, segura y escalable, se implementaron mecanismos avanzados a nivel de motor SQL:
  - Seguridad y Control de Accesos: Implementación de un esquema basado en el principio de mínimo privilegio con perfiles específicos (Administrador, Vendedor y Consulta) mediante Logins, Usuarios y Roles, bloqueando modificaciones no autorizadas mediante sentencias DENY.
  - Manejo de Transacciones (ACID): Uso de BEGIN TRANSACTION, COMMIT y ROLLBACK para asegurar que las ventas múltiples y el descuento de stock ocurran como una unidad lógica inquebrantable.
  - Triggers de Auditoría: Mecanismos automáticos que registran toda modificación de datos sensibles (como la alteración de precios o catálogos), documentando el usuario, la fecha y el valor anterior.
  - Optimización de Consultas: Creación de Índices (CLUSTERED y NONCLUSTERED) para mejorar los tiempos de respuesta y reducir las lecturas lógicas en grandes volúmenes de datos.
  - Procedimientos y Funciones Almacenadas: Centralización de la lógica de negocio para reducir la redundancia y facilitar el mantenimiento del código. 

<h3>Módulo de Reportes Analíticos </h3>
El sistema cuenta con scripts DML complejos diseñados para la extracción de métricas clave orientadas a la toma de decisiones:
  - Generación de comprobantes y facturas detalladas con subtotales por renglón y totales acumulados. 
  - Reportes agregados de ventas y recaudación por cada vendedor, filtrados mediante rangos de fechas dinámicos.
  - Identificación automatizada de "Productos Estrella" (aquellos cuya recaudación supera el promedio general). 
    
<h2><picture> <img align="left"src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3dDUxNTBqMXJ4MHI3NHR5cXozdzVtNGE0cWYwNzNxYnFmN2Jkc25tciZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/4VOJ5yzvkniT4sSkwL/giphy.gif" width="30" alt="imagen">
  

<h2><picture> <img align="left"src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3dm1vdzN5OW1zZjJoMDdtM2Jxbm91Y2RuaGR4OTRiOGEwemxtbDBleiZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/UVG0BN8TOMKkPOJS6e/giphy.gif" width="35" alt="imagen">
</picture>Tecnologías usadas </h2>

<span> 
  <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
  <img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white">
  <img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white">
  <img src="https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=databricks&logoColor=white">
  <img src ="https://img.shields.io/badge/WhatsApp-%2325D366.svg?style=for-the-badge&logo=whatsapp&logoColor=white">
</span>

<h3> Agentes de Inteligencia Artificial </h3>
  <span>
     <img src="https://img.shields.io/badge/claude-%23D97757.svg?style=for-the-badge&logo=claude&logoColor=white">
     <img src="https://img.shields.io/badge/google%20gemini-%238E75B2.svg?style=for-the-badge&logo=google%20gemini&logoColor=white">
     <img src= "https://img.shields.io/badge/chatGPT-000000?style=for-the-badge&logo=openai&logoColor=white">
  </span>

<h2><picture> <img align="left"src="https://media.giphy.com/media/v1.Y2lkPWVjZjA1ZTQ3cWhuZ2w3dGpwZmJlY2c5b3gzOWh5azU3bnRrN2Mwd3FkajA2YWI3ayZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/CNf0N9qikZpt3k4Ihh/giphy.gif" width="50" alt="imagen">
</picture>Accesos</h2>

- [docs](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/docs)
  - [etapa1](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/docs/etapa1)
  - [etapa2/der](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/docs/etapa2/der)
- [sql](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/sql)
  - [Técnico](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/sql/T%C3%A9cnico)
  - [Consultas](https://github.com/belescub/proyecto-bd1-equipo-28/tree/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/sql/consultas)
- [README.md](https://github.com/belescub/proyecto-bd1-equipo-28/blob/721dabdd3fa8bf98d2edacafa83ef74bbb3ea66e/README.md)

<br>
<h3><picture> Hasta pronto, Saludos! <img align="center"src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExdW9tcnM5MzJ3ZGZuOWZvbzR2ZjhyeW1oaDJuaDFtcTVxeXQ3ZTF2OSZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/w1OBpBd7kJqHrJnJ13/giphy.gif" width="50" alt="imagen">
</picture></h3>
<picture>
  <img align="center" src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZHM2OHcxc2Vwa3Q5dzNlbzAxcmEyYmEzd2I2ZzZxOGtuZXVvNmkyYiZlcD12MV9naWZzX3NlYXJjaCZjdD1n/1lk1IcVgqPLkA/giphy.gif" width="350" alt="imagen">
</picture>

