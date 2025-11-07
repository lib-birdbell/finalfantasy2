.include "Constants.inc"
.include "variables.inc"

.segment "BANK_0A"

; ========== pointers to text2 ( 768 items) ($8000-$85FF) START ==========
; pointers to text 2
;; [$8000 :: 0x28000]

.word T000_8600h			; 8000	$00 $86
.word T001_8601h			; 8002	$01 $86
.word T002_863Bh			; 8004	$3B $86
.word T003_864Dh			; 8006	$4D $86
.word T004_8670h			; 8008	$70 $86
.word T005_86C2h			; 800A	$C2 $86
.word T006_86DEh			; 800C	$DE $86
.word T007_8728h			; 800E	$28 $87
.word T008_8774h			; 8010	$74 $87
.word T009_87ADh			; 8012	$AD $87
.word T010_87F9h			; 8014	$F9 $87
.word T011_881Fh			; 8016	$1F $88
.word T012_883Bh			; 8018	$3B $88
.word T013_8862h			; 801A	$62 $88
.word T014_88CCh			; 801C	$CC $88
.word T015_88F7h			; 801E	$F7 $88
.word T016_8913h			; 8020	$13 $89
.word T017_8942h			; 8022	$42 $89
.word T018_895Ch			; 8024	$5C $89
.word T019_89A6h			; 8026	$A6 $89
.word T020_89E1h			; 8028	$E1 $89
.word T021_8A0Dh			; 802A	$0D $8A
.word T022_8A49h			; 802C	$49 $8A
.word T023_8A59h			; 802E	$59 $8A
.word T024_8A75h			; 8030	$75 $8A
.word T025_8AAFh			; 8032	$AF $8A
.word T026_8ADDh			; 8034	$DD $8A
.word T027_8B01h			; 8036	$01 $8B
.word T028_8B25h			; 8038	$25 $8B
.word T029_8B80h			; 803A	$80 $8B
.word T030_8BA4h			; 803C	$A4 $8B
.word T031_8BBCh			; 803E	$BC $8B
.word T032_8BDEh			; 8040	$DE $8B
.word T033_8BFEh			; 8042	$FE $8B
.word T034_8C30h			; 8044	$30 $8C
.word T035_8C6Bh			; 8046	$6B $8C
.word T036_8C9Fh			; 8048	$9F $8C
.word T037_8CE0h			; 804A	$E0 $8C
.word T038_8D29h			; 804C	$29 $8D
.word T039_8D6Eh			; 804E	$6E $8D
.word T040_8D97h			; 8050	$97 $8D
.word T041_8DA7h			; 8052	$A7 $8D
.word T042_8DDAh			; 8054	$DA $8D
.word T043_8E09h			; 8056	$09 $8E
.word T044_8E50h			; 8058	$50 $8E
.word T045_8E60h			; 805A	$60 $8E
.word T046_8E8Bh			; 805C	$8B $8E
.word T047_8EA9h			; 805E	$A9 $8E
.word T048_8ECAh			; 8060	$CA $8E
.word T049_8EE7h			; 8062	$E7 $8E
.word T050_8F02h			; 8064	$02 $8F
.word T051_8F25h			; 8066	$25 $8F
.word T052_8F4Ch			; 8068	$4C $8F
.word T053_8F65h			; 806A	$65 $8F
.word T054_8F8Bh			; 806C	$8B $8F
.word T055_8FAEh			; 806E	$AE $8F
.word T056_8FC6h			; 8070	$C6 $8F
.word T057_8FD1h			; 8072	$D1 $8F
.word T058_8FE7h			; 8074	$E7 $8F
.word T059_8FF7h			; 8076	$F7 $8F
.word T060_904Bh			; 8078	$4B $90
.word T061_905Fh			; 807A	$5F $90
.word T062_907Bh			; 807C	$7B $90
.word T063_90B0h			; 807E	$B0 $90
.word T064_90C5h			; 8080	$C5 $90
.word T065_90F3h			; 8082	$F3 $90
.word T066_9105h			; 8084	$05 $91
.word T067_9115h			; 8086	$15 $91
.word T068_912Fh			; 8088	$2F $91
.word T069_9143h			; 808A	$43 $91
.word T070_916Ch			; 808C	$6C $91
.word T071_91BDh			; 808E	$BD $91
.word T072_91E2h			; 8090	$E2 $91
.word T073_9224h			; 8092	$24 $92
.word T074_922Dh			; 8094	$2D $92
.word T075_9242h			; 8096	$42 $92
.word T076_9264h			; 8098	$64 $92
.word T077_9272h			; 809A	$72 $92
.word T078_9295h			; 809C	$95 $92
.word T079_92AEh			; 809E	$AE $92
.word T080_92C0h			; 80A0	$C0 $92
.word T081_92DFh			; 80A2	$DF $92
.word T082_92EDh			; 80A4	$ED $92
.word T083_92FEh			; 80A6	$FE $92
.word T084_931Dh			; 80A8	$1D $93
.word T085_932Fh			; 80AA	$2F $93
.word T086_9347h			; 80AC	$47 $93
.word T087_935Eh			; 80AE	$5E $93
.word T088_936Fh			; 80B0	$6F $93
.word T089_9385h			; 80B2	$85 $93
.word T090_93A5h			; 80B4	$A5 $93
.word T091_93C4h			; 80B6	$C4 $93
.word T092_93CBh			; 80B8	$CB $93
.word T093_9405h			; 80BA	$05 $94
.word T094_942Ch			; 80BC	$2C $94
.word T095_9437h			; 80BE	$37 $94
.word T096_944Eh			; 80C0	$4E $94
.word T097_945Dh			; 80C2	$5D $94
.word T098_9496h			; 80C4	$96 $94
.word T099_94A7h			; 80C6	$A7 $94
.word T100_94CBh			; 80C8	$CB $94
.word T101_94EAh			; 80CA	$EA $94
.word T102_9525h			; 80CC	$25 $95
.word T103_9550h			; 80CE	$50 $95
.word T104_9560h			; 80D0	$60 $95
.word T105_9577h			; 80D2	$77 $95
.word T106_958Fh			; 80D4	$8F $95
.word T107_95ABh			; 80D6	$AB $95
.word T108_95E2h			; 80D8	$E2 $95
.word T109_9604h			; 80DA	$04 $96
.word T110_9617h			; 80DC	$17 $96
.word T111_9636h			; 80DE	$36 $96
.word T112_9651h			; 80E0	$51 $96
.word T113_966Bh			; 80E2	$6B $96
.word T114_9673h			; 80E4	$73 $96
.word T115_9688h			; 80E6	$88 $96
.word T116_969Fh			; 80E8	$9F $96
.word T117_96A8h			; 80EA	$A8 $96
.word T118_96E8h			; 80EC	$E8 $96
.word T119_9707h			; 80EE	$07 $97
.word T120_9721h			; 80F0	$21 $97
.word T121_9730h			; 80F2	$30 $97
.word T122_9765h			; 80F4	$65 $97
.word T123_9775h			; 80F6	$75 $97
.word T124_97C2h			; 80F8	$C2 $97
.word T125_97D0h			; 80FA	$D0 $97
.word T126_9808h			; 80FC	$08 $98
.word T127_9816h			; 80FE	$16 $98

;; [$8100 :: 0x28100]

.word T128_982Eh			; 8100	$2E $98
.word T129_985Ah			; 8102	$5A $98
.word T130_986Bh			; 8104	$6B $98
.word T131_9889h			; 8106	$89 $98
.word T132_98A1h			; 8108	$A1 $98
.word T133_98B6h			; 810A	$B6 $98
.word T134_98C0h			; 810C	$C0 $98
.word T135_98F1h			; 810E	$F1 $98
.word T136_98FDh			; 8110	$FD $98
.word T137_9907h			; 8112	$07 $99
.word T138_991Dh			; 8114	$1D $99
.word T139_9948h			; 8116	$48 $99
.word T140_996Bh			; 8118	$6B $99
.word T141_997Eh			; 811A	$7E $99
.word T142_9993h			; 811C	$93 $99
.word T143_99B1h			; 811E	$B1 $99
.word T144_99CCh			; 8120	$CC $99
.word T145_99E2h			; 8122	$E2 $99
.word T146_99EFh			; 8124	$EF $99
.word T147_99FEh			; 8126	$FE $99
.word T148_9A29h			; 8128	$29 $9A
.word T149_9A7Fh			; 812A	$7F $9A
.word T150_9ACBh			; 812C	$CB $9A
.word T151_9AEEh			; 812E	$EE $9A
.word T152_9B15h			; 8130	$15 $9B
.word T153_9B2Fh			; 8132	$2F $9B
.word T154_9BC0h			; 8134	$C0 $9B
.word T155_9BC2h			; 8136	$C2 $9B
.word T156_9BD6h			; 8138	$D6 $9B
.word T157_9BEEh			; 813A	$EE $9B
.word T158_9C1Ah			; 813C	$1A $9C
.word T159_9C46h			; 813E	$46 $9C
.word T160_9C6Ch			; 8140	$6C $9C
.word T161_9CB0h			; 8142	$B0 $9C
.word T162_9CE9h			; 8144	$E9 $9C
.word T163_9D02h			; 8146	$02 $9D
.word T164_9D1Dh			; 8148	$1D $9D
.word T165_9D30h			; 814A	$30 $9D
.word T166_9D49h			; 814C	$49 $9D
.word T167_9D54h			; 814E	$54 $9D
.word T168_9D6Bh			; 8150	$6B $9D
.word T169_9D8Ah			; 8152	$8A $9D
.word T170_9D93h			; 8154	$93 $9D
.word T171_9D9Ch			; 8156	$9C $9D
.word T172_9DB3h			; 8158	$B3 $9D
.word T173_9DDBh			; 815A	$DB $9D
.word T174_9DF2h			; 815C	$F2 $9D
.word T175_9E23h			; 815E	$23 $9E
.word T176_9E2Bh			; 8160	$2B $9E
.word T177_9E6Bh			; 8162	$6B $9E
.word T178_9E8Ch			; 8164	$8C $9E
.word T179_9EBBh			; 8166	$BB $9E
.word T180_9ECFh			; 8168	$CF $9E
.word T181_9EEBh			; 816A	$EB $9E
.word T182_9EFEh			; 816C	$FE $9E
.word T183_9F14h			; 816E	$14 $9F
.word T184_9F3Eh			; 8170	$3E $9F
.word T185_9F52h			; 8172	$52 $9F
.word T186_9F6Bh			; 8174	$6B $9F
.word T187_9F9Ch			; 8176	$9C $9F
.word T188_9FB8h			; 8178	$B8 $9F
.word T189_9FD1h			; 817A	$D1 $9F
.word T190_9FEDh			; 817C	$ED $9F
.word T191_A00Dh			; 817E	$0D $A0
.word T192_A027h			; 8180	$27 $A0
.word T193_A035h			; 8182	$35 $A0
.word T194_A044h			; 8184	$44 $A0
.word T195_A061h			; 8186	$61 $A0
.word T196_A07Ah			; 8188	$7A $A0
.word T197_A094h			; 818A	$94 $A0
.word T198_A0C0h			; 818C	$C0 $A0
.word T199_A0D2h			; 818E	$D2 $A0
.word T200_A0E5h			; 8190	$E5 $A0
.word T201_A0F5h			; 8192	$F5 $A0
.word T202_A10Dh			; 8194	$0D $A1
.word T203_A11Ch			; 8196	$1C $A1
.word T204_A12Dh			; 8198	$2D $A1
.word T205_A13Eh			; 819A	$3E $A1
.word T206_A150h			; 819C	$50 $A1
.word T207_A179h			; 819E	$79 $A1
.word T208_A1A1h			; 81A0	$A1 $A1
.word T209_A1B0h			; 81A2	$B0 $A1
.word T210_A1D1h			; 81A4	$D1 $A1
.word T211_A1F3h			; 81A6	$F3 $A1
.word T212_A218h			; 81A8	$18 $A2
.word T213_A222h			; 81AA	$22 $A2
.word T214_A23Ch			; 81AC	$3C $A2
.word T215_A24Eh			; 81AE	$4E $A2
.word T216_A26Ah			; 81B0	$6A $A2
.word T217_A2A6h			; 81B2	$A6 $A2
.word T218_A2BDh			; 81B4	$BD $A2
.word T219_A2CAh			; 81B6	$CA $A2
.word T220_A320h			; 81B8	$20 $A3
.word T221_A331h			; 81BA	$31 $A3
.word T222_A345h			; 81BC	$45 $A3
.word T223_A354h			; 81BE	$54 $A3
.word T224_A368h			; 81C0	$68 $A3
.word T225_A37Eh			; 81C2	$7E $A3
.word T226_A3B7h			; 81C4	$B7 $A3
.word T227_A3D6h			; 81C6	$D6 $A3
.word T228_A3E1h			; 81C8	$E1 $A3
.word T229_A3FBh			; 81CA	$FB $A3
.word T230_A412h			; 81CC	$12 $A4
.word T231_A424h			; 81CE	$24 $A4
.word T232_A43Ah			; 81D0	$3A $A4
.word T233_A469h			; 81D2	$69 $A4
.word T234_A481h			; 81D4	$81 $A4
.word T235_A4CEh			; 81D6	$CE $A4
.word T236_A500h			; 81D8	$00 $A5
.word T237_A517h			; 81DA	$17 $A5
.word T238_A530h			; 81DC	$30 $A5
.word T239_A54Bh			; 81DE	$4B $A5
.word T240_A56Dh			; 81E0	$6D $A5
.word T241_A588h			; 81E2	$88 $A5
.word T242_A5BBh			; 81E4	$BB $A5
.word T243_A604h			; 81E6	$04 $A6
.word T244_A624h			; 81E8	$24 $A6
.word T245_A64Ah			; 81EA	$4A $A6
.word T246_A66Eh			; 81EC	$6E $A6
.word T247_A69Dh			; 81EE	$9D $A6
.word T248_A6B6h			; 81F0	$B6 $A6
.word T249_A6D0h			; 81F2	$D0 $A6
.word T250_A700h			; 81F4	$00 $A7
.word T251_A717h			; 81F6	$17 $A7
.word T252_A739h			; 81F8	$39 $A7
.word T253_A75Bh			; 81FA	$5B $A7
.word T254_A765h			; 81FC	$65 $A7
.word T255_A73Ah			; 81FE	$3A $A7

;; [$8200 :: 0x28200]
.word T256_A78Bh			; 8200	$8B $A7
.word T257_A78Ch			; 8202	$8C $A7
.word T258_A790h			; 8204	$90 $A7
.word T259_A795h			; 8206	$95 $A7
.word T260_A799h			; 8208	$99 $A7
.word T261_A7A0h			; 820A	$A0 $A7
.word T262_A7AAh			; 820C	$AA $A7
.word T263_A7B3h			; 820E	$B3 $A7
.word T264_A7BCh			; 8210	$BC $A7
.word T265_A7C3h			; 8212	$C3 $A7
.word T266_A7C9h			; 8214	$C9 $A7
.word T267_A7D2h			; 8216	$D2 $A7
.word T268_A7DAh			; 8218	$DA $A7
.word T269_A7E3h			; 821A	$E3 $A7
.word T270_A7ECh			; 821C	$EC $A7
.word T271_A7F2h			; 821E	$F2 $A7
.word T272_A7F6h			; 8220	$F6 $A7
.word T273_A7FCh			; 8222	$FC $A7
.word T274_A805h			; 8224	$05 $A8
.word T275_A80Dh			; 8226	$0D $A8
.word T276_A814h			; 8228	$14 $A8
.word T277_A81Dh			; 822A	$1D $A8
.word T278_A823h			; 822C	$23 $A8
.word T279_A82Dh			; 822E	$2D $A8
.word T280_A837h			; 8230	$37 $A8
.word T281_A83Eh			; 8232	$3E $A8
.word T282_A843h			; 8234	$43 $A8
.word T283_A84Ch			; 8236	$4C $A8
.word T284_A854h			; 8238	$54 $A8
.word T285_A85Dh			; 823A	$5D $A8
.word T286_A867h			; 823C	$67 $A8
.word T287_A86Ch			; 823E	$6C $A8
.word T288_A876h			; 8240	$76 $A8
.word T289_A87Fh			; 8242	$7F $A8
.word T290_A888h			; 8244	$88 $A8
.word T291_A891h			; 8246	$91 $A8
.word T292_A89Ah			; 8248	$9A $A8
.word T293_A8A4h			; 824A	$A4 $A8
.word T294_A8AEh			; 824C	$AE $A8
.word T295_A8B6h			; 824E	$B6 $A8
.word T296_A8BEh			; 8250	$BE $A8
.word T297_A8C7h			; 8252	$C7 $A8
.word T298_A8D1h			; 8254	$D1 $A8
.word T299_A8D9h			; 8256	$D9 $A8
.word T300_A8E1h			; 8258	$E1 $A8
.word T301_A8EAh			; 825A	$EA $A8
.word T302_A8F2h			; 825C	$F2 $A8
.word T303_A8F9h			; 825E	$F9 $A8
.word T304_A8FEh			; 8260	$FE $A8
.word T305_A904h			; 8262	$04 $A9
.word T306_A90Ch			; 8264	$0C $A9
.word T307_A913h			; 8266	$13 $A9
.word T308_A91Bh			; 8268	$1B $A9
.word T309_A922h			; 826A	$22 $A9
.word T310_A927h			; 826C	$27 $A9
.word T311_A92Dh			; 826E	$2D $A9
.word T312_A935h			; 8270	$35 $A9
.word T313_A93Ch			; 8272	$3C $A9
.word T314_A942h			; 8274	$42 $A9
.word T315_A949h			; 8276	$49 $A9
.word T316_A950h			; 8278	$50 $A9
.word T317_A958h			; 827A	$58 $A9
.word T318_A961h			; 827C	$61 $A9
.word T319_A96Bh			; 827E	$6B $A9
.word T320_A972h			; 8280	$72 $A9
.word T321_A97Bh			; 8282	$7B $A9
.word T322_A982h			; 8284	$82 $A9
.word T323_A988h			; 8286	$88 $A9
.word T324_A990h			; 8288	$90 $A9
.word T325_A998h			; 828A	$98 $A9
.word T326_A99Eh			; 828C	$9E $A9
.word T327_A9A4h			; 828E	$A4 $A9
.word T328_A9ABh			; 8290	$AB $A9
.word T329_A9B1h			; 8292	$B1 $A9
.word T330_A9B9h			; 8294	$B9 $A9
.word T331_A9C0h			; 8296	$C0 $A9
.word T332_A9C6h			; 8298	$C6 $A9
.word T333_A9CEh			; 829A	$CE $A9
.word T334_A9D5h			; 829C	$D5 $A9
.word T335_A9DBh			; 829E	$DB $A9
.word T336_A9E1h			; 82A0	$E1 $A9
.word T337_A9E6h			; 82A2	$E6 $A9
.word T338_A9EDh			; 82A4	$ED $A9
.word T339_A9F3h			; 82A6	$F3 $A9
.word T340_A9FAh			; 82A8	$FA $A9
.word T341_A9FFh			; 82AA	$FF $A9
.word T342_AA07h			; 82AC	$07 $AA
.word T343_AA0Fh			; 82AE	$0F $AA
.word T344_AA17h			; 82B0	$17 $AA
.word T345_AA1Ch			; 82B2	$1C $AA
.word T346_AA23h			; 82B4	$23 $AA
.word T347_AA29h			; 82B6	$29 $AA
.word T348_AA2Fh			; 82B8	$2F $AA
.word T349_AA34h			; 82BA	$34 $AA
.word T350_AA3Ch			; 82BC	$3C $AA
.word T351_AA41h			; 82BE	$41 $AA
.word T352_AA4Bh			; 82C0	$4B $AA
.word T353_AA54h			; 82C2	$54 $AA
.word T354_AA59h			; 82C4	$59 $AA
.word T355_AA5Fh			; 82C6	$5F $AA
.word T356_AA67h			; 82C8	$67 $AA
.word T357_AA6Dh			; 82CA	$6D $AA
.word T358_AA75h			; 82CC	$75 $AA
.word T359_AA7Bh			; 82CE	$7B $AA
.word T360_AA81h			; 82D0	$81 $AA
.word T361_AA86h			; 82D2	$86 $AA
.word T362_AA8Bh			; 82D4	$8B $AA
.word T363_AA93h			; 82D6	$93 $AA
.word T364_AA98h			; 82D8	$98 $AA
.word T365_AA9Eh			; 82DA	$9E $AA
.word T366_AAA3h			; 82DC	$A3 $AA
.word T367_AAA4h			; 82DE	$A4 $AA
.word T368_AAACh			; 82E0	$AC $AA
.word T369_AAB2h			; 82E2	$B2 $AA
.word T370_AAB9h			; 82E4	$B9 $AA
.word T371_AAC1h			; 82E6	$C1 $AA
.word T372_AAC7h			; 82E8	$C7 $AA
.word T373_AACDh			; 82EA	$CD $AA
.word T374_AAD5h			; 82EC	$D5 $AA
.word T375_AADCh			; 82EE	$DC $AA
.word T376_AAE2h			; 82F0	$E2 $AA
.word T377_AAEAh			; 82F2	$EA $AA
.word T378_AAF1h			; 82F4	$F1 $AA
.word T379_AAF8h			; 82F6	$F8 $AA
.word T380_AAFEh			; 82F8	$FE $AA
.word T381_AB05h			; 82FA	$05 $AB
.word T382_AB0Dh			; 82FC	$0D $AB
.word T383_AB13h			; 82FE	$13 $AB

;; [$8300 :: 0x28300]
.word T384_AB1Bh			; 8300	$1B $AB
.word T385_AB21h			; 8302	$21 $AB
.word T386_AB26h			; 8304	$26 $AB
.word T387_AB2Eh			; 8306	$2E $AB
.word T388_AB35h			; 8308	$35 $AB
.word T389_AB3Ch			; 830A	$3C $AB
.word T390_AB43h			; 830C	$43 $AB
.word T391_AB4Ah			; 830E	$4A $AB
.word T392_AB50h			; 8310	$50 $AB
.word T393_AB56h			; 8312	$56 $AB
.word T394_AB5Eh			; 8314	$5E $AB
.word T395_AB68h			; 8316	$68 $AB
.word T396_AB72h			; 8318	$72 $AB
.word T397_AB78h			; 831A	$78 $AB
.word T398_AB81h			; 831C	$81 $AB
.word T399_AB87h			; 831E	$87 $AB
.word T400_AB8Eh			; 8320	$8E $AB
.word T401_AB96h			; 8322	$96 $AB
.word T402_AB9Eh			; 8324	$9E $AB
.word T403_ABA5h			; 8326	$A5 $AB
.word T404_ABAAh			; 8328	$AA $AB
.word T405_ABB2h			; 832A	$B2 $AB
.word T406_ABB9h			; 832C	$B9 $AB
.word T407_ABC2h			; 832E	$C2 $AB
.word T408_ABC8h			; 8330	$C8 $AB
.word T409_ABCDh			; 8332	$CD $AB
.word T410_ABD4h			; 8334	$D4 $AB
.word T411_ABDCh			; 8336	$DC $AB
.word T412_ABE4h			; 8338	$E4 $AB
.word T413_ABEAh			; 833A	$EA $AB
.word T414_ABF2h			; 833C	$F2 $AB
.word T415_ABF8h			; 833E	$F8 $AB
.word T416_ABFEh			; 8340	$FE $AB
.word T417_AC04h			; 8342	$04 $AC
.word T418_AC09h			; 8344	$09 $AC
.word T419_AC11h			; 8346	$11 $AC
.word T420_AC16h			; 8348	$16 $AC
.word T421_AC1Dh			; 834A	$1D $AC
.word T422_AC23h			; 834C	$23 $AC
.word T423_AC29h			; 834E	$29 $AC
.word T424_AC2Eh			; 8350	$2E $AC
.word T425_AC33h			; 8352	$33 $AC
.word T426_AC3Ah			; 8354	$3A $AC
.word T427_AC40h			; 8356	$40 $AC
.word T428_AC46h			; 8358	$46 $AC
.word T429_AC4Bh			; 835A	$4B $AC
.word T430_AC51h			; 835C	$51 $AC
.word T431_AC58h			; 835E	$58 $AC
.word T432_AC5Fh			; 8360	$5F $AC
.word T433_AC66h			; 8362	$66 $AC
.word T434_AC6Ch			; 8364	$6C $AC
.word T435_AC75h			; 8366	$75 $AC
.word T436_AC7Ah			; 8368	$7A $AC
.word T437_AC7Fh			; 836A	$7F $AC
.word T438_AC86h			; 836C	$86 $AC
.word T439_AC8Bh			; 836E	$8B $AC
.word T440_AC93h			; 8370	$93 $AC
.word T441_AC98h			; 8372	$98 $AC
.word T442_AC9Dh			; 8374	$9D $AC
.word T443_ACA3h			; 8376	$A3 $AC
.word T444_ACA9h			; 8378	$A9 $AC
.word T445_ACAEh			; 837A	$AE $AC
.word T446_ACB4h			; 837C	$B4 $AC
.word T447_ACBCh			; 837E	$BC $AC
.word T448_ACC3h			; 8380	$C3 $AC
.word T449_ACC7h			; 8382	$C7 $AC
.word T450_ACCDh			; 8384	$CD $AC
.word T451_ACD3h			; 8386	$D3 $AC
.word T452_ACD9h			; 8388	$D9 $AC
.word T453_ACDEh			; 838A	$DE $AC
.word T454_ACE4h			; 838C	$E4 $AC
.word T455_ACE8h			; 838E	$E8 $AC
.word T456_ACEDh			; 8390	$ED $AC
.word T457_ACF2h			; 8392	$F2 $AC
.word T458_ACF6h			; 8394	$F6 $AC
.word T459_ACFCh			; 8396	$FC $AC
.word T460_AD00h			; 8398	$00 $AD
.word T461_AD06h			; 839A	$06 $AD
.word T462_AD0Bh			; 839C	$0B $AD
.word T463_AD10h			; 839E	$10 $AD
.word T464_AD14h			; 83A0	$14 $AD
.word T465_AD18h			; 83A2	$18 $AD
.word T466_AD1Dh			; 83A4	$1D $AD
.word T467_AD21h			; 83A6	$21 $AD
.word T468_AD26h			; 83A8	$26 $AD
.word T469_AD2Ah			; 83AA	$2A $AD
.word T470_AD2Fh			; 83AC	$2F $AD
.word T471_AD35h			; 83AE	$35 $AD
.word T472_AD3Bh			; 83B0	$3B $AD
.word T473_AD41h			; 83B2	$41 $AD
.word T474_AD46h			; 83B4	$46 $AD
.word T475_AD4Bh			; 83B6	$4B $AD
.word T476_AD4Fh			; 83B8	$4F $AD
.word T477_AD53h			; 83BA	$53 $AD
.word T478_AD58h			; 83BC	$58 $AD
.word T479_AD5Ch			; 83BE	$5C $AD
.word T480_AD62h			; 83C0	$62 $AD
.word T481_AD66h			; 83C2	$66 $AD
.word T482_AD6Ah			; 83C4	$6A $AD
.word T483_AD6Fh			; 83C6	$6F $AD
.word T484_AD74h			; 83C8	$74 $AD
.word T485_AD78h			; 83CA	$78 $AD
.word T486_AD7Dh			; 83CC	$7D $AD
.word T487_AD83h			; 83CE	$83 $AD
.word T488_AD88h			; 83D0	$88 $AD
.word T489_AD8Fh			; 83D2	$8F $AD
.word T490_AD95h			; 83D4	$95 $AD
.word T491_AD99h			; 83D6	$99 $AD
.word T492_AD9Eh			; 83D8	$9E $AD
.word T493_ADABh			; 83DA	$AB $AD
.word T494_ADB2h			; 83DC	$B2 $AD
.word T495_ADBCh			; 83DE	$BC $AD
.word T496_ADC2h			; 83E0	$C2 $AD
.word T497_ADC8h			; 83E2	$C8 $AD
.word T498_ADD1h			; 83E4	$D1 $AD
.word T499_ADD8h			; 83E6	$D8 $AD
.word T500_ADE1h			; 83E8	$E1 $AD
.word T501_ADEAh			; 83EA	$EA $AD
.word T502_ADF2h			; 83EC	$F2 $AD
.word T503_ADFEh			; 83EE	$FE $AD
.word T504_AE05h			; 83F0	$05 $AE
.word T505_AE0Dh			; 83F2	$0D $AE
.word T506_AE17h			; 83F4	$17 $AE
.word T507_AE1Eh			; 83F6	$1E $AE
.word T508_AE24h			; 83F8	$24 $AE
.word T509_AE2Bh			; 83FA	$2B $AE
.word T510_AE36h			; 83FC	$36 $AE
.word T511_AE3Ah			; 83FE	$3A $AE

;; [$8400 :: 0x28400]

.word T512_AE53h			; 8400	$53 $AE
.word T513_AE5Dh			; 8402	$5D $AE
.word T514_AE67h			; 8404	$67 $AE
.word T515_AE75h			; 8406	$75 $AE
.word T516_AE88h			; 8408	$88 $AE
.word T517_AE95h			; 840A	$95 $AE
.word T518_AEA4h			; 840C	$A4 $AE
.word T519_AEB4h			; 840E	$B4 $AE
.word T520_AEC8h			; 8410	$C8 $AE
.word T521_AEDBh			; 8412	$DB $AE
.word T522_AEF0h			; 8414	$F0 $AE
.word T523_AEFEh			; 8416	$FE $AE
.word T524_AF17h			; 8418	$17 $AF
.word T525_AF3Bh			; 841A	$3B $AF
.word T526_AF76h			; 841C	$76 $AF
.word T527_AF8Ah			; 841E	$8A $AF
.word T528_AF96h			; 8420	$96 $AF
.word T529_AFA3h			; 8422	$A3 $AF
.word T530_AFC7h			; 8424	$C7 $AF
.word T531_AFEEh			; 8426	$EE $AF
.word T532_B017h			; 8428	$17 $B0
.word T533_B04Ch			; 842A	$4C $B0
.word T534_B08Bh			; 842C	$8B $B0
.word T535_B0ADh			; 842E	$AD $B0
.word T536_B0BFh			; 8430	$BF $B0
.word T537_B0C9h			; 8432	$C9 $B0
.word T538_B0E4h			; 8434	$E4 $B0
.word T539_B0F9h			; 8436	$F9 $B0
.word T540_B119h			; 8438	$19 $B1
.word T541_B11Eh			; 843A	$1E $B1
.word T542_B128h			; 843C	$28 $B1
.word T543_B14Fh			; 843E	$4F $B1
.word T544_B155h			; 8440	$55 $B1
.word T545_B161h			; 8442	$61 $B1
.word T546_B177h			; 8444	$77 $B1
.word T547_B184h			; 8446	$84 $B1
.word T548_B19Ah			; 8448	$9A $B1
.word T549_B1DEh			; 844A	$DE $B1
.word T550_B26Ch			; 844C	$6C $B2
.word T551_B2F8h			; 844E	$F8 $B2
.word T552_B3E8h			; 8450	$E8 $B3
.word T553_B405h			; 8452	$05 $B4
.word T554_B422h			; 8454	$22 $B4
.word T555_B45Ch			; 8456	$5C $B4
.word T556_B46Ch			; 8458	$6C $B4
.word T557_B47Dh			; 845A	$7D $B4
.word T558_B48Dh			; 845C	$8D $B4
.word T559_B49Fh			; 845E	$9F $B4
.word T560_B4AFh			; 8460	$AF $B4
.word T561_B4C2h			; 8462	$C2 $B4
.word T562_B4D2h			; 8464	$D2 $B4
.word T563_B4EBh			; 8466	$EB $B4
.word T564_B50Dh			; 8468	$0D $B5
.word T565_B51Fh			; 846A	$1F $B5
.word T566_B534h			; 846C	$34 $B5
.word T567_B554h			; 846E	$54 $B5
.word T568_B570h			; 8470	$70 $B5
.word T569_B580h			; 8472	$80 $B5
.word T570_B599h			; 8474	$99 $B5
.word T571_B5B0h			; 8476	$B0 $B5
.word T572_B5CFh			; 8478	$CF $B5
.word T573_B5E7h			; 847A	$E7 $B5
.word T574_B601h			; 847C	$01 $B6
.word T575_B618h			; 847E	$18 $B6
.word T576_B628h			; 8480	$28 $B6
.word T577_B644h			; 8482	$44 $B6
.word T578_B6D4h			; 8484	$D4 $B6
.word T579_B764h			; 8486	$64 $B7
.word T580_B76Bh			; 8488	$6B $B7
.word T581_B778h			; 848A	$78 $B7
.word T582_B786h			; 848C	$86 $B7
.word T583_B840h			; 848E	$40 $B8
.word T584_B864h			; 8490	$64 $B8
.word T585_B8E6h			; 8492	$E6 $B8
.word T586_B9E7h			; 8494	$E7 $B9
.word T587_BA09h			; 8496	$09 $BA
.word T588_BA1Ch			; 8498	$1C $BA
.word T589_BA37h			; 849A	$37 $BA
;; [$849C-$85DF] - T590-T
.byte $00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02

;;,[$8500 :: 0x28500]

.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
.byte $00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02,$00,$02
;; [$85E0
.word T752_BFABh			; 85E0	$AB $BF
.word T753_BFB0h			; 85E2	$B0 $BF
.word T754_BFB5h			; 85E4	$B5 $BF
.word T755_BFBAh			; 85E6	$BA $BF
.word T756_BFBFh			; 85E8	$BF $BF
.word T757_BFC4h			; 85EA	$C4 $BF
.word T758_BFC9h			; 85EC	$C9 $BF
.word T759_BFCAh			; 85EE	$CA $BF
.word T760_BFCFh			; 85F0	$CF $BF
.word T761_BFD4h			; 85F2	$D4 $BF
.word T762_BFD9h			; 85F4	$D9 $BF
.word T763_BFDEh			; 85F6	$DE $BF
.word T764_BFE3h			; 85F8	$E3 $BF
.word T765_BFE8h			; 85FA	$E8 $BF
.word T766_BFEDh			; 85FC	$ED $BF
.word T767_BFF2h			; 85FE	$F2 $BF
; ========== pointers to text2 ( 768 items) ($8000-$85FF) END ==========


; ========== text2 ( 768 items) ($8600-$BFFF) START ==========
; text 2 (768 items)
;; [$8600 :: 0x28600]
T000_8600h:
.byte $00
T001_8601h:
.byte $9D,$AB,$40,$5C,$47,$3D,$4D,$AE,$3C,$AA,$DE,$FF,$B5,$B2,$B2
.byte $B0,$C0,$01,$91,$40,$FF,$96,$A4,$AD,$5A,$B7,$50,$BA,$6A,$FF,$AA
.byte $B5,$A4,$62,$AF,$BC,$01,$BA,$45,$57,$3E,$5C,$B1,$49,$54,$69,$64
.byte $68,$4F,$A9,$B5,$B2,$B0,$01,$18,$2F,$C0,$00
T002_863Bh:
.byte $9D,$AB,$40,$5C,$47
.byte $3D,$4D,$6C,$6D,$3C,$AA,$FF,$B5,$B2,$B2,$B0,$C0,$00
T003_864Dh:
.byte $99,$A4,$AF
.byte $B2,$B2,$B0,$FF,$64,$5A,$FF,$56,$5B,$C0,$A2,$45,$4B,$3F,$E0,$01
.byte $AA,$6D,$49,$54,$4A,$4C,$58,$AB,$45,$4F,$A4,$FF,$18,$02,$C0,$00
T004_8670h:
.byte $98,$A9,$A9,$49,$53,$18,$2F,$C5,$FF,$8B,$A4,$48,$AC,$59,$A4,$C4
.byte $01,$9D,$54,$4B,$58,$BC,$DE,$4B,$B5,$A4,$BA,$64,$41,$4C,$58,$AB
.byte $01,$3D,$4D,$A8,$B0,$B3,$AC,$4A,$DE,$6B,$44,$5B,$42,$B6,$C0,$01
.byte $01,$A2,$45,$E1,$4E,$4D,$AF,$B8,$A6,$AE,$50,$60,$6B,$A4,$AE,$4D
.byte $58,$01,$60,$FF,$90,$52,$4A,$A4,$FF,$B8,$B3,$FF,$B1,$51,$3D,$C4
.byte $01,$00
T005_86C2h:
.byte $A2,$45,$E3,$4D,$3C,$49,$54,$FF,$4A,$A5,$A8,$AF,$01,$AB
.byte $AC,$59,$45,$4F,$5D,$FF,$8A,$AF,$B7,$A4,$AC,$B5,$C0,$00
T006_86DEh:
.byte $99,$B5
.byte $3C,$A6,$4D,$90,$51,$A7,$44,$FF,$5D,$FF,$94,$6A,$AB,$B8,$3F,$01
.byte $40,$FF,$AB,$AC,$A7,$3C,$AA,$FF,$54,$4A,$5C,$B1,$FF,$8A,$AF,$B7

;; [$8700 :: 0x28700]

.byte $A4,$AC,$B5,$C0,$01,$9C,$B2,$6C,$3D,$3C,$AA,$DE,$6B,$A4,$59,$FF
.byte $AB,$AC,$B0,$01,$AF,$B2,$B6,$4D,$A9,$A4,$58,$AB,$5C,$B1,$FF,$AB
.byte $AC,$B0,$B6,$A8,$AF,$A9,$C0,$00
T007_8728h:
.byte $18,$ED,$FF,$18,$EF,$FF,$5A,$A6
.byte $A4,$B3,$3E,$49,$B2,$01,$3D,$40,$49,$B2,$BA,$B1,$4C,$54,$B1,$FF
.byte $18,$2F,$4C,$6A,$01,$B6,$A4,$A6,$AE,$3E,$C0,$01,$01,$9C,$54,$5C
.byte $47,$63,$A4,$A7,$3C,$AA,$49,$54,$FF,$4A,$A5,$A8,$AF,$B6,$01,$BA
.byte $AB,$AC,$63,$49,$54,$FF,$94,$3C,$AA,$FF,$4A,$A6,$B2,$62,$B5,$B6
.byte $C0,$01,$01,$00
T008_8774h:
.byte $9D,$AB,$40,$5C,$47,$3D,$4D,$60,$BA,$B1,$FF,$5D
.byte $01,$8A,$AF,$B7,$A4,$AC,$B5,$C0,$9D,$54,$5C,$B0,$B3,$42,$AC,$A4
.byte $AF,$69,$51,$A6,$5A,$01,$55,$62,$B1,$E0,$4E,$A8,$A8,$B1,$FF,$59
.byte $B3,$AF,$B2,$BC,$3E,$49,$AB,$40,$01,$A9,$66,$C0,$00
T009_87ADh:
.byte $9D,$B2,$A5
.byte $B8,$AF,$BF,$3D,$4D,$B0,$3F,$5C,$B1,$49,$54,$01,$BA,$56,$B3,$44
.byte $FF,$B6,$AB,$B2,$B3,$BF,$40,$43,$FF,$B6,$AE,$AC,$46,$3E,$01,$A5
.byte $AF,$A4,$A6,$AE,$B6,$B0,$58,$AB,$C0,$01,$01,$9C,$B2,$6C,$3D,$3C
.byte $AA,$DE,$4E,$A8,$A8,$B1,$4E,$B2,$3D,$42,$3C,$AA,$01,$AB,$AC,$B0
.byte $FF,$AF,$52,$A8,$AF,$BC,$C0,$01,$00
T010_87F9h:
.byte $A2,$45,$4B,$3F,$49,$B5,$B8

;; [$8800 :: 0x28800]

.byte $5B,$FF,$99,$A4,$B8,$AF,$C0,$91,$4D,$44,$AF,$BC,$01,$5B,$56,$AF
.byte $47,$A9,$B5,$B2,$B0,$49,$54,$FF,$A8,$B0,$B3,$AC,$4A,$C0,$00
T011_881Fh:
.byte $18
.byte $2F,$DE,$4E,$A8,$A8,$B1,$49,$A4,$AE,$A8,$B1,$FF,$B2,$62,$B5,$4E
.byte $BC,$01,$3D,$4D,$8E,$B0,$B3,$AC,$4A,$C3,$00
T012_883Bh:
.byte $90,$52,$4A,$A4,$43
.byte $57,$FF,$8A,$AF,$B7,$A4,$AC,$B5,$FF,$55,$62,$B1,$E0,$01,$A9,$A4
.byte $46,$A8,$B1,$49,$53,$3D,$4D,$A8,$B0,$B3,$AC,$4A,$C3,$BC,$6D,$C0
.byte $01,$00
T013_8862h:
.byte $9D,$54,$4A,$DE,$43,$FF,$B3,$B8,$A5,$FF,$44,$49,$54,$01
.byte $45,$B7,$B6,$AE,$AC,$B5,$B7,$47,$5D,$FF,$8F,$BC,$B1,$B1,$C0,$A0
.byte $54,$B1,$01,$3D,$4D,$A8,$B0,$B3,$AC,$4A,$5C,$B1,$B9,$A4,$59,$A7
.byte $BF,$3D,$A8,$01,$B2,$BA,$B1,$42,$FF,$A7,$AC,$A7,$B1,$E0,$6B,$A4
.byte $AE,$4D,$58,$FF,$45,$B7,$01,$3C,$49,$AC,$6C,$C0,$97,$B2,$BA,$FF
.byte $54,$DE,$FF,$B6,$42,$B9,$3C,$AA,$01,$A7,$B5,$3C,$AE,$47,$60,$49
.byte $54,$5C,$B0,$B3,$42,$AC,$A4,$AF,$B6,$C0,$01,$00
T014_88CCh:
.byte $9D,$AB,$40,$5C
.byte $47,$3D,$4D,$B9,$AC,$46,$A4,$AA,$4D,$5D,$01,$90,$52,$4A,$A4,$C0
.byte $18,$2F,$5C,$47,$A4,$A6,$B5,$B2,$B6,$B6,$01,$3D,$4D,$AF,$A4,$AE
.byte $A8,$BF,$B6,$A8,$A8,$C5,$00
T015_88F7h:
.byte $9D,$54,$FF,$AE,$3C,$AA,$5C,$47,$B0

;; [$8900 :: 0x28900]

.byte $B2,$5B,$FF,$B3,$63,$6A,$3E,$01,$BA,$58,$AB,$67,$45,$B5,$4C,$51
.byte $AE,$C4,$00
T016_8913h:
.byte $9D,$54,$4C,$56,$B3,$44,$47,$BA,$4D,$55,$62,$01,$66
.byte $4D,$B1,$53,$B0,$52,$A6,$AB,$69,$51,$49,$54,$01,$8E,$B0,$B3,$AC
.byte $4A,$DE,$C3,$01,$92,$A9,$FF,$44,$AF,$50,$BA,$4D,$55,$48,$18,$F2
.byte $C3,$00
T017_8942h:
.byte $99,$63,$6A,$4D,$A5,$B5,$3C,$AA,$FF,$18,$F2,$01,$A5,$A4
.byte $A6,$AE,$49,$53,$8A,$AF,$B7,$A4,$AC,$B5,$C4,$00
T018_895Ch:
.byte $98,$A9,$A9,$49
.byte $53,$9C,$A4,$AF,$A4,$B0,$3F,$A7,$C5,$FF,$90,$53,$56,$5B,$01,$60
.byte $FF,$99,$A4,$AF,$B2,$B2,$B0,$BF,$3F,$48,$B7,$A4,$AE,$4D,$A4,$FF
.byte $B6,$AB,$AC,$B3,$01,$A9,$B5,$B2,$B0,$49,$54,$4A,$C0,$A2,$45,$E1
.byte $FF,$B1,$A8,$62,$B5,$01,$B0,$A4,$AE,$4D,$58,$49,$54,$4A,$FF,$44
.byte $69,$B2,$B2,$B7,$C4,$00
T019_89A6h:
.byte $9D,$54,$FF,$A8,$B0,$B3,$AC,$4A,$FF,$55
.byte $47,$A8,$B1,$B6,$AF,$A4,$62,$A7,$01,$3D,$4D,$60,$BA,$B1,$FF,$5D
.byte $FF,$8B,$A4,$A9,$B6,$AE,$BF,$3F,$48,$40,$01,$A9,$51,$A6,$3C,$AA
.byte $49,$54,$B0,$49,$53,$A5,$B8,$AC,$AF,$48,$3D,$A8,$01,$18,$F3,$C0
.byte $00
T020_89E1h:
.byte $9E,$B6,$4D,$3D,$52,$FF,$18,$02,$49,$53,$A6,$B5,$B2,$B6,$B6
.byte $01,$3D,$4D,$AF,$A4,$AE,$4D,$60,$49,$54,$FF,$56,$5B,$49,$B2,$01

;; [$8A00 :: 0x28A00]

.byte $4A,$A4,$A6,$AB,$FF,$99,$A4,$AF,$B2,$B2,$B0,$C0,$00
T021_8A0Dh:
.byte $92,$A9,$67
.byte $45,$4B,$3F,$69,$3C,$48,$B6,$B2,$6C,$01,$18,$F2,$49,$53,$AA,$AC
.byte $62,$49,$53,$9D,$B2,$A5,$B8,$AF,$BF,$01,$54,$DF,$AF,$4E,$4D,$A4
.byte $A5,$63,$49,$53,$B0,$A4,$AE,$A8,$01,$B6,$B2,$6C,$FF,$B6,$B8,$B3
.byte $42,$A5,$4C,$56,$B3,$44,$B6,$C0,$00
T022_8A49h:
.byte $A0,$AC,$46,$49,$54,$4C,$66
.byte $FF,$A8,$62,$B5,$FF,$A8,$57,$C5,$00
T023_8A59h:
.byte $18,$F2,$C5,$FF,$A0,$55,$B7
.byte $DE,$49,$55,$B7,$C5,$01,$8D,$B2,$5A,$5C,$4F,$B7,$6A,$B7,$4D,$AA
.byte $B2,$B2,$A7,$C5,$00
T024_8A75h:
.byte $92,$B1,$FF,$99,$A4,$AF,$B2,$B2,$B0,$BF,$B7
.byte $A4,$AE,$4D,$A4,$FF,$B6,$AB,$AC,$B3,$01,$60,$FF,$99,$5D,$B7,$C0
.byte $8F,$B5,$B2,$B0,$49,$54,$4A,$BF,$54,$A4,$A7,$01,$B1,$51,$3D,$49
.byte $53,$4A,$A4,$A6,$AB,$FF,$9C,$A4,$AF,$A4,$B0,$3F,$A7,$C0,$00
T025_8AAFh:
.byte $A2
.byte $45,$E4,$4D,$B6,$A8,$A8,$B1,$49,$54,$FF,$18,$F5,$01,$A9,$AF,$BC
.byte $3C,$AA,$43,$A5,$45,$B7,$C5,$FF,$8A,$6B,$3F,$FF,$B1,$A4,$6C,$A7
.byte $01,$8C,$AC,$48,$B3,$AC,$AF,$B2,$B7,$47,$58,$C0,$00
T026_8ADDh:
.byte $92,$B7,$DE
.byte $49,$54,$4C,$66,$B5,$61,$B5,$47,$BA,$AB,$B2,$E4,$A8,$01,$A6,$A4
.byte $B8,$68,$4F,$3D,$4D,$A8,$BC,$4D,$5D,$FF,$18,$ED,$01,$18,$EF,$C4

;; [$8B00 :: 0x28B00]

.byte $00
T027_8B01h:
.byte $98,$62,$B5,$3D,$B5,$B2,$BA,$49,$54,$FF,$A8,$B0,$B3,$42,$51
.byte $43,$57,$01,$4A,$5B,$51,$4D,$B3,$56,$A6,$4D,$60,$49,$54,$01,$BA
.byte $51,$AF,$A7,$C4,$00
T028_8B25h:
.byte $92,$47,$3D,$52,$FF,$9C,$A6,$B2,$B7,$B7,$DE
.byte $FF,$18,$01,$C5,$01,$9D,$54,$4A,$DE,$49,$AB,$40,$FF,$B6,$B3,$A8
.byte $46,$49,$55,$4F,$54,$01,$BA,$45,$AF,$48,$B6,$A4,$50,$60,$49,$54
.byte $FF,$18,$01,$43,$57,$01,$58,$4C,$45,$AF,$48,$B6,$AB,$B2,$BA,$43
.byte $6B,$A4,$B3,$C0,$01,$92,$4F,$BA,$A8,$5E,$FF,$64,$AE,$A8,$C1,$01
.byte $9D,$A6,$A8,$63,$47,$97,$B2,$B7,$B7,$B8,$A5,$FF,$8B,$01,$01,$00
T029_8B80h:
.byte $9D,$54,$FF,$B6,$AB,$AC,$B3,$FF,$54,$A4,$A7,$3C,$BE,$FF,$45,$4F
.byte $5D,$01,$54,$4A,$4C,$AC,$46,$49,$A4,$AE,$4D,$BC,$4D,$60,$01,$99
.byte $5D,$B7,$C0,$00
T030_8BA4h:
.byte $9D,$AB,$40,$5C,$47,$3D,$4D,$B3,$51,$4F,$60,$BA
.byte $B1,$FF,$5D,$01,$99,$A4,$AF,$B2,$B2,$B0,$C0,$00
T031_8BBCh:
.byte $9D,$54,$4B,$58
.byte $AC,$5A,$FF,$B3,$6A,$4F,$99,$5D,$4F,$66,$A8,$01,$B2,$A6,$A6,$B8
.byte $B3,$AC,$3E,$4E,$50,$3D,$4D,$8E,$B0,$B3,$AC,$4A,$C0,$00
T032_8BDEh:
.byte $99,$A4
.byte $AF,$B2,$B2,$B0,$43,$57,$FF,$99,$5D,$4F,$55,$62,$B1,$E0,$01,$A5
.byte $A8,$A8,$B1,$43,$B7,$B7,$A4,$A6,$AE,$3E,$67,$6D,$C0,$00
T033_8BFEh:
.byte $99,$A4

;; [$8C00 :: 0x28C00]

.byte $AF,$B2,$B2,$B0,$DE,$43,$49,$B2,$BA,$B1,$FF,$5D,$01,$A9,$4A,$3E
.byte $B2,$B0,$C0,$A0,$3F,$B1,$A4,$FF,$B6,$6D,$B7,$63,$01,$A7,$B2,$BA
.byte $B1,$FF,$54,$4A,$4C,$58,$AB,$6B,$A8,$BF,$A6,$B8,$5F,$A8,$C5,$00
T034_8C30h:
.byte $99,$AC,$B5,$52,$A8,$C1,$97,$B2,$BA,$49,$54,$4A,$DE,$43,$01,$A9
.byte $3C,$4D,$AF,$6A,$B6,$C0,$95,$A8,$B0,$6C,$4E,$B8,$50,$BC,$45,$01
.byte $A4,$FF,$A7,$B5,$3C,$AE,$C4,$01,$01,$11,$02,$C1,$A0,$58,$AB,$67
.byte $45,$C5,$FF,$97,$53,$BA,$A4,$BC,$C4,$01,$00
T035_8C6Bh:
.byte $9D,$AB,$40,$5C,$47
.byte $3D,$4D,$B3,$51,$4F,$5D,$FF,$99,$5D,$B7,$C0,$01,$9C,$A4,$AF,$A4
.byte $B0,$3F,$48,$40,$49,$53,$3D,$4D,$B1,$51,$3D,$BF,$01,$3F,$48,$60
.byte $FF,$45,$B5,$FF,$56,$5B,$5C,$47,$8B,$A4,$A9,$B6,$AE,$C0,$00
T036_8C9Fh:
.byte $91
.byte $A4,$62,$67,$45,$FF,$B6,$A8,$A8,$B1,$49,$54,$01,$18,$F5,$C5,$01
.byte $01,$01,$92,$4F,$BA,$6A,$4E,$B8,$AC,$AF,$4F,$A5,$50,$8C,$AC,$A7
.byte $BF,$BA,$AB,$B2,$01,$64,$62,$47,$54,$4A,$5C,$B1,$FF,$99,$5D,$B7
.byte $C0,$01,$98,$B1,$AF,$50,$54,$4B,$3F,$69,$AF,$50,$58,$C0,$01,$00
T037_8CE0h:
.byte $A2,$45,$FF,$AF,$B2,$B2,$AE,$3C,$BE,$69,$51,$FF,$8C,$AC,$A7,$C5
.byte $FF,$91,$A8,$DE,$01,$B3,$B5,$B2,$A5,$A4,$A5,$AF,$50,$B2,$62,$B5

;; [$8D00 :: 0x28D00]

.byte $5C,$B1,$49,$54,$FF,$B3,$B8,$A5,$C0,$01,$8A,$69,$A8,$BA,$FF,$AA
.byte $AC,$AF,$4C,$AC,$46,$FF,$AA,$6D,$67,$45,$43,$01,$B5,$AC,$59,$FF
.byte $44,$FF,$AB,$40,$FF,$18,$F5,$C0,$00
T038_8D29h:
.byte $8B,$A4,$A9,$B6,$AE,$BF,$3D
.byte $4D,$A6,$58,$50,$60,$FF,$45,$B5,$01,$56,$5B,$BF,$40,$FF,$B2,$A6
.byte $A6,$B8,$B3,$AC,$3E,$4E,$50,$3D,$A8,$01,$A8,$B0,$B3,$AC,$4A,$C0
.byte $9D,$54,$BC,$E3,$4D,$A5,$B8,$AC,$AF,$A7,$3C,$AA,$01,$B6,$B2,$6C
.byte $3D,$3C,$AA,$49,$42,$B5,$AC,$A5,$63,$49,$54,$4A,$C3,$00
T039_8D6Eh:
.byte $91,$40
.byte $FF,$96,$A4,$AD,$5A,$B7,$50,$40,$FF,$AA,$4A,$52,$AF,$BC,$01,$4A
.byte $6A,$B6,$B8,$4A,$48,$A5,$50,$BC,$45,$B5,$01,$BA,$44,$59,$B5,$A9
.byte $B8,$AF,$4C,$51,$AE,$C0,$00
T040_8D97h:
.byte $99,$63,$6A,$4D,$59,$5B,$B5,$B2,$50
.byte $3D,$A8,$01,$18,$F3,$C4,$00
T041_8DA7h:
.byte $92,$A9,$49,$54,$FF,$A8,$B0,$B3,$AC
.byte $4A,$4B,$B2,$B0,$B3,$63,$B7,$5A,$01,$3D,$4D,$18,$F3,$BF,$3D,$A8
.byte $B1,$01,$8A,$AF,$B7,$A4,$AC,$B5,$BF,$99,$5D,$B7,$C3,$A4,$46,$4C
.byte $AC,$46,$4E,$A8,$01,$AF,$B2,$5B,$C0,$00
T042_8DDAh:
.byte $92,$4B,$3F,$FF,$B6,$A8
.byte $A8,$C3,$8A,$FF,$AA,$4A,$52,$FF,$A8,$B9,$AC,$AF,$5C,$B1,$01,$3D
.byte $4D,$B6,$AE,$AC,$5A,$BF,$64,$AE,$4D,$B5,$B2,$AC,$64,$41,$01,$5B

;; [$8E00 :: 0x28E00]

.byte $51,$B0,$4B,$AF,$45,$A7,$B6,$C0,$00
T043_8E09h:
.byte $8B,$A4,$A9,$B6,$AE,$5C,$47
.byte $A6,$44,$B7,$B5,$B2,$46,$3E,$4E,$BC,$01,$3D,$4D,$18,$EE,$C0,$01
.byte $01,$01,$91,$4D,$B8,$B6,$3E,$FF,$AB,$BC,$B3,$B1,$B2,$B6,$40,$49
.byte $B2,$01,$B0,$3F,$AC,$B3,$B8,$AF,$52,$4D,$3D,$4D,$B0,$3C,$A7,$47
.byte $5D,$01,$3D,$4D,$60,$BA,$B1,$B6,$B3,$A8,$B2,$B3,$63,$C0,$01,$00
T044_8E50h:
.byte $8B,$AF,$B2,$BA,$49,$55,$4F,$18,$F3,$01,$60,$4E,$58,$B6,$C4,$00
T045_8E60h:
.byte $9D,$54,$50,$B6,$A4,$50,$8B,$51,$68,$A8,$B1,$DE,$01,$4A,$B3,$AF
.byte $A4,$A6,$3E,$49,$54,$FF,$18,$EE,$01,$6A,$4B,$B2,$B0,$B0,$3F,$59
.byte $B5,$5C,$B1,$FF,$8B,$A4,$A9,$B6,$AE,$C0,$00
T046_8E8Bh:
.byte $92,$E5,$FF,$AA,$44
.byte $B1,$A4,$FF,$AD,$B2,$3C,$49,$54,$FF,$4A,$A5,$A8,$AF,$01,$66,$B0
.byte $50,$3F,$48,$A9,$AC,$68,$B7,$C4,$00
T047_8EA9h:
.byte $A2,$45,$6B,$B8,$5B,$FF,$59
.byte $5B,$B5,$B2,$50,$3D,$A8,$01,$18,$F3,$4E,$A8,$A9,$51,$4D,$58,$DE
.byte $01,$A6,$B2,$B0,$B3,$63,$B7,$3E,$C0,$00
T048_8ECAh:
.byte $92,$FF,$54,$66,$48,$5D
.byte $49,$54,$FF,$4A,$A5,$A8,$AF,$43,$B5,$B0,$BC,$BF,$01,$B6,$53,$92
.byte $FF,$AD,$B2,$3C,$3E,$C4,$00
T049_8EE7h:
.byte $9D,$54,$BC,$E3,$4D,$A5,$B8,$AC,$AF
.byte $A7,$3C,$AA,$49,$54,$01,$18,$F3,$5C,$B1,$FF,$8B,$A4,$A9,$B6,$AE

;; [$8F00 :: 0x28F00]

.byte $C0,$00
T050_8F02h:
.byte $92,$47,$8A,$AF,$B7,$A4,$AC,$B5,$FF,$AA,$44,$B1,$A4,$4E
.byte $4D,$B7,$A4,$AE,$A8,$B1,$01,$B2,$62,$B5,$4E,$50,$3D,$4D,$A8,$B0
.byte $B3,$AC,$4A,$C5,$00
T051_8F25h:
.byte $9D,$B2,$A5,$B8,$AF,$DE,$6B,$A4,$AE,$3C,$AA
.byte $FF,$AF,$B2,$B7,$47,$5D,$01,$BA,$56,$B3,$44,$47,$BA,$58,$AB,$49
.byte $55,$4F,$18,$F2,$01,$BC,$45,$69,$45,$57,$C0,$00
T052_8F4Ch:
.byte $9D,$54,$FF,$AE
.byte $3C,$AA,$DE,$4B,$44,$A7,$58,$61,$B1,$FF,$55,$B6,$01,$BA,$51,$B6
.byte $A8,$B1,$3E,$C3,$00
T053_8F65h:
.byte $8B,$63,$BA,$FF,$B8,$B3,$49,$54,$FF,$18,$F3
.byte $BF,$01,$A7,$AC,$48,$BC,$45,$C5,$65,$FF,$AE,$B1,$A8,$BA,$67,$45
.byte $FF,$55,$A7,$01,$58,$5C,$B1,$67,$45,$C4,$00
T054_8F8Bh:
.byte $9D,$54,$FF,$99,$B5
.byte $3C,$A6,$5A,$47,$40,$FF,$B6,$A4,$A9,$A8,$BF,$01,$A5,$B8,$4F,$3D
.byte $4D,$AE,$3C,$AA,$5C,$47,$B1,$B2,$4F,$BA,$A8,$46,$C3,$00
T055_8FAEh:
.byte $A2,$45
.byte $FF,$A7,$AC,$48,$58,$C4,$A2,$45,$FF,$59,$5B,$B5,$B2,$BC,$3E,$01
.byte $3D,$4D,$18,$F3,$C4,$00
T056_8FC6h:
.byte $A0,$55,$4F,$A4,$FF,$4A,$64,$A8,$A9,$C4
.byte $00
T057_8FD1h:
.byte $9D,$54,$FF,$18,$F3,$4C,$6A,$01,$59,$5B,$B5,$B2,$BC,$3E,$C5
.byte $FF,$97,$AC,$A6,$A8,$C4,$00
T058_8FE7h:
.byte $A0,$A8,$E4,$4D,$AF,$B2,$5B,$FF,$45
.byte $B5,$FF,$AE,$3C,$AA,$C3,$00
T059_8FF7h:
.byte $8D,$A8,$40,$B7,$C5,$65,$B7,$DE,$43

;; [$9000 :: 0x29000]

.byte $B1,$5C,$B6,$AF,$3F,$A7,$01,$AE,$3C,$AA,$A7,$B2,$B0,$FF,$AF,$B2
.byte $A6,$52,$3E,$FF,$56,$5B,$FF,$5D,$01,$3D,$4D,$B6,$B1,$B2,$BA,$FF
.byte $B3,$AF,$A4,$3C,$B6,$C0,$01,$01,$9D,$A4,$AE,$4D,$A4,$FF,$B6,$AB
.byte $AC,$B3,$69,$B5,$B2,$B0,$FF,$99,$A4,$AF,$B2,$B2,$B0,$01,$3F,$48
.byte $B6,$A4,$AC,$AF,$FF,$B6,$45,$3D,$C0,$01,$00
T060_904Bh:
.byte $91,$40,$FF,$96,$A4
.byte $AD,$5A,$B7,$BC,$DE,$C3,$B3,$6A,$B6,$3E,$4C,$A4,$BC,$C3,$00
T061_905Fh:
.byte $92
.byte $4C,$3F,$B1,$A4,$FF,$B5,$AC,$59,$43,$FF,$18,$FB,$43,$57,$01,$B6
.byte $B2,$66,$49,$54,$FF,$B6,$AE,$AC,$5A,$C4,$00
T062_907Bh:
.byte $8D,$A8,$40,$4F,$40
.byte $FF,$AB,$B2,$6C,$49,$53,$18,$FB,$B6,$01,$3F,$48,$18,$FA,$B6,$C0
.byte $90,$6D,$49,$54,$4A,$4E,$BC,$01,$B7,$A4,$AE,$3C,$AA,$43,$FF,$B6
.byte $AB,$AC,$B3,$FF,$45,$4F,$5D,$01,$99,$A4,$AF,$B2,$B2,$B0,$C0,$00
T063_90B0h:
.byte $8D,$A8,$40,$B7,$C5,$FF,$8A,$B6,$AE,$FF,$B6,$B2,$6C,$44,$4D,$A8
.byte $AF,$B6,$A8,$C0,$00
T064_90C5h:
.byte $90,$B2,$3C,$AA,$49,$53,$8D,$A8,$40,$B7,$C5
.byte $FF,$91,$56,$48,$A5,$A4,$A6,$AE,$01,$60,$FF,$99,$A4,$AF,$B2,$B2
.byte $B0,$43,$57,$49,$A4,$AE,$4D,$A4,$FF,$B6,$AB,$AC,$B3,$01,$3D,$42
.byte $A8,$C0,$00
T065_90F3h:
.byte $93,$B2,$B6,$A8,$A9,$DE,$FF,$59,$A4,$A7,$BF,$40,$B1

;; [$9100 :: 0x29100]

.byte $E0,$FF,$54,$C3,$00
T066_9105h:
.byte $9D,$54,$FF,$AE,$3C,$AA,$5C,$47,$B1,$B2,$4F
.byte $BA,$A8,$46,$C0,$00
T067_9115h:
.byte $8D,$53,$BA,$4D,$5B,$3F,$48,$A4,$4B,$55,$B1
.byte $A6,$A8,$01,$A4,$AA,$A4,$3C,$5B,$49,$54,$FF,$18,$F3,$C5,$00
T068_912Fh:
.byte $9D
.byte $54,$50,$A9,$3C,$A4,$46,$50,$A9,$3C,$40,$54,$48,$3D,$A8,$01,$18
.byte $F3,$C3,$00
T069_9143h:
.byte $92,$4B,$A4,$46,$3E,$5C,$B7,$C4,$98,$A5,$B9,$61,$B8
.byte $B6,$AF,$BC,$01,$3D,$4D,$B7,$6A,$AE,$4C,$6A,$6B,$51,$4D,$3D,$3F
.byte $01,$BC,$45,$4B,$45,$AF,$48,$55,$57,$63,$C4,$00
T070_916Ch:
.byte $9D,$54,$FF,$18
.byte $F3,$43,$B7,$B7,$A4,$A6,$AE,$3E,$01,$8A,$AF,$B7,$A4,$AC,$B5,$C0
.byte $8F,$51,$B7,$B8,$B1,$52,$A8,$AF,$BC,$BF,$3D,$A8,$01,$AB,$AC,$59
.byte $45,$4F,$40,$FF,$B8,$B1,$B6,$A6,$52,$54,$A7,$C0,$01,$01,$9D,$54
.byte $49,$B2,$BA,$B1,$B6,$B3,$A8,$B2,$B3,$63,$FF,$55,$62,$49,$A4,$AE
.byte $A8,$B1,$01,$4A,$A9,$B8,$AA,$4D,$54,$4A,$C0,$01,$00
T071_91BDh:
.byte $92,$A9,$4C
.byte $4D,$A7,$44,$E0,$FF,$59,$5B,$B5,$B2,$50,$3D,$A8,$01,$18,$F3,$BF
.byte $B0,$51,$4D,$B3,$A8,$B2,$B3,$63,$01,$BA,$AC,$46,$FF,$A7,$AC,$A8
.byte $C0,$00
T072_91E2h:
.byte $8C,$AC,$48,$B0,$AC,$68,$4F,$AE,$B1,$B2,$BA,$5C,$A9,$49
.byte $54,$01,$18,$F3,$FF,$55,$47,$3F,$BC,$01,$BA,$56,$AE,$B1,$5A,$B6

;; [$9200 :: 0x29200]

.byte $5A,$C0,$01,$01,$91,$A8,$DE,$49,$54,$69,$AC,$B5,$5B,$FF,$B3,$42
.byte $B6,$44,$49,$B2,$01,$A8,$62,$B5,$4E,$B8,$AC,$AF,$48,$3F,$FF,$18
.byte $F5,$C0,$01,$00
T073_9224h:
.byte $92,$E5,$FF,$B6,$A6,$66,$3E,$C3,$00
T074_922Dh:
.byte $99,$63,$6A
.byte $A8,$BF,$95,$51,$A7,$BF,$B6,$A4,$62,$FF,$45,$B5,$FF,$AE,$3C,$AA
.byte $C0,$00
T075_9242h:
.byte $A0,$A8,$DF,$AF,$FF,$5B,$A4,$50,$54,$4A,$43,$57,$FF,$AB
.byte $B2,$AF,$A7,$01,$45,$4F,$B8,$5E,$AC,$AF,$67,$45,$FF,$4A,$B7,$B8
.byte $B5,$B1,$C0,$00
T076_9264h:
.byte $A0,$54,$4A,$5C,$47,$99,$B5,$3C,$A6,$4D,$18,$EB
.byte $C5,$00
T077_9272h:
.byte $9D,$54,$FF,$18,$F3,$43,$B7,$B7,$A4,$A6,$AE,$3E,$C3,$01
.byte $8A,$4F,$63,$6A,$4F,$45,$B5,$FF,$AB,$AC,$59,$45,$4F,$40,$01,$B6
.byte $A4,$A9,$A8,$C0,$00
T078_9295h:
.byte $8E,$62,$B5,$BC,$44,$4D,$BA,$AB,$53,$BA,$6A
.byte $FF,$45,$B7,$B6,$AC,$59,$01,$40,$FF,$59,$A4,$A7,$C3,$00
T079_92AEh:
.byte $9D,$54
.byte $FF,$18,$F3,$FF,$AE,$AC,$46,$3E,$01,$3D,$A8,$B0,$43,$46,$C3,$00
T080_92C0h:
.byte $92,$E5,$FF,$AB,$B8,$B5,$B7,$C3,$92,$FF,$A7,$44,$E0,$49,$AB,$3C
.byte $AE,$65,$E5,$01,$AA,$44,$B1,$A4,$6B,$A4,$AE,$4D,$58,$C3,$00
T081_92DFh:
.byte $9D
.byte $54,$FF,$18,$F3,$43,$B7,$B7,$A4,$A6,$AE,$3E,$C3,$00
T082_92EDh:
.byte $9D,$54,$50
.byte $AE,$AC,$46,$3E,$6B,$50,$A7,$A4,$B8,$68,$B7,$42,$C3,$00
T083_92FEh:
.byte $9D,$54

;; [$9300 :: 0x29300]

.byte $FF,$18,$F3,$FF,$B2,$B3,$A8,$B1,$3E,$01,$A9,$AC,$4A,$43,$57,$FF
.byte $AE,$AC,$46,$3E,$FF,$A8,$62,$B5,$BC,$44,$A8,$C3,$00
T084_931Dh:
.byte $A2,$45,$6B
.byte $B8,$5B,$FF,$4A,$B6,$A6,$B8,$4D,$3D,$A8,$01,$18,$ED,$C4,$00
T085_932Fh:
.byte $18
.byte $ED,$FF,$18,$EF,$4C,$6A,$01,$A6,$A4,$B3,$B7,$B8,$4A,$48,$A5,$50
.byte $3D,$A8,$01,$18,$F3,$C4,$00
T086_9347h:
.byte $9D,$54,$FF,$18,$F3,$5C,$47,$54,$A4
.byte $A7,$3C,$AA,$01,$B1,$51,$3D,$FF,$5D,$FF,$18,$2F,$C0,$00
T087_935Eh:
.byte $9D,$AB
.byte $40,$5C,$47,$A4,$46,$67,$45,$B5,$69,$A4,$B8,$AF,$B7,$C4,$00
T088_936Fh:
.byte $9D
.byte $54,$FF,$18,$ED,$5C,$47,$B7,$B5,$A4,$B3,$B3,$3E,$FF,$44,$01,$3D
.byte $4D,$18,$F3,$C4,$00
T089_9385h:
.byte $92,$49,$B5,$AC,$3E,$49,$53,$5B,$B2,$B3,$49
.byte $54,$01,$18,$ED,$69,$B5,$B2,$B0,$4E,$B2,$66,$A7,$3C,$AA,$49,$54
.byte $01,$18,$F5,$C3,$00
T090_93A5h:
.byte $92,$A9,$49,$54,$FF,$18,$F3,$43,$B7,$B7,$A4
.byte $A6,$AE,$B6,$01,$A4,$AA,$A4,$3C,$BF,$BA,$A8,$E3,$4D,$A9,$3C,$40
.byte $54,$A7,$C4,$00
T091_93C4h:
.byte $18,$ED,$FF,$18,$EF,$C3,$00
T092_93CBh:
.byte $9D,$54,$FF,$A8,$B0
.byte $B3,$AC,$4A,$FF,$55,$47,$A4,$FF,$B6,$B8,$B3,$B3,$AF,$BC,$01,$A5
.byte $6A,$4D,$60,$49,$54,$FF,$B1,$51,$3D,$FF,$5D,$FF,$18,$2F,$C0,$01
.byte $9D,$54,$FF,$18,$F3,$6B,$A4,$50,$55,$62,$01,$A7,$B2,$A6,$AE,$3E

;; [$9400 :: 0x29400]

.byte $49,$54,$4A,$C0,$00
T093_9405h:
.byte $9D,$54,$FF,$18,$ED,$FF,$63,$A9,$4F,$44,$FF
.byte $8C,$AC,$A7,$DE,$01,$8A,$AC,$B5,$B6,$AB,$AC,$B3,$49,$53,$6C,$6D
.byte $67,$45,$43,$B7,$01,$94,$6A,$AB,$B8,$3F,$C0,$00
T094_942Ch:
.byte $9D,$55,$B7,$DE
.byte $C3,$3D,$4D,$18,$F7,$C4,$00
T095_9437h:
.byte $9E,$B6,$4D,$3D,$4D,$18,$F7,$49,$53
.byte $A5,$AF,$B2,$BA,$FF,$B8,$B3,$01,$3D,$4D,$18,$F3,$C4,$00
T096_944Eh:
.byte $99,$63
.byte $6A,$4D,$B6,$A4,$62,$FF,$18,$ED,$01,$18,$EF,$C4,$00
T097_945Dh:
.byte $9D,$54,$FF
.byte $18,$F3,$DE,$49,$A4,$AE,$3C,$AA,$01,$44,$FF,$B6,$B8,$B3,$B3,$64
.byte $5A,$49,$53,$3D,$4D,$B1,$51,$3D,$C0,$01,$A2,$45,$FF,$B6,$AB,$45
.byte $AF,$48,$B6,$B1,$56,$AE,$5C,$B1,$43,$57,$01,$B6,$A4,$62,$49,$54
.byte $FF,$18,$ED,$C4,$01,$00
T098_9496h:
.byte $18,$ED,$FF,$18,$EF,$4C,$6A,$01,$A6,$A4
.byte $B3,$B7,$B8,$4A,$A7,$C3,$00
T099_94A7h:
.byte $BE,$91,$56,$B5,$48,$3D,$4D,$A8,$B0
.byte $B3,$AC,$4A,$4B,$A4,$B3,$B7,$B8,$4A,$A7,$01,$3D,$4D,$18,$ED,$43
.byte $57,$FF,$8C,$AC,$A7,$DE,$01,$18,$F5,$C0,$00
T100_94CBh:
.byte $96,$A4,$BC,$A5,$4D
.byte $92,$FF,$45,$68,$B7,$A4,$FF,$AD,$B2,$3C,$49,$54,$01,$AC,$B0,$B3
.byte $42,$AC,$A4,$AF,$43,$B5,$B0,$BC,$C0,$00
T101_94EAh:
.byte $9D,$54,$FF,$A8,$B0,$B3
.byte $AC,$4A,$4B,$A4,$B3,$B7,$B8,$4A,$A7,$01,$18,$ED,$FF,$18,$EF,$FF

;; [$9500 :: 0x29500]

.byte $44,$43,$B1,$01,$18,$F5,$C4,$90,$6D,$4E,$A4,$A6,$AE,$49,$53,$8A
.byte $AF,$B7,$A4,$AC,$B5,$01,$3F,$48,$B7,$A8,$46,$49,$54,$FF,$4A,$A5
.byte $A8,$AF,$B6,$C4,$00
T102_9525h:
.byte $99,$B5,$3C,$A6,$4D,$18,$EB,$FF,$55,$47,$63
.byte $48,$3D,$A8,$01,$66,$B0,$50,$5B,$B5,$44,$AA,$AF,$50,$B6,$3C,$A6
.byte $4D,$3D,$A8,$01,$AE,$3C,$AA,$DE,$FF,$B3,$6A,$B6,$3C,$AA,$C0,$00
T103_9550h:
.byte $9D,$54,$FF,$18,$FA,$B6,$C3,$B9,$3F,$B4,$B8,$40,$54,$A7,$C5,$00
T104_9560h:
.byte $A0,$AB,$50,$40,$49,$54,$FF,$18,$ED,$43,$A6,$5F,$41,$01,$B6,$53
.byte $BA,$A8,$AC,$B5,$A7,$C5,$00
T105_9577h:
.byte $90,$B2,$B2,$48,$60,$FF,$B6,$A8,$4D
.byte $BC,$45,$4E,$A4,$A6,$AE,$01,$B6,$A4,$A9,$A8,$AF,$BC,$C0,$00
T106_958Fh:
.byte $9D
.byte $54,$FF,$18,$ED,$FF,$55,$47,$A5,$A8,$A8,$B1,$01,$A4,$A6,$5F,$41
.byte $FF,$62,$B5,$50,$5B,$B5,$3F,$AA,$A8,$C0,$00
T107_95ABh:
.byte $99,$B5,$3C,$A6,$4D
.byte $18,$EB,$FF,$55,$47,$A5,$A8,$A6,$B2,$6C,$43,$01,$A9,$AC,$B5,$B0
.byte $FF,$63,$A4,$59,$B5,$49,$55,$B1,$AE,$47,$60,$FF,$AB,$40,$01,$5F
.byte $6C,$FF,$B6,$B3,$A8,$5E,$4C,$58,$AB,$67,$45,$B5,$FF,$AF,$B2,$B7
.byte $C0,$00
T108_95E2h:
.byte $A0,$AB,$50,$A7,$B2,$5A,$49,$54,$FF,$18,$ED,$FF,$AD,$B8
.byte $5B,$01,$AF,$A4,$B8,$68,$4C,$54,$B1,$65,$49,$A4,$AF,$AE,$49,$53

;; [$9600 :: 0x29600]

.byte $54,$B5,$C5,$00
T109_9604h:
.byte $9D,$54,$FF,$18,$ED,$5C,$47,$A4,$A6,$5F,$41,$01
.byte $BA,$A8,$AC,$B5,$A7,$C0,$00
T110_9617h:
.byte $92,$E4,$4D,$AF,$B2,$5B,$FF,$B6,$63
.byte $A8,$B3,$FF,$B2,$62,$B5,$01,$A9,$56,$B5,$3C,$AA,$49,$54,$FF,$8E
.byte $B0,$B3,$AC,$4A,$C3,$00
T111_9636h:
.byte $A0,$A8,$AF,$A6,$B2,$6C,$49,$53,$3D,$4D
.byte $4A,$A5,$A8,$AF,$43,$B5,$B0,$BC,$BF,$01,$95,$A8,$AC,$AF,$A4,$C0
.byte $00
T112_9651h:
.byte $9D,$54,$FF,$18,$ED,$4C,$44,$E0,$4B,$B2,$6C,$FF,$45,$B7,$01
.byte $5D,$FF,$54,$B5,$FF,$B5,$B2,$B2,$B0,$C3,$00
T113_966Bh:
.byte $99,$B2,$51,$FF,$18
.byte $FB,$C3,$00
T114_9673h:
.byte $92,$FF,$B6,$A4,$BA,$49,$54,$FF,$18,$ED,$FF,$56,$5F
.byte $41,$01,$A4,$FF,$B5,$52,$C4,$00
T115_9688h:
.byte $A0,$AC,$46,$4C,$4D,$A8,$62,$B5
.byte $FF,$4A,$B7,$A4,$AE,$4D,$8C,$6A,$B7,$63,$01,$18,$2F,$C5,$00
T116_969Fh:
.byte $91
.byte $B2,$BA,$43,$4A,$67,$A8,$C5,$00
T117_96A8h:
.byte $8D,$AC,$48,$BC,$4D,$B6,$A8,$4D
.byte $3D,$4D,$40,$AF,$3F,$48,$B1,$56,$B5,$01,$8D,$A8,$40,$B7,$C5,$FF
.byte $9D,$54,$4A,$DE,$FF,$B6,$B2,$6C,$FF,$B2,$A7,$A7,$01,$B0,$6A,$AE
.byte $C2,$BA,$56,$B5,$3C,$BE,$FF,$B3,$A8,$B2,$B3,$63,$5C,$B1,$43,$01
.byte $A6,$A4,$62,$49,$54,$4A,$C0,$00
T118_96E8h:
.byte $9D,$54,$FF,$18,$ED,$FF,$5D,$FF
.byte $18,$2F,$DE,$4E,$A8,$A8,$B1,$01,$A4,$A6,$5F,$41,$FF,$B2,$A7,$48

;; [$9700 :: 0x29700]

.byte $AF,$52,$A8,$AF,$BC,$C0,$00
T119_9707h:
.byte $9C,$B2,$6C,$3D,$3C,$AA,$DE,$FF,$55
.byte $B3,$B3,$A8,$B1,$3C,$AA,$5C,$B1,$01,$8A,$AF,$B7,$A4,$AC,$B5,$C0
.byte $00
T120_9721h:
.byte $9D,$54,$FF,$18,$ED,$C3,$3F,$5C,$B0,$B3,$B2,$5B,$51,$C5,$00
T121_9730h:
.byte $9D,$54,$FF,$18,$F0,$4C,$AC,$46,$43,$B7,$B7,$A8,$57,$01,$3D,$4D
.byte $60,$B8,$B5,$B1,$A4,$6C,$5E,$C0,$9D,$AB,$40,$4B,$45,$AF,$A7,$01
.byte $A5,$4D,$45,$B5,$4B,$55,$B1,$A6,$4D,$60,$FF,$59,$A9,$56,$B7,$01
.byte $AB,$AC,$B0,$C0,$00
T122_9765h:
.byte $9D,$54,$FF,$18,$ED,$4C,$6A,$43,$01,$B0,$44
.byte $5B,$42,$C4,$C5,$00
T123_9775h:
.byte $98,$A9,$A9,$49,$53,$3D,$4D,$A8,$B1,$A8,$B0
.byte $BC,$DE,$FF,$AF,$A4,$AC,$B5,$C5,$01,$8B,$4D,$A6,$66,$A8,$A9,$B8
.byte $AF,$C4,$92,$FF,$AE,$B1,$B2,$BA,$5C,$4F,$B1,$A8,$62,$B5,$01,$B6
.byte $A8,$A8,$6C,$48,$64,$AE,$4D,$58,$BF,$A5,$B8,$4F,$92,$E4,$A8,$01
.byte $A4,$AF,$BA,$A4,$BC,$47,$64,$AE,$3E,$67,$45,$FF,$AE,$AC,$A7,$B6
.byte $C0,$00
T124_97C2h:
.byte $99,$63,$6A,$4D,$B6,$A4,$62,$49,$54,$FF,$18,$ED,$C4,$00
T125_97D0h:
.byte $18,$F4,$C5,$65,$B7,$DE,$FF,$B6,$45,$3D,$FF,$5D,$01,$94,$6A,$AB
.byte $B8,$3F,$C0,$8B,$B8,$4F,$3D,$42,$4D,$66,$A8,$01,$5B,$B5,$44,$AA
.byte $6B,$44,$5B,$42,$47,$64,$B9,$3C,$AA,$5C,$B1,$01,$3D,$4D,$18,$F4

;; [$9800 :: 0x29800]

.byte $B1,$FF,$8D,$5A,$42,$B7,$C4,$00
T126_9808h:
.byte $9D,$54,$43,$4A,$B1,$A4,$DE,$5C
.byte $B1,$FF,$18,$F4,$C0,$00
T127_9816h:
.byte $98,$B8,$B5,$FF,$18,$ED,$5C,$47,$B1,$B2
.byte $4F,$A4,$6B,$42,$A8,$01,$B7,$B5,$B2,$B3,$AB,$BC,$C4,$00
T128_982Eh:
.byte $9D,$54
.byte $4A,$DE,$43,$FF,$B3,$B5,$40,$44,$4E,$A8,$B1,$56,$3D,$01,$3D,$4D
.byte $66,$A8,$B1,$A4,$C0,$9D,$54,$FF,$18,$ED,$5C,$B6,$01,$A5,$A8,$3C
.byte $AA,$FF,$54,$AF,$48,$3D,$42,$A8,$C0,$00
T129_985Ah:
.byte $9D,$A4,$AE,$4D,$A6,$66
.byte $A8,$BF,$99,$B5,$3C,$A6,$4D,$18,$EB,$C0,$00
T130_986Bh:
.byte $96,$3C,$BA,$B8,$FF
.byte $5B,$AC,$46,$FF,$55,$B6,$B1,$E0,$FF,$4A,$B7,$B8,$B5,$B1,$3E,$01
.byte $A9,$B5,$B2,$B0,$FF,$18,$F8,$C0,$00
T131_9889h:
.byte $8E,$62,$B1,$49,$54,$FF,$18
.byte $FA,$47,$AF,$B2,$5B,$49,$B2,$01,$3D,$4D,$8E,$B0,$B3,$AC,$4A,$C3
.byte $00
T132_98A1h:
.byte $92,$FF,$AB,$B2,$B3,$4D,$3D,$4D,$18,$ED,$5C,$B6,$01,$A4,$AF
.byte $B5,$AC,$68,$B7,$C3,$00
T133_98B6h:
.byte $9C,$A4,$62,$49,$54,$FF,$18,$ED,$C4,$00
T134_98C0h:
.byte $9D,$54,$4B,$B2,$64,$B6,$A8,$B8,$B0,$4E,$4D,$B6,$45,$3D,$FF,$5D
.byte $01,$94,$6A,$AB,$B8,$3F,$BF,$52,$49,$54,$FF,$56,$5B,$42,$B1,$01
.byte $3E,$AA,$4D,$5D,$49,$54,$FF,$18,$F4,$B1,$01,$8D,$5A,$42,$B7,$C0
.byte $00
T135_98F1h:
.byte $91,$B2,$BA,$DE,$FF,$95,$A8,$AC,$AF,$A4,$C5,$00
T136_98FDh:
.byte $90,$B2,$B2

;; [$9900 :: 0x29900]

.byte $48,$AF,$B8,$A6,$AE,$C4,$00
T137_9907h:
.byte $9D,$54,$49,$45,$B5,$B1,$A4,$6C,$5E
.byte $6B,$B8,$5B,$4E,$4D,$A4,$01,$B7,$B5,$A4,$B3,$C4,$00
T138_991Dh:
.byte $99,$B5,$3C
.byte $A6,$4D,$18,$EB,$43,$57,$FF,$18,$ED,$01,$18,$EF,$43,$4A,$FF,$AA
.byte $52,$54,$B5,$3C,$AA,$49,$B5,$B2,$B2,$B3,$B6,$01,$B1,$56,$B5,$49
.byte $54,$FF,$AF,$A4,$AE,$A8,$C0,$00
T139_9948h:
.byte $9D,$54,$FF,$4A,$A5,$A8,$AF,$47
.byte $66,$4D,$B3,$4A,$B3,$66,$3C,$AA,$01,$60,$FF,$4A,$A6,$AF,$A4,$AC
.byte $B0,$FF,$8C,$6A,$B7,$63,$FF,$18,$2F,$C4,$00
T140_996Bh:
.byte $9D,$54,$FF,$4A,$A5
.byte $A8,$AF,$43,$B5,$B0,$50,$40,$FF,$B5,$40,$3C,$AA,$C4,$00
T141_997Eh:
.byte $A2,$4D
.byte $B6,$A4,$62,$48,$3D,$4D,$18,$ED,$C5,$01,$A0,$A4,$50,$60,$FF,$AA
.byte $B2,$C4,$00
T142_9993h:
.byte $A2,$45,$FF,$B6,$A4,$62,$48,$3D,$4D,$18,$ED,$C4,$01
.byte $A2,$45,$FF,$AA,$B8,$BC,$47,$66,$4D,$A4,$B0,$A4,$BD,$3C,$AA,$C4
.byte $00
T143_99B1h:
.byte $8C,$6A,$B7,$63,$FF,$18,$2F,$5C,$47,$45,$B5,$47,$A4,$AA,$A4
.byte $3C,$BF,$01,$3D,$3F,$AE,$47,$60,$67,$45,$C4,$00
T144_99CCh:
.byte $18,$F8,$5C,$47
.byte $44,$43,$4B,$44,$5F,$B1,$A8,$5E,$01,$60,$49,$54,$FF,$B6,$45,$3D
.byte $C0,$00
T145_99E2h:
.byte $A0,$4D,$AA,$B2,$4F,$18,$2F,$4E,$A4,$A6,$AE,$C5,$00
T146_99EFh:
.byte $A2
.byte $4D,$A9,$B2,$AF,$AE,$47,$66,$4D,$54,$B5,$B2,$5A,$C4,$00
T147_99FEh:
.byte $9D,$54

;; [$9A00 :: 0x29A00]

.byte $50,$B6,$A4,$50,$3D,$4D,$A5,$B2,$B2,$AE,$47,$3C,$01,$18,$F8,$FF
.byte $AB,$B2,$AF,$A7,$47,$A4,$46,$49,$54,$01,$B6,$A8,$A6,$4A,$B7,$47
.byte $5D,$49,$54,$4C,$51,$AF,$A7,$C3,$00
T148_9A29h:
.byte $9D,$54,$FF,$A8,$B0,$B3,$AC
.byte $4A,$FF,$55,$47,$A8,$B1,$B6,$AF,$A4,$62,$A7,$01,$3D,$4D,$6C,$B1
.byte $FF,$5D,$FF,$9C,$A4,$AF,$A4,$B0,$3F,$48,$3F,$A7,$01,$A9,$51,$A6
.byte $3E,$49,$54,$B0,$49,$53,$BA,$51,$AE,$5C,$B1,$01,$3D,$4D,$A6,$A4
.byte $62,$43,$4F,$9C,$A8,$B0,$58,$4F,$8F,$A4,$46,$B6,$C0,$01,$99,$63
.byte $6A,$A8,$BF,$54,$AF,$B3,$49,$54,$B0,$43,$46,$C4,$01,$01,$00
T149_9A7Fh:
.byte $9C
.byte $A8,$B0,$58,$4F,$8F,$A4,$46,$47,$40,$4E,$A8,$BC,$44,$A7,$01,$3D
.byte $4D,$B0,$45,$5E,$A4,$3C,$47,$60,$49,$54,$01,$B6,$45,$3D,$FF,$5D
.byte $FF,$9C,$A4,$AF,$A4,$B0,$3F,$A7,$C0,$01,$01,$9D,$55,$B7,$DE,$4C
.byte $54,$4A,$49,$54,$FF,$A8,$B0,$B3,$AC,$4A,$01,$55,$47,$A5,$A8,$A8
.byte $B1,$6B,$3C,$3C,$AA,$FF,$18,$F2,$C0,$01,$00
T150_9ACBh:
.byte $98,$B8,$B5,$FF,$AB
.byte $B8,$B6,$A5,$3F,$A7,$47,$66,$4D,$A5,$A4,$A6,$AE,$01,$AB,$B2,$6C
.byte $FF,$B6,$A4,$A9,$A8,$C0,$9D,$55,$B1,$AE,$67,$45,$C0,$00
T151_9AEEh:
.byte $91,$B8
.byte $B5,$B5,$BC,$C4,$9D,$A4,$AE,$4D,$3D,$4D,$18,$F2,$01,$60,$FF,$8A

;; [$9B00 :: 0x29B00]

.byte $AF,$B7,$A4,$AC,$B5,$43,$57,$FF,$AA,$AC,$62,$5C,$4F,$60,$01,$3D
.byte $4D,$18,$ED,$C4,$00
T152_9B15h:
.byte $9D,$55,$B1,$AE,$67,$45,$FF,$B6,$53,$B0,$B8
.byte $A6,$AB,$69,$51,$01,$B6,$A4,$B9,$3C,$AA,$FF,$B8,$B6,$C0,$00
T153_9B2Fh:
.byte $A2
.byte $45,$DF,$AF,$FF,$B1,$A8,$3E,$43,$FF,$9C,$B1,$B2,$BA,$A6,$B5,$A4
.byte $A9,$B7,$01,$60,$FF,$AA,$6D,$43,$A6,$B5,$B2,$B6,$47,$B6,$B1,$B2
.byte $BA,$A9,$AC,$A8,$AF,$A7,$B6,$C0,$01,$01,$01,$92,$E4,$4D,$54,$66
.byte $48,$3D,$52,$FF,$93,$B2,$B6,$A8,$A9,$01,$AB,$AC,$59,$47,$AB,$40
.byte $FF,$9C,$B1,$B2,$BA,$A6,$B5,$A4,$A9,$4F,$3C,$01,$3D,$4D,$A6,$A4
.byte $62,$B5,$B1,$43,$4F,$9C,$A8,$B0,$58,$B7,$01,$8F,$A4,$46,$B6,$C0
.byte $01,$92,$FF,$4A,$6C,$B0,$A5,$42,$FF,$AB,$AC,$B0,$FF,$B6,$A4,$BC
.byte $3C,$AA,$01,$B6,$B2,$6C,$3D,$3C,$AA,$43,$A5,$45,$4F,$A4,$4C,$A4
.byte $46,$01,$B1,$56,$B5,$43,$4E,$AF,$B8,$4D,$5B,$44,$A8,$C3,$01,$00
T154_9BC0h:
.byte $C3,$00
T155_9BC2h:
.byte $9D,$55,$4F,$8B,$51,$68,$A8,$B1,$5C,$47,$A4,$01,$A5,$B8
.byte $A9,$A9,$B2,$44,$C4,$00
T156_9BD6h:
.byte $92,$47,$3D,$4D,$18,$EE,$FF,$A8,$62,$B5
.byte $01,$AA,$B2,$3C,$AA,$49,$53,$4A,$B7,$B8,$B5,$B1,$C5,$00
T157_9BEEh:
.byte $90,$6D
.byte $4E,$A4,$A6,$AE,$49,$53,$BA,$51,$AE,$C4,$01,$97,$53,$44,$4D,$BA

;; [$9C00 :: 0x29C00]

.byte $3F,$B7,$47,$60,$4C,$51,$AE,$01,$B8,$57,$42,$FF,$90,$A8,$B1,$42
.byte $A4,$AF,$FF,$8B,$51,$68,$A8,$B1,$C3,$00
T158_9C1Ah:
.byte $90,$A8,$B1,$42,$A4,$AF
.byte $FF,$8B,$51,$68,$A8,$B1,$FF,$B1,$A8,$3E,$47,$60,$01,$A5,$4D,$B0
.byte $51,$4D,$A9,$AC,$B5,$B0,$4C,$58,$AB,$49,$54,$B6,$A8,$01,$B3,$56
.byte $B6,$3F,$B7,$B6,$C0,$00
T159_9C46h:
.byte $A2,$45,$E3,$4D,$BA,$58,$AB,$49,$54,$FF
.byte $4A,$A5,$A8,$AF,$B6,$C5,$01,$A2,$45,$E4,$4D,$AA,$B2,$4F,$60,$FF
.byte $59,$5B,$B5,$B2,$50,$3D,$A8,$01,$18,$F3,$C4,$00
T160_9C6Ch:
.byte $9D,$54,$BC,$E3
.byte $4D,$B0,$A4,$AE,$3C,$AA,$FF,$B8,$47,$BA,$51,$AE,$01,$64,$AE,$4D
.byte $B6,$AF,$A4,$62,$B6,$C0,$92,$4B,$3F,$E0,$01,$4A,$6C,$B0,$A5,$42
.byte $4C,$55,$4F,$58,$4C,$6A,$FF,$64,$AE,$A8,$01,$BA,$54,$B1,$49,$54
.byte $FF,$18,$EE,$4C,$6A,$01,$3C,$4B,$B2,$B0,$B0,$3F,$A7,$C0,$01,$00
T161_9CB0h:
.byte $9D,$54,$4A,$DE,$43,$FF,$4A,$A5,$A8,$AF,$FF,$B6,$B3,$BC,$01,$B0
.byte $6A,$B4,$B8,$42,$A4,$A7,$3C,$AA,$43,$47,$3F,$01,$AC,$B0,$B3,$42
.byte $AC,$A4,$AF,$FF,$B6,$B2,$AF,$A7,$AC,$42,$C0,$01,$90,$53,$B7,$A4
.byte $AF,$AE,$49,$53,$AB,$AC,$B0,$C0,$00
T162_9CE9h:
.byte $A2,$45,$DF,$AF,$FF,$B1,$A8
.byte $3E,$43,$FF,$18,$03,$49,$B2,$01,$A5,$B2,$66,$48,$3D,$4D,$18,$F3

;; [$9D00 :: 0x29D00]

.byte $C0,$00
T163_9D02h:
.byte $9D,$54,$BC,$E4,$4D,$A9,$3C,$40,$54,$48,$3D,$A8,$01,$18
.byte $F3,$C0,$A0,$A8,$E3,$4D,$A7,$B2,$B2,$6C,$A7,$C3,$00
T164_9D1Dh:
.byte $9D,$54,$FF
.byte $18,$F3,$FF,$54,$A4,$59,$A7,$01,$A9,$51,$FF,$99,$5D,$B7,$C0,$00
T165_9D30h:
.byte $A2,$45,$6B,$B8,$5B,$49,$A8,$46,$FF,$18,$ED,$01,$18,$EF,$43,$A5
.byte $45,$4F,$3D,$A8,$01,$18,$F3,$C4,$00
T166_9D49h:
.byte $A0,$A8,$E3,$4D,$A7,$B2,$B2
.byte $6C,$A7,$C4,$00
T167_9D54h:
.byte $9D,$55,$B1,$AE,$47,$A9,$51,$4E,$AF,$B2,$BA,$3C
.byte $AA,$FF,$B8,$B3,$01,$3D,$4D,$18,$F3,$C4,$00
T168_9D6Bh:
.byte $A0,$58,$AB,$45,$4F
.byte $3D,$4D,$18,$F3,$BF,$01,$3D,$4D,$A8,$B0,$B3,$AC,$4A,$DE,$FF,$B1
.byte $B2,$4F,$B6,$53,$B6,$A6,$66,$BC,$C4,$00
T169_9D8Ah:
.byte $A2,$45,$FF,$A7,$AC,$48
.byte $58,$C4,$00
T170_9D93h:
.byte $90,$4A,$52,$FF,$AD,$B2,$A5,$C4,$00
T171_9D9Ch:
.byte $A0,$A8,$E3,$4D
.byte $B7,$A4,$AE,$3C,$AA,$4E,$A4,$A6,$AE,$FF,$45,$B5,$01,$A6,$6A,$B7
.byte $63,$C4,$00
T172_9DB3h:
.byte $A0,$A8,$E4,$4D,$3C,$A9,$AC,$AF,$B7,$B5,$52,$3E,$49
.byte $54,$01,$A6,$6A,$B7,$63,$C4,$9D,$54,$FF,$A8,$B1,$A8,$B0,$50,$40
.byte $5C,$B1,$01,$A7,$40,$66,$B5,$A4,$BC,$C4,$00
T173_9DDBh:
.byte $9D,$55,$B1,$AE,$47
.byte $60,$67,$45,$BF,$BA,$4D,$4A,$A6,$AF,$A4,$AC,$6C,$A7,$01,$18,$2F
.byte $C4,$00
T174_9DF2h:
.byte $91,$A4,$62,$67,$45,$4E,$A8,$A8,$B1,$49,$53,$99,$A4,$B8

;; [$9E00 :: 0x29E00]

.byte $AF,$DE,$01,$AB,$45,$B6,$4D,$BC,$6D,$C5,$FF,$91,$4D,$BA,$6A,$FF
.byte $A8,$BB,$A6,$58,$3E,$01,$60,$4E,$4D,$A5,$A4,$A6,$AE,$FF,$AB,$B2
.byte $6C,$C0,$00
T175_9E23h:
.byte $9D,$55,$B1,$AE,$67,$45,$C4,$00
T176_9E2Bh:
.byte $A0,$A8,$E4,$4D,$B7
.byte $A4,$AE,$A8,$B1,$FF,$18,$2F,$4E,$A4,$A6,$AE,$BF,$A5,$B8,$B7,$01
.byte $3D,$4D,$BA,$66,$5C,$B6,$B1,$E0,$FF,$B2,$62,$B5,$67,$6D,$C0,$01
.byte $A0,$4D,$B1,$A8,$3E,$FF,$96,$3C,$BA,$B8,$49,$53,$4A,$B7,$B8,$B5
.byte $B1,$01,$A9,$B5,$B2,$B0,$FF,$18,$F8,$C3,$00
T177_9E6Bh:
.byte $95,$AC,$B9,$3C,$AA
.byte $FF,$54,$4A,$43,$AA,$A4,$3C,$5C,$47,$64,$AE,$A8,$01,$A4,$FF,$A7
.byte $4A,$A4,$B0,$4B,$B2,$6C,$49,$B5,$B8,$A8,$C0,$00
T178_9E8Ch:
.byte $92,$FF,$B1,$A8
.byte $62,$B5,$49,$AB,$45,$68,$4F,$92,$E1,$4E,$A8,$01,$A4,$A5,$63,$49
.byte $53,$A6,$B2,$6C,$4E,$A4,$A6,$AE,$49,$53,$18,$2F,$01,$A7,$B8,$B5
.byte $3C,$AA,$6B,$50,$64,$A9,$6D,$AC,$6C,$C0,$00
T179_9EBBh:
.byte $A2,$45,$4E,$56,$4F
.byte $3D,$4D,$A5,$AC,$AA,$4E,$A4,$A7,$C5,$01,$A0,$B2,$BA,$C3,$00
T180_9ECFh:
.byte $9D
.byte $54,$FF,$18,$F1,$69,$64,$5A,$FF,$AB,$AC,$68,$01,$B2,$62,$B5,$FF
.byte $18,$2F,$FF,$44,$A6,$4D,$B0,$51,$A8,$C4,$00
T181_9EEBh:
.byte $18,$2F,$5C,$47,$45
.byte $B5,$47,$A4,$AA,$A4,$3C,$43,$B7,$01,$AF,$6A,$B7,$C4,$00
T182_9EFEh:
.byte $A0,$4D

;; [$9F00 :: 0x29F00]

.byte $B2,$BA,$4D,$58,$43,$46,$49,$53,$BC,$45,$C0,$01,$9D,$55,$B1,$AE
.byte $67,$45,$C0,$00
T183_9F14h:
.byte $18,$ED,$FF,$18,$EF,$43,$57,$FF,$99,$B5,$3C,$A6
.byte $A8,$01,$18,$EB,$43,$BA,$A4,$58,$67,$45,$5C,$B1,$49,$54,$01,$A4
.byte $B8,$A7,$AC,$A8,$B1,$A6,$4D,$A6,$55,$B0,$A5,$42,$C0,$00
T184_9F3Eh:
.byte $92,$FF
.byte $AB,$B2,$B3,$4D,$96,$3C,$BA,$B8,$5C,$47,$A4,$AF,$B5,$AC,$68,$B7
.byte $C3,$00
T185_9F52h:
.byte $9D,$54,$4A,$43,$4A,$6B,$3F,$50,$3F,$A6,$AC,$A8,$5E,$01
.byte $A5,$B2,$B2,$AE,$47,$3C,$FF,$18,$F8,$C0,$00
T186_9F6Bh:
.byte $8A,$FF,$B6,$A8,$A6
.byte $4A,$4F,$A6,$44,$B1,$A8,$A6,$B7,$3E,$49,$53,$3D,$A8,$01,$96,$BC
.byte $B6,$AC,$A7,$AC,$3F,$FF,$9D,$B2,$BA,$42,$FF,$64,$5A,$01,$A5,$A8
.byte $B1,$56,$3D,$49,$AB,$40,$4B,$6A,$B7,$63,$C0,$00
T187_9F9Ch:
.byte $9D,$54,$B6,$4D
.byte $5B,$A8,$B3,$47,$63,$A4,$48,$60,$49,$54,$01,$96,$AC,$B5,$B5,$51
.byte $FF,$8C,$55,$B0,$A5,$42,$C0,$00
T188_9FB8h:
.byte $99,$63,$6A,$4D,$B3,$4A,$B3,$66
.byte $4D,$BC,$45,$B5,$01,$A8,$B4,$B8,$AC,$B3,$6C,$5E,$FF,$54,$4A,$C0
.byte $00
T189_9FD1h:
.byte $9D,$AB,$40,$5C,$47,$3D,$4D,$B6,$A8,$A6,$44,$48,$A9,$AF,$B2
.byte $51,$01,$5D,$FF,$8C,$6A,$B7,$63,$FF,$18,$2F,$C0,$00
T190_9FEDh:
.byte $A0,$4D,$BA
.byte $44,$E0,$FF,$4A,$5B,$FF,$B8,$5E,$AC,$AF,$FF,$B3,$56,$A6,$A8,$01

;; [$A000 :: 0x2A000]

.byte $55,$47,$A5,$A8,$A8,$B1,$FF,$4A,$5B,$51,$3E,$C0,$00
T191_A00Dh:
.byte $9D,$54,$43
.byte $B8,$A7,$AC,$A8,$B1,$A6,$4D,$A6,$55,$B0,$A5,$42,$5C,$47,$B8,$B3
.byte $01,$A4,$54,$A4,$A7,$C0,$00
T192_A027h:
.byte $99,$B5,$3C,$A6,$4D,$18,$EB,$43,$BA
.byte $A4,$58,$B6,$C0,$00
T193_A035h:
.byte $8E,$62,$B5,$BC,$A5,$B2,$A7,$BC,$DE,$FF,$59
.byte $A4,$A7,$C3,$00
T194_A044h:
.byte $8A,$FF,$18,$FC,$43,$B3,$B3,$56,$4A,$48,$3F,$A7
.byte $01,$59,$5B,$B5,$B2,$BC,$3E,$FF,$A8,$62,$B5,$BC,$3D,$3C,$AA,$C3
.byte $00
T195_A061h:
.byte $9D,$54,$FF,$18,$F0,$DE,$FF,$18,$FC,$01,$59,$5B,$B5,$B2,$BC
.byte $3E,$6B,$3F,$50,$60,$BA,$B1,$B6,$C3,$00
T196_A07Ah:
.byte $18,$2F,$5C,$47,$A7,$B2
.byte $B2,$6C,$48,$AC,$A9,$49,$54,$01,$18,$FC,$4B,$B2,$6C,$47,$A5,$A4
.byte $A6,$AE,$C0,$00
T197_A094h:
.byte $92,$B7,$DE,$5C,$B0,$B3,$B2,$B6,$B6,$AC,$A5,$63
.byte $49,$53,$A8,$5E,$42,$01,$3D,$4D,$18,$FC,$C4,$92,$4F,$BA,$45,$AF
.byte $48,$B7,$56,$B5,$01,$BC,$45,$49,$53,$B3,$AC,$A8,$A6,$5A,$C4,$00
T198_A0C0h:
.byte $8C,$45,$AF,$48,$3D,$4D,$18,$F0,$4E,$4D,$3C,$01,$3D,$4D,$18,$FC
.byte $C5,$00
T199_A0D2h:
.byte $9D,$54,$FF,$18,$F0,$5C,$47,$60,$B2,$01,$B3,$B2,$BA,$42
.byte $A9,$B8,$AF,$C4,$00
T200_A0E5h:
.byte $9D,$54,$FF,$18,$F0,$4B,$4A,$52,$3E,$49,$54
.byte $01,$18,$FC,$C3,$00
T201_A0F5h:
.byte $9D,$54,$6B,$AC,$B5,$B5,$51,$5C,$47,$44,$49

;; [$A100 :: 0x2A100]

.byte $54,$49,$AB,$AC,$B5,$A7,$01,$A9,$AF,$B2,$51,$C0,$00
T202_A10Dh:
.byte $92,$FF,$A7
.byte $44,$E0,$4C,$3F,$4F,$60,$FF,$A7,$AC,$A8,$C4,$00
T203_A11Ch:
.byte $A0,$54,$B1,$4C
.byte $AC,$46,$4C,$4D,$55,$62,$FF,$B3,$56,$A6,$A8,$C5,$00
T204_A12Dh:
.byte $92,$47,$3D
.byte $4D,$18,$EE,$49,$54,$01,$B1,$A8,$BA,$FF,$18,$F0,$C5,$00
T205_A13Eh:
.byte $91,$B2
.byte $BA,$FF,$A7,$B2,$5A,$FF,$44,$4D,$A8,$5E,$42,$01,$18,$F4,$C5,$00
T206_A150h:
.byte $18,$F4,$5C,$47,$3D,$4D,$54,$66,$4F,$5D,$01,$3D,$4D,$8E,$B0,$B3
.byte $AC,$4A,$C0,$92,$B7,$DE,$FF,$B6,$B8,$B5,$B5,$45,$57,$3E,$01,$A5
.byte $50,$B0,$45,$5E,$A4,$3C,$B6,$C0,$00
T207_A179h:
.byte $9D,$54,$5C,$B0,$B3,$42,$AC
.byte $A4,$AF,$69,$51,$A6,$5A,$01,$A6,$45,$AF,$A7,$B1,$E0,$FF,$55,$62
.byte $FF,$55,$48,$5F,$6C,$49,$B2,$01,$4A,$AA,$B5,$45,$B3,$67,$6D,$C0
.byte $00
T208_A1A1h:
.byte $98,$B1,$AF,$50,$BC,$45,$4B,$3F,$FF,$A7,$53,$3D,$40,$C4,$00
T209_A1B0h:
.byte $9D,$54,$6B,$44,$5B,$42,$47,$BA,$AC,$46,$FF,$B9,$3F,$40,$AB,$01
.byte $44,$A6,$4D,$3D,$4D,$18,$EE,$5C,$B6,$01,$59,$A9,$56,$B7,$3E,$C0
.byte $00
T210_A1D1h:
.byte $A0,$4D,$B0,$B8,$5B,$FF,$B2,$62,$B5,$3D,$B5,$B2,$BA,$49,$54
.byte $01,$18,$EE,$43,$57,$49,$54,$01,$18,$F4,$B1,$FF,$8E,$B0,$B3,$AC
.byte $4A,$C4,$00
T211_A1F3h:
.byte $99,$A4,$B8,$AF,$FF,$5D,$B7,$A8,$B1,$4E,$B5,$A4,$AA

;; [$A200 :: 0x2A200]

.byte $47,$A4,$A5,$45,$B7,$01,$B6,$B1,$56,$AE,$3C,$AA,$5C,$5E,$53,$8C
.byte $6A,$B7,$63,$01,$18,$F4,$C0,$00
T212_A218h:
.byte $92,$E5,$FF,$B6,$53,$5F,$4A,$A7
.byte $C3,$00
T213_A222h:
.byte $A0,$55,$B7,$DE,$FF,$AA,$44,$B1,$A4,$FF,$55,$B3,$B3,$A8
.byte $B1,$49,$53,$3D,$A8,$01,$BA,$51,$AF,$A7,$C5,$00
T214_A23Ch:
.byte $9D,$54,$FF,$18
.byte $F0,$4C,$6A,$01,$4A,$B6,$B8,$B5,$4A,$A6,$B7,$3E,$C3,$00
T215_A24Eh:
.byte $99,$3F
.byte $A7,$A4,$A8,$B0,$44,$AC,$B8,$B0,$FF,$55,$47,$B5,$40,$A8,$B1,$01
.byte $A9,$B5,$B2,$B0,$FF,$91,$A8,$46,$C3,$00
T216_A26Ah:
.byte $8C,$6A,$B7,$63,$FF,$18
.byte $F4,$4B,$B5,$B8,$B0,$A5,$63,$A7,$BF,$01,$A5,$B8,$4F,$99,$3F,$A7
.byte $A4,$A8,$B0,$44,$AC,$B8,$B0,$FF,$B5,$B2,$B6,$4D,$3C,$01,$58,$47
.byte $B3,$AF,$A4,$A6,$A8,$C0,$9D,$54,$FF,$18,$F0,$6B,$B8,$5B,$01,$A5
.byte $4D,$3D,$42,$A8,$C0,$00
T217_A2A6h:
.byte $9D,$54,$FF,$18,$F0,$DE,$FF,$4A,$B7,$B8
.byte $B5,$B1,$3E,$69,$B5,$B2,$B0,$01,$91,$A8,$46,$C3,$00
T218_A2BDh:
.byte $9D,$AB,$40
.byte $5C,$47,$AB,$51,$B5,$AC,$A5,$63,$C3,$00
T219_A2CAh:
.byte $99,$3F,$A7,$A4,$A8,$B0
.byte $44,$AC,$B8,$B0,$5C,$47,$A4,$4B,$6A,$B7,$63,$01,$5D,$5C,$46,$B8
.byte $B6,$61,$B1,$C0,$A2,$45,$4B,$3F,$E0,$FF,$A8,$5E,$42,$01,$58,$FF
.byte $A7,$AC,$4A,$A6,$B7,$AF,$BC,$C0,$01,$01,$8B,$B8,$B7,$BF,$92,$E4

;; [$A300 :: 0x2A300]

.byte $4D,$54,$66,$48,$5B,$51,$AC,$5A,$FF,$5D,$01,$A4,$FF,$AF,$A4,$AE
.byte $4D,$3D,$52,$FF,$63,$A4,$A7,$47,$60,$FF,$91,$A8,$46,$C3,$01,$00
T220_A320h:
.byte $9D,$54,$FF,$18,$F0,$4B,$3F,$FF,$AA,$53,$60,$01,$91,$A8,$46,$C4
.byte $00
T221_A331h:
.byte $9D,$54,$FF,$18,$F0,$DE,$FF,$B6,$45,$AF,$FF,$55,$B6,$01,$B5
.byte $40,$A8,$B1,$C0,$00
T222_A345h:
.byte $9D,$54,$4C,$51,$AF,$48,$40,$43,$4F,$58,$47
.byte $A8,$57,$C3,$00
T223_A354h:
.byte $98,$B2,$B2,$AB,$BF,$BA,$54,$4A,$67,$45,$4B,$B2
.byte $6C,$50,$A9,$B5,$B2,$B0,$C5,$00
T224_A368h:
.byte $98,$B2,$B2,$AB,$BF,$BA,$AB,$50
.byte $BC,$45,$FF,$B1,$53,$BA,$56,$B5,$BC,$01,$18,$FE,$C5,$00
T225_A37Eh:
.byte $A0,$A8
.byte $E3,$4D,$4A,$B7,$A4,$AE,$3C,$AA,$FF,$8C,$6A,$B7,$63,$01,$18,$2F
.byte $C4,$FF,$99,$B5,$3C,$A6,$4D,$18,$EB,$43,$57,$01,$18,$ED,$FF,$18
.byte $EF,$FF,$55,$62,$01,$B3,$58,$A6,$54,$48,$A6,$A4,$B0,$B3,$FF,$B1
.byte $56,$B5,$FF,$18,$2F,$C4,$00
T226_A3B7h:
.byte $8C,$AB,$B2,$A6,$B2,$A5,$53,$64,$62
.byte $5C,$B1,$49,$54,$69,$51,$5A,$B7,$01,$B6,$45,$3D,$FF,$5D,$FF,$94
.byte $6A,$AB,$B8,$3F,$C0,$00
T227_A3D6h:
.byte $92,$B7,$DE,$FF,$A8,$B0,$B3,$B7,$BC,$C0
.byte $00
T228_A3E1h:
.byte $A0,$A8,$E3,$4D,$3C,$B6,$AC,$59,$FF,$95,$A8,$B9,$AC,$52,$55
.byte $B1,$DE,$01,$5B,$B2,$B0,$A4,$A6,$AB,$C3,$00
T229_A3FBh:
.byte $95,$A8,$B9,$AC,$52

;; [$A400 :: 0x2A400]

.byte $55,$B1,$FF,$B6,$BA,$A4,$46,$B2,$BA,$3E,$FF,$B8,$B6,$01,$A4,$46
.byte $C0,$00
T230_A412h:
.byte $A0,$4D,$BA,$42,$4D,$B6,$BA,$A4,$46,$B2,$BA,$3E,$4C,$AB
.byte $B2,$63,$C4,$00
T231_A424h:
.byte $A0,$AC,$46,$4C,$4D,$A5,$4D,$5B,$B8,$A6,$AE,$FF
.byte $54,$4A,$01,$A9,$51,$A8,$62,$B5,$C5,$00
T232_A43Ah:
.byte $92,$A9,$49,$54,$6B,$44
.byte $5B,$42,$4C,$6A,$B1,$E0,$01,$3D,$42,$A8,$BF,$BC,$45,$4B,$45,$AF
.byte $48,$5A,$A6,$A4,$B3,$A8,$01,$3D,$B5,$45,$68,$FF,$95,$A8,$B9,$AC
.byte $52,$55,$B1,$DE,$6B,$45,$3D,$C0,$00
T233_A469h:
.byte $9D,$A8,$B1,$67,$56,$B5,$47
.byte $92,$E4,$4D,$A5,$A8,$A8,$B1,$FF,$64,$B9,$3C,$AA,$01,$54,$4A,$C3
.byte $00
T234_A481h:
.byte $95,$A8,$B9,$AC,$52,$55,$B1,$5C,$47,$3D,$4D,$A5,$56,$5B,$01
.byte $3D,$52,$FF,$B3,$B5,$B2,$B7,$A8,$A6,$B7,$47,$3D,$4D,$60,$BA,$42
.byte $C0,$01,$92,$4F,$B6,$BA,$A4,$46,$B2,$BA,$47,$3F,$BC,$44,$4D,$BA
.byte $58,$AB,$01,$A4,$FF,$8C,$B5,$BC,$5B,$A4,$AF,$FF,$9B,$B2,$A7,$C3
.byte $01,$92,$4E,$B5,$45,$68,$4F,$44,$4D,$60,$B2,$C4,$01,$00
T235_A4CEh:
.byte $A0,$A8
.byte $E3,$4D,$B7,$B5,$A4,$B3,$B3,$3E,$FF,$54,$4A,$4E,$A8,$A6,$A4,$B8
.byte $B6,$A8,$01,$5D,$49,$55,$4F,$B2,$AF,$48,$B0,$3F,$DE,$FF,$5B,$B8
.byte $B3,$AC,$A7,$01,$8C,$B5,$BC,$5B,$A4,$AF,$FF,$9B,$B2,$A7,$C4,$00

;; [$A500 :: 0x2A500]

T236_A500h:
.byte $9D,$AB,$40,$5C,$47,$18,$F8,$BF,$AE,$3C,$AA,$A7,$B2,$B0,$FF,$5D
.byte $01,$B0,$A4,$AA,$5A,$C0,$00
T237_A517h:
.byte $92,$B7,$DE,$49,$AC,$6C,$49,$53,$A5
.byte $4A,$A4,$AE,$49,$54,$01,$60,$BA,$42,$DE,$FF,$B6,$56,$AF,$C0,$00
T238_A530h:
.byte $99,$63,$6A,$4D,$4A,$A4,$48,$3D,$4D,$B0,$3F,$BC,$01,$3F,$A6,$AC
.byte $A8,$5E,$4E,$B2,$B2,$AE,$47,$54,$4A,$C0,$00
T239_A54Bh:
.byte $9D,$AB,$4A,$4D,$66
.byte $5F,$A9,$A4,$A6,$B7,$47,$B3,$B5,$B2,$B7,$A8,$A6,$B7,$01,$3D,$4D
.byte $B6,$56,$AF,$FF,$44,$49,$54,$49,$B2,$BA,$42,$C0,$00
T240_A56Dh:
.byte $8A,$4C,$AC
.byte $BD,$66,$48,$B1,$A4,$6C,$48,$96,$3C,$BA,$B8,$4C,$A8,$5E,$01,$60
.byte $49,$54,$49,$B2,$BA,$42,$C0,$00
T241_A588h:
.byte $8A,$FF,$5B,$52,$B8,$4D,$5D,$43
.byte $FF,$AA,$B2,$A7,$59,$B6,$B6,$01,$A5,$A8,$B1,$56,$3D,$49,$54,$4B
.byte $58,$50,$BA,$52,$A6,$54,$B6,$01,$B2,$62,$B5,$49,$54,$FF,$8C,$B5
.byte $BC,$5B,$A4,$AF,$FF,$9B,$B2,$A7,$B6,$C0,$00
T242_A5BBh:
.byte $9D,$53,$A5,$4A,$A4
.byte $AE,$49,$54,$49,$B2,$BA,$42,$DE,$FF,$B6,$56,$AF,$BF,$01,$A9,$3C
.byte $48,$3D,$4D,$B7,$BA,$53,$18,$FE,$47,$3F,$48,$AA,$B2,$01,$60,$49
.byte $54,$4B,$A4,$62,$FF,$44,$49,$AB,$40,$FF,$AF,$3F,$A7,$C0,$01,$A2
.byte $45,$DF,$AF,$69,$3C,$48,$A4,$FF,$8C,$B5,$BC,$5B,$A4,$AF,$FF,$9B

;; [$A600 :: 0x2A600]

.byte $B2,$A7,$C0,$00
T243_A604h:
.byte $9D,$54,$FF,$8B,$AF,$A4,$A6,$AE,$FF,$18,$FE,$5C
.byte $47,$AE,$A8,$B3,$4F,$44,$01,$A4,$FF,$B6,$B0,$A4,$46,$5C,$B6,$AF
.byte $3F,$A7,$C0,$00
T244_A624h:
.byte $A2,$45,$E4,$4D,$B6,$B8,$A6,$A6,$A8,$3E,$3E,$C0
.byte $91,$56,$48,$A5,$A4,$A6,$AE,$01,$60,$FF,$18,$2F,$C0,$9D,$54,$FF
.byte $18,$ED,$01,$A4,$BA,$A4,$58,$B6,$C0,$00
T245_A64Ah:
.byte $96,$3C,$BA,$B8,$69,$B8
.byte $AF,$A9,$AC,$46,$3E,$FF,$AB,$40,$01,$59,$5B,$3C,$BC,$C3,$96,$A4
.byte $50,$54,$FF,$4A,$5B,$5C,$B1,$01,$B3,$56,$A6,$A8,$C0,$00
T246_A66Eh:
.byte $9D,$54
.byte $FF,$18,$F0,$DE,$FF,$18,$FC,$5C,$B6,$01,$59,$5B,$B5,$B2,$BC,$3C
.byte $AA,$FF,$AE,$3C,$AA,$A7,$B2,$B0,$B6,$C4,$01,$91,$56,$48,$A5,$A4
.byte $A6,$AE,$49,$53,$18,$2F,$43,$4F,$44,$A6,$A8,$C4,$00
T247_A69Dh:
.byte $8A,$FF,$B1
.byte $A8,$BA,$FF,$B3,$B2,$BA,$42,$FF,$AA,$AF,$B2,$BA,$47,$BA,$58,$AB
.byte $3C,$01,$BC,$45,$C0,$00
T248_A6B6h:
.byte $9D,$54,$FF,$18,$F0,$DE,$6B,$A4,$AA,$AC
.byte $A6,$A4,$AF,$01,$B3,$B2,$BA,$42,$5C,$47,$3C,$B6,$3F,$A8,$C3,$00
T249_A6D0h:
.byte $9B,$6D,$B8,$B5,$B1,$49,$53,$8C,$6A,$B7,$63,$FF,$18,$2F,$01,$3F
.byte $48,$B6,$B8,$B0,$B0,$44,$49,$54,$FF,$18,$FB,$01,$A9,$B5,$B2,$B0
.byte $49,$54,$FF,$96,$AC,$B5,$B5,$51,$FF,$8C,$55,$B0,$A5,$42,$C0,$00

;; [$A700 :: 0x2A700]

T250_A700h:
.byte $9D,$54,$FF,$B3,$B2,$BA,$42,$FF,$5D,$FF,$18,$F8,$FF,$64,$5A,$01
.byte $BA,$58,$AB,$67,$45,$C0,$00
T251_A717h:
.byte $9D,$54,$FF,$18,$FD,$43,$B3,$B3,$56
.byte $B5,$B6,$01,$BA,$58,$AB,$49,$54,$4B,$B2,$B0,$3C,$AA,$FF,$5D,$49
.byte $54,$01,$59,$B9,$AC,$AF,$B6,$C3,$00
T252_A739h:
.byte $9C
T255_A73Ah:
.byte $B7,$A4,$50,$A4,$BA,$A4
.byte $50,$A9,$B5,$B2,$B0,$FF,$8B,$AF,$A4,$A6,$AE,$FF,$18,$FE,$01,$52
.byte $4B,$A4,$62,$50,$A5,$B2,$B7,$60,$B0,$C4,$00
T253_A75Bh:
.byte $97,$B2,$4F,$93,$B2
.byte $B6,$A8,$A9,$C3,$00
T254_A765h:
.byte $91,$44,$51,$FF,$93,$B2,$B6,$A8,$A9,$DE,$4C
.byte $40,$54,$B6,$C4,$01,$90,$6D,$49,$55,$4F,$A5,$A8,$46,$49,$53,$94
.byte $6A,$AB,$B8,$3F,$C4,$00,$FF,$FF,$FF,$FF,$00
T256_A78Bh:
.byte $00
T257_A78Ch:
.byte $9B,$3C,$AA,$00
T258_A790h:
.byte $8C,$3F,$B2,$A8,$00
T259_A795h:
.byte $99,$6A,$B6,$00
T260_A799h:
.byte $96,$BC,$3D,$B5,$AC,$AF,$00
T261_A7A0h:
.byte $9C,$B1,$B2,$BA,$A6,$B5,$A4,$A9,$B7,$00
T262_A7AAh:
.byte $7C,$90,$B2,$A7,$59,$B6
.byte $B6,$DE,$00
T263_A7B3h:
.byte $8E,$AA,$D2,$DE,$9D,$51,$A6,$AB,$00
T264_A7BCh:
.byte $9C,$B8,$B1,$A9
.byte $AC,$4A,$00
T265_A7C3h:
.byte $99,$A8,$57,$3F,$B7,$00
T266_A7C9h:
.byte $A0,$BC,$62,$B5,$B1,$8E,$AA
.byte $AA,$00
T267_A7D2h:
.byte $A0,$AB,$58,$A8,$96,$6A,$AE,$00
T268_A7DAh:
.byte $8B,$AF,$A4,$A6,$AE,$96
.byte $6A,$AE,$00
T269_A7E3h:
.byte $8C,$B5,$BC,$5B,$AF,$9B,$B2,$A7,$00
T270_A7ECh:
.byte $A0,$BC,$62,$B5
.byte $B1,$00
T271_A7F2h:
.byte $C5,$C5,$C5,$00
T272_A7F6h:
.byte $CE,$99,$B2,$5F,$44,$00
T273_A7FCh:
.byte $CE,$8A,$5E,$AC

;; [$A800 :: 0x2A800]

.byte $A7,$B2,$B7,$A8,$00
T274_A805h:
.byte $CE,$90,$C0,$97,$A8,$3E,$63,$00
T275_A80Dh:
.byte $CE,$8C,$B5
.byte $B2,$B6,$B6,$00
T276_A814h:
.byte $CE,$96,$A4,$AC,$A7,$94,$40,$B6,$00
T277_A81Dh:
.byte $CE,$96,$A4
.byte $46,$6D,$00
T278_A823h:
.byte $CE,$8E,$BC,$A8,$8D,$B5,$B2,$B3,$B6,$00
T279_A82Dh:
.byte $CE,$99,$AB
.byte $BB,$C0,$8D,$B2,$BA,$B1,$00
T280_A837h:
.byte $CE,$8E,$64,$BB,$AC,$B5,$00
T281_A83Eh:
.byte $CE,$8E
.byte $3D,$42,$00
T282_A843h:
.byte $CE,$91,$AC,$C2,$99,$B2,$D5,$44,$00
T283_A84Ch:
.byte $8C,$B2,$B7,$B7
.byte $A4,$AA,$A8,$00
T284_A854h:
.byte $A0,$3C,$A7,$8F,$AF,$B8,$B7,$A8,$00
T285_A85Dh:
.byte $90,$A4,$AC
.byte $A4,$FF,$8D,$B5,$B8,$B0,$00
T286_A867h:
.byte $90,$66,$64,$A6,$00
T287_A86Ch:
.byte $9E,$B1,$AC,$A6
.byte $B5,$B1,$91,$B5,$B1,$00
T288_A876h:
.byte $8A,$B5,$A6,$D5,$A6,$A0,$3C,$A7,$00
T289_A87Fh:
.byte $9C
.byte $A4,$AA,$A8,$A0,$40,$A7,$B0,$00
T290_A888h:
.byte $9C,$B7,$C0,$9C,$B3,$AC,$B5,$58
.byte $00
T291_A891h:
.byte $91,$B5,$90,$AF,$9C,$AB,$B2,$5A,$00
T292_A89Ah:
.byte $9C,$B3,$AC,$A7,$B5,$9C
.byte $AC,$AF,$AE,$00
T293_A8A4h:
.byte $8B,$A8,$D1,$9C,$D2,$A8,$B1,$A6,$A8,$00
T294_A8AEh:
.byte $91,$45
.byte $B5,$AA,$AF,$6A,$B6,$00
T295_A8B6h:
.byte $8D,$56,$3D,$92,$A7,$B2,$AF,$00
T296_A8BEh:
.byte $8B,$A6
.byte $AB,$B6,$DE,$A0,$3C,$A8,$00
T297_A8C7h:
.byte $8A,$A6,$AC,$A7,$99,$AB,$AC,$A4,$AF
.byte $00
T298_A8D1h:
.byte $9C,$AF,$B3,$AA,$B5,$6A,$B6,$00
T299_A8D9h:
.byte $8C,$44,$A6,$AB,$9C,$54,$AF
.byte $00
T300_A8E1h:
.byte $8B,$B7,$B5,$A4,$BC,$8F,$3F,$AA,$00
T301_A8EAh:
.byte $96,$3D,$96,$AC,$B5,$B5
.byte $51,$00
T302_A8F2h:
.byte $91,$A8,$46,$A9,$AC,$4A,$00
T303_A8F9h:
.byte $8F,$BC,$B1,$B1,$00
T304_A8FEh:
.byte $9E,$B1

;; [$A900 :: 0x2A900]

.byte $66,$6C,$A7,$00
T305_A904h:
.byte $6F,$8B,$B8,$A6,$AE,$63,$B5,$00
T306_A90Ch:
.byte $6F,$8B,$B5,$44
.byte $BD,$A8,$00
T307_A913h:
.byte $6F,$96,$BC,$3D,$B5,$AC,$AF,$00
T308_A91Bh:
.byte $6F,$90,$B2,$AF,$59
.byte $B1,$00
T309_A922h:
.byte $6F,$92,$A6,$A8,$00
T310_A927h:
.byte $6F,$8F,$AF,$A4,$6C,$00
T311_A92Dh:
.byte $6F,$8D,$AC
.byte $A4,$B0,$44,$A7,$00
T312_A935h:
.byte $6F,$8D,$B5,$A4,$AA,$44,$00
T313_A93Ch:
.byte $6F,$8A,$A8,$AA
.byte $40,$00
T314_A942h:
.byte $70,$94,$B1,$AC,$A9,$A8,$00
T315_A949h:
.byte $70,$8D,$A4,$AA,$AA,$42,$00
T316_A950h:
.byte $70,$96,$BC,$3D,$B5,$AC,$AF,$00
T317_A958h:
.byte $70,$96,$C0,$90,$A4,$B8,$A6,$54
.byte $00
T318_A961h:
.byte $70,$98,$AB,$B5,$A6,$A4,$AF,$B8,$B0,$00
T319_A96Bh:
.byte $70,$9B,$AC,$B3,$B3
.byte $42,$00
T320_A972h:
.byte $70,$8C,$52,$8C,$AF,$A4,$BA,$B6,$00
T321_A97Bh:
.byte $71,$9C,$B7,$A4,$A9
.byte $A9,$00
T322_A982h:
.byte $71,$96,$A4,$A6,$A8,$00
T323_A988h:
.byte $71,$96,$BC,$3D,$B5,$AC,$AF,$00
T324_A990h:
.byte $71,$A0,$42,$A8,$A5,$5B,$B5,$00
T325_A998h:
.byte $71,$96,$A4,$AA,$A8,$00
T326_A99Eh:
.byte $71,$99
.byte $B2,$BA,$42,$00
T327_A9A4h:
.byte $71,$A0,$AC,$BD,$66,$A7,$00
T328_A9ABh:
.byte $71,$91,$56,$64,$41
.byte $00
T329_A9B1h:
.byte $71,$8D,$AC,$A4,$B0,$44,$A7,$00
T330_A9B9h:
.byte $72,$93,$A4,$62,$64,$B1,$00
T331_A9C0h:
.byte $72,$9C,$B3,$56,$B5,$00
T332_A9C6h:
.byte $72,$96,$BC,$3D,$B5,$AC,$AF,$00
T333_A9CEh:
.byte $72,$9D
.byte $B5,$AC,$59,$5E,$00
T334_A9D5h:
.byte $72,$8D,$A8,$B0,$44,$00
T335_A9DBh:
.byte $72,$8F,$AF,$A4,$6C
.byte $00
T336_A9E1h:
.byte $72,$92,$A6,$A8,$00
T337_A9E6h:
.byte $72,$9D,$AB,$B8,$57,$42,$00
T338_A9EDh:
.byte $72,$91,$B2
.byte $AF,$BC,$00
T339_A9F3h:
.byte $73,$8B,$B5,$B2,$A4,$A7,$00
T340_A9FAh:
.byte $73,$95,$44,$AA,$00
T341_A9FFh:
.byte $73

;; [$AA00 :: 0x2AA00]

.byte $96,$BC,$3D,$B5,$AC,$AF,$00
T342_AA07h:
.byte $73,$8A,$B1,$A6,$AC,$A8,$5E,$00
T343_AA0Fh:
.byte $73
.byte $8C,$4A,$B6,$A6,$A8,$5E,$00
T344_AA17h:
.byte $73,$A0,$3C,$AA,$00
T345_AA1Ch:
.byte $73,$8B,$AF,$B2
.byte $B2,$A7,$00
T346_AA23h:
.byte $73,$90,$A4,$AC,$A4,$00
T347_AA29h:
.byte $73,$8F,$AF,$A4,$6C,$00
T348_AA2Fh:
.byte $73
.byte $92,$A6,$A8,$00
T349_AA34h:
.byte $73,$8D,$A8,$A9,$A8,$57,$42,$00
T350_AA3Ch:
.byte $73,$9C,$B8,$B1
.byte $00
T351_AA41h:
.byte $73,$8E,$BB,$A6,$A4,$D3,$A5,$B8,$B5,$00
T352_AA4Bh:
.byte $73,$96,$6A,$A4,$B0
.byte $B8,$B1,$A8,$00
T353_AA54h:
.byte $74,$8A,$BB,$A8,$00
T354_AA59h:
.byte $74,$8B,$52,$B7,$63,$00
T355_AA5Fh:
.byte $74
.byte $96,$BC,$3D,$B5,$AC,$AF,$00
T356_AA67h:
.byte $74,$8D,$A8,$B0,$44,$00
T357_AA6Dh:
.byte $74,$98,$AA
.byte $4A,$94,$46,$B5,$00
T358_AA75h:
.byte $74,$99,$B2,$40,$44,$00
T359_AA7Bh:
.byte $74,$9B,$B8,$B1,$A8
.byte $00
T360_AA81h:
.byte $75,$8B,$B2,$BA,$00
T361_AA86h:
.byte $75,$95,$44,$AA,$00
T362_AA8Bh:
.byte $75,$96,$BC,$3D,$B5
.byte $AC,$AF,$00
T363_AA93h:
.byte $75,$8D,$66,$AE,$00
T364_AA98h:
.byte $75,$8F,$AF,$A4,$6C,$00
T365_AA9Eh:
.byte $75,$92
.byte $A6,$A8,$00
T366_AAA3h:
.byte $00
T367_AAA4h:
.byte $75,$A2,$B2,$AC,$A6,$AB,$AC,$00
T368_AAACh:
.byte $CB,$95,$56,$3D
.byte $42,$00
T369_AAB2h:
.byte $CB,$8B,$B5,$44,$BD,$A8,$00
T370_AAB9h:
.byte $CB,$96,$BC,$3D,$B5,$AC,$AF
.byte $00
T371_AAC1h:
.byte $CB,$90,$AC,$3F,$B7,$00
T372_AAC7h:
.byte $CB,$8F,$AF,$A4,$6C,$00
T373_AACDh:
.byte $CB,$8D,$AC
.byte $A4,$B0,$44,$A7,$00
T374_AAD5h:
.byte $CB,$90,$A8,$B1,$AD,$AC,$00
T375_AADCh:
.byte $CB,$9D,$BA,$40
.byte $B7,$00
T376_AAE2h:
.byte $CB,$90,$B2,$AF,$A7,$B3,$3C,$00
T377_AAEAh:
.byte $CB,$9B,$AC,$A5,$A5,$44
.byte $00
T378_AAF1h:
.byte $CA,$8C,$AF,$B2,$3D,$5A,$00
T379_AAF8h:
.byte $CA,$95,$56,$3D,$42,$00
T380_AAFEh:
.byte $CA,$8B

;; [$AB00 :: 0x2AB00]

.byte $B5,$44,$BD,$A8,$00
T381_AB05h:
.byte $CA,$96,$BC,$3D,$B5,$AC,$AF,$00
T382_AB0Dh:
.byte $CA,$90,$B2
.byte $AF,$A7,$00
T383_AB13h:
.byte $CA,$94,$B1,$AC,$68,$B7,$B6,$00
T384_AB1Bh:
.byte $CA,$8F,$AF,$A4,$6C
.byte $00
T385_AB21h:
.byte $CA,$92,$A6,$A8,$00
T386_AB26h:
.byte $CA,$8D,$AC,$A4,$B0,$44,$A7,$00
T387_AB2Eh:
.byte $CA,$8D
.byte $B5,$A4,$AA,$44,$00
T388_AB35h:
.byte $CA,$90,$A8,$B1,$AD,$AC,$00
T389_AB3Ch:
.byte $CA,$8B,$B5,$44
.byte $BD,$A8,$00
T390_AB43h:
.byte $D0,$9C,$AC,$AF,$62,$B5,$00
T391_AB4Ah:
.byte $D0,$9B,$B8,$A5,$BC,$00
T392_AB50h:
.byte $D0,$90,$B2,$AF,$A7,$00
T393_AB56h:
.byte $D0,$8D,$AC,$A4,$B0,$44,$A7,$00
T394_AB5Eh:
.byte $CA,$A0
.byte $AB,$B7,$A8,$9B,$B2,$A5,$A8,$00
T395_AB68h:
.byte $CA,$8B,$AF,$A6,$AE,$9B,$B2,$A5
.byte $A8,$00
T396_AB72h:
.byte $CA,$99,$B2,$BA,$42,$00
T397_AB78h:
.byte $CA,$8B,$AF,$A6,$AE,$90,$66,$A5
.byte $00
T398_AB81h:
.byte $CC,$95,$56,$3D,$42,$00
T399_AB87h:
.byte $CC,$8B,$B5,$44,$BD,$A8,$00
T400_AB8Eh:
.byte $CC,$96
.byte $BC,$3D,$B5,$AC,$AF,$00
T401_AB96h:
.byte $CC,$9D,$AB,$AC,$A8,$A9,$B6,$00
T402_AB9Eh:
.byte $CC,$90
.byte $AC,$3F,$B7,$B6,$00
T403_ABA5h:
.byte $CC,$92,$A6,$A8,$00
T404_ABAAh:
.byte $CC,$8D,$AC,$A4,$B0,$44
.byte $A7,$00
T405_ABB2h:
.byte $CC,$90,$A8,$B1,$AD,$AC,$00
T406_ABB9h:
.byte $CC,$99,$B5,$B2,$B7,$A8,$A6
.byte $B7,$00
T407_ABC2h:
.byte $CC,$99,$B2,$BA,$42,$00
T408_ABC8h:
.byte $CF,$8F,$AC,$4A,$00
T409_ABCDh:
.byte $CF,$9D,$AB
.byte $B8,$57,$42,$00
T410_ABD4h:
.byte $CF,$8B,$64,$BD,$BD,$66,$A7,$00
T411_ABDCh:
.byte $CF,$9C,$A6,$45
.byte $B5,$AA,$A8,$00
T412_ABE4h:
.byte $CF,$8D,$B5,$A4,$3C,$00
T413_ABEAh:
.byte $CF,$98,$B6,$B0,$B2,$B6
.byte $A8,$00
T414_ABF2h:
.byte $CF,$8F,$AF,$66,$A8,$00
T415_ABF8h:
.byte $CF,$9C,$63,$A8,$B3,$00
T416_ABFEh:
.byte $CF,$9C

;; [$AC00 :: 0x2AC00]

.byte $B7,$B8,$B1,$00
T417_AC04h:
.byte $CF,$9C,$60,$B3,$00
T418_AC09h:
.byte $CF,$8C,$44,$A9,$B8,$B6,$A8
.byte $00
T419_AC11h:
.byte $CF,$8B,$64,$57,$00
T420_AC16h:
.byte $CF,$8C,$B8,$B5,$B6,$A8,$00
T421_AC1Dh:
.byte $CF,$9D,$B2
.byte $A4,$A7,$00
T422_AC23h:
.byte $CF,$8B,$4A,$A4,$AE,$00
T423_AC29h:
.byte $CF,$8D,$56,$3D,$00
T424_AC2Eh:
.byte $CF,$A0
.byte $66,$B3,$00
T425_AC33h:
.byte $CF,$8B,$42,$B6,$42,$AE,$00
T426_AC3Ah:
.byte $CF,$91,$6A,$B7,$A8,$00
T427_AC40h:
.byte $CF,$8A,$B8,$B5,$A4,$00
T428_AC46h:
.byte $CF,$8C,$B8,$4A,$00
T429_AC4Bh:
.byte $CF,$95,$AC,$A9,$A8
.byte $00
T430_AC51h:
.byte $CF,$8B,$6A,$B8,$B1,$A4,$00
T431_AC58h:
.byte $CF,$8E,$B6,$B8,$B1,$A4,$00
T432_AC5Fh:
.byte $CF
.byte $8B,$66,$B5,$AC,$42,$00
T433_AC66h:
.byte $CF,$8B,$64,$B1,$AE,$00
T434_AC6Ch:
.byte $CF,$99,$B5,$B2
.byte $B7,$A8,$A6,$B7,$00
T435_AC75h:
.byte $CF,$9C,$54,$46,$00
T436_AC7Ah:
.byte $CF,$A0,$A4,$46,$00
T437_AC7Fh:
.byte $CF
.byte $8D,$40,$B3,$A8,$AF,$00
T438_AC86h:
.byte $CF,$96,$3C,$AC,$00
T439_AC8Bh:
.byte $CF,$9C,$AC,$63,$B1
.byte $A6,$A8,$00
T440_AC93h:
.byte $CF,$9C,$A4,$B3,$00
T441_AC98h:
.byte $CF,$8F,$B2,$AA,$00
T442_AC9Dh:
.byte $CF,$9C,$AF
.byte $B2,$BA,$00
T443_ACA3h:
.byte $CF,$9C,$BA,$A4,$B3,$00
T444_ACA9h:
.byte $CF,$8F,$56,$B5,$00
T445_ACAEh:
.byte $CF,$91
.byte $B2,$AF,$BC,$00
T446_ACB4h:
.byte $CF,$9D,$A8,$63,$B3,$51,$B7,$00
T447_ACBCh:
.byte $CF,$9E,$AF,$5F
.byte $B0,$A4,$00
T448_ACC3h:
.byte $8F,$AC,$4A,$00
T449_ACC7h:
.byte $9D,$E6,$E7,$E8,$E9,$00
T450_ACCDh:
.byte $8B,$EA,$EB
.byte $EC,$ED,$00
T451_ACD3h:
.byte $9C,$A6,$B5,$AA,$F6,$00
T452_ACD9h:
.byte $8D,$B5,$7D,$B1,$00
T453_ACDEh:
.byte $98,$B6
.byte $B0,$B6,$F6,$00
T454_ACE4h:
.byte $8F,$7E,$4A,$00
T455_ACE8h:
.byte $9C,$7F,$A8,$B3,$00
T456_ACEDh:
.byte $9C,$B7,$B8
.byte $B1,$00
T457_ACF2h:
.byte $9C,$60,$B3,$00
T458_ACF6h:
.byte $8C,$B1,$A9,$B6,$F6,$00
T459_ACFCh:
.byte $8B,$D3,$57,$00

;; [$AD00 :: 0x2AD00]

T460_AD00h:
.byte $8C,$B8,$B5,$B6,$F6,$00
T461_AD06h:
.byte $9D,$B2,$A4,$A7,$00
T462_AD0Bh:
.byte $8B,$D7,$A4,$AE,$00
T463_AD10h:
.byte $8D,$56,$D8,$00
T464_AD14h:
.byte $A0,$66,$B3,$00
T465_AD18h:
.byte $8B,$B6,$B5,$AE,$00
T466_AD1Dh:
.byte $91,$6A,$D9
.byte $00
T467_AD21h:
.byte $8A,$B8,$B5,$A4,$00
T468_AD26h:
.byte $8C,$B8,$4A,$00
T469_AD2Ah:
.byte $95,$AC,$A9,$A8,$00
T470_AD2Fh:
.byte $8B
.byte $EE,$EF,$F0,$F1,$00
T471_AD35h:
.byte $8E,$B6,$F2,$F3,$F4,$00
T472_AD3Bh:
.byte $8B,$A4,$CD,$D6,$DD
.byte $00
T473_AD41h:
.byte $8B,$D3,$B1,$AE,$00
T474_AD46h:
.byte $99,$B5,$D9,$A6,$00
T475_AD4Bh:
.byte $9C,$54,$D1,$00
T476_AD4Fh:
.byte $A0
.byte $A4,$46,$00
T477_AD53h:
.byte $8D,$B6,$B3,$AF,$00
T478_AD58h:
.byte $96,$3C,$AC,$00
T479_AD5Ch:
.byte $9C,$D2,$E2,$F5
.byte $F6,$00
T480_AD62h:
.byte $9C,$A4,$B3,$00
T481_AD66h:
.byte $8F,$B2,$AA,$00
T482_AD6Ah:
.byte $9C,$AF,$B2,$BA,$00
T483_AD6Fh:
.byte $9C
.byte $BA,$A4,$B3,$00
T484_AD74h:
.byte $8F,$56,$B5,$00
T485_AD78h:
.byte $91,$B2,$AF,$BC,$00
T486_AD7Dh:
.byte $9D,$A8,$7F
.byte $B3,$E9,$00
T487_AD83h:
.byte $9E,$DA,$DB,$DC,$00
T488_AD88h:
.byte $9D,$4A,$6A,$B8,$4A,$C1,$00
T489_AD8Fh:
.byte $9B
.byte $A8,$B0,$B2,$62,$00
T490_AD95h:
.byte $8E,$BB,$58,$00
T491_AD99h:
.byte $90,$51,$A7,$44,$00
T492_AD9Eh:
.byte $A0,$AB
.byte $53,$BA,$AC,$46,$FF,$B8,$B6,$4D,$58,$C5,$00
T493_ADABh:
.byte $99,$B5,$3C,$A6,$5A
.byte $B6,$00
T494_ADB2h:
.byte $8D,$66,$AE,$FF,$94,$B1,$AC,$68,$B7,$00
T495_ADBCh:
.byte $91,$AC,$AF,$A7
.byte $A4,$00
T496_ADC2h:
.byte $8E,$B0,$B3,$42,$51,$00
T497_ADC8h:
.byte $A0,$AC,$AF,$48,$9B,$B2,$B6,$A8
.byte $00
T498_ADD1h:
.byte $96,$BC,$3D,$B5,$AC,$AF,$00
T499_ADD8h:
.byte $8D,$4A,$A4,$A7,$B1,$45,$68,$B7
.byte $00
T500_ADE1h:
.byte $99,$A4,$AF,$A4,$6C,$A6,$AC,$A4,$00
T501_ADEAh:
.byte $8A,$AC,$B5,$B6,$AB,$AC
.byte $B3,$00
T502_ADF2h:
.byte $90,$B2,$A7,$59,$B6,$B6,$DE,$FF,$8B,$A8,$46,$00
T503_ADFEh:
.byte $9C,$B8

;; [$AE00 :: 0x2AE00]

.byte $B1,$A9,$AC,$4A,$00
T504_AE05h:
.byte $96,$BC,$B6,$AC,$A7,$AC,$A4,$00
T505_AE0Dh:
.byte $9E,$AF,$5F
.byte $B0,$A4,$FF,$9D,$B2,$6C,$00
T506_AE17h:
.byte $8D,$B5,$A4,$AA,$B2,$44,$00
T507_AE1Eh:
.byte $A0,$BC
.byte $62,$B5,$B1,$00
T508_AE24h:
.byte $8C,$BC,$A6,$AF,$44,$A8,$00
T509_AE2Bh:
.byte $93,$A4,$59,$FF,$99
.byte $6A,$B6,$A4,$AA,$A8,$00
T510_AE36h:
.byte $96,$6A,$AE,$00
T511_AE3Ah:
.byte $8E,$AE,$6C,$4F,$9D,$A8
.byte $AF,$B2,$5A,$B6,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$00
T512_AE53h:
.byte $97,$B2,$3D,$3C,$AA,$49,$54,$4A,$C0,$00
T513_AE5Dh:
.byte $9B,$A8,$A6
.byte $A8,$AC,$62,$48,$02,$C4,$00
T514_AE67h:
.byte $9B,$A8,$A6,$A8,$AC,$62,$48,$03,$FF
.byte $90,$AC,$AF,$C4,$00
T515_AE75h:
.byte $A2,$45,$E3,$4D,$A6,$66,$B5,$BC,$3C,$AA,$01
.byte $60,$53,$B0,$B8,$A6,$AB,$C4,$00
T516_AE88h:
.byte $A2,$45,$FF,$B1,$A8,$3E,$43,$FF
.byte $AE,$A8,$BC,$C0,$00
T517_AE95h:
.byte $A0,$55,$4F,$A6,$3F,$65,$FF,$A7,$53,$A9,$51
.byte $67,$45,$C5,$00
T518_AEA4h:
.byte $A0,$55,$4F,$BA,$45,$AF,$A7,$01,$BC,$45,$FF,$64
.byte $AE,$A8,$C5,$00
T519_AEB4h:
.byte $A2,$45,$FF,$A7,$44,$E0,$FF,$55,$62,$FF,$A8,$B1
.byte $45,$68,$FF,$AA,$AC,$AF,$C0,$00
T520_AEC8h:
.byte $A2,$45,$E3,$4D,$A6,$66,$B5,$BC
.byte $3C,$AA,$49,$B2,$53,$B0,$B8,$A6,$AB,$C0,$00
T521_AEDBh:
.byte $9D,$55,$B1,$AE,$67
.byte $45,$C4,$01,$8A,$B1,$BC,$3D,$3C,$AA,$FF,$A8,$AF,$B6,$A8,$C5,$00
T522_AEF0h:
.byte $A0,$55,$4F,$BA,$AC,$46,$67,$45,$FF,$B6,$A8,$46,$C5,$00
T523_AEFEh:
.byte $92,$4B

;; [$AF00 :: 0x2AF00]

.byte $3F,$E0,$49,$A4,$AE,$4D,$3D,$52,$C0,$01,$8A,$B1,$BC,$3D,$3C,$AA
.byte $FF,$A8,$AF,$B6,$A8,$C5,$00
T524_AF17h:
.byte $92,$DF,$AF,$FF,$AA,$AC,$62,$67,$45
.byte $FF,$04,$FF,$90,$AC,$AF,$01,$A9,$51,$49,$55,$B7,$C0,$98,$94,$C5
.byte $FF,$01,$16,$08,$A2,$5A,$16,$16,$97,$B2,$00
T525_AF3Bh:
.byte $A0,$A8,$AF,$A6,$B2
.byte $6C,$C4,$01,$92,$4F,$BA,$AC,$46,$4B,$B2,$5B,$FF,$04,$FF,$AA,$AC
.byte $AF,$01,$60,$FF,$4A,$5B,$51,$4D,$BC,$45,$B5,$FF,$91,$99,$43,$57
.byte $FF,$96,$99,$C0,$01,$A0,$45,$AF,$48,$BC,$45,$FF,$64,$AE,$4D,$60
.byte $FF,$5B,$A4,$BC,$C5,$00
T526_AF76h:
.byte $A2,$45,$FF,$A7,$44,$E0,$FF,$55,$62,$FF
.byte $A8,$B1,$45,$68,$FF,$AA,$AC,$AF,$C0,$00
T527_AF8Ah:
.byte $99,$63,$6A,$3F,$4F,$A7
.byte $4A,$A4,$B0,$B6,$C3,$00
T528_AF96h:
.byte $99,$63,$6A,$4D,$A6,$B2,$6C,$43,$AA,$A4
.byte $3C,$C4,$00
T529_AFA3h:
.byte $A2,$45,$FF,$B1,$A8,$3E,$43,$FF,$B5,$AC,$59,$C5,$01
.byte $83,$82,$FF,$AA,$AC,$AF,$4C,$AC,$46,$49,$A4,$AE,$4D,$BC,$45,$49
.byte $B2,$01,$99,$5D,$B7,$C4,$00
T530_AFC7h:
.byte $A2,$45,$FF,$B1,$A8,$3E,$43,$FF,$B5
.byte $AC,$59,$C5,$01,$83,$82,$FF,$AA,$AC,$AF,$4C,$AC,$46,$49,$A4,$AE
.byte $4D,$BC,$45,$49,$B2,$01,$99,$A4,$AF,$B2,$B2,$B0,$C4,$00
T531_AFEEh:
.byte $8D,$44
.byte $A8,$C4,$93,$B8,$5B,$4E,$B2,$66,$48,$3D,$A8,$01,$B6,$AB,$AC,$B3

;; [$B000 :: 0x2B000]

.byte $5C,$B1,$69,$B5,$44,$4F,$5D,$49,$B2,$BA,$B1,$01,$3F,$48,$5D,$A9
.byte $67,$45,$FF,$AA,$B2,$C4,$00
T532_B017h:
.byte $8A,$B6,$B6,$40,$B7,$3F,$B7,$C1,$8C
.byte $AC,$A7,$DE,$FF,$18,$F5,$01,$A6,$3F,$49,$A4,$AE,$4D,$BC,$45,$43
.byte $B1,$BC,$BA,$54,$4A,$C4,$01,$8B,$B8,$4F,$58,$DF,$AF,$4B,$B2,$5B
.byte $67,$A4,$C0,$01,$92,$5E,$42,$5A,$B7,$3E,$C5,$00
T533_B04Ch:
.byte $FF,$FF,$90,$B2
.byte $16,$0D,$8B,$A4,$A9,$B6,$AE,$FF,$FF,$FF,$FF,$81,$80,$80,$01,$FF
.byte $4C,$54,$4A,$C5,$16,$0D,$9C,$A4,$AF,$A4,$B0,$3F,$48,$82,$80,$80
.byte $01,$16,$0D,$9C,$A8,$B0,$58,$4D,$FF,$FF,$83,$80,$80,$01,$16,$0D
.byte $94,$6A,$AB,$B8,$3F,$FF,$FF,$84,$80,$80,$00
T534_B08Bh:
.byte $9D,$55,$B1,$AE,$B6
.byte $C4,$9D,$54,$FF,$18,$F5,$4C,$AC,$46,$4E,$A8,$01,$BA,$A4,$58,$3C
.byte $AA,$69,$51,$67,$45,$FF,$45,$B7,$B6,$AC,$59,$C0,$00
T535_B0ADh:
.byte $15,$01,$8B
.byte $B8,$BC,$01,$15,$01,$9C,$A8,$46,$01,$15,$01,$8E,$BB,$58,$00
T536_B0BFh:
.byte $15
.byte $01,$A2,$5A,$01,$15,$01,$97,$B2,$00
T537_B0C9h:
.byte $98,$B2,$B3,$B6,$C4,$97,$B2
.byte $4F,$A8,$B1,$45,$68,$6B,$44,$A8,$BC,$C4,$01,$8C,$B2,$6C,$43,$AA
.byte $A4,$3C,$C4,$00
T538_B0E4h:
.byte $15,$01,$8A,$B6,$AE,$01,$15,$01,$95,$56,$B5,$B1
.byte $01,$15,$01,$92,$B7,$A8,$B0,$B6,$00
T539_B0F9h:
.byte $15,$01,$92,$B7,$A8,$B0,$15

;; [$B100 :: 0x2B100]

.byte $06,$96,$A4,$AA,$AC,$A6,$15,$0C,$8E,$B4,$B8,$AC,$B3,$15,$12,$9C
.byte $B7,$52,$B6,$15,$18,$9C,$A4,$62,$00
T540_B119h:
.byte $05,$FF,$90,$D2,$00
T541_B11Eh:
.byte $FF,$FF
.byte $FF,$FF,$01,$FF,$FF,$FF,$FF,$00
T542_B128h:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$10,$02
.byte $01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$10,$01,$01,$91,$99,$FF,$10,$20
.byte $7A,$10,$21,$01,$96,$99,$FF,$FF,$10,$22,$7A,$FF,$10,$23,$00
T543_B14Fh:
.byte $65
.byte $B7,$A8,$B0,$B6,$00
T544_B155h:
.byte $FF,$96,$A4,$AA,$AC,$A6,$01,$FF,$FF,$10,$02
.byte $00
T545_B161h:
.byte $FF,$91,$99,$FF,$10,$20,$7A,$10,$21,$01,$FF,$96,$99,$FF,$FF
.byte $10,$22,$7A,$FF,$10,$23,$00
T546_B177h:
.byte $FF,$8E,$B4,$D4,$B3,$6C,$5E,$01,$FF
.byte $FF,$10,$02,$00
T547_B184h:
.byte $FF,$8A,$B7,$B7,$A4,$A6,$AE,$C1,$10,$24,$01,$8D
.byte $A8,$A9,$A8,$B1,$B6,$A8,$C1,$10,$25,$00
T548_B19Ah:
.byte $FF,$9B,$C0,$91,$3F,$A7
.byte $14,$0A,$91,$56,$A7,$14,$13,$91,$3F,$A7,$B6,$01,$16,$02,$10,$06
.byte $16,$0B,$10,$03,$16,$14,$10,$05,$01,$FF,$95,$C0,$91,$3F,$A7,$14
.byte $0A,$8B,$B2,$A7,$BC,$14,$13,$92,$B7,$A8,$B0,$01,$16,$02,$10,$07
.byte $16,$0B,$10,$04,$16,$14,$10,$08,$01,$16,$14,$10,$09,$00
T549_B1DEh:
.byte $17,$01
.byte $1A,$00,$17,$0B,$1A,$01,$17,$15,$1A,$02,$01,$17,$01,$1A,$03,$17
.byte $0B,$1A,$04,$17,$15,$1A,$05,$01,$17,$01,$1A,$06,$17,$0B,$1A,$07

;; [$B200 :: 0x2B200]

.byte $17,$15,$1A,$08,$01,$17,$01,$1A,$09,$17,$0B,$1A,$0A,$17,$15,$1A
.byte $0B,$01,$17,$01,$1A,$0C,$17,$0B,$1A,$0D,$17,$15,$1A,$0E,$01,$17
.byte $01,$1A,$0F,$17,$0B,$1A,$10,$17,$15,$1A,$11,$01,$17,$01,$1A,$12
.byte $17,$0B,$1A,$13,$17,$15,$1A,$14,$01,$17,$01,$1A,$15,$17,$0B,$1A
.byte $16,$17,$15,$1A,$17,$01,$17,$01,$1A,$18,$17,$0B,$1A,$19,$17,$15
.byte $1A,$1A,$01,$17,$01,$1A,$1B,$17,$0B,$1A,$1C,$17,$15,$1A,$1D,$01
.byte $17,$01,$1A,$1E,$17,$0B,$1A,$1F,$17,$15,$0F,$00
T550_B26Ch:
.byte $17,$02,$10,$0A
.byte $14,$07,$10,$38,$17,$0F,$10,$0B,$14,$14,$10,$39,$01,$17,$02,$10
.byte $0C,$14,$07,$10,$3A,$17,$0F,$10,$0D,$14,$14,$10,$3B,$01,$17,$02
.byte $10,$0E,$14,$07,$10,$3C,$17,$0F,$10,$0F,$14,$14,$10,$3D,$01,$17
.byte $02,$10,$10,$14,$07,$10,$3E,$17,$0F,$10,$11,$14,$14,$10,$3F,$01
.byte $17,$02,$10,$12,$14,$07,$10,$40,$17,$0F,$10,$13,$14,$14,$10,$41
.byte $01,$17,$02,$10,$14,$14,$07,$10,$42,$17,$0F,$10,$15,$14,$14,$10
.byte $43,$01,$17,$02,$10,$16,$14,$07,$10,$44,$17,$0F,$10,$17,$14,$14
.byte $10,$45,$01,$17,$02,$10,$18,$14,$07,$10,$46,$17,$0F,$10,$19,$14
.byte $14,$10,$47,$01,$17,$0F,$0F,$00
T551_B2F8h:
.byte $14,$05,$10,$02,$14,$0E,$91,$99

;; [$B300 :: 0x2B300]

.byte $FF,$10,$20,$7A,$10,$21,$01,$14,$0E,$96,$99,$FF,$FF,$10,$22,$7A
.byte $FF,$10,$23,$01,$9C,$B7,$4A,$41,$3D,$C1,$10,$26,$FF,$10,$00,$C2
.byte $55,$57,$3E,$01,$FF,$8A,$AA,$AC,$64,$B7,$BC,$C1,$10,$27,$FF,$FF
.byte $FF,$8A,$B7,$B7,$A4,$A6,$AE,$C1,$10,$24,$01,$FF,$9C,$B7,$A4,$B0
.byte $3C,$A4,$C1,$10,$28,$FF,$8A,$A6,$A6,$B8,$B5,$A4,$A6,$BC,$C1,$10
.byte $2D,$C6,$01,$92,$5E,$A8,$D1,$A8,$A6,$B7,$C1,$10,$29,$FF,$FF,$8D
.byte $A8,$A9,$A8,$B1,$B6,$A8,$C1,$10,$25,$01,$FF,$FF,$9C,$B3,$AC,$B5
.byte $58,$C1,$10,$2A,$FF,$FF,$8E,$B9,$6A,$61,$B1,$C1,$10,$2E,$C6,$01
.byte $FF,$96,$C0,$99,$B2,$BA,$42,$C1,$10,$2B,$FF,$96,$C0,$9B,$5A,$40
.byte $B7,$C1,$10,$2F,$C6,$01,$14,$00,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3
.byte $C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3,$C3
.byte $C3,$C3,$C3,$01,$14,$01,$A0,$B3,$B1,$C0,$9C,$AE,$AC,$46,$FF,$70
.byte $10,$32,$FF,$FF,$73,$10,$35,$01,$14,$03,$6E,$10,$30,$FF,$FF,$71
.byte $10,$33,$FF,$FF,$74,$10,$36,$01,$14,$03,$6F,$10,$31,$FF,$FF,$72
.byte $10,$34,$FF,$FF,$75,$10,$37,$00
T552_B3E8h:
.byte $FF,$FF,$9C,$A4,$62,$FF,$B2,$62
.byte $B5,$49,$AB,$40,$69,$AC,$63,$C5,$01,$FF,$FF,$16,$09,$A2,$5A,$FF

;; [$B400 :: 0x2B400]

.byte $16,$0E,$97,$B2,$00
T553_B405h:
.byte $FF,$FF,$A0,$AB,$AC,$A6,$AB,$69,$AC,$63,$C5
.byte $01,$16,$03,$FF,$81,$16,$06,$FF,$82,$16,$09,$FF,$83,$16,$0C,$FF
.byte $84,$00
T554_B422h:
.byte $FF,$FF,$9C,$A4,$62,$A7,$C0,$FF,$9B,$A8,$6C,$B0,$A5,$42
.byte $49,$53,$AB,$B2,$AF,$A7,$01,$FF,$49,$54,$FF,$9B,$5A,$6D,$4E,$B8
.byte $B7,$60,$B1,$4C,$AB,$AC,$63,$FF,$01,$FF,$49,$B8,$B5,$B1,$3C,$AA
.byte $49,$54,$FF,$B3,$B2,$BA,$42,$FF,$5D,$A9,$C4,$00
T555_B45Ch:
.byte $FF,$FF,$9B,$5A
.byte $60,$4A,$47,$91,$99,$C0,$01,$FF,$FF,$18,$EC,$00
T556_B46Ch:
.byte $FF,$FF,$8C,$B8
.byte $4A,$47,$B3,$B2,$40,$44,$C0,$01,$FF,$FF,$18,$EC,$00
T557_B47Dh:
.byte $FF,$FF,$8C
.byte $B8,$4A,$47,$5B,$44,$A8,$C0,$01,$FF,$FF,$18,$EC,$00
T558_B48Dh:
.byte $FF,$FF,$8C
.byte $B8,$4A,$47,$A6,$B8,$B5,$B6,$A8,$C0,$01,$FF,$FF,$18,$EC,$00
T559_B49Fh:
.byte $FF
.byte $FF,$8C,$B8,$4A,$47,$60,$A4,$A7,$C0,$01,$FF,$FF,$18,$EC,$00
T560_B4AFh:
.byte $FF
.byte $FF,$8C,$B8,$4A,$47,$B6,$AC,$63,$B1,$A6,$A8,$C0,$01,$FF,$FF,$18
.byte $EC,$00
T561_B4C2h:
.byte $FF,$FF,$8C,$B8,$4A,$47,$A5,$64,$57,$C0,$01,$FF,$FF,$18
.byte $EC,$00
T562_B4D2h:
.byte $FF,$FF,$9B,$A8,$B9,$AC,$62,$47,$A4,$FF,$94,$98,$E1,$FF
.byte $B3,$42,$B6,$44,$C0,$01,$FF,$FF,$18,$EC,$00
T563_B4EBh:
.byte $FF,$FF,$8C,$B2,$B0
.byte $B3,$63,$B7,$A8,$AF,$50,$4A,$A6,$B2,$62,$B5,$B6,$01,$FF,$FF,$91

;; [$B500 :: 0x2B500]

.byte $99,$43,$57,$FF,$96,$99,$C0,$01,$FF,$FF,$18,$EC,$00
T564_B50Dh:
.byte $FF,$FF,$9B
.byte $A8,$A6,$B2,$62,$B5,$47,$96,$99,$C0,$01,$FF,$FF,$18,$EC,$00
T565_B51Fh:
.byte $FF
.byte $FF,$90,$4A,$52,$AF,$50,$4A,$5B,$51,$5A,$FF,$91,$99,$C0,$01,$FF
.byte $FF,$18,$EC,$00
T566_B534h:
.byte $FF,$FF,$9B,$A8,$A6,$B2,$62,$B5,$47,$91,$99,$7A
.byte $96,$99,$FF,$5D,$49,$54,$01,$FF,$FF,$A8,$5E,$AC,$4A,$FF,$B3,$66
.byte $B7,$BC,$C0,$00
T567_B554h:
.byte $FF,$9D,$B5,$3F,$B6,$B3,$51,$B7,$47,$B3,$66,$B7
.byte $50,$60,$01,$FF,$B3,$4A,$B9,$61,$B8,$47,$A9,$AF,$B2,$51,$C0,$00
T568_B570h:
.byte $FF,$FF,$9B,$5A,$60,$4A,$47,$91,$99,$C0,$01,$FF,$FF,$18,$EC,$00
T569_B580h:
.byte $FF,$FF,$9B,$A8,$B9,$AC,$62,$47,$A4,$FF,$94,$98,$E1,$FF,$B3,$42
.byte $B6,$44,$C0,$01,$FF,$FF,$18,$EC,$00
T570_B599h:
.byte $FF,$FF,$8C,$B8,$4A,$47,$5B
.byte $52,$B8,$47,$A4,$AC,$AF,$6C,$5E,$B6,$C0,$01,$FF,$FF,$18,$EC,$00
T571_B5B0h:
.byte $FF,$A0,$66,$B3,$47,$3D,$4D,$B3,$66,$B7,$50,$45,$4F,$5D,$01,$FF
.byte $A7,$B8,$41,$A8,$44,$B6,$C0,$8C,$B2,$5B,$47,$91,$99,$C0,$00
T572_B5CFh:
.byte $FF
.byte $FF,$A0,$AB,$53,$BA,$AC,$46,$FF,$63,$66,$B1,$49,$AB,$40,$01,$FF
.byte $FF,$B6,$B3,$A8,$46,$C5,$00
T573_B5E7h:
.byte $FF,$FF,$A2,$45,$43,$AF,$4A,$A4,$A7
.byte $50,$AE,$B1,$B2,$BA,$49,$55,$B7,$01,$FF,$FF,$B6,$B3,$A8,$46,$C0

;; [$B600 :: 0x2B600]

.byte $00
T574_B601h:
.byte $FF,$FF,$A2,$45,$FF,$55,$62,$49,$B2,$53,$B0,$3F,$BC,$01,$FF
.byte $FF,$B6,$B3,$A8,$46,$B6,$C0,$00
T575_B618h:
.byte $01,$FF,$FF,$FF,$97,$B2,$3D,$3C
.byte $AA,$49,$53,$63,$66,$B1,$C0,$00
T576_B628h:
.byte $FF,$FF,$A2,$45,$4B,$3F,$FF,$44
.byte $AF,$50,$B6,$A4,$62,$FF,$44,$01,$FF,$49,$54,$4C,$51,$AF,$48,$B0
.byte $A4,$B3,$C0,$00
T577_B644h:
.byte $17,$05,$1B,$00,$17,$05,$1B,$00,$01,$17,$05,$1B
.byte $01,$17,$05,$1B,$01,$01,$17,$05,$1B,$02,$17,$05,$1B,$02,$01,$17
.byte $05,$1B,$03,$17,$05,$1B,$03,$01,$17,$05,$1B,$04,$17,$05,$1B,$04
.byte $01,$17,$05,$1B,$05,$17,$05,$1B,$05,$01,$17,$05,$1B,$06,$17,$05
.byte $1B,$06,$01,$17,$05,$1B,$07,$17,$05,$1B,$07,$01,$17,$05,$1B,$08
.byte $17,$05,$1B,$08,$01,$17,$05,$1B,$09,$17,$05,$1B,$09,$01,$17,$05
.byte $1B,$0A,$17,$05,$1B,$0A,$01,$17,$05,$1B,$0B,$17,$05,$1B,$0B,$01
.byte $17,$05,$1B,$0C,$17,$05,$1B,$0C,$01,$17,$05,$1B,$0D,$17,$05,$1B
.byte $0D,$01,$17,$05,$1B,$0E,$17,$05,$1B,$0E,$01,$17,$05,$1B,$0F,$17
.byte $05,$1B,$0F,$00
T578_B6D4h:
.byte $17,$01,$1A,$00,$17,$0B,$1A,$01,$01,$17,$01,$1A
.byte $02,$17,$0B,$1A,$03,$01,$17,$01,$1A,$04,$17,$0B,$1A,$05,$01,$17
.byte $01,$1A,$06,$17,$0B,$1A,$07,$01,$17,$01,$1A,$08,$17,$0B,$1A,$09

;; [$B700 :: 0x2B700]

.byte $01,$17,$01,$1A,$0A,$17,$0B,$1A,$0B,$01,$17,$01,$1A,$0C,$17,$0B
.byte $1A,$0D,$01,$17,$01,$1A,$0E,$17,$0B,$1A,$0F,$01,$17,$01,$1A,$10
.byte $17,$0B,$1A,$11,$01,$17,$01,$1A,$12,$17,$0B,$1A,$13,$01,$17,$01
.byte $1A,$14,$17,$0B,$1A,$15,$01,$17,$01,$1A,$16,$17,$0B,$1A,$17,$01
.byte $17,$01,$1A,$18,$17,$0B,$1A,$19,$01,$17,$01,$1A,$1A,$17,$0B,$1A
.byte $1B,$01,$17,$01,$1A,$1C,$17,$0B,$1A,$1D,$01,$17,$01,$1A,$1E,$17
.byte $0B,$1A,$1F,$00
T579_B764h:
.byte $01,$01,$14,$0B,$C5,$FF,$00
T580_B76Bh:
.byte $A2,$45,$4B,$3F,$E0
.byte $FF,$B8,$B6,$4D,$3D,$40,$C0,$00
T581_B778h:
.byte $FF,$FF,$FF,$FF,$14,$07,$10,$02
.byte $01,$FF,$FF,$FF,$FF,$00
T582_B786h:
.byte $17,$01,$8A,$17,$03,$8B,$17,$05,$8C,$17
.byte $07,$8D,$17,$09,$8E,$17,$0C,$A4,$17,$0E,$A5,$17,$10,$A6,$17,$12
.byte $A7,$17,$14,$A8,$01,$17,$01,$8F,$17,$03,$90,$17,$05,$91,$17,$07
.byte $92,$17,$09,$93,$17,$0C,$A9,$17,$0E,$AA,$17,$10,$AB,$17,$12,$AC
.byte $17,$14,$AD,$01,$17,$01,$94,$17,$03,$95,$17,$05,$96,$17,$07,$97
.byte $17,$09,$98,$17,$0C,$AE,$17,$0E,$AF,$17,$10,$B0,$17,$12,$B1,$17
.byte $14,$B2,$01,$17,$01,$99,$17,$03,$9A,$17,$05,$9B,$17,$07,$9C,$17
.byte $09,$9D,$17,$0C,$B3,$17,$0E,$B4,$17,$10,$B5,$17,$12,$B6,$17,$14

;; [$B800 :: 0x2B800]

.byte $B7,$01,$17,$01,$9E,$17,$03,$9F,$17,$05,$A0,$17,$07,$A1,$17,$09
.byte $A2,$17,$0C,$B8,$17,$0E,$B9,$17,$10,$BA,$17,$12,$BB,$17,$14,$BC
.byte $01,$17,$01,$A3,$17,$03,$FF,$17,$05,$FF,$17,$07,$FF,$17,$09,$FF
.byte $17,$0C,$BD,$17,$0E,$FF,$17,$10,$FF,$17,$12,$FF,$17,$14,$FF,$00
T583_B840h:
.byte $FF,$8A,$B1,$FF,$A8,$B1,$42,$AA,$50,$A9,$AC,$A8,$AF,$48,$B3,$4A
.byte $62,$5E,$B6,$01,$67,$45,$69,$B5,$B2,$B0,$4C,$66,$B3,$3C,$AA,$FF
.byte $45,$B7,$C0,$00
T584_B864h:
.byte $8A,$47,$BC,$45,$FF,$B3,$B5,$A4,$BC,$BF,$A4,$4C
.byte $66,$B0,$FF,$64,$68,$B7,$01,$A8,$B1,$62,$AF,$B2,$B3,$47,$BC,$45
.byte $43,$57,$43,$FF,$B9,$B2,$AC,$A6,$A8,$01,$A9,$AC,$46,$3E,$4C,$58
.byte $AB,$4B,$B2,$B0,$B3,$6A,$B6,$61,$B1,$01,$A8,$A6,$AB,$B2,$5A,$C1
.byte $01,$9C,$45,$AF,$49,$55,$4F,$BA,$3F,$59,$B5,$47,$3C,$01,$59,$52
.byte $AB,$BF,$4A,$B7,$B8,$B5,$B1,$FF,$B1,$B2,$BA,$69,$B5,$B2,$B0,$49
.byte $55,$B7,$01,$A7,$40,$B7,$3F,$4F,$AF,$3F,$48,$BA,$54,$4A,$FF,$B6
.byte $51,$B5,$B2,$BA,$01,$3F,$48,$A7,$66,$AE,$B1,$5A,$47,$AB,$B2,$AF
.byte $48,$BA,$A4,$BC,$C4,$00
;; TEXT??
;; [$B8E6-
T585_B8E6h:
.byte $FF,$8A,$FF,$AF,$44,$AA,$C2,$64,$62,$48
.byte $B3,$56,$A6,$4D,$40,$FF,$B2,$62,$B5,$C0,$01,$9D,$54,$FF,$18,$F0

;; [$B900 :: 0x2B900]
; Some data
.byte $FF,$5D,$FF,$18,$F4,$FF,$55,$B6,$01,$B6,$B8,$B0,$B0,$44,$3E,$6B
.byte $44,$5B,$42,$47,$A9,$B5,$B2,$B0,$FF,$91,$A8,$46,$01,$49,$53,$A5
.byte $A8,$AA,$3C,$FF,$AB,$40,$4B,$A4,$B0,$B3,$A4,$AC,$AA,$B1,$69,$51
.byte $01,$BA,$51,$AF,$48,$A6,$44,$B4,$B8,$5A,$B7,$C0,$8A,$FF,$4A,$A5
.byte $A8,$AF,$43,$B5,$B0,$BC,$01,$66,$B2,$B6,$4D,$3C,$49,$54,$FF,$94
.byte $3C,$AA,$A7,$B2,$B0,$FF,$5D,$FF,$18,$2F,$01,$49,$53,$5B,$B2,$B3
.byte $49,$54,$FF,$8E,$B0,$B3,$AC,$4A,$C0,$91,$B2,$BA,$A8,$62,$B5,$BF
.byte $01,$FF,$8C,$6A,$B7,$63,$FF,$18,$2F,$FF,$55,$47,$A9,$A4,$46,$A8
.byte $B1,$BF,$3F,$A7,$01,$49,$54,$FF,$4A,$A5,$A8,$AF,$47,$5A,$A6,$A4
.byte $B3,$3E,$49,$53,$3D,$A8,$01,$49,$B2,$BA,$B1,$FF,$5D,$FF,$8A,$AF
.byte $B7,$A4,$AC,$B5,$C0,$8F,$45,$B5,$67,$45,$3D,$B6,$01,$FF,$69,$B5
.byte $B2,$B0,$FF,$18,$2F,$BF,$3D,$A8,$AC,$B5,$FF,$B3,$66,$A8,$5E,$B6
.byte $01,$FF,$AE,$AC,$46,$3E,$4E,$50,$3D,$4D,$8E,$B0,$B3,$AC,$4A,$BF
.byte $A9,$63,$A8,$01,$FF,$FF,$69,$B5,$B2,$B0,$5C,$B0,$B3,$42,$AC,$A4
.byte $AF,$69,$51,$A6,$5A,$C3,$00
T586_B9E7h:
.byte $FF,$FF,$10,$02,$14,$09,$91,$99,$FF
.byte $10,$20,$7A,$10,$21,$01,$9C,$B3,$A8,$3E,$FF,$06,$FF,$FF,$96,$99

;; [$BA00 :: 0x2BA00]

.byte $FF,$FF,$10,$22,$7A,$FF,$10,$23,$00
T587_BA09h:
.byte $FF,$97,$A8,$BA,$FF,$90,$A4
.byte $6C,$FF,$FF,$FF,$9C,$B3,$A8,$3E,$C1,$FF,$06,$00
T588_BA1Ch:
.byte $9B,$A8,$A6,$A8
.byte $AC,$62,$48,$02,$C4,$01,$01,$01,$01,$8A,$6B,$44,$5B,$42,$43,$B3
.byte $B3,$56,$4A,$A7,$C4,$01,$00
T589_BA37h:
.byte $FF,$FF,$A2,$45,$4B,$3F,$B1,$B2,$4F
.byte $A6,$B8,$B5,$4A,$5E,$AF,$50,$A6,$6A,$B7,$01,$FF,$6B,$A4,$AA,$AC
.byte $A6,$C0,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$01,$1A,$06,$17,$0A,$1A,$07,$01,$17,$01,$1A,$08,$17,$0A
.byte $1A,$09,$01,$17,$01,$1A,$0A,$17,$0A,$1A,$0B,$01,$17,$01,$1A,$0C
.byte $17,$0A,$1A,$0D,$01,$17,$01,$1A,$0E,$17,$0A,$1A,$0F,$01,$17,$01
.byte $1A,$10,$17,$0A,$1A,$11,$01,$17,$01,$1A,$12,$17,$0A,$1A,$13,$01
.byte $17,$01,$1A,$14,$17,$0A,$1A,$15,$01,$17,$01,$1A,$16,$17,$0A,$1A

;; [$BB00 :: 0x2BB00]

.byte $17,$01,$17,$01,$1A,$18,$17,$0A,$1A,$19,$01,$17,$01,$1A,$1A,$17
.byte $0A,$1A,$1B,$01,$17,$01,$1A,$1C,$17,$0A,$1A,$1D,$01,$17,$01,$1A
.byte $1E,$17,$0A,$1A,$1F,$00,$01,$01,$14,$0B,$C5,$FF,$00,$A2,$45,$FF
.byte $A6,$3F,$BE,$4F,$B8,$B6,$4D,$B7,$AB,$40,$C0,$00,$FF,$FF,$FF,$FF
.byte $14,$07,$10,$02,$01,$FF,$FF,$FF,$FF,$00,$17,$01,$8A,$17,$03,$8B
.byte $17,$05,$8C,$17,$07,$8D,$17,$09,$8E,$17,$0C,$A4,$17,$0E,$A5,$17
.byte $10,$A6,$17,$12,$A7,$17,$14,$A8,$01,$17,$01,$8F,$17,$03,$90,$17
.byte $05,$91,$17,$07,$92,$17,$09,$93,$17,$0C,$A9,$17,$0E,$AA,$17,$10
.byte $AB,$17,$12,$AC,$17,$14,$AD,$01,$17,$01,$94,$17,$03,$95,$17,$05
.byte $96,$17,$07,$97,$17,$09,$98,$17,$0C,$AE,$17,$0E,$AF,$17,$10,$B0
.byte $17,$12,$B1,$17,$14,$B2,$01,$17,$01,$99,$17,$03,$9A,$17,$05,$9B
.byte $17,$07,$9C,$17,$09,$9D,$17,$0C,$B3,$17,$0E,$B4,$17,$10,$B5,$17
.byte $12,$B6,$17,$14,$B7,$01,$17,$01,$9E,$17,$03,$9F,$17,$05,$A0,$17
.byte $07,$A1,$17,$09,$A2,$17,$0C,$B8,$17,$0E,$B9,$17,$10,$BA,$17,$12
.byte $BB,$17,$14,$BC,$01,$17,$01,$A3,$17,$03,$FF,$17,$05,$FF,$17,$07
.byte $11,$00,$01,$10,$06,$00,$01,$1F,$07,$0F,$03,$00,$01,$80,$01,$40

;; [$BC00 :: 0x2BC00]

.byte $01,$00,$01,$20,$01,$00,$03,$F8,$01,$78,$02,$38,$02,$18,$01,$00
.byte $01,$42,$06,$00,$01,$7E,$07,$3C,$01,$00,$01,$20,$06,$00,$01,$3E
.byte $02,$1E,$05,$1F,$01,$00,$01,$44,$06,$00,$01,$7C,$07,$38,$08,$00
.byte $08,$03,$08,$00,$06,$C0,$02,$E0,$01,$00,$01,$84,$06,$00,$01,$FC
.byte $07,$78,$03,$00,$01,$04,$01,$00,$01,$08,$02,$00,$03,$3F,$02,$3B
.byte $03,$33,$03,$00,$01,$20,$01,$00,$01,$10,$02,$00,$03,$FC,$02,$DC
.byte $03,$CC,$03,$00,$01,$03,$04,$00,$01,$07,$02,$0F,$05,$1C,$01,$00
.byte $01,$01,$06,$00,$01,$81,$02,$C0,$05,$E0,$01,$00,$01,$0A,$04,$00
.byte $01,$80,$01,$00,$01,$FB,$04,$F1,$01,$F9,$02,$7B,$01,$00,$01,$20
.byte $05,$00,$01,$40,$01,$E0,$06,$C0,$01,$80,$08,$00,$08,$0F,$01,$00
.byte $01,$10,$02,$00,$01,$08,$03,$00,$01,$18,$02,$08,$01,$28,$02,$20
.byte $02,$60,$08,$00,$08,$3C,$08,$00,$08,$1F,$08,$00,$03,$38,$05,$B8
.byte $08,$00,$08,$07,$08,$00,$08,$E0,$08,$00,$08,$78,$01,$10,$02,$00
.byte $01,$20,$04,$00,$03,$23,$05,$03,$01,$08,$02,$00,$01,$04,$04,$00
.byte $03,$C4,$05,$C0,$06,$00,$01,$10,$01,$00,$03,$1C,$03,$1E,$01,$0E
.byte $01,$0F,$04,$00,$01,$20,$01,$40,$01,$80,$01,$00,$04,$E0,$01,$C0

;; [$BD00 :: 0x2BD00]

.byte $01,$80,$07,$00,$01,$40,$02,$00,$03,$7B,$02,$7F,$03,$3F,$05,$00
.byte $01,$80,$02,$00,$05,$80,$07,$00,$01,$80,$01,$40,$02,$00,$04,$E0
.byte $01,$60,$03,$20,$02,$00,$01,$02,$04,$00,$01,$01,$02,$1F,$05,$1D
.byte $01,$1C,$08,$00,$03,$B8,$05,$F8,$01,$00,$01,$01,$06,$00,$01,$07
.byte $02,$06,$05,$0E,$07,$00,$01,$80,$07,$F0,$01,$70,$08,$00,$08,$C0
.byte $01,$00,$01,$08,$01,$00,$01,$04,$01,$02,$01,$00,$01,$01,$01,$00
.byte $01,$0F,$02,$07,$01,$03,$02,$01,$01,$02,$01,$06,$09,$00,$02,$80
.byte $01,$C0,$03,$E0,$01,$F0,$03,$00,$01,$20,$01,$01,$03,$00,$03,$3F
.byte $01,$1F,$04,$1E,$01,$20,$17,$00,$08,$1C,$05,$00,$01,$80,$02,$00
.byte $05,$F8,$03,$78,$08,$00,$04,$0E,$01,$1E,$03,$1F,$08,$00,$03,$70
.byte $02,$78,$03,$F8,$08,$00,$05,$40,$03,$C0,$08,$00,$02,$0E,$06,$1E
.byte $01,$80,$07,$00,$02,$70,$06,$78,$08,$00,$08,$1E,$07,$00,$01,$1F
.byte $06,$0F,$01,$1F,$08,$00,$01,$80,$06,$00,$01,$80,$08,$00,$01,$7E
.byte $06,$3C,$01,$7E,$08,$00,$01,$3E,$06,$1C,$01,$3E,$04,$00,$01,$40
.byte $03,$00,$01,$38,$03,$78,$04,$38,$01,$00,$01,$01,$01,$02,$05,$00
.byte $01,$3E,$01,$1E,$05,$1C,$01,$3E,$01,$00,$01,$80,$06,$00,$01,$FC

;; [$BE00 :: 0x2BE00]

.byte $06,$78,$01,$FC,$08,$00,$01,$7F,$01,$78,$02,$79,$01,$7B,$03,$7F
.byte $08,$00,$08,$C0,$08,$00,$01,$07,$06,$03,$01,$07,$08,$00,$01,$E0
.byte $06,$C0,$01,$E0,$04,$00,$01,$10,$02,$00,$01,$08,$01,$07,$03,$1E
.byte $02,$0E,$01,$0F,$01,$07,$04,$00,$01,$08,$02,$00,$01,$10,$01,$E0
.byte $03,$78,$02,$70,$01,$F0,$01,$E0,$08,$00,$01,$3F,$06,$1E,$01,$3F
.byte $01,$00,$A7,$FF,$02,$C0,$01,$01,$01,$01,$FF,$FF,$8B,$B8,$4F,$B6
.byte $B8,$A7,$A7,$A8,$B1,$AF,$BC,$BF,$01,$FF,$FF,$B0,$44,$B6,$B7,$42
.byte $B6,$43,$B3,$B3,$56,$B5,$C4,$01,$00,$FF,$FF,$A2,$45,$FF,$A6,$3F
.byte $B1,$B2,$4F,$A6,$B8,$B5,$4A,$B1,$B7,$AF,$50,$A6,$A4,$5B,$01,$FF
.byte $FF,$B0,$A4,$AA,$AC,$A6,$C0,$00,$5B,$FF,$A5,$A8,$AB,$3C,$A7,$C3
.byte $01,$00,$FF,$FF,$10,$02,$14,$09,$91,$99,$FF,$10,$20,$7A,$10,$21
.byte $01,$9C,$B3,$A8,$3E,$FF,$06,$FF,$FF,$96,$99,$FF,$FF,$10,$22,$7A
.byte $FF,$10,$23,$00,$FF,$97,$A8,$BA,$FF,$90,$A4,$B0,$4D,$FF,$FF,$9C
.byte $B3,$A8,$3E,$C1,$FF,$06,$00,$FF,$FF,$99,$B5,$B2,$A6,$B8,$4A,$A7
.byte $FF,$02,$C0,$01,$01,$01,$01,$FF,$FF,$8B,$B8,$4F,$B6,$B8,$A7,$A7
.byte $A8,$B1,$AF,$BC,$BF,$01,$FF,$FF,$B0,$44,$B6,$B7,$42,$B6,$43,$B3

;; [$BF00 :: 0x2BF00]

.byte $B3,$56,$B5,$C4,$01,$00,$FF,$FF,$A2,$45,$FF,$A6,$3F,$B1,$B2,$4F
.byte $A6,$B8,$B5,$4A,$B1,$B7,$AF,$50,$A6,$A4,$5B,$01,$FF,$FF,$B0,$A4
.byte $AA,$AC,$A6,$C0,$00,$B7,$FF,$A6,$B8,$B5,$B5,$A8,$B1,$B7,$AF,$BC
.byte $FF,$A6,$A4,$B6,$B7,$01,$B0,$A4,$AA,$AC,$A6,$C0,$00,$B8,$A7,$A7
.byte $A8,$B1,$AF,$BC,$BF,$FF,$B0,$B2,$B1,$B6,$B7,$A8,$B5,$B6,$FF,$A4
.byte $B3,$B3,$A8,$A4,$B5,$C4,$00,$A2,$B2,$B8,$FF,$A6,$A4,$B1,$B1,$B2
.byte $B7,$FF,$A6,$B8,$B5,$B5,$A8,$B1,$B7,$AF,$BC,$FF,$A6,$A4,$B6,$B7
.byte $01,$B0,$A4,$AA,$AC,$A6,$C0,$00,$99,$8B,$49,$A3,$01,$FF,$A8,$A7
.byte $8C,$7B,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
T752_BFABh:
.byte $99,$B6,$B1,$C0,$00
T753_BFB0h:
.byte $9C,$7F,$A8,$B3,$00
T754_BFB5h:
.byte $9C,$D2,$B1,$C0,$00
T755_BFBAh:
.byte $96,$AC,$B1,$AC,$00
T756_BFBFh:
.byte $91
.byte $B2,$AF,$A7,$00
T757_BFC4h:
.byte $8C,$B1,$A9,$C0,$00
T758_BFC9h:
.byte $00
T759_BFCAh:
.byte $8B,$D3,$B1,$A7,$00
T760_BFCFh:
.byte $9F
.byte $B1,$B0,$C0,$00
T761_BFD4h:
.byte $8C,$B8,$B5,$B6,$00
T762_BFD9h:
.byte $8A,$B0,$B1,$C0,$00
T763_BFDEh:
.byte $9D,$B2
.byte $A4,$A7,$00
T764_BFE3h:
.byte $9C,$B7,$B1,$C0,$00
T765_BFE8h:
.byte $94,$98,$E1,$00,$00
T766_BFEDh:
.byte $9B,$AC,$68
.byte $B7,$00
T767_BFF2h:
.byte $95,$A8,$A9,$B7,$00,$00,$46,$B1,$90,$90,$00,$00,$00,$00
; ========== text2 ( 768 items) ($8600-$BFFF) END ==========


