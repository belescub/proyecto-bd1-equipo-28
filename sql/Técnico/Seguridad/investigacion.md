1. Definición y Objetivo
  La seguridad es una base de datos permite contraolar qué usuarios pueden acceder a la información
  y que operaciones pueden realizar. SQL Server gestiona esto mediante tres niveles: 
    1) Logins (Autenticación): Credenciales a nivel de servidor.
    2) Usuarios (Autorización): Identidades vinculadas a los logins dentro de una base de datos especifica. 
    3) Roles: Contenedores que agrupan privilegios (GRANT, REVOKE, DENY) para facilitar la administración y aplicación de permisos
  Objetivo:
    El objetivo principal es proteger la integridad, confidencialidad y disponibilidad de la información
    del sistema comercial, garatizando el principio de minimo privilegio. 

2. Ventajas y Aplicaciones
    -Protección de datos sensibles y registros de ventas: Evita la alteración o eliminación malintencionada de precios históricos, comprobantes de venta y registros de caja.   
    -Previsión de errores humanos: Impide que perfiles de menor rango (como cajeros o vendedores) ejecuten por accidente comandos destructivos (ej. DELETE o DROP).   
    -Administración eficiente mediante roles: Agrupar permisos en roles (Administrador, Vendedor, Consulta) permite que la gestión de accesos sea escalable y fácil de mantener al incorporar nuevos empleados.   
    -Cumplimiento de reglas de negocio: Refuerza desde la capa de la base de datos las restricciones operativas definidas en la etapa de analisis.
Aplicaciones en el Proyecto
     -Perfil Administrador (Administrador): Control total de lectura, escritura y modificación sobre todo el esquema dbo.   
     -Perfil Operativo Comercial (Vendedor): Permisos de lectura (SELECT) sobre listas de precios, productos, presentaciones y clientes, y permisos de inserción (INSERT) estrictamente sobre la apertura de caja y el registro de comprobantes de ventas (Venta, Detalle_Venta, Incluye).
     -Restricciones explícitas (DENY): Bloqueo total al rol Vendedor para eliminar registros de ventas pasadas o modificar precios vigentes en la tabla Precio.
     -Perfil Auditor / Reportería (Consulta): Permiso exclusivo de lectura (SELECT) a nivel de esquema, con bloqueo explícito (DENY INSERT, UPDATE, DELETE) para evitar cualquier tipo de modificación.
