#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Instalador del entorno de diseno analogico con el PDK GF180MCU
# Para WSL 2 + Ubuntu 24.04. Uso:  bash install.sh
#
# Instala: xschem, ngspice, netgen, klayout, xterm, magic (compilada) y el
# PDK GF180MCU (variante D) con versiones fijas para que todos tengan lo mismo.
# ---------------------------------------------------------------------------
set -euo pipefail

# ----- Versiones fijadas (cambiarlas solo de comun acuerdo) -----------------
PDK_FAMILY="gf180mcu"
PDK_VARIANT="gf180mcuD"
PDK_HASH="792ef67037d74c8c51811eab3ce23cf793491296"      # PDK del 2026.10.19
MAGIC_COMMIT="9479691a649fff9b0915436006560b060180ba40"  # magic compilada

# ----- Rutas -----------------------------------------------------------------
EDA_DIR="$HOME/eda"
export PDK_ROOT="$EDA_DIR/pdks"
export PDK="$PDK_VARIANT"
MAGIC_PREFIX="$EDA_DIR/tools/local"

paso()  { echo; echo "==> $*"; }
aviso() { echo "AVISO: $*" >&2; }
fallo() { echo "ERROR: $*" >&2; exit 1; }

# ----- 0. Comprobaciones -----------------------------------------------------
[ "$(id -u)" -ne 0 ] || fallo "No ejecutes el script como root. Usa tu usuario normal (sin sudo): bash install.sh"

if [ -r /etc/os-release ]; then
  . /etc/os-release
  if [ "${ID:-}" != "ubuntu" ] || [ "${VERSION_ID:-}" != "24.04" ]; then
    aviso "Este script esta pensado para Ubuntu 24.04 y tienes ${PRETTY_NAME:-otro sistema}. Puede que algo falle."
  fi
fi

# ----- 1. Paquetes del sistema ----------------------------------------------
paso "Instalando paquetes del sistema (pedira tu contrasena de sudo)"
sudo apt update
sudo apt install -y \
  build-essential git python3 python3-pip python3-venv pipx \
  tcsh csh m4 tcl-dev tk-dev libcairo2-dev libx11-dev \
  mesa-common-dev libglu1-mesa-dev libncurses-dev \
  ngspice netgen klayout xschem xterm

# ----- 2. Carpetas -----------------------------------------------------------
paso "Creando carpetas en $EDA_DIR"
mkdir -p "$EDA_DIR"/{pdks,tools,projects}

# ----- 3. ciel y el PDK ------------------------------------------------------
paso "Instalando ciel (gestor de PDKs)"
export PATH="$HOME/.local/bin:$PATH"
pipx install ciel || pipx upgrade ciel || true
command -v ciel >/dev/null || fallo "No se encontro el comando ciel tras instalarlo."

paso "Descargando y activando el PDK $PDK_FAMILY ($PDK_HASH). Pesa ~1 GB, puede tardar"
ciel enable --pdk-family "$PDK_FAMILY" "$PDK_HASH"
[ -d "$PDK_ROOT/$PDK_VARIANT" ] || fallo "No aparece $PDK_ROOT/$PDK_VARIANT despues de activar el PDK."

# ----- 4. magic (compilada desde fuente) -------------------------------------
STAMP="$MAGIC_PREFIX/.magic-commit"
if [ -f "$STAMP" ] && [ "$(cat "$STAMP")" = "$MAGIC_COMMIT" ]; then
  paso "magic ya esta compilada en la version correcta, se omite"
else
  paso "Compilando magic (version fija $MAGIC_COMMIT). Tarda unos minutos"
  if [ -d "$EDA_DIR/tools/magic/.git" ]; then
    git -C "$EDA_DIR/tools/magic" fetch --all --quiet
  else
    git clone https://github.com/RTimothyEdwards/magic.git "$EDA_DIR/tools/magic"
  fi
  git -C "$EDA_DIR/tools/magic" checkout --quiet "$MAGIC_COMMIT"
  (
    cd "$EDA_DIR/tools/magic"
    ./configure --prefix="$MAGIC_PREFIX"
    make -j"$(nproc)"
    make install
  )
  echo "$MAGIC_COMMIT" > "$STAMP"
fi

# ----- 5. Configuracion del terminal (~/.bashrc) -----------------------------
MARCA_INI="# >>> entorno-gf180 >>>"
MARCA_FIN="# <<< entorno-gf180 <<<"
if grep -qF "$MARCA_INI" "$HOME/.bashrc"; then
  paso "~/.bashrc ya tiene la configuracion, se omite"
else
  paso "Agregando la configuracion a ~/.bashrc"
  cat >> "$HOME/.bashrc" <<'EOF'

# >>> entorno-gf180 >>>
export PATH="$HOME/.local/bin:$HOME/eda/tools/local/bin:$PATH"
export PDK_ROOT="$HOME/eda/pdks"
export PDK=gf180mcuD
alias magicpdk='magic -d XR -rcfile $PDK_ROOT/$PDK/libs.tech/magic/${PDK}.magicrc'
# nuevo_proyecto NOMBRE: crea la carpeta y copia el xschemrc del PDK
nuevo_proyecto() {
  [ -n "$1" ] || { echo "Uso: nuevo_proyecto NOMBRE"; return 1; }
  mkdir -p "$HOME/eda/projects/$1" && cd "$HOME/eda/projects/$1" || return 1
  cp "$PDK_ROOT/$PDK/libs.tech/xschem/xschemrc" .
}
# <<< entorno-gf180 <<<
EOF
fi
export PATH="$MAGIC_PREFIX/bin:$PATH"

# ----- 6. Verificacion -------------------------------------------------------
paso "Verificando la instalacion"
ERRORES=0

echo "- magic:   $(command -v magic || echo 'NO ENCONTRADA')"
echo "- version: $(magic --version 2>/dev/null || echo '?')"
echo "- ngspice: $(ngspice --version 2>/dev/null | grep -m1 -i 'ngspice-' || echo '?')"
echo "- xterm:   $(command -v xterm || echo 'NO ENCONTRADO')"
echo "- xschem:  $(command -v xschem || echo 'NO ENCONTRADO')"
echo "- netgen:  $(command -v netgen || echo 'NO ENCONTRADO')"
echo "- klayout: $(command -v klayout || echo 'NO ENCONTRADO')"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Tecnologia de magic (sin abrir ventana)
RC="$PDK_ROOT/$PDK/libs.tech/magic/${PDK}.magicrc"
if echo "quit" | magic -dnull -noconsole -rcfile "$RC" 2>&1 | grep -q "Using technology \"$PDK\""; then
  echo "- magic carga la tecnologia $PDK: OK"
else
  aviso "magic no cargo la tecnologia $PDK correctamente."
  ERRORES=$((ERRORES+1))
fi

# Simulacion de prueba con un transistor del PDK
cat > "$TMP/prueba.spice" <<EOF
* Prueba NMOS 3.3V gf180mcu
.lib $PDK_ROOT/$PDK/libs.tech/ngspice/sm141064.ngspice typical
.include $PDK_ROOT/$PDK/libs.tech/ngspice/design.ngspice
Vds d 0 1.65
Vgs g 0 3.3
XM1 d g 0 0 nfet_03v3 W=10u L=0.28u
.control
op
print -i(Vds)
.endc
.end
EOF
if ngspice -b "$TMP/prueba.spice" > "$TMP/salida.log" 2>&1 \
   && ! grep -qiE "error|could not find" "$TMP/salida.log" \
   && grep -qiE "i\(vds\) *= *[-0-9.e+]+" "$TMP/salida.log"; then
  echo "- ngspice simula un nfet_03v3 del PDK: OK"
else
  aviso "La simulacion de prueba con ngspice fallo. Revisa: $TMP/salida.log"
  trap - EXIT
  ERRORES=$((ERRORES+1))
fi

echo
if [ "$ERRORES" -eq 0 ]; then
  echo "Todo listo. Cierra y vuelve a abrir la terminal (o ejecuta: source ~/.bashrc)."
  echo "Para empezar un proyecto:  nuevo_proyecto mi_diseno"
else
  echo "La instalacion termino con $ERRORES advertencia(s). Copia el mensaje y consultalo antes de seguir."
  exit 1
fi
