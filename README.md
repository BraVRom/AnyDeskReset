# AnyDesk Reset Tool v3 (Works Oct 2026)

```
  /\_/\
 ( o.o )   AnyDesk Reset
  > ^ <    by Br4hx
```

Script `.bat` que regenera la ID de AnyDesk. Útil contra el aviso de **cuenta atrás de 100 o 999 segundos** en sesiones de uso no comercial.

## Uso

1. Descarga `AnyDeskReset.bat`.
2. Doble clic. Si no eres administrador, se auto-eleva (UAC).
3. Espera ~13s máx. Muestra la ID nueva y se cierra solo.

## Qué hace

1. Para `AnyDeskService` y mata `AnyDesk.exe`.
2. Mueve `system.conf` y `service.conf` a `%TEMP%\AnyDeskBackup_<fecha>`.
3. Borra los `*.trace`.
4. Arranca servicio y AnyDesk, que generan una ID nueva.
5. Espera a que aparezca `system.conf` (máx. 20s) y muestra la ID.

| Archivo / carpeta | Acción | Motivo |
|---|---|---|
| `system.conf` | Mover a backup | Guarda la ID |
| `service.conf` | Mover a backup | Config del servicio (puede guardar ID) |
| `*.trace` | Borrar | Logs |
| `user.conf` | Intacto | Favoritos y ajustes |
| `thumbnails/` | Intacto | Miniaturas |

Favoritos y miniaturas no se tocan, así que no hay restauración que pueda fallar.

## Requisitos

- Windows 10 / 11
- AnyDesk instalado (`%ProgramFiles(x86)%` o `%ProgramFiles%`)
- Permisos de administrador (pide UAC solo)

## Recuperar la ID vieja

Copia los archivos de `%TEMP%\AnyDeskBackup_<fecha>` de vuelta a:

- `%APPDATA%\AnyDesk` (prefijo `roaming_`)
- `%ProgramData%\AnyDesk` (prefijo `pd_`)

Quita el prefijo al copiar y cierra AnyDesk antes.

## Easter egg

Pulsa **R** mientras espera la ID nueva. 🎵

## Notas

- Código abierto y corto: léelo antes de ejecutarlo (clic derecho → Editar).
- Para uso personal. Si usas AnyDesk con fines comerciales, compra licencia.
- Uso bajo tu responsabilidad. El backup existe por algo.
