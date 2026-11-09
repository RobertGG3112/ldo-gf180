# Entorno de diseño analógico con el PDK GF180MCU (WSL 2 + Ubuntu 24.04)

Instala en tu Windows, con un solo script, las herramientas open source para diseñar circuitos CMOS en el PDK de 180 nm de GlobalFoundries:

| Herramienta | Para qué sirve |
|---|---|
| xschem | Esquemáticos y simulación pre-layout |
| ngspice | Simulador SPICE |
| magic | Layout, DRC y extracción (con parásitos) |
| netgen | LVS (layout vs. esquemático) |
| klayout | Visor/editor de layout |
| xterm | Lo necesita xschem para abrir ngspice al simular |

Versiones fijadas: PDK GF180MCU variante D (`792ef670...`, del 2026.10.19) y magic compilada del commit `9479691a...`. Así todos trabajamos con lo mismo.

Necesitas unos 5 GB libres y ~20 minutos (la mayor parte es la descarga del PDK y compilar magic).

## 1. Preparar Windows (solo una vez)

Necesitas Windows 11 (o un Windows 10 actualizado con WSLg) para que las ventanas gráficas funcionen sin configurar nada.

En **PowerShell como administrador**:

```powershell
wsl --install -d Ubuntu-24.04
```

Reinicia si te lo pide. Al abrir Ubuntu por primera vez te pedirá crear un **usuario** (en minúsculas, sin espacios) y una **contraseña**. No uses el usuario root.

Comprueba que quedó en WSL 2:

```powershell
wsl -l -v
```

## 2. Instalar el entorno

Copia `install.sh` a tu carpeta de Linux y ejecútalo. Dentro de Ubuntu:

```bash
cd ~
cp /mnt/c/Users/TU_USUARIO_WINDOWS/Downloads/install.sh .
bash install.sh
```

Cambia `TU_USUARIO_WINDOWS` por el nombre de tu carpeta de usuario en Windows. Si prefieres, copia el contenido del script a un archivo nuevo con `nano install.sh`.

- Te pedirá la contraseña de Linux (para `sudo`).
- No lo ejecutes con `sudo` ni como root.
- Si se interrumpe, puedes volver a ejecutarlo: omite lo que ya está hecho.

Al terminar debe decir **"Todo listo"**. Cierra y vuelve a abrir la terminal.

## 3. Trabajar con el repositorio del proyecto

El diseño del equipo (LDO en GF180MCU) vive en este repositorio de GitHub:

https://github.com/RobertGG3112/ldo-gf180.git

Clónalo dentro de `~/eda/projects` (nunca en `/mnt/c/...`):

```bash
cd ~/eda/projects
git clone https://github.com/RobertGG3112/ldo-gf180.git
cd ldo-gf180
```

La primera vez que uses git en esta máquina, configura tu identidad (con tus datos reales, sin los signos `<>`):

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu_correo@ejemplo.com"
```

### Copia el `xschemrc` antes de abrir xschem

El archivo `xschemrc` es el que le dice a xschem dónde están los símbolos, los modelos y las rutas del PDK. xschem lo lee de la **carpeta desde la que lo abres**, así que en cada carpeta de trabajo donde vayas a usar xschem debe haber uno. Si no, no verás los transistores del PDK o la simulación fallará.

```bash
cd ~/eda/projects/ldo-gf180/xschem      # o la subcarpeta desde la que abras xschem
cp -n $PDK_ROOT/$PDK/libs.tech/xschem/xschemrc .
xschem
```

(`-n` evita sobrescribir un `xschemrc` que ya exista ahí.)

### Cada carpeta tiene su función

Trabaja en la carpeta que corresponde a lo que estás haciendo, y abre cada herramienta desde ella:

| Carpeta | Qué se hace ahí | Herramienta |
|---|---|---|
| `xschem/` | Esquemáticos (y su simulación pre-layout) | `xschem` |
| `sim/` | Simulaciones: netlists, análisis y resultados | `ngspice archivo.spice` |
| `mag/` | Layout, DRC y extracción | `magicpdk` |
| `scripts/` | Scripts de apoyo del proyecto | (según el script) |
| `docs/paper/` | Documentación y paper del proyecto | (editor de texto) |

Cada quien abre la herramienta desde la carpeta que le corresponde (por ejemplo, `cd mag` y luego `magicpdk`). Así los archivos que genera cada herramienta quedan donde deben y el repositorio se mantiene ordenado. No guardes archivos en una carpeta que no corresponde.

### Flujo básico con git

```bash
git pull                              # SIEMPRE antes de empezar a trabajar
# ... trabajas ...
git status                            # ver qué cambió
git add .
git commit -m "Descripción corta del cambio"
git push                              # subir tus cambios
```

Si dos personas editan el mismo esquemático a la vez habrá conflictos difíciles de resolver, así que avísale al equipo qué archivo vas a tocar. No subas el PDK ni archivos temporales generados (el repositorio ya trae un `.gitignore` para varios de ellos): el PDK lo instala cada quien con el script.

El repositorio tiene varias ramas. Antes de empezar, revisa en cuál estás con `git branch` y acuerda con el equipo en cuál se trabaja.

## 4. Uso diario

Trabaja siempre dentro de `~/eda/projects`, nunca en `/mnt/c/...` (es mucho más lento).

```bash
nuevo_proyecto mi_diseno     # para proyectos propios: crea ~/eda/projects/mi_diseno y copia el xschemrc del PDK
xschem                       # esquemáticos y simulación
magicpdk                     # layout
klayout                      # visor de layout
ngspice archivo.spice
```

Simular desde xschem: dibuja el circuito con los símbolos del PDK (por ejemplo `nfet_03v3`, `pfet_03v3`), agrega un bloque de código SPICE con el análisis, y usa **Netlist** y luego **Simulate**.

En la consola de magic:

```
drc check      # reglas de diseño
drc why        # explica el error bajo el cursor
extract all    # extracción
```

## 5. Problemas frecuentes

- **Al simular en xschem no pasa nada:** falta `xterm`. Ejecuta `sudo apt install -y xterm`.
- **xschem no muestra los transistores del PDK (`nfet_03v3`, etc.) o da errores de rutas:** falta el `xschemrc` en la carpeta desde la que abriste xschem. Cópialo como se explica en la sección 3.
- **magic dice `Using technology "minimum"` y un bloque "contained errors":** estás usando la magic de apt (antigua). Comprueba con `which magic`: debe ser `~/eda/tools/local/bin/magic`. Si no, ejecuta `source ~/.bashrc`.
- **No abre ninguna ventana gráfica:** ejecuta `wsl --update` en PowerShell y luego `wsl --shutdown`.
- **`bash: syntax error near unexpected token newline`:** copiaste un texto con `<` y `>` tal cual. Reemplaza todo, incluidos los signos, por el nombre real.

## 6. Respaldo

Antes de cambios grandes, en PowerShell (no dentro de Ubuntu):

```powershell
wsl --export Ubuntu-24.04 D:\respaldo\ubuntu-eda.tar
```

(El nombre de la distro puede ser `Ubuntu`; mira cuál sale en `wsl -l -v`.)

## 7. Actualizar el PDK

No cambies de versión del PDK a mitad de un diseño. Si el equipo acuerda actualizar:

```bash
ciel ls-remote --pdk-family=gf180mcu
ciel enable --pdk-family=gf180mcu HASH_NUEVO
```

y actualiza `PDK_HASH` en `install.sh` para que los demás instalen lo mismo.
