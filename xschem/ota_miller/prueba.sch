v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 140 -150 140 -60 {
lab=vout}
N 110 -150 140 -150 {
lab=vout}
N -140 -80 -140 -70 {
lab=#net1}
N -140 -80 -80 -80 {
lab=#net1}
N 270 -140 270 -120 {
lab=GND}
N -140 -10 -140 10 {
lab=GND}
N 80 10 80 40 {
lab=GND}
N 140 -60 210 -60 {
lab=vout}
N 210 0 210 30 {
lab=GND}
N 210 -200 210 -100 {
lab=#net2}
N 210 -200 270 -200 {
lab=#net2}
N 10 -150 50 -150 {
lab=#net3}
N -20 -80 10 -80 {
lab=#net3}
N 10 -150 10 -80 {
lab=#net3}
N -50 -40 10 -40 {
lab=#net4}
N -50 20 -50 30 {
lab=GND}
N 100 -30 100 10 {
lab=GND}
N 80 10 100 10 {
lab=GND}
N 20 -180 20 -110 {
lab=#net5}
N 20 -110 60 -110 {
lab=#net5}
N 20 -290 20 -240 {
lab=#net2}
N 20 -290 270 -290 {
lab=#net2}
N 270 -290 270 -200 {
lab=#net2}
N 100 -100 210 -100 {
lab=#net2}
N 100 -100 100 -90 {
lab=#net2}
C {res.sym} -50 -80 1 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 80 -150 1 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {vsource.sym} -140 -40 0 0 {name=V1 value=1.65 savecurrent=false}
C {vsource.sym} 270 -170 0 0 {name=V2 value=3.3 savecurrent=false}
C {gnd.sym} 80 40 0 0 {name=l1 lab=GND}
C {gnd.sym} 270 -120 0 0 {name=l2 lab=GND}
C {gnd.sym} -140 10 0 0 {name=l3 lab=GND}
C {gnd.sym} -50 30 0 0 {name=l4 lab=GND}
C {code.sym} -170 -280 0 0 {name=PRUEBA_TRAN 
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

* 1. Senoidales en contrafase (180 deg) con offset 1.65V, amplitud 1mV, frecuencia 1kHz
alter @v1[sin] [ 1.65 1m 1k 0 0 0 ]
alter @v3[sin] [ 1.65 1m 1k 0 0 180 ]

* 2. Simular 5 ms con paso de 1 us (5 ciclos de 1 kHz)
tran 1u 5m

* 3. Medir pico a pico directamente con meas (2ms a 5ms)
meas tran vout_pp pp v(vout) from=2m to=5m
meas tran vnet1_pp pp v(net1) from=2m to=5m

* 4. Calcular diferencia de entrada y su pico a pico en pasos separados
let vdiff = v(net4) - v(net1)
let vdiff_max = vecmax(vdiff)
let vdiff_min = vecmin(vdiff)
let vdiff_pp = vdiff_max - vdiff_min

* 5. Calcular ganancias por separado
let ganancia_v1 = vout_pp / vnet1_pp
let ganancia_diff = vout_pp / vdiff_pp

echo "========================================"
print ganancia_v1
print ganancia_diff
echo "========================================"

* 6. Graficar salida y entradas
plot v(vout) v(net1) v(net4) title 'Respuesta Transitoria OTA 5T' xlabel 'Tiempo (s)' ylabel 'Voltaje (V)'
.endc
"}
C {code.sym} -320 -280 0 0 {name=Modelos
only_toplevel=true
value="
.include /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.param sw\\_stat\\_mismatch = 0
"}
C {capa.sym} 210 -30 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 210 30 0 0 {name=l5 lab=GND}
C {lab_wire.sym} 190 -60 0 0 {name=p2 sig_type=std_logic lab=vout}
C {vsource.sym} -50 -10 0 0 {name=V3 value=1.65 savecurrent=false}
C {isource.sym} 20 -210 0 0 {name=I0 value=20u}
C {ota_n_in.sym} 50 80 0 0 {name=x1}
