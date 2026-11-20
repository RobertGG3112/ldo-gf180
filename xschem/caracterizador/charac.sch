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
L=\{l_n\}
W=\{wn\}
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
L=\{lp\}
W=\{wp\}
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
C {vsource.sym} -220 -1210 2 0 {name=V4 value=1.8 savecurrent=false}
C {lab_pin.sym} -190 -1150 1 0 {name=p4 sig_type=std_logic lab=Vgp}
C {code.sym} -650 -1440 0 0 {name=Modelos
only_toplevel=true
value="
.include /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.param sw_stat_mismatch = 0
.param wn=1u l_n=1u wp=1u lp=1u
"}
C {code.sym} -520 -1440 0 0 {name=Parametros_OG
spice_ignore=1
only_toplevel=true
value="
.control

* ========================================================
* 1. PARAMETROS EDITABLES
* ========================================================
* --- NMOS: dimensiones (m) y punto de polarizacion (V) ---
set wn_val = 4.1e-6
set ln_val = 1e-6
set vgs_n = 1.1
set vds_n = 1.65

* --- PMOS: dimensiones (m) y punto de polarizacion (V, magnitudes) ---
set wp_val = 1e-6
set lp_val = 1e-6
set vsg_p = 1.35
set vsd_p = 1.65

* Aplicar W y L al circuito
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos, fuentes y TODOS los parametros internos BSIM4 necesarios
save all 

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
save @m.xm1.m0[gds] 
save @m.xm1.m0[gmbs] 
save @m.xm1.m0[cgg] 
save @m.xm1.m0[cgs] 
save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
save @m.xm2.m0[gds] 
save @m.xm2.m0[gmbs] 
save @m.xm2.m0[cgg] 
save @m.xm2.m0[cgs] 
save @m.xm2.m0[cgd]

* ========================================================
* 2. UNICO PUNTO DE OPERACION (NMOS y PMOS)
* ========================================================
set vgs_p_neg = -$vsg_p
alter v1 $vgs_n
alter v2 $vds_n
alter v4 $vgs_p_neg
alter v3 $vsd_p
op

* ========================================================
* 3. EXTRACCION DIRECTA BSIM4 Y CALCULOS DERIVADOS (NMOS)
* ========================================================
let id_n_x    = abs(@m.xm1.m0[id])
let vth_n_x   = abs(@m.xm1.m0[vth])
let vdsat_n_x = abs(@m.xm1.m0[vdsat])
let gm_n_x    = abs(@m.xm1.m0[gm])
let gds_n_x   = abs(@m.xm1.m0[gds])
let gmb_n_x   = abs(@m.xm1.m0[gmbs])
let cgg_n_x   = abs(@m.xm1.m0[cgg])
let cgs_n_x   = abs(@m.xm1.m0[cgs])
let cgd_n_x   = abs(@m.xm1.m0[cgd])

set id_n_val    = "$&id_n_x"
set vth_n_val   = "$&vth_n_x"
set vdsat_n_val = "$&vdsat_n_x"
set gm_n_val    = "$&gm_n_x"
set gds_n_val   = "$&gds_n_x"
set gmb_n_val   = "$&gmb_n_x"
set cgg_n_val   = "$&cgg_n_x"
set cgs_n_val   = "$&cgs_n_x"
set cgd_n_val   = "$&cgd_n_x"

* Calculos derivados NMOS
let vov_n       = $vgs_n - $vth_n_val
let vdsmvdsat_n = $vds_n - $vdsat_n_val
let ro_n        = 1 / $gds_n_val
let gmro_n      = $gm_n_val / $gds_n_val
let gmoid_n     = $gm_n_val / $id_n_val
let ft_n        = $gm_n_val / (2*pi*$cgg_n_val)
let ftgmid_n    = ft_n * gmoid_n
let gft_n       = ft_n * gmro_n

set vov_n_val       = "$&vov_n"
set vdsmvdsat_n_val = "$&vdsmvdsat_n"
set ro_n_val        = "$&ro_n"
set gmro_n_val      = "$&gmro_n"
set gmoid_n_val     = "$&gmoid_n"
set ft_n_val        = "$&ft_n"
set ftgmid_n_val    = "$&ftgmid_n"
set gft_n_val       = "$&gft_n"

set region_n = 2
if $vgs_n < $vth_n_val
  set region_n = 3
else
  if $vds_n < $vdsat_n_val
    set region_n = 1
  end
end

* ========================================================
* 4. EXTRACCION DIRECTA BSIM4 Y CALCULOS DERIVADOS (PMOS)
* ========================================================
let id_p_x    = abs(@m.xm2.m0[id])
let vth_p_x   = abs(@m.xm2.m0[vth])
let vdsat_p_x = abs(@m.xm2.m0[vdsat])
let gm_p_x    = abs(@m.xm2.m0[gm])
let gds_p_x   = abs(@m.xm2.m0[gds])
let gmb_p_x   = abs(@m.xm2.m0[gmbs])
let cgg_p_x   = abs(@m.xm2.m0[cgg])
let cgs_p_x   = abs(@m.xm2.m0[cgs])
let cgd_p_x   = abs(@m.xm2.m0[cgd])

set id_p_val    = "$&id_p_x"
set vth_p_val   = "$&vth_p_x"
set vdsat_p_val = "$&vdsat_p_x"
set gm_p_val    = "$&gm_p_x"
set gds_p_val   = "$&gds_p_x"
set gmb_p_val   = "$&gmb_p_x"
set cgg_p_val   = "$&cgg_p_x"
set cgs_p_val   = "$&cgs_p_x"
set cgd_p_val   = "$&cgd_p_x"

* Calculos derivados PMOS
let vov_p       = $vsg_p - $vth_p_val
let vdsmvdsat_p = $vsd_p - $vdsat_p_val
let ro_p        = 1 / $gds_p_val
let gmro_p      = $gm_p_val / $gds_p_val
let gmoid_p     = $gm_p_val / $id_p_val
let ft_p        = $gm_p_val / (2*pi*$cgg_p_val)
let ftgmid_p    = ft_p * gmoid_p
let gft_p       = ft_p * gmro_p

set vov_p_val       = "$&vov_p"
set vdsmvdsat_p_val = "$&vdsmvdsat_p"
set ro_p_val        = "$&ro_p"
set gmro_p_val      = "$&gmro_p"
set gmoid_p_val     = "$&gmoid_p"
set ft_p_val        = "$&ft_p"
set ftgmid_p_val    = "$&ftgmid_p"
set gft_p_val       = "$&gft_p"

set region_p = 2
if $vsg_p < $vth_p_val
  set region_p = 3
else
  if $vsd_p < $vdsat_p_val
    set region_p = 1
  end
end

* ========================================================
* 5. IMPRESION DE TABLAS (ORDEN EXACTO CADENCE ADE)
* ========================================================
echo ==========================================================
echo  NMOS (XM1) : W = $wn_val m | L = $ln_val m
echo ==========================================================
echo  ID          = $id_n_val A
echo  VGS         = $vgs_n V
echo  VDS         = $vds_n V
echo  VSB         = 0 V
echo  VTH         = $vth_n_val V
echo  Vov         = $vov_n_val V
echo  Vdsat       = $vdsat_n_val V
echo  VDS-Vdsat   = $vdsmvdsat_n_val V
echo  Region      = $region_n (1:triodo, 2:sat, 3:subumbral)
echo  gm          = $gm_n_val S
echo  ro          = $ro_n_val Ohm
echo  gmb         = $gmb_n_val S
echo  gmro        = $gmro_n_val V/V
echo  Cgs         = $cgs_n_val F
echo  Cgd         = $cgd_n_val F
echo  gmoid       = $gmoid_n_val 1/V
echo  fT          = $ft_n_val Hz
echo  FTGMID      = $ftgmid_n_val Hz/V
echo  GFT         = $gft_n_val Hz
echo ==========================================================
echo ""
echo ==========================================================
echo  PMOS (XM2) : W = $wp_val m | L = $lp_val m  (magnitudes)
echo ==========================================================
echo  ID          = $id_p_val A
echo  VSG         = $vsg_p V
echo  VSD         = $vsd_p V
echo  VSB         = 0 V
echo  VTH         = $vth_p_val V
echo  Vov         = $vov_p_val V
echo  Vdsat       = $vdsat_p_val V
echo  VSD-Vdsat   = $vdsmvdsat_p_val V
echo  Region      = $region_p (1:triodo, 2:sat, 3:subumbral)
echo  gm          = $gm_p_val S
echo  ro          = $ro_p_val Ohm
echo  gmb         = $gmb_p_val S
echo  gmro        = $gmro_p_val V/V
echo  Cgs         = $cgs_p_val F
echo  Cgd         = $cgd_p_val F
echo  gmoid       = $gmoid_p_val 1/V
echo  fT          = $ft_p_val Hz
echo  FTGMID      = $ftgmid_p_val Hz/V
echo  GFT         = $gft_p_val Hz
echo ==========================================================
.endc
"}
C {code.sym} -340 -1440 0 0 {name=Curva_gmID_VGS
only_toplevel=true
spice_ignore=1
value="
.control

* ==================================================================
* 1. PARAMETROS EDITABLES
* ==================================================================
* --- NMOS: dimensiones (m), VDS fijo (V) y punto objetivo gm/ID ---
set wn_val     = 69.45e-6
set ln_val     = 1e-6
set vds_fijo_n = 1.65
set gmid_obj_n = 22

* --- PMOS: dimensiones (m), VSD fijo (V) y punto objetivo gm/ID ---
set wp_val     = 10e-6
set lp_val     = 1e-6
set vsd_fijo_p = 1.65
set gmid_obj_p = 5

* Aplicar geometria al esquematico
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos y parametros internos BSIM4 necesarios para el barrido
save all

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
save @m.xm1.m0[gds] 
*save @m.xm1.m0[gmbs] 
*save @m.xm1.m0[cgg] 
*save @m.xm1.m0[cgs] 
*save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
*save @m.xm2.m0[gds] 
*save @m.xm2.m0[gmbs] 
*save @m.xm2.m0[cgg] 
*save @m.xm2.m0[cgs] 
*save @m.xm2.m0[cgd]

* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 2. NMOS: BARRIDO gm/ID vs VGS (a VDS fijo)
* ==================================================================
alter v2 $vds_fijo_n
dc V1 0.1 3.3 0.005

let id_n    = abs(@m.xm1.m0[id]) + 1e-18
let gm_n    = abs(@m.xm1.m0[gm])
let gds_n    = abs(@m.xm1.m0[gds])
let gmid_n  = gm_n / id_n
let vdsat_n = abs(@m.xm1.m0[vdsat])
let vth_n   = abs(@m.xm1.m0[vth])
let ref_n   = $gmid_obj_n + 0*gmid_n

* Extraccion del punto especifico donde gm/ID = gmid_obj_n
meas dc vgs_pt_n   find v(vgn)  when gmid_n=$gmid_obj_n cross=last
meas dc id_pt_n    find id_n    when gmid_n=$gmid_obj_n cross=last
meas dc vdsat_pt_n find vdsat_n when gmid_n=$gmid_obj_n cross=last
meas dc vth_pt_n   find vth_n   when gmid_n=$gmid_obj_n cross=last

set vgs_pn   = "$&vgs_pt_n"
set id_pn    = "$&id_pt_n"
set vdsat_pn = "$&vdsat_pt_n"
set vth_pn   = "$&vth_pt_n"

plot gmid_n ref_n title 'NMOS: gm/ID vs VGS' xlabel 'VGS (V)' ylabel 'gm/ID (1/V)'

plot gds_n title 'NMOS: gds vs VGS' xlabel 'VGS (V)' ylabel 'gds (dId/dVds)'

* ==================================================================
* 3. PMOS: BARRIDO gm/ID vs VSG (a VSD fijo)
* ==================================================================
alter v3 $vsd_fijo_p
dc V4 -0.1 -3.3 -0.005

let vsg_p   = abs(v(vgp) - v(vsp))
let id_p    = abs(@m.xm2.m0[id]) + 1e-18
let gm_p    = abs(@m.xm2.m0[gm])
let gmid_p  = gm_p / id_p
let vdsat_p = abs(@m.xm2.m0[vdsat])
let vth_p   = abs(@m.xm2.m0[vth])
let ref_p   = $gmid_obj_p + 0*gmid_p

* Extraccion del punto especifico donde gm/ID = gmid_obj_p
meas dc vsg_pt_p   find vsg_p   when gmid_p=$gmid_obj_p cross=last
meas dc id_pt_p    find id_p    when gmid_p=$gmid_obj_p cross=last
meas dc vdsat_pt_p find vdsat_p when gmid_p=$gmid_obj_p cross=last
meas dc vth_pt_p   find vth_p   when gmid_p=$gmid_obj_p cross=last

set vsg_pp   = "$&vsg_pt_p"
set id_pp    = "$&id_pt_p"
set vdsat_pp = "$&vdsat_pt_p"
set vth_pp   = "$&vth_pt_p"

plot gmid_p ref_p vs vsg_p title 'PMOS: gm/ID vs VSG' xlabel 'VSG (V)' ylabel 'gm/ID (1/V)'

* ==================================================================
* 4. REPORTE NUMERICO EN CONSOLA
* ==================================================================
echo ==========================================================
echo  NMOS (W=$wn_val, L=$ln_val, VDS=$vds_fijo_n V) -- gm/ID = $gmid_obj_n 1/V
echo ==========================================================
echo  VGS requerido = $vgs_pn V
echo  VTH interno   = $vth_pn V
echo  Vdsat minimo  = $vdsat_pn V
echo  ID resultante = $id_pn A
echo ==========================================================
echo ""
echo ==========================================================
echo  PMOS (W=$wp_val, L=$lp_val, VSD=$vsd_fijo_p V) -- gm/ID = $gmid_obj_p 1/V
echo ==========================================================
echo  VSG requerido = $vsg_pp V
echo  VTH interno   = $vth_pp V
echo  Vdsat minimo  = $vdsat_pp V
echo  ID resultante = $id_pp A
echo ==========================================================
.endc
"}
C {code.sym} -170 -1440 0 0 {name=Curva_VDsat_Vgs
only_toplevel=true
spice_ignore=1
value="
.control

* ==================================================================
* 1. PARAMETROS EDITABLES
* ==================================================================
* --- NMOS: dimensiones (m), VDS fijo (V) y punto objetivo gm/ID ---
set wn_val     = 10e-6
set ln_val     = 1e-6
set vds_fijo_n = 1.65
set vdsat_obj_n = 200e-3

* --- PMOS: dimensiones (m), VSD fijo (V) y punto objetivo gm/ID ---
set wp_val     = 10e-6
set lp_val     = 1e-6
set vsd_fijo_p = 1.65
set vdsat_obj_p = 200e-3

* Aplicar geometria al esquematico
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos y parametros internos BSIM4 necesarios para el barrido
save all

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
*save @m.xm1.m0[gds] 
*save @m.xm1.m0[gmbs] 
*save @m.xm1.m0[cgg] 
*save @m.xm1.m0[cgs] 
*save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
*save @m.xm2.m0[gds] 
*save @m.xm2.m0[gmbs] 
*save @m.xm2.m0[cgg] 
*save @m.xm2.m0[cgs] 
*save @m.xm2.m0[cgd]

* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 2. NMOS: BARRIDO Vdsat vs VGS (a VDS fijo)
* ==================================================================
alter v2 $vds_fijo_n
dc V1 0.1 3.3 0.005

let id_n    = abs(@m.xm1.m0[id])
let gm_n    = abs(@m.xm1.m0[gm])
let vdsat_n = abs(@m.xm1.m0[vdsat])
let vth_n   = abs(@m.xm1.m0[vth])
let ref_n   = $vdsat_obj_n + 0*vdsat_n

* Extraccion del punto especifico donde gm/ID = gmid_obj_n
meas dc vgs_pt_n   find v(vgn)  when vdsat_n=$vdsat_obj_n 
meas dc id_pt_n    find id_n    when vdsat_n=$vdsat_obj_n  
meas dc gm_n_pt_n find gm_n when vdsat_n=$vdsat_obj_n 
meas dc vth_pt_n   find vth_n   when vdsat_n=$vdsat_obj_n 

set vgs_pn   = "$&vgs_pt_n"
set id_pn    = "$&id_pt_n"
set gm_pn = "$&gm_n_pt_n"
set vth_pn   = "$&vth_pt_n"

plot vdsat_n ref_n title 'NMOS: gm/ID vs VGS' xlabel 'VGS (V)' ylabel 'vdsat'

* ==================================================================
* 3. PMOS: BARRIDO gm/ID vs VSG (a VSD fijo)
* ==================================================================
alter v3 $vsd_fijo_p
dc V4 -0.1 -3.3 -0.005

let vsg_p   = abs(v(vgp) - v(vsp))
let id_p    = abs(@m.xm2.m0[id])
let gm_p    = abs(@m.xm2.m0[gm])
let vdsat_p = abs(@m.xm2.m0[vdsat])
let vth_p   = abs(@m.xm2.m0[vth])
let ref_p   = $vdsat_obj_p + 0*vdsat_p

* Extraccion del punto especifico donde gm/ID = gmid_obj_p
meas dc vsg_pt_p   find vsg_p   when vdsat_p=$vdsat_obj_p
meas dc id_pt_p    find id_p    when vdsat_p=$vdsat_obj_p
meas dc gm_p_pt_p find gm_p when vdsat_p=$vdsat_obj_p
meas dc vth_pt_p   find vth_p   when vdsat_p=$vdsat_obj_p 

set vsg_pp   = "$&vsg_pt_p"
set id_pp    = "$&id_pt_p"
set gm_pp = "$&gm_p_pt_p"
set vth_pp   = "$&vth_pt_p"

plot vdsat_p ref_p vs vsg_p title 'PMOS: gm/ID vs VSG' xlabel 'VSG (V)' ylabel 'vdsat'

* ==================================================================
* 4. REPORTE NUMERICO EN CONSOLA
* ==================================================================
echo ==========================================================
echo  NMOS (W=$wn_val, L=$ln_val, VDS=$vds_fijo_n V) -- vdsat = $vdsat_obj_n 1/V
echo ==========================================================
echo  VGS requerido = $vgs_pn V
echo  VTH interno   = $vth_pn V
echo  gm = $gm_pn S
echo  ID resultante = $id_pn A
echo ==========================================================
echo ""
echo ==========================================================
echo  PMOS (W=$wp_val, L=$lp_val, VSD=$vsd_fijo_p V) -- vdsat = $vdsat_obj_p 1/V
echo ==========================================================
echo  VSG requerido = $vsg_pp V
echo  VTH interno   = $vth_pp V
echo  gm  = $gm_pp S
echo  ID resultante = $id_pp A
echo ==========================================================
.endc
"}
C {code.sym} 10 -1440 0 0 {name=Curva_gmID_Id
only_toplevel=true
spice_ignore=1
value="
.control

* ==================================================================
* 1. PARAMETROS EDITABLES
* ==================================================================
* --- NMOS: dimensiones (m), VDS fijo (V) y punto objetivo gm/ID ---
set wn_val     = 10e-6
set ln_val     = 1e-6
set vds_fijo_n = 1.65
set gmid_obj_n = 5

* --- PMOS: dimensiones (m), VSD fijo (V) y punto objetivo gm/ID ---
set wp_val     = 10e-6
set lp_val     = 1e-6
set vsd_fijo_p = 1.65
set gmid_obj_p = 5

* Aplicar geometria al esquematico
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos y parametros internos BSIM4 necesarios para el barrido
save all

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
*save @m.xm1.m0[gds] 
*save @m.xm1.m0[gmbs] 
*save @m.xm1.m0[cgg] 
*save @m.xm1.m0[cgs] 
*save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
*save @m.xm2.m0[gds] 
*save @m.xm2.m0[gmbs] 
*save @m.xm2.m0[cgg] 
*save @m.xm2.m0[cgs] 
*save @m.xm2.m0[cgd]

* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 2. NMOS: BARRIDO gm/ID vs VGS (a VDS fijo)
* ==================================================================
alter v2 $vds_fijo_n
dc V1 0.1 3.3 0.005

let id_n    = abs(@m.xm1.m0[id]) + 1e-18
let gm_n    = abs(@m.xm1.m0[gm])
let gmid_n  = gm_n / id_n
let vdsat_n = abs(@m.xm1.m0[vdsat])
let vth_n   = abs(@m.xm1.m0[vth])
let ref_n   = $gmid_obj_n + 0*gmid_n

* Extraccion del punto especifico donde gm/ID = gmid_obj_n
meas dc vgs_pt_n   find v(vgn)  when gmid_n=$gmid_obj_n cross=last
meas dc id_pt_n    find id_n    when gmid_n=$gmid_obj_n cross=last
meas dc vdsat_pt_n find vdsat_n when gmid_n=$gmid_obj_n cross=last
meas dc vth_pt_n   find vth_n   when gmid_n=$gmid_obj_n cross=last

set vgs_pn   = "$&vgs_pt_n"
set id_pn    = "$&id_pt_n"
set vdsat_pn = "$&vdsat_pt_n"
set vth_pn   = "$&vth_pt_n"

plot gmid_n ref_n vs id_n title 'NMOS: gm/ID vs Id' xlabel 'Id' ylabel 'gm/ID (1/V)'

* ==================================================================
* 3. PMOS: BARRIDO gm/ID vs VSG (a VSD fijo)
* ==================================================================
alter v3 $vsd_fijo_p
dc V4 -0.1 -3.3 -0.005

let vsg_p   = abs(v(vgp) - v(vsp))
let id_p    = abs(@m.xm2.m0[id]) + 1e-18
let gm_p    = abs(@m.xm2.m0[gm])
let gmid_p  = gm_p / id_p
let vdsat_p = abs(@m.xm2.m0[vdsat])
let vth_p   = abs(@m.xm2.m0[vth])
let ref_p   = $gmid_obj_p + 0*gmid_p

* Extraccion del punto especifico donde gm/ID = gmid_obj_p
meas dc vsg_pt_p   find vsg_p   when gmid_p=$gmid_obj_p cross=last
meas dc id_pt_p    find id_p    when gmid_p=$gmid_obj_p cross=last
meas dc vdsat_pt_p find vdsat_p when gmid_p=$gmid_obj_p cross=last
meas dc vth_pt_p   find vth_p   when gmid_p=$gmid_obj_p cross=last

set vsg_pp   = "$&vsg_pt_p"
set id_pp    = "$&id_pt_p"
set vdsat_pp = "$&vdsat_pt_p"
set vth_pp   = "$&vth_pt_p"

plot gmid_p ref_p vs id_p title 'PMOS: gm/ID vs Id' xlabel 'Id' ylabel 'gm/ID (1/V)'

* ==================================================================
* 4. REPORTE NUMERICO EN CONSOLA
* ==================================================================
echo ==========================================================
echo  NMOS (W=$wn_val, L=$ln_val, VDS=$vds_fijo_n V) -- gm/ID = $gmid_obj_n 1/V
echo ==========================================================
echo  VTH interno   = $vth_pn V
echo  ID requerido = $id_pn A
echo ==========================================================
echo ""
echo ==========================================================
echo  PMOS (W=$wp_val, L=$lp_val, VSD=$vsd_fijo_p V) -- gm/ID = $gmid_obj_p 1/V
echo ==========================================================
echo  VTH interno   = $vth_pp V
echo  ID requerido = $id_pp A
echo ==========================================================
.endc
"}
C {code.sym} -510 -1630 0 0 {name=Curva_gds_VDS
only_toplevel=true
spice_ignore=1
value="
.control
* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 1. PARAMETROS EDITABLES (NMOS y PMOS)
* ==================================================================
set wn_val     = 10e-6
set ln_val     = 1e-6
set wp_val     = 10e-6
set lp_val     = 1e-6
set vgs_fijo_n = 1.65

* Aplicar geometria al esquematico (ambos transistores)
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* --- Guardar parametros internos DESPUES del reset ---
save all
save @m.xm1.m0[id]
save @m.xm1.m0[gds]
save @m.xm1.m0[vdsat]
save @m.xm1.m0[vth]

* ==================================================================
* 2. NMOS: BARRIDO gds vs VDS (a VGS fijo)
* ==================================================================
alter V1 $vgs_fijo_n
dc V2 0 3.3 0.005

let gds_n   = abs(@m.xm1.m0[gds])
let id_n    = abs(@m.xm1.m0[id])
let vdsat_n = abs(@m.xm1.m0[vdsat])
let vth_n   = abs(@m.xm1.m0[vth])
let rout_n  = 1 / (gds_n + 1e-18)

* Diferencia entre VDS real (v(vdn)) y VDSAT para hallar el cruce
let dv_sat  = v(vdn) - vdsat_n

* Medir VDSAT y gds en el punto donde VDS cruza a VDSAT
meas dc vdsat_medido find vdsat_n when dv_sat=0 cross=1
meas dc gds_en_vdsat find gds_n when dv_sat=0 cross=1

echo '=================================================='
echo 'VDSAT en el cruce (V) : $&vdsat_medido'
echo 'gds en VDSAT (S)      : $&gds_en_vdsat'
echo '=================================================='

* Graficar gds vs VDS
plot gds_n vs v(vdn) title 'NMOS: gds vs VDS (VGS = 1.65V)' xlabel 'VDS (V)' ylabel 'gds (S)'

.endc
"}
C {code.sym} -320 -1610 0 0 {name=Curva_gmro_VGS
only_toplevel=true
spice_ignore=0
value="
.control

* ==================================================================
* 1. PARAMETROS EDITABLES
* ==================================================================
* --- NMOS: dimensiones (m), VDS fijo (V) y punto objetivo gm/ID ---
set wn_val     = 10e-6
set ln_val     = 1e-6
set vds_fijo_n = 1.65
set gmro_obj_n = 300

* --- PMOS: dimensiones (m), VSD fijo (V) y punto objetivo gm/ID ---
set wp_val     = 10e-6
set lp_val     = 1e-6
set vsd_fijo_p = 1.65
set gmro_obj_p = 300

* Aplicar geometria al esquematico
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos y parametros internos BSIM4 necesarios para el barrido
save all

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
save @m.xm1.m0[gds] 
*save @m.xm1.m0[gmbs] 
*save @m.xm1.m0[cgg] 
*save @m.xm1.m0[cgs] 
*save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
*save @m.xm2.m0[gds] 
*save @m.xm2.m0[gmbs] 
*save @m.xm2.m0[cgg] 
*save @m.xm2.m0[cgs] 
*save @m.xm2.m0[cgd]

* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 2. NMOS: BARRIDO gm/ID vs VGS (a VDS fijo)
* ==================================================================
alter v2 $vds_fijo_n
dc V1 0.1 3.3 0.005

let id_n = abs(@m.xm1.m0[id])
let gm_n    = abs(@m.xm1.m0[gm])
let gds_n    = abs(@m.xm1.m0[gds])
let gmid_n  = gm_n / id_n
let gmro_n = gm_n/gds_n
let vdsat_n = abs(@m.xm1.m0[vdsat])
let vth_n   = abs(@m.xm1.m0[vth])
let ref_n   = $gmro_obj_n + 0*gmro_n

* Extraccion del punto especifico donde gm/ID = gmid_obj_n
meas dc vgs_pt_n find v(vgn) when gmro_n=$gmro_obj_n

set vgs_pn   = "$&vgs_pt_n"

plot gmro_n ref_n title 'NMOS: gmro vs VGS' xlabel 'VGS (V)' ylabel 'gmro (V/V)'

* ==================================================================
* 3. PMOS: BARRIDO gm/ID vs VSG (a VSD fijo)
* ==================================================================
alter v3 $vsd_fijo_p
dc V4 -0.1 -3.3 -0.005

let vsg_p   = abs(v(vgp) - v(vsp))
let id_p    = abs(@m.xm2.m0[id]) + 1e-18
let gm_p    = abs(@m.xm2.m0[gm])
let gds_p   = abs(@m.xm2.m0[gds])
let gmro_p = gm_p/gdp_n
let gmid_p  = gm_p / id_p
let vdsat_p = abs(@m.xm2.m0[vdsat])
let vth_p   = abs(@m.xm2.m0[vth])
let ref_p   = $gmro_obj_p + 0*gmro_p

* Extraccion del punto especifico donde gm/ID = gmid_obj_p
meas dc vsg_pt_p find vsg_p when gmro_p=$gmro_obj_p 

set vsg_pp   = "$&vsg_pt_p"

plot gmro_p ref_p vs vsg_p title 'PMOS: gmro vs VSG' xlabel 'VSG (V)' ylabel 'gmro (V/V)'

* ==================================================================
* 4. REPORTE NUMERICO EN CONSOLA
* ==================================================================
echo ==========================================================
echo  NMOS (W=$wn_val, L=$ln_val, VDS=$vds_fijo_n V) -- gmro = $gmro_obj_n V/V
echo ==========================================================
echo  VGS requerido = $vgs_pn V
echo ==========================================================
echo ""
echo ==========================================================
echo  PMOS (W=$wp_val, L=$lp_val, VSD=$vsd_fijo_p V) -- gmro = $gmro_obj_p V/V
echo ==========================================================
echo  VSG requerido = $vsg_pp V
echo ==========================================================
.endc
"}
C {code.sym} -130 -1610 0 0 {name=Curva_ID_VGS
only_toplevel=true
spice_ignore=1
value="
.control

* ==================================================================
* 1. PARAMETROS EDITABLES
* ==================================================================
* --- NMOS: dimensiones (m), VDS fijo (V) y punto objetivo gm/ID ---
set wn_val     = 5e-6
set ln_val     = 1e-6
set vds_fijo_n = 1.65
set id_obj_n= 100e-6

* --- PMOS: dimensiones (m), VSD fijo (V) y punto objetivo gm/ID ---
set wp_val     = 1e-6
set lp_val     = 1e-6
set vsd_fijo_p = 1.65
set id_obj_p = 50e-6

* Aplicar geometria al esquematico
alterparam wn=$wn_val
alterparam l_n=$ln_val
alterparam wp=$wp_val
alterparam lp=$lp_val
reset

* Guardar nodos y parametros internos BSIM4 necesarios para el barrido
save all

* Guardar parámetros internos del NMOS (XM1) 
save @m.xm1.m0[id] 
save @m.xm1.m0[vth] 
save @m.xm1.m0[vdsat] 
save @m.xm1.m0[gm] 
save @m.xm1.m0[gds] 
*save @m.xm1.m0[gmbs] 
*save @m.xm1.m0[cgg] 
*save @m.xm1.m0[cgs] 
*save @m.xm1.m0[cgd] 

*Guardar parámetros internos del PMOS (XM2) 
save @m.xm2.m0[id] 
save @m.xm2.m0[vth] 
save @m.xm2.m0[vdsat] 
save @m.xm2.m0[gm] 
*save @m.xm2.m0[gds] 
*save @m.xm2.m0[gmbs] 
*save @m.xm2.m0[cgg] 
*save @m.xm2.m0[cgs] 
*save @m.xm2.m0[cgd]

* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set color4=darkgreen
set xbrushwidth=2

* ==================================================================
* 2. NMOS: BARRIDO gm/ID vs VGS (a VDS fijo)
* ==================================================================
alter v2 $vds_fijo_n
dc V1 0 3.3 0.005

let id_n    = abs(@m.xm1.m0[id])
let vth_n = abs(@m.xm1.m0[vth])
let vdsat_n = abs(@m.xm1.m0[vdsat])
let ref_n = $id_obj_n + 0*id_n


* Extraccion del punto especifico donde gm/ID = gmid_obj_n
meas dc vgs_pt_n   find v(vgn)  when id_n=$id_obj_n
meas dc vdsat_pt_n   find vdsat_n  when id_n=$id_obj_n
meas dc vth_pt_n   find vth_n   when id_p=$id_obj_n

set vgs_pt_n_val = $&vgs_pt_n
set vth_n_val = $&vth_pt_n 
set vdsat_n_val = $&vdsat_pt_n

plot id_n ref_n title 'NMOS: ID vs VGS' xlabel 'VGS (V)' ylabel 'ID'

* ==================================================================
* 3. PMOS: BARRIDO gm/ID vs VSG (a VSD fijo)
* ==================================================================
alter v3 $vsd_fijo_p
dc V4 0 -3.3 -0.005

let vsg_p   = abs(v(vgp) - v(vsp))
let id_p    = abs(@m.xm2.m0[id])
let gm_p    = abs(@m.xm2.m0[gm])
let gmid_p  = gm_p / id_p
let vdsat_p = abs(@m.xm2.m0[vdsat])
let vth_p   = abs(@m.xm2.m0[vth])
let ref_p   = $id_obj_p + 0*id_p

* Extraccion del punto especifico donde gm/ID = gmid_obj_p
meas dc vsg_pt_p   find vsg_p   when id_p=$id_obj_p
meas dc vdsat_pt_p find vdsat_p when id_p=$id_obj_p 
meas dc vth_pt_p   find vth_p   when id_p=$id_obj_p 

set vsg_pt_p_val   = "$&vsg_pt_p"
set vdsat_p_val = "$&vdsat_pt_p"
set vth_p_val   = "$&vth_pt_p"

plot id_p ref_p vs vsg_p title 'PMOS: ID vs VSG' xlabel 'VSG (V)' ylabel 'ID'


* ==================================================================
* 4. REPORTE NUMERICO EN CONSOLA
* ==================================================================
echo ==========================================================
echo  NMOS (W=$wn_val, L=$ln_val, VDS=$vds_fijo_n V) --ID = $id_obj_n A
echo ==========================================================
echo  vgs = $vgs_pt_n_val V
echo  vth = $vth_n_val V
echo  vdsat = $vdsat_n_val V

echo ==========================================================
echo  PMOS (W=$wp_val, L=$lp_val, VSD=$vsd_fijo_p V) --ID = $id_obj_p A
echo ==========================================================
echo  vsg = $vsg_pt_p_val V
echo  vth = $vth_p_val V
echo  vdsat = $vdsat_p_val V
.endc
"}
