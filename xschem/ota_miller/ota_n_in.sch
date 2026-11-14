v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 60 -10 60 20 {
lab=#net1}
N 60 20 290 20 {
lab=#net1}
N 290 -10 290 20 {
lab=#net1}
N 60 -230 60 -220 {
lab=VDD}
N 60 -160 60 -70 {
lab=#net2}
N 290 -160 290 -70 {
lab=Voutn}
N 290 -280 290 -220 {
lab=VDD}
N 60 -280 290 -280 {
lab=VDD}
N 60 -280 60 -230 {
lab=VDD}
N 180 -300 180 -280 {
lab=VDD}
N 180 20 180 60 {
lab=#net1}
N -0 -40 20 -40 {
lab=+n}
N 330 -40 360 -40 {
lab=-n}
N 290 -110 340 -110 {
lab=Voutn}
N -40 90 140 90 {
lab=IDn}
N -80 230 180 230 {
lab=VSSn}
N 180 230 180 260 {
lab=VSSn}
N 180 120 180 230 {
lab=VSSn}
N -80 120 -80 230 {
lab=VSSn}
N -80 40 -80 60 {
lab=IDn}
N -80 40 20 40 {
lab=IDn}
N 20 40 20 90 {
lab=IDn}
N 100 -190 250 -190 {
lab=#net2}
N 60 -160 100 -160 {
lab=#net2}
N 100 -190 100 -160 {
lab=#net2}
N -80 -60 -80 40 {
lab=IDn}
N -80 -80 -80 -60 {
lab=IDn}
C {opin.sym} 340 -110 0 0 {name=p1 lab=Voutn}
C {ipin.sym} 180 260 3 0 {name=p2 lab=VSSn}
C {ipin.sym} 180 -300 1 0 {name=p3 lab=VDD}
C {ipin.sym} 0 -40 0 0 {name=p4 lab=+n}
C {ipin.sym} 360 -40 2 0 {name=p5 lab=-n}
C {gf180mcu_fd_pr/nfet3_03v3.sym} 40 -40 0 0 {name=M1
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
C {gf180mcu_fd_pr/nfet3_03v3.sym} 310 -40 0 1 {name=M2
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
C {gf180mcu_fd_pr/pfet3_03v3.sym} 80 -190 0 1 {name=M3
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
C {gf180mcu_fd_pr/pfet3_03v3.sym} 270 -190 0 0 {name=M4
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
C {gf180mcu_fd_pr/nfet3_03v3.sym} 160 90 0 0 {name=M5
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
C {gf180mcu_fd_pr/nfet3_03v3.sym} -60 90 0 1 {name=M6
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
C {ipin.sym} -80 -80 1 0 {name=p7 lab=IDn}
