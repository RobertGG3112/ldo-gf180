v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 240 -160 240 -140 {
lab=GND}
N 50 -10 50 20 {
lab=GND}
N 110 -80 180 -80 {
lab=vout}
N 180 -20 180 10 {
lab=GND}
N 180 -220 180 -120 {
lab=#net1}
N 180 -220 240 -220 {
lab=#net1}
N -80 -60 -20 -60 {
lab=vin_p}
N -80 0 -80 10 {
lab=GND}
N 70 -50 70 -10 {
lab=GND}
N 50 -10 70 -10 {
lab=GND}
N -10 -200 -10 -130 {
lab=#net2}
N -10 -130 30 -130 {
lab=#net2}
N -10 -310 -10 -260 {
lab=#net1}
N -10 -310 240 -310 {
lab=#net1}
N 240 -310 240 -220 {
lab=#net1}
N 70 -120 180 -120 {
lab=#net1}
N 70 -120 70 -110 {
lab=#net1}
N -170 -40 -170 -10 {
lab=GND}
N -170 -100 -20 -100 {
lab=vin_n}
C {vsource.sym} -170 -70 0 0 {name=V1 value=1.65 savecurrent=false}
C {vsource.sym} 240 -190 0 0 {name=V2 value=3.3 savecurrent=false}
C {gnd.sym} 50 20 0 0 {name=l1 lab=GND}
C {gnd.sym} 240 -140 0 0 {name=l2 lab=GND}
C {gnd.sym} -170 -10 0 0 {name=l3 lab=GND}
C {gnd.sym} -80 10 0 0 {name=l4 lab=GND}
C {code.sym} -340 -460 0 0 {name=PRUEBA_LAZO_ABIERTO
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

* 1. Senoidales en contrafase alrededor de 1.65V (amplitud 50uV para no saturar)
alter @v1[sin] [ 1.65 50u 1k 0 0 180 ]
alter @v3[sin] [ 1.65 50u 1k 0 0 0 ]

* 2. Simular 5 ms con paso de 1 us (5 ciclos de 1 kHz)
tran 1u 5m

* 3. Calcular diferencia de entrada y sus valores pico a pico
let vdiff = v(vin_p) - v(vin_n)
let vdiff_max = vecmax(vdiff)
let vdiff_min = vecmin(vdiff)
let vdiff_pp = vdiff_max - vdiff_min

* 4. Medir pico a pico, valor promedio DC y offset respecto a 1.65V (en 3 ciclos: 2ms a 5ms)
meas tran vout_pp pp v(vout) from=2m to=5m
meas tran vout_dc avg v(vout) from=2m to=5m

let Av0 = vout_pp / vdiff_pp
let Av0_dB = 20 * log10(Av0)
let offset_out = vout_dc - 1.65
let offset_in = offset_out / Av0

echo "========================================"
print vdiff_pp
print vout_pp
print Av0
print Av0_dB
print vout_dc
print offset_out
print offset_in
echo "========================================"

* 5. Graficas por separado: salida y senal diferencial
plot v(vout) title 'Salida OTA (Lazo Abierto)' xlabel 'Tiempo (s)' ylabel 'Voltaje (V)'
plot vdiff title 'Senal Diferencial de Entrada (V+ - V-)' xlabel 'Tiempo (s)' ylabel 'Voltaje (V)'
.endc
"}
C {code.sym} -350 -300 0 0 {name=Modelos
only_toplevel=true
value="
.include /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.param sw\\_stat\\_mismatch = 0
"}
C {capa.sym} 180 -50 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 180 10 0 0 {name=l5 lab=GND}
C {lab_wire.sym} 160 -80 0 0 {name=p2 sig_type=std_logic lab=vout}
C {vsource.sym} -80 -30 0 0 {name=V3 value=1.65 savecurrent=false}
C {isource.sym} -10 -230 0 0 {name=I0 value=20u}
C {ota_n_in.sym} 20 60 0 0 {name=x1}
C {lab_wire.sym} -50 -100 0 0 {name=p1 sig_type=std_logic lab=vin_n}
C {lab_wire.sym} -40 -60 0 0 {name=p3 sig_type=std_logic lab=vin_p}
