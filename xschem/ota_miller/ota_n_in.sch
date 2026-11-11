v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 60 -40 70 -40 {
lab=VSS}
N 280 -40 290 -40 {
lab=VSS}
N 60 -10 60 20 {
lab=#net1}
N 60 20 290 20 {
lab=#net1}
N 290 -10 290 20 {
lab=#net1}
N 100 -190 250 -190 {
lab=VDD}
N 60 -230 60 -220 {
lab=VDD}
N 60 -230 110 -230 {
lab=VDD}
N 110 -230 110 -190 {
lab=VDD}
N 290 -190 300 -190 {
lab=VSS}
N 50 -190 60 -190 {
lab=VSS}
N 60 -160 60 -70 {
lab=#net2}
N 290 -160 290 -70 {
lab=Vout}
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
lab=+}
N 330 -40 360 -40 {
lab=-}
N 290 -110 340 -110 {
lab=Vout}
N -40 90 140 90 {
lab=#net3}
N -80 230 180 230 {
lab=VSS}
N 180 230 180 260 {
lab=VSS}
N 180 120 180 230 {
lab=VSS}
N -80 -280 60 -280 {
lab=VDD}
N -90 90 -80 90 {
lab=VSS}
N -90 90 -90 120 {
lab=VSS}
N -90 120 -80 120 {
lab=VSS}
N 180 90 190 90 {
lab=VSS}
N 190 90 190 120 {
lab=VSS}
N 180 120 190 120 {
lab=VSS}
N -80 120 -80 230 {
lab=VSS}
N -80 40 -80 60 {
lab=#net3}
N -80 -280 -80 -20 {
lab=VDD}
N -80 40 20 40 {
lab=#net3}
N 20 40 20 90 {
lab=#net3}
C {gf180mcu_fd_pr/nfet_03v3.sym} 40 -40 0 0 {name=M1
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
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet_03v3.sym} 310 -40 0 1 {name=M2
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
model=nfet_03v3
spiceprefix=X
}
C {opin.sym} 340 -110 0 0 {name=p1 lab=Vout}
C {ipin.sym} 180 260 3 0 {name=p2 lab=VSS}
C {ipin.sym} 180 -300 1 0 {name=p3 lab=VDD}
C {gf180mcu_fd_pr/nfet_03v3.sym} 80 -190 0 1 {name=M3
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
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet_03v3.sym} 270 -190 0 0 {name=M4
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
model=nfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet_03v3.sym} 160 90 0 0 {name=M5
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
model=nfet_03v3
spiceprefix=X
}
C {ipin.sym} 0 -40 0 0 {name=p4 lab=+}
C {ipin.sym} 360 -40 2 0 {name=p5 lab=-}
C {gf180mcu_fd_pr/nfet_03v3.sym} -60 90 0 1 {name=M6
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
model=nfet_03v3
spiceprefix=X
}
C {isource.sym} -80 10 0 0 {name=I0 value=1m}
C {lab_wire.sym} 50 -190 0 0 {name=p6 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 70 -40 0 1 {name=p7 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 280 -40 0 0 {name=p8 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} 300 -190 0 1 {name=p9 sig_type=std_logic lab=VSS
}
