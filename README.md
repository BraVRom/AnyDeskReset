# AnyDesk Reset Tool (Works Jan 2026)

Esta utilidad avanzada en batch automatiza el proceso de reinicio de la ID de AnyDesk, diseñada específicamente para entornos donde se requiere una regeneración limpia sin perder la configuración personal crítica.

A diferencia de otros scripts, esta versión corrige los fallos de lógica de versiones anteriores, asegurando que tus favoritos y miniaturas realmente se restauren.

## 🚀 Novedades en la v2

* **Backup:** Se corrigió un error crítico donde `user.conf` y `thumbnails` no se copiaban a la carpeta temporal antes del borrado. Ahora la restauración funciona de verdad.
* **Soporte `service.conf`:** Las versiones modernas de AnyDesk a veces guardan la ID en `service.conf` en lugar de `system.conf`. Este script ahora detecta y elimina ambos.
* **Rutas Dinámicas:** Se eliminaron las rutas "hardcodeadas". Ahora utiliza variables de entorno (`%ProgramData%`) para mayor compatibilidad con cualquier instalación de Windows.
* **Reinicio Inteligente:** Detención de procesos reforzada para evitar errores de "Acceso Denegado" cuando AnyDesk se resiste a cerrar.

## Características Principales

* **Gestión Automática de Servicios:** Detiene `AnyDeskService` y mata los procesos activos de forma forzada pero segura.
* **Backup Temporal:** Toda configuración antigua se mueve a `%TEMP%\AnyDeskBackup_[Timestamp]`. Nada se borra permanentemente; si algo sale mal, tus archivos siguen ahí.
* **Limpieza de Rastros:** Elimina archivos `.trace` para purgar logs de conexiones antiguas.
* **Barra de Progreso:** Interfaz limpia sin parpadeos (`flicker-free`) usando retorno de carro.

##  Requisitos

* **Windows 10 / 11**.
* **Ejecutar como Administrador** (Click derecho > Ejecutar como administrador).
* **AnyDesk Instalado** (Funciona tanto en instalaciones estándar como portables si están en rutas de sistema).

##  Cómo Usar

1.  **Descarga** el archivo `AnyDeskReset.bat`.
2.  **Ejecuta** el archivo con **permisos de Administrador**.
3.  **Espera** a que la magia ocurra:
    * El script cerrará AnyDesk.
    * Hará una copia de seguridad de tus Favoritos y Miniaturas.
    * Lanzará AnyDesk brevemente para forzar la generación de una nueva ID.
    * Cerrará AnyDesk nuevamente para restaurar tus datos.
4.  **Listo:** Abre AnyDesk y disfruta de tu nueva ID.

## Detalles Técnicos

El script actúa sobre las rutas críticas de datos (`%APPDATA%` y `%ProgramData%`).

### Tabla de Archivos Gestionados

| Archivo / Carpeta | Acción | Propósito |
| :--- | :--- | :--- |
| `system.conf` | **Reset** | Contiene la ID antigua en versiones clásicas. |
| `service.conf` | **Reset** | **(Nuevo)** Contiene la ID en versiones modernas/services. |
| `user.conf` | **Backup & Restore** | Mantiene tu lista de **Favoritos/Contactos**. |
| `thumbnails/` | **Backup & Restore** | Mantiene las imágenes previas de tus conexiones. |
| `*.trace` | **Delete** | Elimina el historial de logs y depuración. |

## ⚠️ Notas Importantes

* **Uso Ético:** Esta herramienta está diseñada para mantenimiento y uso personal. Por favor, apoya a los desarrolladores de software comprando una licencia si lo usas con fines comerciales.
* **Recuperación Manual:** El backup se guarda en la carpeta temporal del sistema (`%TEMP%`). Si por alguna razón necesitas recuperar tu ID anterior, busca la carpeta con la fecha más reciente allí.
* **Seguridad:** El código es transparente y `open source`. Puedes (y debes) revisarlo haciendo click derecho > Editar para ver exactamente qué comandos se ejecutan.
