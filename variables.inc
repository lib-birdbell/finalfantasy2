;; Zero page ;; 

tmp                = $00 ; $10 bytes I assume
open_tile_ID		= $0D

_1C_unknown		= $1C
_1D_unknown		= $1D
_1E_unknown		= $1E
_1F_unknown		= $1F

; abesudlr
key1p			= $20
new_btn			= $21
division_result    = $22
e_pressing		= $22
s_pressing		= $23
dialog_box	   = $24
a_pressing		= $24
b_pressing		= $25

_26_unknown		= $26

ow_x_pos		= $27
ow_y_pos		= $28
in_x_pos		= $29
in_y_pos		= $2A

_2B_unknown		= $2B
_2C_unknown		= $2C	; next overworld y position ??

;---- --hn
scroll_dir_map		= $2D
nt_y_pos		= $2F

_30_unknown		= $30
_31_unknown		= $31
map_update		= $32

;udlr
player_dir		= $33
;player_movement_speed	= $34
mov_spd			= $34
;player_horizontal/vertical_subtile_position
hor_stile_pos		= $35
ver_stile_pos		= $36

text_win_mode		= $37	; 0: map, 1: menu. PPU scroll variable?? - 01 = scroll disable
text_win_L		= $38
text_win_T		= $39
text_x			= $3A
text_y			= $3B
menu_win_W		= $3C
menu_win_H		= $3D
_3E_unknown		= $3E	; bank temp buffer ??
_3F_unknown		= $3F

oam_x			= $40
oam_y			= $41

; 01h:no vehicle, 02h:canoe/snowcraft, 04h:ship, 08h:airship
vehicle_ID		= $42
check_entrance		= $43	; ??

tile_prop		= $44	; ??
p_map1			= $45
p_map2			= $46
player_mv_timer		= $47
_48_unknown		= $48	; world map entrance ID ??
_49_unknown		= $49

_4E_unknown		= $4E

bank			= $57

ch_name1buf		= $5A
ch_name2buf		= $5B
ch_name3buf		= $5C
ch_name4buf		= $5D
ch_name5buf		= $5E
ch_name6buf		= $5F

_62_unknown		= $62
_63_unknown		= $63
_64_palette_tmp		= $64
_66_unknown		= $66
_67_unknown		= $67
_68_unknown		= $68
_69_unknown		= $69
_6A_unknown		= $6A

event			= $6C
map_water_cnt		= $6D

charstat_pointer   = $7A ; 2 bytes
charskill_pointer  = $7E ; 2 bytes
battlestat_pointer = $80 ; 2 bytes ; Pointer to Temp Battle Stats ($7D7A)

; map/field - move to local variables, maybe
cur_oam_tbl		= $80
cur_oam_tbl_L		= $80
cur_oam_tbl_H		= $81
cur_idx_base		= $82

_84_unknown		= $84
_85_unknown		= $85
_86_unknown		= $86
_87_unknown		= $86

text_x_offset		= $90
_91_unknown		= $91
text_ID			= $92
bank_tmp		= $93
text_bank		= $93
text_offset		= $94
_95_unknown		= $95		; text_offset_H ??
; 00h: dialogue - 28x10 at (2,2), 01h: yes/no, buy/sell/exit - 8x10 at (2,10)
; 02h: keyword/item select - 22x10 at (8,10), 03h: gil - 12x4 at (18,14)
win_type		= $96
_98_unknown		= $98

charstat_pointer2  = $A1 ; 2 bytes ; Mixed pointer? A1 = 7A, A2 = 81
_A2_unknown		= $A2
_A3_unknown		= $A3
_A4_unknown		= $A4

_AF_unknown		= $AF

entity_counter     = $9E 

SQ1FramePosition	= $B0

current_song_ID		= $E0
;	#$41 = title prelude
;	#$42 = suprise
;	#$43 = chocobo
;	#$44 = Main thema
;	#$45 = Main thema
;	#$46 = Main thema
;	#$47 = victory
;	#$48 = item get
;	#$49 = keyword get
;	#$4A = company joined
;	#$4B = pandemonium
;	#$4C = Castle
;	#$4D = crystal tower
;	#$4E = airplane
;	#$4F = doungueon
;	#$50 = viliage
;	#$51 = rebel_army
;	#$52 = battle
;	#$53 = final battle
;	#$54 = fall sound
;	#$55 = battle win
;	#$56 = game over
;	#$57 = lamia
;	#$58 = survive
;	#$59 = first meet
;	#$5A = escape
;	#$5B = celebrate
;	#$5C = warning
;	#$5D = ending
;	#$5E = laser?
;	#$5F = ??
_E5_unknown		= $E5

frame_cnt_L	   = $F0	; Timer, Increases by 1 every frame.
frame_cnt_H	   = $F1	; Timer, Increases by 1 Every time $F0 Overflows, Every time values hits a multiple of 40, the airship flies over the screen

rng_cnt			= $F5
rng_tbl_dir		= $F6

rng_cnt_bat		= $F7
_F8_unknown		= $F8

skip_intro		= $FA	; $77 is already saw the logo screen, else is Show logo screen.

ppu_con_p		= $FD
ppu_mask		= $FE
ppu_con_c		= $FF

palette_UBGC	   = $03C0
palette_BG00	   = $03C1
palette_BG01	   = $03C2
palette_BG02	   = $03C3
palette_BG10	   = $03C5
palette_BG11	   = $03C6
palette_BG12	   = $03C7
palette_BG20	   = $03C9
palette_BG21	   = $03CA
palette_BG22	   = $03CB
palette_BG30	   = $03CD
palette_BG31	   = $03CE
palette_BG32	   = $03CF
palette_UOAM	   = $03D0
palette_OAM00	   = $03D1
palette_OAM01	   = $03D2
palette_OAM02	   = $03D3
palette_OAM10	   = $03D5
palette_OAM11	   = $03D6
palette_OAM12	   = $03D7
palette_OAM20	   = $03D9
palette_OAM21	   = $03DA
palette_OAM22	   = $03DB
palette_OAM30	   = $03DD
palette_OAM31	   = $03DE
palette_OAM32	   = $03DF


;; Some kind of dialogue text buffer/box drawing stuff at $0780-07FF

; ppu address (hi) for text window attributes ($07D0-$07DF)
ppu_addr_H		= $07D0
; ppu address (lo) for text window attributes ($07E0-$07EF)
ppu_addr_L		= $07E0
; text window attribute data ($07F0-$07FF)
textwin_attr		= $07F0


;; ========== WORK RAM ==========

_6000_base_stat		= $6000
msg_spd			= $601F
; 00h: hidden, 01h: caaught, 02h: riding??, 80h: running away
;chocobo_stat		= $6008
;chocobo_x		= $6009
;chocobo_y		= $600A
chocobo_x_		= $623E
chocobo_y_		= $623F


; 20h=256bit
treasure_sw		= $6020
; 20h=256bit
; $6040-$604B(00-5F=96bit): npc with say/learn/item dialogue
; $604C-$6057(60-BF=96bit): npcs with dialogue only
; $6058-$605B(C0-DF=32bit): shop/ferry/inn/revive npcs
; $605C-$605F(E0-FF=32bit): event switches
event_npc_sw		= $6040
;inventory		= $6060
acq_keyword		= $6080

; saved guest character name ($6276-$627B)
sav_guest_name		= $6276

;; ========== SAVE RAM START ==========

sram_1                   = $6300
sram_2                   = $6600
sram_3                   = $6900
sram_4                   = $6C00

; $300 bytes
unsram                   = $6000
zeropage_5A              = unsram + $02FE
checksum                 = unsram + $02FF

pirateship_flag          = unsram + $00 ; $01 will trigger animation and fight scene; $02 gives total control over sailing
pirateship_x             = unsram + $01
pirateship_y             = unsram + $02
animated_movement        = unsram + $03 ; $C0 when riding ship in animation, $10 when in control of pirate ship?
airship_flag             = unsram + $04 ; $01 = airship visible, $02 = trigger animation?, $04 = in control of airship
airship_x                = unsram + $05
airship_y                = unsram + $06
airship_flyover          = unsram + $07 ; Counts down when airship is flying overhead 
; 00h: hidden, 01h: caaught, 02h: riding??, 80h: running away
; $02 = riding and in control of chocobo, $80 = animation?
chocobo_stat             = unsram + $08
chocobo_x                = unsram + $09
chocobo_y                = unsram + $0A
;                        = unsram + $0B
ship_flag                = unsram + $0C
ship_x                   = unsram + $0D
ship_y                   = unsram + $0E
;                        = unsram + $0F
ow_save_pos_x            = unsram + $10
ow_save_pos_y            = unsram + $11
mapcheckything           = unsram + $12 ; constantly read when moving in town (value = $36)
;                        = unsram + $13
dreadnaught_flag         = unsram + $14
dreadnaught_x            = unsram + $15
dreadnaught_y            = unsram + $16
;                        = unsram + $17
zeropage_42              = unsram + $18 ; 01 when saving? (copied over from zero page $42)
;                        = unsram + $19
key_items                = unsram + $1A ; becomes $02 when given Scott's Ring
key_items_2              = unsram + $1B ; there's 15 key items, so I assume it needs these bits too
gold                     = unsram + $1C ; gold low byte
;                        = unsram + $1D ; gold middle byte
;                        = unsram + $1E ; gold high byte
battlespeed              = unsram + $1F ; battle text Speed (-1 from option chosen on game start)
chest_flags              = unsram + $20 ; starts at $FF, then each bit is set to 0 when its corresponding chest is opened
event_flags              = unsram + $40 ; similar to chests, 1s get turned to 0s to influence the game's story progression
;                                       ; at least one visible effect is to make NPC sprites vanish
;6042 - Starts $8B, turns to $8A when given Scott's Ring
;6046 - Starts $7F, turns to $7E when using Wild Rose on bartender in third town. Then to $7C when given Scott's Ring. Flags character sprites vanishing?

inventory                = unsram + $60 ; $20 bytes
passwords                = unsram + $80 ; $10 bytes ; password item IDs start at $F1 and end at $FF
keywords                = unsram + $80 ; $10 bytes ; password item IDs start at $F1 and end at $FF

ch_stats_1		 = unsram + $0100
ch_stats_2		 = unsram + $0140
ch_stats_3		 = unsram + $0180
ch_stats_4		 = unsram + $01C0
ch_stats                 = unsram + $0100 ; $40 bytes per character, so use 00,40,80,C0 to index ch_stats
ch_id                    = ch_stats + $00 ; portrait and sprite; high bit set = don't display anything
;	00 = Firion
;	01 = Maria
;	02 = Guy
;	03 = Minwu
;	04 = Josef
;	05 = Gordon
;	06 = Leila
;	07 = Ricard
;	08 = Leon

ch_status              = ch_stats + $01
;	01 = Blind
;	02 = 
;	04 = Venom
;	08 = Cursed
;	10 = Amnesia
;	20 = Toad
;	40 = Stone
;	80 = Dead 

ch_names		= $6102
ch_name1		= ch_stats + $02 ; 6 bytes
ch_name2		= ch_stats + $03
ch_name3		= ch_stats + $04
ch_name4		= ch_stats + $05
ch_name5		= ch_stats + $06
ch_name6		= ch_stats + $07
ch_current_hp            = ch_stats + $08 ; 2 bytes, low then high
ch_max_hp                = ch_stats + $0A ; 2 bytes, low then high
ch_current_mp            = ch_stats + $0C ; 2 bytes, low then high
ch_max_mp                = ch_stats + $0E ; 2 bytes, low then high
ch_strength              = ch_stats + $10
ch_agility               = ch_stats + $11
ch_stamina               = ch_stats + $12
ch_intellect             = ch_stats + $13
ch_spirit                = ch_stats + $14
ch_mpower                = ch_stats + $15
ch_minaccuracy           = ch_stats + $16
ch_maxaccuracy           = ch_stats + $17
ch_attack                = ch_stats + $18
ch_head                  = ch_stats + $19 ; saved as item ID
ch_body                  = ch_stats + $1A
ch_hands                 = ch_stats + $1B
ch_righthand             = ch_stats + $1C
ch_lefthand              = ch_stats + $1D
ch_item1                 = ch_stats + $1E
ch_item2                 = ch_stats + $1F
ch_strength_real         = ch_stats + $20
ch_agility_real          = ch_stats + $21
ch_stamina_real          = ch_stats + $22
ch_intellect_real        = ch_stats + $23
ch_spirit_real           = ch_stats + $24
ch_mpower_real           = ch_stats + $25
ch_defense               = ch_stats + $26
ch_unknown1              = ch_stats + $27
ch_unknown2              = ch_stats + $28
ch_unknown3              = ch_stats + $29
ch_minevasion            = ch_stats + $2A
ch_maxevasion            = ch_stats + $2B
ch_min_mresist           = ch_stats + $2C
ch_max_mresist           = ch_stats + $2D
ch_unknown4              = ch_stats + $2E
ch_unknown5              = ch_stats + $2F
ch_spells                = ch_stats + $30 ; saved as item ID

ch_skills_1		= ch_stats + $0100
ch_skills_2		= ch_stats + $0140
ch_skills_3		= ch_stats + $0180
ch_skills_4		= ch_stats + $01C0
ch_skills                = ch_stats + $0100 ; $40 per character
unarmed_level            = ch_skills + $00
unarmed_exp              = ch_skills + $01
shield_level             = ch_skills + $02
shield_exp               = ch_skills + $03
dagger_level             = ch_skills + $04
dagger_exp               = ch_skills + $05
staff_level              = ch_skills + $06
staff_exp                = ch_skills + $07
spear_level              = ch_skills + $08
spear_exp                = ch_skills + $09
sword_level              = ch_skills + $0A
sword_exp                = ch_skills + $0B
axe_level                = ch_skills + $0C
axe_exp                  = ch_skills + $0D
bow_level                = ch_skills + $0E
bow_exp                  = ch_skills + $0F
spell_1_level            = ch_skills + $10
spell_1_exp              = ch_skills + $11
spell_2_level            = ch_skills + $12
spell_2_exp              = ch_skills + $13
spell_3_level            = ch_skills + $14
spell_3_exp              = ch_skills + $15
spell_4_level            = ch_skills + $16
spell_4_exp              = ch_skills + $17
spell_5_level            = ch_skills + $18
spell_5_exp              = ch_skills + $19
spell_6_level            = ch_skills + $1A
spell_6_exp              = ch_skills + $1B
spell_7_level            = ch_skills + $1C
spell_7_exp              = ch_skills + $1D
spell_8_level            = ch_skills + $1E
spell_8_exp              = ch_skills + $1F
spell_9_level            = ch_skills + $20
spell_9_exp              = ch_skills + $21
spell_10_level           = ch_skills + $22
spell_10_exp             = ch_skills + $23
spell_11_level           = ch_skills + $24
spell_11_exp             = ch_skills + $25
spell_12_level           = ch_skills + $26
spell_12_exp             = ch_skills + $27
spell_13_level           = ch_skills + $28
spell_13_exp             = ch_skills + $29
spell_14_level           = ch_skills + $2A
spell_14_exp             = ch_skills + $2B
spell_15_level           = ch_skills + $2C
spell_15_exp             = ch_skills + $2D
spell_16_level           = ch_skills + $2E
spell_16_exp             = ch_skills + $2F
battle_min_evasion       = ch_skills + $30
;                        = ch_skills + $31
battle_min_mresist       = ch_skills + $32
;                        = ch_skills + $33
;                        = ch_skills + $34
battle_row               = ch_skills + $35 ; $00 = back row, $01 = front row, $80 = no character portrait visible

;; ========== SAVE RAM END ==========



song_tempo		= $6F00
SQ1vol			= $6F04
SQ2vol			= $6F05
_6F06_unknown		= $6F06
SQ2_Note_Value		 = $6F1F
current_BGM_ID		 = $6F25
_6F26_unknown		= $6F26

; general buffer: map bg tilemap($7000-$7FFF)

obj_properties		= $7400
cur_tile_prop		= $7400
dest_tile_prop		= $7401
mov_rate		= $7402
rnd_mov_freq		= $7403

npc_properties		= $7500
npc_id			= $7500
npc_un1			= $7501
npc_x			= $7504
npc_y			= $7505
npc_x_stile_pos		= $7506
npc_y_stile_pos		= $7507
; a--- ---t interacted with player(a), touched by player(udlr)
npc_und			= $750D
npc_ani_L		= $750E
npc_ani_H		= $750F

cur_pos			= $78F0		; ??
len_cur_dat		= $78F1		; ??



battle_result            = $7B48 ; not sure yet
_7B49_unknown		= $7B49

statup_confirmation      = $7B62 ; 8 bytes, all $FF during testing 
; but the next $10 bytes are 3, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...













;; Battle Stats ;; 

battle_stats             = $7D7A ; #48 bytes per entity
btl_stat_minevasion      = battle_stats + $00
btl_stat_maxevasion      = battle_stats + $01
btl_stat_charstat29      = battle_stats + $02
btl_stat_min_mresist     = battle_stats + $03
btl_stat_max_mresist     = battle_stats + $04
btl_stat_charstat2E      = battle_stats + $05
btl_stat_unknown_0_1     = battle_stats + $06
btl_stat_unknown_14      = battle_stats + $07
btl_stat_ailment         = battle_stats + $08
btl_stat_unknown_0_2     = battle_stats + $09
btl_stat_current_hp_low  = battle_stats + $0A
btl_stat_current_hp_high = battle_stats + $0B
btl_stat_current_mp_low  = battle_stats + $0C
btl_stat_current_mp_high = battle_stats + $0D
btl_stat_max_hp_low      = battle_stats + $0E
btl_stat_max_hp_high     = battle_stats + $0F
btl_stat_max_mp_low      = battle_stats + $10
btl_stat_max_mp_high     = battle_stats + $11
btl_stat_intellect       = battle_stats + $12
btl_stat_spirit          = battle_stats + $13
;                        = battle_stats + $14
;                        = battle_stats + $15
;                        = battle_stats + $16
;                        = battle_stats + $17
btl_stat_minaccuracy     = battle_stats + $18
btl_stat_maxaccuracy     = battle_stats + $19
btl_stat_attack          = battle_stats + $1A
;                        = battle_stats + $1B
;                        = battle_stats + $1C
;                        = battle_stats + $1D
btl_stat_defense         = battle_stats + $1E
btl_stat_charstat27      = battle_stats + $1F
btl_stat_charstat28      = battle_stats + $20
;                        = battle_stats + $21
;                        = battle_stats + $22
;                        = battle_stats + $23
btl_stat_charstat2F      = battle_stats + $24
;                        = battle_stats + $25
;                        = battle_stats + $26
;                        = battle_stats + $27
;                        = battle_stats + $28
btl_stat_command         = battle_stats + $29 ; $00 = attack, $FE = flee
btl_stat_target          = battle_stats + $2A ; high bit set when targeting enemies 
;                        = battle_stats + $2B
btl_stat_ailmentbackup   = battle_stats + $2C
btl_stat_btlstat09backup = battle_stats + $2D
btl_stat_unknown         = battle_stats + $2E
btl_stat_unknown_2       = battle_stats + $2F



battle_magiclist         = $7CE3 ; List of spell item IDs for the character choosing a spell in battle

;; Command counters - rise when confirming attack, does not reset between turns; 4 bytes per character ;;
attack_counter           = $7CF3 ; 4 bytes
magic_counter            = $7CF7 ; 4 bytes

;; Stat level up counters ;; 
hp_levelup               = $7D6A ; 2 bytes per character, first 2 are Firion's, second 2 are Maria's... ; 8 bytes total
; a value of $06, $00 resulted in Firion gaining HP at battle's end

mp_levelup               = $7D72 ; 2 bytes per character, 8 bytes total

palette_RAM_idx		= $3F00


;; NES Registers ;;

PpuControl_2000          = $2000
PpuMask_2001             = $2001
PpuStatus_2002           = $2002
PpuScroll_2005           = $2005
PpuAddr_2006             = $2006
PpuData_2007             = $2007
Sq0Duty_4000             = $4000         
Sq0Sweep_4001            = $4001 
Sq0Timer_4002            = $4002 
Sq0Length_4003           = $4003
Sq1Duty_4004             = $4004  
Sq1Sweep_4005            = $4005 
Sq1Timer_4006            = $4006 
Sq1Length_4007           = $4007
TrgLinear_4008           = $4008
NoiseVolume_400C         = $400C
NoisePeriod_400E         = $400E
NoiseLength_400F         = $400F
DmcFreq_4010             = $4010
SpriteDma_4014           = $4014
ApuStatus_4015           = $4015
Ctrl1_4016               = $4016
Ctrl2_FrameCtr_4017      = $4017














