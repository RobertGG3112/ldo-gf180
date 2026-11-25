v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -60 -20 -60 -10 {
lab=GND}
N -150 -60 -150 -30 {
lab=GND}
N -60 -80 -0 -80 {
lab=vin_p}
N -150 -120 0 -120 {
lab=vin_n}
N 50 -50 50 -10 {
lab=#net1}
N 110 -60 110 -10 {
lab=GND}
N 90 -60 110 -60 {
lab=GND}
N 90 -70 90 -60 {
lab=GND}
N 110 -10 110 20 {
lab=GND}
N 90 -160 90 -130 {
lab=#net2}
N 90 -250 90 -220 {
lab=GND}
N 190 -40 190 20 {
lab=GND}
N 110 20 190 20 {
lab=GND}
N 130 -100 190 -100 {
lab=#net3}
C {vsource.sym} -150 -90 0 0 {name=V1 value=1.65 savecurrent=false}
C {gnd.sym} -150 -30 0 0 {name=l3 lab=GND}
C {gnd.sym} -60 -10 0 0 {name=l4 lab=GND}
C {lab_wire.sym} -70 -120 0 0 {name=p1 sig_type=std_logic lab=vin_n}
C {lab_wire.sym} -20 -80 0 0 {name=p3 sig_type=std_logic lab=vin_p}
C {isource.sym} 80 -10 3 0 {name=I0 value=0.5u}
C {gnd.sym} 110 20 0 0 {name=l1 lab=GND}
C {gnd.sym} 90 -250 2 0 {name=l2 lab=GND}
C {vsource.sym} -60 -50 0 0 {name=V2 value=1.65 savecurrent=false}
C {vsource.sym} 90 -190 2 0 {name=V3 value=3.3 savecurrent=false}
C {code.sym} -290 -310 0 0 {name=Chequeo_Inversion_Region_OTA_P
only_toplevel=true
spice_ignore=0
value="
.control
* ======================= ESTILO DE GRAFICOS =======================
set color0=white
set color1=black
set color2=blue
set color3=red
set xbrushwidth=2

* ==================================================================
* 1. UMBRALES GENERALES, FUENTES, DIMENSIONES, m Y nf EDITABLES
* ==================================================================
set gmid_debil  = 15
set gmid_fuerte = 10
set sat_min     = 0.1

set v1_val  = 0.4
set v2_val  = 0.4
set v3_val  = 3.3
set i0_val  = 0.5e-6

set w1_val = 29e-6   set l1_val = 1e-6   set m1_val = 1   set nf1_val = 1
set w2_val = 29e-6   set l2_val = 1e-6   set m2_val = 1   set nf2_val = 1
set w3_val = 0.22e-6   set l3_val = 1.6e-6   set m3_val = 1   set nf3_val = 1
set w4_val = 0.22e-6   set l4_val = 1.6e-6   set m4_val = 1   set nf4_val = 1
set w5_val = 1e-6   set l5_val = 1e-6   set m5_val = 4   set nf5_val = 1
set w6_val = 1e-6   set l6_val = 1e-6   set m6_val = 1   set nf6_val = 1

* Si w1..w6 estan definidos a nivel donde alterparam los alcanza, descomenta:
* alterparam w1=$w1_val l1=$l1_val m1=$m1_val nf1=$nf1_val
* alterparam w2=$w2_val l2=$l2_val m2=$m2_val nf2=$nf2_val
* alterparam w3=$w3_val l3=$l3_val m3=$m3_val nf3=$nf3_val
* alterparam w4=$w4_val l4=$l4_val m4=$m4_val nf4=$nf4_val
* alterparam w5=$w5_val l5=$l5_val m5=$m5_val nf5=$nf5_val
* alterparam w6=$w6_val l6=$l6_val m6=$m6_val nf6=$nf6_val
* reset

* ==================================================================
* 2. GUARDAR PARAMETROS INTERNOS, FIJAR FUENTES Y CORRER OP
* ==================================================================
save all
save @m.x1.m.xm1.m0[id] @m.x1.m.xm1.m0[gm] @m.x1.m.xm1.m0[gds] @m.x1.m.xm1.m0[vds] @m.x1.m.xm1.m0[vdsat] @m.x1.m.xm1.m0[vgs]
save @m.x1.m.xm2.m0[id] @m.x1.m.xm2.m0[gm] @m.x1.m.xm2.m0[gds] @m.x1.m.xm2.m0[vds] @m.x1.m.xm2.m0[vdsat] @m.x1.m.xm2.m0[vgs]
save @m.x1.m.xm3.m0[id] @m.x1.m.xm3.m0[gm] @m.x1.m.xm3.m0[gds] @m.x1.m.xm3.m0[vds] @m.x1.m.xm3.m0[vdsat] @m.x1.m.xm3.m0[vgs]
save @m.x1.m.xm4.m0[id] @m.x1.m.xm4.m0[gm] @m.x1.m.xm4.m0[gds] @m.x1.m.xm4.m0[vds] @m.x1.m.xm4.m0[vdsat] @m.x1.m.xm4.m0[vgs]
save @m.x1.m.xm5.m0[id] @m.x1.m.xm5.m0[gm] @m.x1.m.xm5.m0[gds] @m.x1.m.xm5.m0[vds] @m.x1.m.xm5.m0[vdsat] @m.x1.m.xm5.m0[vgs]
save @m.x1.m.xm6.m0[id] @m.x1.m.xm6.m0[gm] @m.x1.m.xm6.m0[gds] @m.x1.m.xm6.m0[vds] @m.x1.m.xm6.m0[vdsat] @m.x1.m.xm6.m0[vgs]

alter V1 $v1_val
alter V2 $v2_val
alter V3 $v3_val
alter I0 $i0_val

op

* --- XM1 ---
let id1 = abs(@m.x1.m.xm1.m0[id])
let gm1 = abs(@m.x1.m.xm1.m0[gm])
let gmid1 = gm1 / (id1 + 1e-18)
let vds1 = abs(@m.x1.m.xm1.m0[vds])
let vdsat1 = abs(@m.x1.m.xm1.m0[vdsat])
let sat_mrg1 = vds1 - vdsat1

* --- XM2 ---
let id2 = abs(@m.x1.m.xm2.m0[id])
let gm2 = abs(@m.x1.m.xm2.m0[gm])
let gmid2 = gm2 / (id2 + 1e-18)
let vds2 = abs(@m.x1.m.xm2.m0[vds])
let vdsat2 = abs(@m.x1.m.xm2.m0[vdsat])
let sat_mrg2 = vds2 - vdsat2

* --- XM3 ---
let id3 = abs(@m.x1.m.xm3.m0[id])
let gm3 = abs(@m.x1.m.xm3.m0[gm])
let gmid3 = gm3 / (id3 + 1e-18)
let vds3 = abs(@m.x1.m.xm3.m0[vds])
let vdsat3 = abs(@m.x1.m.xm3.m0[vdsat])
let sat_mrg3 = vds3 - vdsat3

* --- XM4 ---
let id4 = abs(@m.x1.m.xm4.m0[id])
let gm4 = abs(@m.x1.m.xm4.m0[gm])
let gmid4 = gm4 / (id4 + 1e-18)
let vds4 = abs(@m.x1.m.xm4.m0[vds])
let vdsat4 = abs(@m.x1.m.xm4.m0[vdsat])
let sat_mrg4 = vds4 - vdsat4

* --- XM5 ---
let id5 = abs(@m.x1.m.xm5.m0[id])
let gm5 = abs(@m.x1.m.xm5.m0[gm])
let gmid5 = gm5 / (id5 + 1e-18)
let vds5 = abs(@m.x1.m.xm5.m0[vds])
let vdsat5 = abs(@m.x1.m.xm5.m0[vdsat])
let sat_mrg5 = vds5 - vdsat5

* --- XM6 ---
let id6 = abs(@m.x1.m.xm6.m0[id])
let gm6 = abs(@m.x1.m.xm6.m0[gm])
let gmid6 = gm6 / (id6 + 1e-18)
let vds6 = abs(@m.x1.m.xm6.m0[vds])
let vdsat6 = abs(@m.x1.m.xm6.m0[vdsat])
let sat_mrg6 = vds6 - vdsat6

echo '============================================================'
echo 'RESUMEN DE INVERSION (gm/ID) Y MARGEN DE SATURACION'
echo '============================================================'

* --- Diagnostico XM1 ---
echo '--- XM1 ---'
print id1 gmid1 sat_mrg1
if gmid1 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid1 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg1 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg1 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

* --- Diagnostico XM2 ---
echo '--- XM2 ---'
print id2 gmid2 sat_mrg2
if gmid2 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid2 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg2 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg2 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

* --- Diagnostico XM3 ---
echo '--- XM3 ---'
print id3 gmid3 sat_mrg3
if gmid3 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid3 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg3 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg3 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

* --- Diagnostico XM4 ---
echo '--- XM4 ---'
print id4 gmid4 sat_mrg4
if gmid4 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid4 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg4 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg4 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

* --- Diagnostico XM5 ---
echo '--- XM5 ---'
print id5 gmid5 sat_mrg5
if gmid5 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid5 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg5 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg5 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

* --- Diagnostico XM6 ---
echo '--- XM6 ---'
print id6 gmid6 sat_mrg6
if gmid6 > $gmid_debil
  echo '  Inversion : DEBIL'
else
  if gmid6 < $gmid_fuerte
    echo '  Inversion : FUERTE'
  else
    echo '  Inversion : MODERADA'
  end
end
if sat_mrg6 >= $sat_min
  echo '  Saturacion: OK (>= umbral minimo)'
else
  if sat_mrg6 >= 0
    echo '  Saturacion: BAJO MARGEN (0 a < umbral minimo)'
  else
    echo '  Saturacion: LINEAL (margen < 0 V)'
  end
end

echo '============================================================'

.endc
"}
C {/home/ringosinye/eda/projects/ldo-gf180/xschem/ota_miller/ota_p_in.sym} 60 40 0 0 {name=x1}
C {capa.sym} 190 -70 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
