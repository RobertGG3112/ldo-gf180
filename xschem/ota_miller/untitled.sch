v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 120 -100 120 -70 {
lab=#net1}
N -40 -170 120 -170 {
lab=#net2}
N -40 -170 -40 -90 {
lab=#net2}
N -40 -90 -10 -90 {
lab=#net2}
N 120 -170 120 -160 {
lab=#net2}
N 120 -170 210 -170 {
lab=#net2}
N 210 -110 210 -90 {
lab=GND}
N -90 10 -90 30 {}
N -90 -50 -10 -50 {}
C {ota_n_in.sym} 100 90 0 0 {name=x1}
C {vsource.sym} -90 -20 0 0 {name=V1 value=3 savecurrent=false}
C {res.sym} 120 -130 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 210 -140 0 0 {name=R2
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 210 -90 0 0 {name=l1 lab=GND}
C {gnd.sym} -90 30 0 0 {name=l2 lab=GND}
