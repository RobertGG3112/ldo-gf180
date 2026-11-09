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
L=0.28u
W=0.22u
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
L=0.28u
W=0.22u
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
spice_ignore=0
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
spice_ignore=0
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
meas dc id_inv_mod_n find idn when gmidn=15

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
meas dc id_inv_mod_p find idp when gmidp=15

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
spice_ignore=0 
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
