v {xschem version=3.4.4 file_version=1.2

* Copyright 2022 GlobalFoundries PDK Authors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     https://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.

}
G {}
K {}
V {}
S {}
E {}
N -120 -1150 -100 -1150 {
lab=VSp}
N -100 -1180 -100 -1150 {
lab=VSp}
N -120 -1180 -100 -1180 {
lab=VSp}
N -480 -1200 -410 -1200 {
lab=Vgn}
N -480 -1140 -480 -1130 {
lab=GND}
N -370 -1170 -370 -1160 {
lab=GND}
N -120 -1120 -120 -1110 {
lab=GND}
N -120 -1190 -120 -1180 {
lab=VSp}
N -370 -1240 -370 -1230 {
lab=Vdn}
N -560 -1150 -560 -1130 {
lab=GND}
N -560 -1240 -560 -1210 {
lab=Vdn}
N -560 -1240 -370 -1240 {
lab=Vdn}
N 20 -1120 20 -1100 {
lab=GND}
N 20 -1190 20 -1180 {
lab=VSp}
N -120 -1190 20 -1190 {
lab=VSp}
N -220 -1150 -160 -1150 {
lab=Vgp}
N -220 -1180 -220 -1150 {
lab=Vgp}
N -220 -1240 -120 -1240 {
lab=VSp}
N -120 -1240 -120 -1190 {
lab=VSp}
C {gf180mcu_fd_pr/nfet3_03v3.sym} -390 -1200 0 0 {name=M1
L=1u
W=10u
body=GND
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/pfet_03v3.sym} -140 -1150 0 0 {name=M2
L=1u
W=10u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {vsource.sym} -480 -1170 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} -560 -1180 0 0 {name=V2 value=1.8 savecurrent=false}
C {gnd.sym} -480 -1130 0 0 {name=l1 lab=GND}
C {gnd.sym} -370 -1160 0 0 {name=l2 lab=GND}
C {gnd.sym} -120 -1110 0 0 {name=l3 lab=GND}
C {gnd.sym} -560 -1130 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -420 -1200 1 0 {name=p1 sig_type=std_logic lab=Vgn
}
C {vsource.sym} 20 -1150 0 0 {name=V3 value=1.8 savecurrent=false}
C {gnd.sym} 20 -1100 0 0 {name=l5 lab=GND}
C {lab_pin.sym} -370 -1240 1 0 {name=p2 sig_type=std_logic lab=Vdn
}
C {lab_pin.sym} -40 -1190 1 0 {name=p3 sig_type=std_logic lab=VSp
}
C {code.sym} -570 -1580 0 0 {name=Curvas_dc
spice_ignore=1
only_toplevel=true
value="

.control
  save all

* ======================= CONFIGURACIÓN PERSONALIZADA DE COLORES Y ESTILO ========================
set color0=white \\* Fondo blanco (o 'black' si prefieres fondo oscuro) [1, 2] 
set color1=black \\* Texto y rejilla negros (si el fondo es blanco) [1, 2] 
set color2=red \\* 1ª curva
set color3=blue \\* 2ª curva
set color4=green \\* 3ª curva
set color5=magenta \\* 4ª curva
set color6=cyan \\* 5ª curva
set color7=orange \\* 6ª curva
set color8=darkgreen \\* 7ª curva
set xbrushwidth=2 \\* Hace el trazo de las curvas más grueso y visible [2, 4]

  * ===== NMOS =====
  dc V2 0 3.3 0.01 V1 0 3.3 0.55
  plot -i(V2) title 'NMOS Output' xlabel 'VDS' ylabel 'ID'

  dc V1 0 3.3 0.01 V2 0.55 3.3 0.55
  plot -i(V2) title 'NMOS Transfer' xlabel 'VGS' ylabel 'ID'

  alter V2 = 1.65
  dc V1 0 3.3 0.01
  let idn = -i(V2)
  let gmn = deriv(idn)
  let gmidn = gmn/idn
  plot gmidn vs idn xlog xlimit 1e-9 1e-3 ylimit 0 35 title 'NMOS gm/Id' xlabel 'ID' ylabel 'gm/ID (1/V)'

  * ===== PMOS (V3 = VSD, V4 = VGS negativo, referido a la fuente) =====
  dc V3 0 3.3 0.01 V4 0 -3.3 -0.55
  plot -i(V3) title 'PMOS Output' xlabel 'VSD' ylabel '|ID|'

  dc V4 0 -3.3 -0.01 V3 0.55 3.3 0.55
  plot -i(V3) title 'PMOS Transfer' xlabel 'VGS' ylabel '|ID|'

  alter V3 = 1.65
  dc V4 0 -3.3 -0.01
  let idp = -i(V3)
  let gmp = abs(deriv(idp))
  let gmidp = gmp/idp
  plot gmidp vs idp xlog xlimit 1e-9 1e-3 ylimit 0 35 title 'PMOS gm/Id' xlabel '|ID| (A)' ylabel 'gm/ID (1/V)'
.endc
"}
C {vsource.sym} -220 -1210 2 0 {name=V4 value=1.8 savecurrent=false}
C {lab_pin.sym} -190 -1150 1 0 {name=p4 sig_type=std_logic lab=Vgp}
C {code.sym} -700 -1580 0 0 {name=Modelos
only_toplevel=true
value="
.include /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.param sw\\_stat\\_mismatch = 0
"}
C {code.sym} -430 -1580 0 0 {name=Metricas_dc
spice_ignore=1
only_toplevel=true
value="
.control
save all

* Coloracion de graficas
set color0=white
set color1=black
set color2=blue
set xbrushwidth=2

* ========================================================
* 1. CARACTERIZACION NMOS (Voltaje fijo VDS = 1.65 V)
* ========================================================
alter V2 = 1.65
dc V1 0 3.3 0.01

let idn = abs(-i(V2)) + 1e-15
let gmn = deriv(idn)
let gmidn = gmn/idn

* --- MEDICIONES AUTOMATICAS NMOS ---
meas dc vth_n find v(vgn) when idn=100n
meas dc gmn_max max gmn
meas dc id_inv_mod_n find idn when gmidn=15 cross=last

* Guardar valores numéricos en variables antes de cambiar de simulación
set vth_n_val = $&vth_n
set gmn_val = $&gmn_max
set id_mod_n_val = $&id_inv_mod_n

* ========================================================
* 2. RESISTENCIA DE SALIDA NMOS (ro) en VGS = 1.65 V
* ========================================================
alter V1 = 1.65
dc V2 0 3.3 0.01

let idn_sat = abs(-i(V2))
let gds_n_vec = deriv(idn_sat)
meas dc gds_n find gds_n_vec at=1.65

set gds_n_val = $&gds_n
let ro_n = 1 / gds_n
let av_n = $gmn_val * ro_n

set ro_n_val = $&ro_n
set av_n_val = $&av_n

* ========================================================
* 1. CARACTERIZACION PMOS (Voltaje fijo VSD = 1.65 V)
* ========================================================
alter V3 = 1.65
dc V4 0 -3.3 -0.01

let idp = abs(i(V3)) + 1e-15
let gmp = abs(deriv(idp))
let gmidp = gmp/idp
let vgsp = vgp-vsp

* --- MEDICIONES AUTOMATICAS PMOS ---
meas dc vth_p find vgsp when idp=100n
meas dc gmp_max max gmp
meas dc id_inv_mod_p find idp when gmidp=15 cross=last

* Guardar valores numéricos en variables antes de cambiar de simulación
set vth_p_val = $&vth_p
set gmp_val = $&gmp_max
set id_mod_p_val = $&id_inv_mod_p

* ========================================================
* 2. RESISTENCIA DE SALIDA NMOS (ro) en VSG= 1.65 V
* ========================================================
alter V4 = -1.65
dc V3 0 3.3 0.01

let idp_sat = abs(i(V3))
let gds_p_vec = deriv(idp_sat)
meas dc gds_p find gds_p_vec at=1.65

set gds_p_val = $&gds_p
let ro_p = 1 / gds_p
let av_p = $gmp_val * ro_p

set ro_p_val = $&ro_p
set av_p_val = $&av_p


* --- IMPRIMIR RESULTADOS EN CONSOLA ---
echo ================ RESUMEN NMOS ================
echo Vth_n = $vth_n_val V
echo gmn_max = $gmn_val S
echo ID_inv_mod_n = $id_mod_n_val A
echo gds_n = $gds_n_val S
echo ro_n = $ro_n_val Ohms
echo Av_n (gmn*ron) = $av_n_val V/V
echo ==============================================
echo ================ RESUMEN PMOS ================
echo Vth_p = $vth_p_val V
echo gmp_max = $gmp_val S
echo ID_inv_mod_p = $id_mod_p_val A
echo gds_p = $gds_p_val S
echo ro_p = $ro_p_val Ohms
echo Av_p (gmp*rop) = $av_p_val V/V
echo ==============================================
.endc
"}
C {code.sym} -560 -1420 0 0 {name=Metricas_ac
spice_ignore=1
only_toplevel=true 
value="
.control
    save all

    * Coloracion de graficas
    set color0=white
    set color1=black
    set color2=blue
    set color3=red
    set xbrushwidth=2

    * ========================================================
    * 1. MEDIDA DE fT PARA NMOS (VDS = 1.65V, VGS = 1.65V)
    * ========================================================
    alter V2 = 1.65
    alter V1 = 1.65
    alter V1 acmag = 1

    * Analisis AC de 1 kHz a 100 GHz (20 puntos por decada)
    ac dec 20 1k 100G

    * Ganancia de corriente H21 = i(V2) / i(V1)
    let h21_n = abs(i(V2) / i(V1))

    * Medir la frecuencia cuando H21 cae a 1 (0 dB)
    meas ac fT_n when h21_n=1


    * ========================================================
    * 2. MEDIDA DE fT PARA PMOS (VSD = 1.65V, VGS = -1.65V)
    * ========================================================
    alter V3 = 1.65
    alter V4 = -1.65
    alter V4 acmag = 1

    ac dec 20 1k 100G
    let h21_p = abs(i(V3) / i(V4))
    meas ac fT_p when h21_p=1


* Graficar ganancia de corriente en dB vs Frecuencia
    plot db(ac1.h21_n) db(ac2.h21_p) xlog title 'Ganancia de Corriente H21 (fT)' xlabel 'Frecuencia (Hz)' ylabel 'H21 (dB)'

    * --- IMPRIMIR RESULTADOS EN CONSOLA ---
    echo ================ RESULTADOS AC (fT) ================
    print ac1.fT_n ac2.fT_p
    echo ====================================================

.endc
"}
C {code.sym} -420 -1420 0 0 {name=Capacitancias
spice_ignore=1
only_toplevel=true

value="
.control
  save all 

  * Coloración de gráficas
  set color0 = white
  set color1 = black
  set color2 = blue
  set color3 = red
  set xbrushwidth = 2

  * ========================================================
  * 1. CAPACITANCIA DE COMPUERTA NMOS (VDS = 1.65V, VGS = 1.65V)
  * ========================================================
  alter V2 = 1.65
  alter V1 = 1.65
  alter V1 acmag = 1

  * Barrido AC de 1 kHz a 100 MHz (1 MHz queda holgadamente dentro)
  ac dec 10 1k 100M
  let cgg_n = imag(-i(V1)) / (2 * pi * frequency)
  meas ac cgg_n_val find cgg_n at = 1meg

  * ========================================================
  * 2. CAPACITANCIA DE COMPUERTA PMOS (VSD = 1.65V, VGS = -1.65V)
  * ========================================================
  alter V3 = 1.65
  alter V4 = -1.65
  alter V4 acmag = 1

  ac dec 10 1k 100M
  let cgg_p = imag(-i(V4)) / (2 * pi * frequency)
  meas ac cgg_p_val find cgg_p at = 1meg

* --- GRAFICAR CAPACITANCIAS VS FRECUENCIA ---
plot ac1.cgg_n ac2.cgg_p xlog title 'Capacitancia de Compuerta Cgg vs Frecuencia' xlabel 'Frecuencia (Hz)' ylabel 'Cgg (F)'

  * --- IMPRIMIR CAPACITANCIAS ---
  echo ================ CAPACITANCIAS DE COMPUERTA (Cgg @ 1MHz) ================
  print ac1.cgg_n_val ac2.cgg_p_val
  echo =========================================================================
.endc
"}
C {code.sym} -210 -1580 0 0 {name=Metricas_dc1
spice_ignore=1
only_toplevel=true
value="
.control
save all

* Coloracion de graficas
set color0=white
set color1=black
set color2=blue
set xbrushwidth=2

* ========================================================
* NOTA: el criterio de Vth usa ID = 100n * (W/L).
* Con W/L = 0.22u/0.28u el umbral es en 78.6n. Si cambias W o L,
* actualiza ese valor en las dos lineas 'meas ... vth_'.
* ========================================================

* ========================================================
* 1. CARACTERIZACION NMOS (VDS fijo = 1.65 V, barrido de VGS)
* ========================================================
alter V2 = 1.65
dc V1 0 3.3 0.01

let idn = abs(-i(V2)) + 1e-15
let gmn = deriv(idn)
let gmidn = gmn/idn

* Para depurar, ver gm/Id contra Id (descomenta la linea):
plot gmidn vs idn xlog

* --- MEDICIONES AUTOMATICAS NMOS ---

* Vth por corriente constante
meas dc vth_n find v(vgn) when idn=1u

* Punto de operacion a gm/Id = 15 (inversion moderada).
* cross=last toma el cruce en que gm/Id BAJA por 15; el primer cruce cae en el piso de fuga (pA) y no sirve.
meas dc id_mod_n find idn when gmidn=15 cross=last
meas dc vgs_mod_n find v(vgn) when gmidn=15 cross=last


* Guardar valores numericos en variables antes de cambiar de simulacion
set vth_n_val = $&vth_n
set id_mod_n_val = $&id_mod_n
set vgs_mod_n_val = $&vgs_mod_n

* ========================================================
* 2. RESISTENCIA DE SALIDA NMOS en el MISMO VGS (barrido de VDS)
* ========================================================
alter V1 = $vgs_mod_n_val
dc V2 0 3.3 0.01

let idn_sat = abs(-i(V2))
let gds_n_vec = deriv(idn_sat)
meas dc gds_n find gds_n_vec at=1.65

* VA = Id/gds (tension de Early); ganancia intrinseca = (gm/Id) * VA
let ro_n = 1 / gds_n
let va_n = $id_mod_n_val / gds_n
let av_n = 15 * va_n

set gds_n_val = $&gds_n
set ro_n_val = $&ro_n
set va_n_val = $&va_n
set av_n_val = $&av_n

* ========================================================
* 3. CARACTERIZACION PMOS (VSD fijo = 1.65 V, barrido de VSG)
* ========================================================
alter V3 = 1.65
dc V4 0 -3.3 -0.01

let idp = abs(i(V3)) + 1e-15
let gmp = abs(deriv(idp))
let gmidp = gmp/idp
let vgsp = vgp-vsp

* --- MEDICIONES AUTOMATICAS PMOS ---
* Vth por corriente constante (sale negativo)
meas dc vth_p find vgsp when idp=1u


* Punto de operacion a gm/Id = 15 (mismo criterio cross=last)
meas dc id_mod_p find idp when gmidp=15 cross=last
meas dc vgs_mod_p find vgsp when gmidp=15 cross=last


* Guardar valores numericos en variables antes de cambiar de simulacion
set vth_p_val = $&vth_p
set id_mod_p_val = $&id_mod_p
set vgs_mod_p_val = $&vgs_mod_p

* ========================================================
* 4. RESISTENCIA DE SALIDA PMOS en el MISMO VGS (barrido de VSD)
* ========================================================
alter V4 = $vgs_mod_p_val
dc V3 0 3.3 0.01

let idp_sat = abs(i(V3))
let gds_p_vec = deriv(idp_sat)
meas dc gds_p find gds_p_vec at=1.65

let ro_p = 1 / gds_p
let va_p = $id_mod_p_val / gds_p
let av_p = 15 * va_p

set gds_p_val = $&gds_p
set ro_p_val = $&ro_p
set va_p_val = $&va_p
set av_p_val = $&av_p

* --- IMPRIMIR RESULTADOS EN CONSOLA ---
echo ================ RESUMEN NMOS (gm/Id = 15) ================
echo Vth_n (ID=1u) = $vth_n_val V
echo Id_mod_n = $id_mod_n_val A
echo Vgs_mod_n = $vgs_mod_n_val V
echo gds_n = $gds_n_val S
echo ro_n = $ro_n_val Ohms
echo VA_n = $va_n_val V
echo Av_n (15*VA) = $av_n_val V/V
echo ===========================================================
echo ================ RESUMEN PMOS (gm/Id = 15) ================
echo Vth_p (ID=1u) = $vth_p_val V
echo Id_mod_p = $id_mod_p_val A
echo Vgs_mod_p = $vgs_mod_p_val V
echo gds_p = $gds_p_val S
echo ro_p = $ro_p_val Ohms
echo VA_p = $va_p_val V
echo Av_p (15*VA) = $av_p_val V/V
echo ===========================================================
.endc
"}
C {code.sym} -210 -1420 0 0 {name=Curvas_dc1
spice_ignore=1
only_toplevel=true
value="
.control
save all

* ======================= COLORES Y ESTILO =======================
* color0 = fondo, color1 = texto y rejilla, color2 en adelante = curvas
set color0=white
set color1=black
set color2=red
set color3=blue
set color4=green
set color5=magenta
set color6=cyan
set color7=orange
set color8=darkgreen
set xbrushwidth=2

* ========================================================
* NOTA: igual que en Metricas_dc, el umbral de Vth es
* ID = 100n * (W/L). Con W/L = 0.22u/0.28u son 7.86e-8 A.
* Si cambias W o L, actualiza ese valor en las dos lineas
* 'let ith_n' y 'let ith_p' (usa notacion 1e-6, no 1u).
* ========================================================

* ========================================================
* 1. NMOS: familias de curvas
* ========================================================
* Salida: ID vs VDS para varios VGS (0 a 3.3 V, paso 0.55 V)
dc V2 0 3.3 0.01 V1 0 3.3 0.55
plot -i(V2) title 'NMOS Output' xlabel 'VDS' ylabel 'ID'

* Transferencia: ID vs VGS para varios VDS (0.55 a 3.3 V)
dc V1 0 3.3 0.01 V2 0.55 3.3 0.55
plot -i(V2) title 'NMOS Transfer' xlabel 'VGS' ylabel 'ID'

* ========================================================
* 2. NMOS: gm/Id y criterio de Vth (VDS fijo = 1.65 V)
* ========================================================
alter V2 = 1.65
dc V1 0 3.3 0.01

* Mismas definiciones que en Metricas_dc
let idn = abs(-i(V2)) + 1e-15
let gmn = deriv(idn)
let gmidn = gmn/idn

* Referencias para los graficos
let ref15 = 15 + 0*idn
let ith_n = 1e-6 + 0*idn

* gm/Id vs ID, con la linea de referencia gm/Id = 15
plot gmidn ref15 vs idn xlog xlimit 1e-9 1e-3 ylimit 0 35 title 'NMOS gm/Id' xlabel 'ID (A)' ylabel 'gm/ID (1/V)'

* ID vs VGS en escala log, con el nivel de corriente del criterio de Vth
plot idn ith_n ylog ylimit 1e-12 1e-3 title 'NMOS ID vs VGS (criterio Vth)' xlabel 'VGS' ylabel 'ID (A)'

* ========================================================
* 3. NMOS: ID y gds contra VDS en el VGS donde gm/Id = 15
* (sirve para comprobar que VDS = 1.65 V esta en saturacion)
* ========================================================
meas dc vgs_mod_n find v(vgn) when gmidn=15 cross=last
set vgs_mod_n_val = $&vgs_mod_n

alter V1 = $vgs_mod_n_val
dc V2 0 3.3 0.01
let idn_sat = abs(-i(V2))
let gds_n_vec = deriv(idn_sat)
plot idn_sat title 'NMOS ID vs VDS (gm/Id = 15)' xlabel 'VDS' ylabel 'ID (A)'
plot gds_n_vec title 'NMOS gds vs VDS (gm/Id = 15)' xlabel 'VDS' ylabel 'gds (S)'

* ========================================================
* 4. PMOS: familias de curvas (V3 = VSD, V4 = VGS negativo)
* ========================================================
* Salida: |ID| vs VSD para varios VGS (0 a -3.3 V, paso -0.55 V)
dc V3 0 3.3 0.01 V4 0 -3.3 -0.55
plot -i(V3) title 'PMOS Output' xlabel 'VSD' ylabel '|ID|'

* Transferencia: |ID| vs VGS para varios VSD (0.55 a 3.3 V)
dc V4 0 -3.3 -0.01 V3 0.55 3.3 0.55
plot -i(V3) title 'PMOS Transfer' xlabel 'VGS' ylabel '|ID|'

* ========================================================
* 5. PMOS: gm/Id y criterio de Vth (VSD fijo = 1.65 V)
* ========================================================
alter V3 = 1.65
dc V4 0 -3.3 -0.01

* Mismas definiciones que en Metricas_dc
let idp = abs(i(V3)) + 1e-15
let gmp = abs(deriv(idp))
let gmidp = gmp/idp
let vgsp = vgp-vsp

* Referencias para los graficos
let ref15p = 15 + 0*idp
let ith_p = 1e-6 + 0*idp

* gm/Id vs |ID|, con la linea de referencia gm/Id = 15
plot gmidp ref15p vs idp xlog xlimit 1e-9 1e-3 ylimit 0 35 title 'PMOS gm/Id' xlabel '|ID| (A)' ylabel 'gm/ID (1/V)'

* |ID| vs VGS en escala log (el eje X va de 0 a -3.3 V)
plot idp ith_p ylog ylimit 1e-12 1e-3 title 'PMOS ID vs VGS (criterio Vth)' xlabel 'VGS' ylabel '|ID| (A)'

* ========================================================
* 6. PMOS: |ID| y gds contra VSD en el VGS donde gm/Id = 15
* ========================================================
meas dc vgs_mod_p find vgsp when gmidp=15 cross=last
set vgs_mod_p_val = $&vgs_mod_p

alter V4 = $vgs_mod_p_val
dc V3 0 3.3 0.01
let idp_sat = abs(i(V3))
let gds_p_vec = deriv(idp_sat)
plot idp_sat title 'PMOS ID vs VSD (gm/Id = 15)' xlabel 'VSD' ylabel '|ID| (A)'
plot gds_p_vec title 'PMOS gds vs VSD (gm/Id = 15)' xlabel 'VSD' ylabel 'gds (S)'
.endc
"}
C {code.sym} -60 -1420 0 0 {name=Metricas_ac1
spice_ignore=0
only_toplevel=true
value="
.control
save all

* Coloracion de graficas
set color0=white
set color1=black
set color2=blue
set color3=red
set xbrushwidth=2

* ========================================================
* PARAMETROS (lo unico que hay que editar)
* ========================================================
* gm/Id objetivo = nivel de inversion de cada transistor.
*   ~5-8   : inversion fuerte (rapido, poco gm por uA)
*   ~15    : inversion moderada
*   ~20-25 : inversion debil (maximo gm por uA, lento)
* Rango valido: ~3 a ~25 (el maximo fisico ronda 25-28).
set gmid_n_obj = 15
set gmid_p_obj = 15
* Este script no depende de W/L: el punto de trabajo se busca
* solo, igual que en Metricas_dc.

* ========================================================
* 1. NMOS: punto de polarizacion a gm/Id = gmid_n_obj
*    (VDS fijo = 1.65 V, barrido de VGS)
* ========================================================
alter V2 = 1.65
dc V1 0 3.3 0.01

let idn = abs(-i(V2)) + 1e-15
let gmn = deriv(idn)
let gmidn = gmn/idn

* cross=last toma el cruce en que gm/Id BAJA por el objetivo
meas dc id_n find idn when gmidn=$gmid_n_obj cross=last
meas dc vgs_n find v(vgn) when gmidn=$gmid_n_obj cross=last
set id_n_val = $&id_n
set vgs_n_val = $&vgs_n

* ========================================================
* 2. NMOS: analisis AC en ese punto (fT, gm y Cgg)
* ========================================================
alter V1 = $vgs_n_val
alter V1 acmag = 1
ac dec 20 1k 100G

* Ganancia de corriente en cortocircuito H21 = i(drenaje) / i(compuerta)
let h21_n = abs(i(V2) / i(V1))
* Cgg = Im(i compuerta) / w, con 1 V de AC en la compuerta
let cgg_n = abs(imag(i(V1))) / (2*pi*frequency)
* gm = |i(drenaje)| con 1 V de AC en la compuerta
let gm_ac_n = abs(i(V2))

* fT = frecuencia en que H21 cae a 1 (0 dB)
meas ac fT_n when h21_n=1

* Cgg a 100 kHz (bien por debajo de fT) y gm a 1 kHz
meas ac cgg_n_m find cgg_n at=1e5
meas ac gm_n_m find gm_ac_n at=1e3

set cgg_n_val = $&cgg_n_m
set gm_n_val = $&gm_n_m
set fT_n_val = $&fT_n

* Evita AC cruzado en la seccion PMOS
alter V1 acmag = 0

* ========================================================
* 3. PMOS: punto de polarizacion a gm/Id = gmid_p_obj
*    (VSD fijo = 1.65 V, barrido de VSG)
* ========================================================
alter V3 = 1.65
dc V4 0 -3.3 -0.01

let idp = abs(i(V3)) + 1e-15
let gmp = abs(deriv(idp))
let gmidp = gmp/idp
let vgsp = vgp-vsp

meas dc id_p find idp when gmidp=$gmid_p_obj cross=last
meas dc vgs_p find vgsp when gmidp=$gmid_p_obj cross=last
set id_p_val = $&id_p
set vgs_p_val = $&vgs_p

* ========================================================
* 4. PMOS: analisis AC en ese punto (fT, gm y Cgg)
* ========================================================
alter V4 = $vgs_p_val
alter V4 acmag = 1
ac dec 20 1k 100G

let h21_p = abs(i(V3) / i(V4))
let cgg_p = abs(imag(i(V4))) / (2*pi*frequency)
let gm_ac_p = abs(i(V3))

meas ac fT_p when h21_p=1

meas ac cgg_p_m find cgg_p at=1e5
meas ac gm_p_m find gm_ac_p at=1e3
set fT_p_val = $&fT_p

set cgg_p_val = $&cgg_p_m
set gm_p_val = $&gm_p_m

* Comprobaciones de consistencia
let gmid_chk_n = $gm_n_val / $id_n_val
let gmid_chk_p = $gm_p_val / $id_p_val
let ft_chk_n = $gm_n_val / (2*pi*$cgg_n_val)
let ft_chk_p = $gm_p_val / (2*pi*$cgg_p_val)

* Graficar ganancia de corriente en dB vs frecuencia
plot db(ac1.h21_n) db(ac2.h21_p) xlog title 'Ganancia de Corriente H21 (fT)' xlabel 'Frecuencia (Hz)' ylabel 'H21 (dB)'

* --- IMPRIMIR RESULTADOS EN CONSOLA ---
echo ================ RESULTADOS AC ================
echo ---- NMOS (gm/Id objetivo = $gmid_n_obj) ----
echo Id = $id_n_val A
echo Vgs = $vgs_n_val V
print ac1.fT_n 
echo gm = $gm_n_val S
echo Cgg = $cgg_n_val F
echo Chequeo gm/Id (debe dar el objetivo) = $&gmid_chk_n
echo Chequeo fT = gm/(2pi Cgg) = $&ft_chk_n Hz
echo ---- PMOS (gm/Id objetivo = $gmid_p_obj) ----
echo Id = $id_p_val A
echo Vgs = $vgs_p_val V
print ac2.fT_p
echo gm = $gm_p_val S
echo Cgg = $cgg_p_val F
echo Chequeo gm/Id (debe dar el objetivo) = $&gmid_chk_p
echo Chequeo fT = gm/(2pi Cgg) = $&ft_chk_p Hz
echo ===============================================
.endc
"}
