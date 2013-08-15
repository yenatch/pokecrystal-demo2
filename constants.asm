_CRYSTAL EQU 1

if _CRYSTAL
VERSION EQU 0
else
VERSION EQU 1
endc

INCLUDE "constants/pokemon_constants.asm"
INCLUDE "constants/move_constants.asm"
INCLUDE "constants/battle_constants.asm"
INCLUDE "constants/map_constants.asm"
INCLUDE "constants/item_constants.asm"
INCLUDE "constants/trainer_constants.asm"
INCLUDE "constants/script_constants.asm"
INCLUDE "constants/music_constants.asm"


; macros require rst vectors to be defined
FarCall    EQU $08
Bankswitch EQU $10
JumpTable  EQU $28


dwb: MACRO
	dw \1
	db \2
	ENDM

dbw: MACRO
	db \1
	dw \2
	ENDM

dn: MACRO
	db \1 << 4 + \2
	ENDM

bigdw: MACRO ; big-endian word
	dw ((\1)/$100) + (((\1)&$ff)*$100)
	ENDM

callab: MACRO ; address, bank
	ld hl, \1
	ld a, BANK(\1)
	rst FarCall
	ENDM

callba: MACRO ; bank, address
	ld a, BANK(\1)
	ld hl, \1
	rst FarCall
	ENDM

TX_RAM: MACRO
	db 1
	dw \1
	ENDM

TX_FAR: MACRO
	db $16
	dw \1
	db BANK(\1)
	ENDM

RGB: MACRO
	dw ((\3 << 10) | (\2 << 5) | (\1))
	ENDM

note: MACRO
	db \1
	ENDM

; It's better to use *coord than FuncCoord.
FuncCoord: MACRO
Coord = $c4a0 + 20 * \2 + \1
	ENDM

bccoord: MACRO
	FuncCoord \1, \2
	ld bc, Coord
	ENDM
	
decoord: MACRO
	FuncCoord \1, \2
	ld de, Coord
	ENDM

hlcoord: MACRO
	FuncCoord \1, \2
	ld hl, Coord
	ENDM


; pic animations
frame: MACRO
	db \1
	db \2
	ENDM
setrepeat: MACRO
	db $fe
	db \1
	ENDM
dorepeat: MACRO
	db $fd
	db \1
	ENDM
endanim: MACRO
	db $ff
	ENDM


NONE       EQU 0


; types
NORMAL   EQU $00
FIGHTING EQU $01
FLYING   EQU $02
POISON   EQU $03
GROUND   EQU $04
ROCK     EQU $05
BUG      EQU $07
GHOST    EQU $08
STEEL    EQU $09
CURSE_T  EQU $13
FIRE     EQU $14
WATER    EQU $15
GRASS    EQU $16
ELECTRIC EQU $17
PSYCHIC  EQU $18
ICE      EQU $19
DRAGON   EQU $1A
DARK     EQU $1B

; egg group constants
MONSTER       EQU $01
AMPHIBIAN     EQU $02
INSECT        EQU $03
AVIAN         EQU $04
FIELD         EQU $05
FAIRY         EQU $06
PLANT         EQU $07
HUMANSHAPE    EQU $08
INVERTEBRATE  EQU $09
INANIMATE     EQU $0A
AMORPHOUS     EQU $0B
FISH          EQU $0C
LADIES_MAN    EQU $0D
REPTILE       EQU $0E
NO_EGGS       EQU $0F

; menu sprites
ICON_POLIWAG       EQU $01
ICON_JIGGLYPUFF    EQU $02
ICON_DIGLETT       EQU $03
ICON_PIKACHU       EQU $04
ICON_STARYU        EQU $05
ICON_FISH          EQU $06
ICON_BIRD          EQU $07
ICON_MONSTER       EQU $08
ICON_CLEFAIRY      EQU $09
ICON_ODDISH        EQU $0a
ICON_BUG           EQU $0b
ICON_GHOST         EQU $0c
ICON_LAPRAS        EQU $0d
ICON_HUMANSHAPE    EQU $0e
ICON_FOX           EQU $0f
ICON_EQUINE        EQU $10
ICON_SHELL         EQU $11
ICON_BLOB          EQU $12
ICON_SERPENT       EQU $13
ICON_VOLTORB       EQU $14
ICON_SQUIRTLE      EQU $15
ICON_BULBASAUR     EQU $16
ICON_CHARMANDER    EQU $17
ICON_CATERPILLAR   EQU $18
ICON_UNOWN         EQU $19
ICON_GEODUDE       EQU $1a
ICON_FIGHTER       EQU $1b
ICON_EGG           EQU $1c
ICON_JELLYFISH     EQU $1d
ICON_MOTH          EQU $1e
ICON_BAT           EQU $1f
ICON_SNORLAX       EQU $20
ICON_HO_OH         EQU $21
ICON_LUGIA         EQU $22
ICON_GYARADOS      EQU $23
ICON_SLOWPOKE      EQU $24
ICON_SUDOWOODO     EQU $25
ICON_BIGMON        EQU $26


; evolution types
EVOLVE_LEVEL     EQU 1
EVOLVE_ITEM      EQU 2
EVOLVE_TRADE     EQU 3
EVOLVE_HAPPINESS EQU 4
EVOLVE_STAT      EQU 5

BASE_HAPPINESS   EQU 70
; happiness evolution triggers
HAPPINESS_TO_EVOLVE EQU 220
TR_ANYTIME EQU 1
TR_MORNDAY EQU 2
TR_NITE    EQU 3

; stat evolution triggers
ATK_GT_DEF EQU 1
ATK_LT_DEF EQU 2
ATK_EQ_DEF EQU 3


; name length
PLAYER_NAME_LENGTH EQU 8
PKMN_NAME_LENGTH EQU 11


; predefs
PREDEF_FLAG EQU $03
PREDEF_FILLPP EQU $05
PREDEF_ADDPARTYMON EQU $06
PREDEF_FILLSTATS EQU $0C
PREDEF_PRINT_MOVE_DESCRIPTION EQU $11
PREDEF_UPDATE_PLAYER_HUD EQU $12
PREDEF_FILL_BOX EQU $13
PREDEF_UPDATE_ENEMY_HUD EQU $15
PREDEF_FILL_IN_EXP_BAR EQU $17
PREDEF_FILLMOVES EQU $1B
PREDEF_GET_GENDER EQU $24
PREDEF_STATS_SCREEN EQU $25
PREDEF_DRAW_PLAYER_HP EQU $26
PREDEF_DRAW_ENEMY_HP EQU $27
PREDEF_GET_TYPE_NAME EQU $29
PREDEF_PRINT_MOVE_TYPE EQU $2A
PREDEF_PRINT_TYPE EQU $2B
PREDEF_GET_UNOWN_LETTER EQU $2D
PREDEF_LOAD_SGB_LAYOUT EQU $31
PREDEF_CHECK_CONTEST_MON EQU $33
PREDEF_PARTYMON_ITEM_NAME EQU $3B
PREDEF_DECOMPRESS EQU $40


; flag manipulation
RESET_FLAG EQU 0
SET_FLAG   EQU 1
CHECK_FLAG EQU 2


; joypad
BUTTONS    EQU %00010000
D_PAD      EQU %00100000

NO_INPUT   EQU %00000000
BUTTON_A   EQU %00000001
BUTTON_B   EQU %00000010
SELECT     EQU %00000100
START      EQU %00001000
D_RIGHT    EQU %00010000
D_LEFT     EQU %00100000
D_UP       EQU %01000000
D_DOWN     EQU %10000000


; screen
HP_BAR_LENGTH EQU 6
HP_BAR_LENGTH_PX EQU 48
EXP_BAR_LENGTH EQU 8
EXP_BAR_LENGTH_PX EQU 64

SCREEN_WIDTH EQU 20
SCREEN_HEIGHT EQU 18
SCREEN_WIDTH_PX EQU 160
SCREEN_HEIGHT_PX EQU 144

TILE_WIDTH EQU 8


; movement
STEP_SLOW EQU 0
STEP_WALK EQU 1
STEP_BIKE EQU 2
STEP_LEDGE EQU 3
STEP_ICE EQU 4
STEP_TURN EQU 5
STEP_BACK_LEDGE EQU 6
STEP_WALK_IN_PLACE EQU 7


