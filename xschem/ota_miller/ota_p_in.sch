v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 60 -10 60 20 {
lab=#net1}
N 290 -10 290 20 {
lab=Vout}
N 60 -160 60 -70 {
lab=#net2}
N 290 -160 290 -70 {
lab=#net2}
N -0 -40 20 -40 {
lab=+}
N 330 -40 360 -40 {
lab=-}
N 60 20 60 70 {
lab=#net1}
N 290 20 290 70 {
lab=Vout}
N 100 60 100 100 {
lab=#net1}
N 60 60 100 60 {
lab=#net1}
N 100 100 250 100 {
lab=#net1}
N 60 130 60 200 {
lab=VSS}
N 60 200 290 200 {
lab=VSS}
N 290 130 290 200 {
lab=VSS}
N 180 200 180 260 {
lab=VSS}
N 290 30 350 30 {
lab=Vout}
N 60 -160 180 -160 {
lab=#net2}
N 180 -200 180 -160 {
lab=#net2}
N 180 -160 290 -160 {
lab=#net2}
N 220 -230 370 -230 {
lab=IDp}
N 180 -300 180 -260 {
lab=VDD}
N 180 -300 410 -300 {
lab=VDD}
N 410 -300 410 -260 {
lab=VDD}
N 300 -320 300 -300 {
lab=VDD}
N 370 -230 370 -190 {
lab=IDp}
N 370 -190 410 -190 {
lab=IDp}
N 410 -200 410 -190 {
lab=IDp}
N 410 -190 410 -140 {
lab=IDp}
C {opin.sym} 350 30 0 0 {name=p1 lab=Vout}
C {ipin.sym} 180 260 3 0 {name=p2 lab=VSS}
C {ipin.sym} 300 -320 1 0 {name=p3 lab=VDD}
C {ipin.sym} 0 -40 0 0 {name=p4 lab=+}
C {ipin.sym} 360 -40 2 0 {name=p5 lab=-}
C {ipin.sym} 410 -140 3 0 {name=p7 lab=ID}
C {gf180mcu_fd_pr/pfet3_03v3.sym} 40 -40 0 0 {name=M1
L=0.28u
W=0.22u
body=VDD
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
C {gf180mcu_fd_pr/pfet3_03v3.sym} 310 -40 0 1 {name=M2
L=0.28u
W=0.22u
body=VDD
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
C {gf180mcu_fd_pr/nfet3_03v3.sym} 80 100 0 1 {name=M3
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
C {gf180mcu_fd_pr/nfet3_03v3.sym} 270 100 0 0 {name=M4
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
C {gf180mcu_fd_pr/pfet3_03v3.sym} 200 -230 0 1 {name=M5
L=0.28u
W=0.22u
body=VDD
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
C {gf180mcu_fd_pr/pfet3_03v3.sym} 390 -230 0 0 {name=M6
L=0.28u
W=0.22u
body=VDD
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
