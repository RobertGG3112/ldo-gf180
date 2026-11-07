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
N 80 -1330 100 -1330 {
lab=VSp}
N 100 -1360 100 -1330 {
lab=VSp}
N 80 -1360 100 -1360 {
lab=VSp}
N -300 -1330 -230 -1330 {
lab=Vgn}
N -300 -1270 -300 -1260 {
lab=GND}
N -190 -1300 -190 -1290 {
lab=GND}
N 80 -1300 80 -1290 {
lab=GND}
N 80 -1370 80 -1360 {
lab=VSp}
N -190 -1370 -190 -1360 {
lab=Vdn}
N -380 -1280 -380 -1260 {
lab=GND}
N -380 -1370 -380 -1340 {
lab=Vdn}
N -380 -1370 -190 -1370 {
lab=Vdn}
N 220 -1300 220 -1280 {
lab=GND}
N 220 -1370 220 -1360 {
lab=VSp}
N 80 -1370 220 -1370 {
lab=VSp}
N -20 -1330 40 -1330 {
lab=Vgp}
N -20 -1360 -20 -1330 {
lab=Vgp}
N -20 -1420 80 -1420 {
lab=VSp}
N 80 -1420 80 -1370 {
lab=VSp}
C {gf180mcu_fd_pr/nfet3_03v3.sym} -210 -1330 0 0 {name=M1
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
C {gf180mcu_fd_pr/pfet_03v3.sym} 60 -1330 0 0 {name=M2
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
C {vsource.sym} -300 -1300 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} -380 -1310 0 0 {name=V2 value=1.8 savecurrent=false}
C {gnd.sym} -300 -1260 0 0 {name=l1 lab=GND}
C {gnd.sym} -190 -1290 0 0 {name=l2 lab=GND}
C {gnd.sym} 80 -1290 0 0 {name=l3 lab=GND}
C {gnd.sym} -380 -1260 0 0 {name=l4 lab=GND}
C {lab_pin.sym} -240 -1330 1 0 {name=p1 sig_type=std_logic lab=Vgn
}
C {vsource.sym} 220 -1330 0 0 {name=V3 value=1.8 savecurrent=false}
C {gnd.sym} 220 -1280 0 0 {name=l5 lab=GND}
C {lab_pin.sym} -190 -1370 1 0 {name=p2 sig_type=std_logic lab=Vdn
}
C {lab_pin.sym} 160 -1370 1 0 {name=p3 sig_type=std_logic lab=VSp
}
C {code.sym} -230 -1590 0 0 {name=CURVAS_DC
spice_ignore=false
only_toplevel=true
value="

.control
  save all

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
C {vsource.sym} -20 -1390 2 0 {name=V4 value=1.8 savecurrent=false}
C {lab_pin.sym} 10 -1330 1 0 {name=p4 sig_type=std_logic lab=Vgp}
C {code.sym} -400 -1590 0 0 {name=MODELOS
only_toplevel=true
value="
.include /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/ringosinye/eda/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
"}
