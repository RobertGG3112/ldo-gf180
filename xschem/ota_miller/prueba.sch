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
N 100 -90 210 -90 {}
N 210 -100 210 -90 {}
N 100 -30 100 10 {}
N 80 10 100 10 {}
C {ota_n_in.sym} 50 80 0 0 {name=x1}
C {res.sym} -50 -80 1 0 {name=R1
value=100k
footprint=1206
device=resistor
m=1}
C {res.sym} 80 -150 1 0 {name=R2
value=100k
footprint=1206
device=resistor
m=1}
C {vsource.sym} -140 -40 0 0 {name=V1 value=3 savecurrent=false}
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

* 1. Convertir V1 a onda senoidal: Offset = 1.65V, Amplitud = 0.5V, Frecuencia = 1kHz
alter V1 sin(1.65 0.5 1k)

* 2. Simular 5 ms con paso de 1 us (5 ciclos de 1 kHz)
tran 1u 2m

* 3. Graficar la señal de salida Vout
plot v(Vout) title 'Respuesta Transitoria Inversor OTA 5T' xlabel 'Tiempo (s)' ylabel 'Voltaje (V)'
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
