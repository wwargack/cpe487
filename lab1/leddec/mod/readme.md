# Position Switch Modification

Lines 3, 4, 5 are modified.

Original: 
```
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {dig[0]}]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {dig[1]}]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {dig[2]}]
```

Modified:
```
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {dig[0]}]
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {dig[1]}]
set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33} [get_ports {dig[2]}]
```

PACKAGE_PINs modifiedd from U12, U11, V10 to U18, R13, T8 respectively.

Corresponds to switches 13, 14, 15 to 6, 7, 8 respectively.