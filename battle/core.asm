; Core components of the battle engine.


Function3c000: ; 3c000
	xor a
	ld [$c664], a
	ld [$c6fc], a
	ld [$d0ec], a
	ld [BattleEnded], a
	inc a
	ld [$d264], a
	ld hl, OTPartyMon1CurHP
	ld bc, $002f
	ld d, $3
.asm_3c019
	inc d
	ld a, [hli]
	or [hl]
	jr nz, .asm_3c021
	add hl, bc
	jr .asm_3c019

.asm_3c021
	ld a, d
	ld [$d430], a
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3c031
	ld a, [$ffcb]
	cp $2
.data_3c02f
	db $28
	db $1b

.asm_3c031
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3c047
	xor a
	ld [$c718], a
	call Function3d834
	call Function3d867
	call Function3dc18
	call Function3d4e1

.asm_3c047
	ld c, $28
	call DelayFrame ; was DelayFrames
	call Function309d
	call Function3d873
	ld a, d
	and a
	jp z, LostBattle
	call Function30b4
	ld a, [BattleType]
	cp $2
	jp z, Function3c0e2
	cp $3
	jp z, Function3c0e2
	xor a
	ld [CurPartyMon], a
.asm_3c06b
	call Function3d887
	jr nz, .asm_3c076
	ld hl, CurPartyMon
	inc [hl]
	jr .asm_3c06b

.asm_3c076
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	inc a
	ld hl, PartyCount
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [CurPartySpecies], a
	ld [TempBattleMonSpecies], a
	ld hl, $c505
	ld a, $9
	call Function3d490
	call Function309d
	call Function3d57a
	call Function3da0d
	call Function3dab1
	call Function3f26d
	call Function3dbde
	call Function3dc18
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	call SetPlayerTurn
	call Function3dc23
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3c0df
	ld a, [$ffcb]
	cp $2
	jr nz, .asm_3c0df
	xor a
	ld [$c718], a
	call Function3d834
	call Function3d867
	call Function3dc18
	call Function3d4e1
	call SetEnemyTurn
	call Function3dc23

.asm_3c0df
	jp Function3c12f
; 3c0e2

Function3c0e2: ; 3c0e2
	jp Function3e139
; 3c0e5



Function3c0e5: ; 3c0e5
	call Function30b4
	ld a, [$d0ee]
	and $c0
	add $2
	ld [$d0ee], a
	ld a, [InLinkBattle]
	and a
	ld hl, $47bd
	jr z, .asm_3c115
	ld a, [$d0ee]
	and $c0
	ld [$d0ee], a
	ld hl, $47cf
	call Function3d2e0
	jr nc, .asm_3c115
	ld hl, $cd2a
	bit 4, [hl]
	jr nz, .asm_3c118
	ld hl, $5863

.asm_3c115
	call StdBattleTextBox

.asm_3c118
	call Function3ceec
	call Function3d2e0
	jr c, .asm_3c126

	ld de, SFX_RUN
	call PlaySFX

.asm_3c126
	call SetPlayerTurn
	ld a, 1
	ld [BattleEnded], a
	ret
; 3c12f

Function3c12f: ; 3c12f
	call Function3c1bf
	call Function3c3f5
	jp c, .asm_3c1be
	xor a
	ld [$c710], a
	ld [$c711], a
	ld [$d264], a
	ld [$c73f], a
	ld [$c740], a
	ld [CurDamage], a
	ld [$d257], a
	call Function3c27c
	call UpdateBattleMonInParty
	callba AIChooseMove
	call Function3d2f1
	jr nz, .asm_3c174
	callba Function100da5
	callba Function100641
	callba Function100dd8
	jp c, .asm_3c1be

.asm_3c174
	call Function3c410
	jr c, .asm_3c18a
.asm_3c179
	call Function3e139
	jr c, .asm_3c1be
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c1be
	ld a, [$d232]
	and a
	jr nz, .asm_3c1be

.asm_3c18a
	call Function3c434
	jr nz, .asm_3c179
	call Function3c300
	jr c, .asm_3c1be
	call Function3c314
	jr c, .asm_3c19e
	call Function3c5fe
	jr .asm_3c1a1

.asm_3c19e
	call Function3c664

.asm_3c1a1
	call Function3d2e0
	jr c, .asm_3c1be
	ld a, [$d232]
	and a
	jr nz, .asm_3c1be
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c1be
	call Function3c1d6
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c1be
	jp Function3c12f

.asm_3c1be
	ret
; 3c1bf

Function3c1bf: ; 3c1bf
	ret
; 3c1c0


Function3c1c0: ; 3c1c0
	ld a, $5
	call GetSRAMBank
	ld hl, $a89b
	inc [hl]
	jr nz, .asm_3c1d2
	dec hl
	inc [hl]
	jr nz, .asm_3c1d2
	dec [hl]
	inc hl
	dec [hl]

.asm_3c1d2
	call CloseSRAM
	ret
; 3c1d6


Function3c1d6: ; 3c1d6
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c1fe
	call Function3c23c
	ret c
	call Function3ca26
	call Function3c23c
	ret c
	call HandleWeather
	call Function3c23c
	ret c
	call Function3c874
	call Function3c23c
	ret c
	call Function3c801
	call Function3c23c
	ret c
	jr .asm_3c21e

.asm_3c1fe
	call Function3c25c
	ret c
	call Function3ca26
	call Function3c25c
	ret c
	call HandleWeather
	call Function3c25c
	ret c
	call Function3c874
	call Function3c25c
	ret c
	call Function3c801
	call Function3c25c
	ret c

.asm_3c21e
	call Function3c8eb
	call Function3c93c
	call Function3ca8f
	call Function3cafb
	call Function3cb36
	call Function3de97
	call Function3dcf9
	call UpdateBattleMonInParty
	call Function309d
	jp Function3c4df
; 3c23c

Function3c23c: ; 3c23c
	call Function3c710
	jr nz, .asm_3c24a
	call Function3d14e
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c25a

.asm_3c24a
	call Function3c70b
	jr nz, .asm_3c258
	call Function3cd55
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c25a

.asm_3c258
	and a
	ret

.asm_3c25a
	scf
	ret
; 3c25c

Function3c25c: ; 3c25c
	call Function3c70b
	jr nz, .asm_3c26a
	call Function3cd55
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c27a

.asm_3c26a
	call Function3c710
	jr nz, .asm_3c278
	call Function3d14e
	ld a, [BattleEnded]
	and a
	jr nz, .asm_3c27a

.asm_3c278
	and a
	ret

.asm_3c27a
	scf
	ret
; 3c27c

Function3c27c: ; 3c27c
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c287
	call .asm_3c28a
	jr .asm_3c296

.asm_3c287
	call .asm_3c296
.asm_3c28a
	call SetPlayerTurn
	ld de, PartyMon1Item
	ld a, [CurBattleMon]
	ld b, a
	jr .asm_3c2a0

.asm_3c296
	call SetEnemyTurn
	ld de, OTPartyMon1Item
	ld a, [CurOTMon]
	ld b, a

.asm_3c2a0
	push de
	push bc
	callab GetUserItem
	ld a, [hl]
	ld [$d265], a
	sub $98
	pop bc
	pop de
	ret nz
	ld [hl], a
	ld h, d
	ld l, e
	ld a, b
	call GetPartyLocation
	xor a
	ld [hl], a
	ld a, $2
	call _GetBattleVar
	push af
	set 7, [hl]
	ld a, $c
	call _GetBattleVar
	push hl
	push af
	xor a
	ld [hl], a
	ld [AttackMissed], a
	ld [EffectFailed], a
	callba BattleCommand77
	pop af
	pop hl
	ld [hl], a
	call GetItemName
	ld hl, $4bde
	call StdBattleTextBox
	callab BattleCommand8c
	pop af
	bit 7, a
	ret nz
	xor a
	ld [$cfca], a
	ld de, $0103
	call Function3ee0f
	call Function3c8e4
	ld hl, $4d97
	jp StdBattleTextBox
; 3c300

Function3c300: ; 3c300
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3c30d
	ld a, [$d430]
	cp $f
	jr z, .asm_3c30f

.asm_3c30d
	and a
	ret

.asm_3c30f
	call Function3c0e5
	scf
	ret
; 3c314

Function3c314: ; 3c314
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3c35b
	ld a, [$d430]
	cp $e
	jr z, .asm_3c35b
	cp $d
	jr z, .asm_3c35b
	sub $4
	jr c, .asm_3c35b
	ld a, [$d0ec]
	cp $2
	jr nz, .asm_3c34c
	ld a, [$ffcb]
	cp $2
	jr z, .asm_3c341
	call BattleRandom
	cp $80
	jp c, .asm_3c3f1
	jp Function3c3f3

.asm_3c341
	call BattleRandom
	cp $80
	jp c, Function3c3f3
	jp .asm_3c3f1

.asm_3c34c
	callab Function3846c
	call SetEnemyTurn
	call Function3dc23
	jp Function3c3f3

.asm_3c35b
	ld a, [$d0ec]
	and a
	jp nz, .asm_3c3f1
	call Function3c5b4
	jr z, .asm_3c36d
	jp c, .asm_3c3f1
	jp Function3c3f3

.asm_3c36d
	call SetPlayerTurn
	callab GetUserItem
	push bc
	callab GetOpponentItem
	pop de
	ld a, d
	cp $4a
	jr nz, .asm_3c391
	ld a, b
	cp $4a
	jr z, .asm_3c39f
	call BattleRandom
	cp e
	jr nc, .asm_3c3c5
	jp .asm_3c3f1

.asm_3c391
	ld a, b
	cp $4a
	jr nz, .asm_3c3c5
	call BattleRandom
	cp c
	jr nc, .asm_3c3c5
	jp Function3c3f3

.asm_3c39f
	ld a, [$ffcb]
	cp $2
	jr z, .asm_3c3b5
	call BattleRandom
	cp c
	jp c, Function3c3f3
	call BattleRandom
	cp e
	jp c, .asm_3c3f1
	jr .asm_3c3c5

.asm_3c3b5
	call BattleRandom
	cp e
	jp c, .asm_3c3f1
	call BattleRandom
	cp c
	jp c, Function3c3f3
	jr .asm_3c3c5

.asm_3c3c5
	ld de, BattleMonSpd
	ld hl, EnemyMonSpd
	ld c, $2
	call StringCmp
	jr z, .asm_3c3d8
	jp nc, .asm_3c3f1
	jp Function3c3f3

.asm_3c3d8
	ld a, [$ffcb]
	cp $2
	jr z, .asm_3c3e9
	call BattleRandom
	cp $80
	jp c, .asm_3c3f1
	jp Function3c3f3

.asm_3c3e9
	call BattleRandom
	cp $80
	jp c, Function3c3f3
.asm_3c3f1
	scf
	ret
; 3c3f3

Function3c3f3: ; 3c3f3
	and a
	ret
; 3c3f5

Function3c3f5: ; 3c3f5
	ld a, [BattleType]
	cp $6
	jr nz, .asm_3c40e
	ld a, [$dc79]
	and a
	jr nz, .asm_3c40e
	ld a, [$d0ee]
	and $c0
	add $2
	ld [$d0ee], a
	scf
	ret

.asm_3c40e
	and a
	ret
; 3c410

Function3c410: ; 3c410
	ld a, [PlayerSubStatus4]
	and $20
	jp nz, Function3c432
	ld hl, EnemySubStatus3
	res 3, [hl]
	ld hl, PlayerSubStatus3
	res 3, [hl]
	ld a, [hl]
	and $12
	jp nz, Function3c432
	ld hl, PlayerSubStatus1
	bit 6, [hl]
	jp nz, Function3c432
	and a
	ret
; 3c432

Function3c432: ; 3c432
	scf
	ret
; 3c434

Function3c434: ; 3c434
	call Function3c410
	jp c, .asm_3c4ba
	ld hl, PlayerSubStatus5
	bit 4, [hl]
	jr z, .asm_3c449
	ld a, [LastPlayerMove]
	ld [CurPlayerMove], a
	jr .asm_3c47c

.asm_3c449
	ld a, [$d0ec]
	cp $2
	jr z, .asm_3c4ce
	and a
	jr nz, .asm_3c4b5
	ld a, [PlayerSubStatus3]
	and $1
	jr nz, .asm_3c4ba
	xor a
	ld [$d235], a
	inc a
	ld [FXAnimIDLo], a
	call Function3e4bc
	push af
	call Function30b4
	call UpdateBattleHuds
	ld a, [CurPlayerMove]
	cp $a5
	jr z, .asm_3c476
	call PlayClickSFX

.asm_3c476
	ld a, $1
	ld [hBGMapMode], a
	pop af
	ret nz

.asm_3c47c
	call SetPlayerTurn
	callab UpdateMoveData
	xor a
	ld [$c732], a
	ld a, [PlayerMoveEffect]
	cp $77
	jr z, .asm_3c494
	xor a
	ld [PlayerFuryCutterCount], a

.asm_3c494
	ld a, [PlayerMoveEffect]
	cp $51
	jr z, .asm_3c4a4
	ld hl, PlayerSubStatus4
	res 6, [hl]
	xor a
	ld [$c72b], a

.asm_3c4a4
	ld a, [PlayerMoveEffect]
	cp $6f
	jr z, .asm_3c4c9
	cp $74
	jr z, .asm_3c4c9
	xor a
	ld [$c679], a
	jr .asm_3c4c9

.asm_3c4b5
	ld hl, PlayerSubStatus3
	res 0, [hl]

.asm_3c4ba
	xor a
	ld [PlayerFuryCutterCount], a
	ld [$c679], a
	ld [$c72b], a
	ld hl, PlayerSubStatus4
	res 6, [hl]

.asm_3c4c9
	call Function3e7c1
	xor a
	ret

.asm_3c4ce
	xor a
	ld [PlayerFuryCutterCount], a
	ld [$c679], a
	ld [$c72b], a
	ld hl, PlayerSubStatus4
	res 6, [hl]
	xor a
	ret
; 3c4df

Function3c4df: ; 3c4df
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c4ea
	call .asm_3c4ed
	jr .asm_3c518

.asm_3c4ea
	call .asm_3c518
.asm_3c4ed
	ld hl, PlayerSubStatus5
	bit 4, [hl]
	ret z
	ld a, [PlayerEncoreCount]
	dec a
	ld [PlayerEncoreCount], a
	jr z, .asm_3c50a
	ld hl, BattleMonPPMove1
	ld a, [CurMoveNum]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	and $3f
	ret nz

.asm_3c50a
	ld hl, PlayerSubStatus5
	res 4, [hl]
	call SetEnemyTurn
	ld hl, $4c8a
	jp StdBattleTextBox

.asm_3c518
	ld hl, EnemySubStatus5
	bit 4, [hl]
	ret z
	ld a, [EnemyEncoreCount]
	dec a
	ld [EnemyEncoreCount], a
	jr z, .asm_3c535
	ld hl, EnemyMonPPMove1
	ld a, [CurEnemyMoveNum]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	and $3f
	ret nz

.asm_3c535
	ld hl, EnemySubStatus5
	res 4, [hl]
	call SetPlayerTurn
	ld hl, $4c8a
	jp StdBattleTextBox
; 3c543


Function3c543: ; 3c543
	ld a, [IsInBattle]
	dec a
	jr nz, .Stay

	ld a, [PlayerSubStatus5]
	bit 7, a
	jr nz, .Stay

	ld a, [$c731]
	and a
	jr nz, .Stay

	ld a, [EnemyMonStatus]
	and 1 << FRZ | SLP
	jr nz, .Stay

	ld a, [TempEnemyMonSpecies]
	ld de, 1
	ld hl, AlwaysFleeMons
	call IsInArray
	jr c, .Flee

	call BattleRandom
	ld b, a
	cp $80
	jr nc, .Stay

	push bc
	ld a, [TempEnemyMonSpecies]
	ld de, 1
	ld hl, OftenFleeMons
	call IsInArray
	pop bc
	jr c, .Flee

	ld a, b
	cp $1a
	jr nc, .Stay

	ld a, [TempEnemyMonSpecies]
	ld de, 1
	ld hl, SometimesFleeMons
	call IsInArray
	jr c, .Flee

.Stay
	and a
	ret

.Flee
	scf
	ret
; 3c59a

FleeMons:

SometimesFleeMons: ; 3c59a
	db MAGNEMITE
	db GRIMER
	db TANGELA
	db MR__MIME
	db EEVEE
	db PORYGON
	db DRATINI
	db DRAGONAIR
	db TOGETIC
	db UMBREON
	db UNOWN
	db SNUBBULL
	db HERACROSS
	db -1

OftenFleeMons: ; 3c5a8
	db CUBONE
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db QUAGSIRE
	db DELIBIRD
	db PHANPY
	db TEDDIURSA
	db -1

AlwaysFleeMons: ; 3c5b1
	db RAIKOU
	db ENTEI
;	db SUICUNE
	db -1
; 3c5b4


Function3c5b4: ; 3c5b4
	ld a, [CurPlayerMove]
	call GetMovePriority
	ld b, a
	push bc
	ld a, [CurEnemyMove]
	call GetMovePriority
	pop bc
	cp b
	ret
; 3c5c5

GetMovePriority: ; 3c5c5
	ld b, a
	cp VITAL_THROW
	ld a, 0
	ret z
	call Function3c5ec
	ld hl, .data_3c5df
.loop
	ld a, [hli]
	cp b
	jr z, .asm_3c5dd
	inc hl
	cp $ff
	jr nz, .loop
	ld a, 1
	ret

.asm_3c5dd
	ld a, [hl]
	ret
; 3c5df

.data_3c5df
	db EFFECT_PROTECT,      3
	db EFFECT_ENDURE,       3
	db EFFECT_PRIORITY_HIT, 2
	db EFFECT_WHIRLWIND,    0
	db EFFECT_COUNTER,      0
	db EFFECT_MIRROR_COAT,  0
	db $ff
; 3c5ec


Function3c5ec: ; 3c5ec
	ld a, b
	dec a
	ld hl, $5afc
	ld bc, $0007
	call AddNTimes
	ld a, $10
	call GetFarByte
	ld b, a
	ret
; 3c5fe

Function3c5fe: ; 3c5fe
	call Function309d
	call Function3c543
	jp c, Function3c0e5
	call SetEnemyTurn
	ld a, $1
	ld [$c70f], a
	callab Function38000
	jr c, .asm_3c62f
	call Function3c6de
	call Function3d2e0
	ret c
	ld a, [$d232]
	and a
	ret nz
	call Function3c710
	jp z, Function3d14e
	call Function3c70b
	jp z, Function3cd55

.asm_3c62f
	call SetEnemyTurn
	call Function3c716
	jp z, Function3cd55
	call RefreshBattleHuds
	call Function3c6cf
	call Function3d2e0
	ret c
	ld a, [$d232]
	and a
	ret nz
	call Function3c70b
	jp z, Function3cd55
	call Function3c710
	jp z, Function3d14e
	call SetPlayerTurn
	call Function3c716
	jp z, Function3d14e
	call RefreshBattleHuds
	xor a
	ld [$d0ec], a
	ret
; 3c664

Function3c664: ; 3c664
	xor a
	ld [$c70f], a
	call SetEnemyTurn
	callab Function38000
	push af
	call Function3c6cf
	pop bc
	ld a, [$d232]
	and a
	ret nz
	call Function3d2e0
	ret c
	call Function3c70b
	jp z, Function3cd55
	call Function3c710
	jp z, Function3d14e
	push bc
	call SetPlayerTurn
	call Function3c716
	pop bc
	jp z, Function3d14e
	push bc
	call RefreshBattleHuds
	pop af
	jr c, .asm_3c6be
	call Function309d
	call Function3c543
	jp c, Function3c0e5
	call Function3c6de
	call Function3d2e0
	ret c
	ld a, [$d232]
	and a
	ret nz
	call Function3c710
	jp z, Function3d14e
	call Function3c70b
	jp z, Function3cd55

.asm_3c6be
	call SetEnemyTurn
	call Function3c716
	jp z, Function3cd55
	call RefreshBattleHuds
	xor a
	ld [$d0ec], a
	ret
; 3c6cf

Function3c6cf: ; 3c6cf
	call SetPlayerTurn
	call Function3c6fe
	callab DoPlayerTurn
	jp Function3c6ed
; 3c6de

Function3c6de: ; 3c6de
	call SetEnemyTurn
	call Function3c6fe
	callab DoEnemyTurn
	jp Function3c6ed
; 3c6ed

Function3c6ed: ; 3c6ed
	ld a, $5
	call _GetBattleVar
	res 2, [hl]
	res 5, [hl]
	ld a, $9
	call _GetBattleVar
	res 6, [hl]
	ret
; 3c6fe

Function3c6fe: ; 3c6fe
	ld a, $4
	call _GetBattleVar
	res 6, [hl]
	ret
; 3c706

Function3c706: ; 3c706
	ld a, [hBattleTurn]
	and a
	jr z, Function3c710
Function3c70b: ; 3c70b
	ld hl, EnemyMonHPHi
	jr asm_3c713

Function3c710: ; 3c710
	ld hl, BattleMonHP

asm_3c713
	ld a, [hli]
	or [hl]
	ret
; 3c716

Function3c716: ; 3c716
	call Function3c706
	ret z
	ld a, $a
	call GetBattleVar
	and $18
	jr z, .asm_3c768
	ld hl, $47e2
	ld de, $0106
	and $10
	jr z, .asm_3c733
	ld hl, $47f8
	ld de, $0105

.asm_3c733
	push de
	call StdBattleTextBox
	pop de
	xor a
	ld [$cfca], a
	call Function3ee0f
	call GetEighthMaxHP
	ld de, $c674
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c74d
	ld de, $c67c

.asm_3c74d
	ld a, $4
	call GetBattleVar
	bit 0, a
	jr z, .asm_3c765
	call Function3cc76
	ld a, [de]
	inc a
	ld [de], a
	ld hl, $0000
.asm_3c75f
	add hl, bc
	dec a
	jr nz, .asm_3c75f
	ld b, h
	ld c, l

.asm_3c765
	call Function3cc3f

.asm_3c768
	call Function3c706
	jp z, .asm_3c7f7
	ld a, $3
	call _GetBattleVar
	bit 7, [hl]
	jr z, .asm_3c7a1
	call Function3c8e4
	xor a
	ld [$cfca], a
	ld de, $0107
	ld a, $7
	call GetBattleVar
	and $60
	call z, Function3ee0f
	call Function3c8e4
	call GetEighthMaxHP
	call Function3cc3f
	ld a, $1
	ld [hBGMapMode], a
	call Function3ccef
	ld hl, $480e
	call StdBattleTextBox

.asm_3c7a1
	call Function3c706
	jr z, .asm_3c7f7
	ld a, $0
	call _GetBattleVar
	bit 0, [hl]
	jr z, .asm_3c7c5
	xor a
	ld [$cfca], a
	ld de, $010c
	call Function3ee0f
	call GetQuarterMaxHP
	call Function3cc3f
	ld hl, $4822
	call StdBattleTextBox

.asm_3c7c5
	call Function3c706
	jr z, .asm_3c7f7
	ld a, $0
	call _GetBattleVar
	bit 1, [hl]
	jr z, .asm_3c7e9
	xor a
	ld [$cfca], a
	ld de, $010c
	call Function3ee0f
	call GetQuarterMaxHP
	call Function3cc3f
	ld hl, $4836
	call StdBattleTextBox

.asm_3c7e9
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c7f4
	ld hl, EnemyMonHPHi

.asm_3c7f4
	ld a, [hli]
	or [hl]
	ret nz

.asm_3c7f7
	call RefreshBattleHuds
	ld c, $14
	call DelayFrame ; was DelayFrames
	xor a
	ret
; 3c801

Function3c801: ; 3c801
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c813
	call SetPlayerTurn
	call .asm_3c81c
	call SetEnemyTurn
	jp .asm_3c81c

.asm_3c813
	call SetEnemyTurn
	call .asm_3c81c
	call SetPlayerTurn
.asm_3c81c
	ld hl, PlayerPerishCount
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c827
	ld hl, EnemyPerishCount

.asm_3c827
	ld a, $0
	call GetBattleVar
	bit 4, a
	ret z
	dec [hl]
	ld a, [hl]
	ld [$d265], a
	push af
	ld hl, $4864
	call StdBattleTextBox
	pop af
	ret nz
	ld a, $0
	call _GetBattleVar
	res 4, [hl]
	ld a, [hBattleTurn]
	and a
	jr nz, .asm_3c85c
	ld hl, BattleMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, PartyMon1CurHP
	ld a, [CurBattleMon]
	call GetPartyLocation
	xor a
	ld [hli], a
	ld [hl], a
	ret

.asm_3c85c
	ld hl, EnemyMonHPHi
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [IsInBattle]
	dec a
	ret z
	ld hl, OTPartyMon1CurHP
	ld a, [CurOTMon]
	call GetPartyLocation
	xor a
	ld [hli], a
	ld [hl], a
	ret
; 3c874

Function3c874: ; 3c874
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c886
	call SetPlayerTurn
	call .asm_3c88f
	call SetEnemyTurn
	jp .asm_3c88f

.asm_3c886
	call SetEnemyTurn
	call .asm_3c88f
	call SetPlayerTurn
.asm_3c88f
	ld hl, $c730
	ld de, $c72e
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c8a0
	ld hl, $c731
	ld de, $c72f

.asm_3c8a0
	ld a, [hl]
	and a
	ret z
	ld a, $3
	call GetBattleVar
	bit 4, a
	ret nz
	ld a, [de]
	ld [$d265], a
	ld [FXAnimIDLo], a
	call GetMoveName
	dec [hl]
	jr z, .asm_3c8de
	ld a, $2
	call GetBattleVar
	and $60
	jr nz, .asm_3c8d3
	call Function3c8e4
	xor a
	ld [$cfca], a
	ld [FXAnimIDHi], a
	ld a, $37
	call Predef
	call Function3c8e4

.asm_3c8d3
	call Function3cc76
	call Function3cc3f
	ld hl, $4de2
	jr .asm_3c8e1

.asm_3c8de
	ld hl, $4df5

.asm_3c8e1
	jp StdBattleTextBox
; 3c8e4

Function3c8e4: ; 3c8e4
	ld a, [hBattleTurn]
	xor $1
	ld [hBattleTurn], a
	ret
; 3c8eb

Function3c8eb: ; 3c8eb
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c8fd
	call SetPlayerTurn
	call .asm_3c906
	call SetEnemyTurn
	jp .asm_3c906

.asm_3c8fd
	call SetEnemyTurn
	call .asm_3c906
	call SetPlayerTurn
.asm_3c906
	callab GetUserItem
	ld a, [hl]
	ld [$d265], a
	call GetItemName
	ld a, b
	cp $3
	ret nz
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c922
	ld hl, EnemyMonHPHi

.asm_3c922
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .asm_3c92d
	ld a, [hl]
	cp c
	ret z

.asm_3c92d
	call Function3cc76
	call Function3c8e4
	call Function3ccef
	ld hl, $4880
	jp StdBattleTextBox
; 3c93c

Function3c93c: ; 3c93c
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3c94e
	call SetPlayerTurn
	call .asm_3c957
	call SetEnemyTurn
	jp .asm_3c957

.asm_3c94e
	call SetEnemyTurn
	call .asm_3c957
	call SetPlayerTurn
.asm_3c957
	callab GetUserItem
	ld a, b
	cp $6
	jr nz, .asm_3c9ae
	ld hl, PartyMon1PP
	ld a, [CurBattleMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, PartyMon1Move1
	ld a, [CurBattleMon]
	call GetPartyLocation
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c99b
	ld de, $c739
	ld hl, $c735
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3c99b
	ld hl, OTPartyMon1PPMove1
	ld a, [CurOTMon]
	call GetPartyLocation
	ld d, h
	ld e, l
	ld hl, OTPartyMon1Move1
	ld a, [CurOTMon]
	call GetPartyLocation

.asm_3c99b
	ld c, $0
.asm_3c99d
	ld a, [hl]
	and a
	jr z, .asm_3c9ae
	ld a, [de]
	and $3f
	jr z, .asm_3c9af
	inc hl
	inc de
	inc c
	ld a, c
	cp $4
	jr nz, .asm_3c99d

.asm_3c9ae
	ret

.asm_3c9af
	ld a, [hl]
	cp $a6
	ld b, $1
	jr z, .asm_3c9b8
	ld b, $5

.asm_3c9b8
	ld a, [de]
	add b
	ld [de], a
	push bc
	push bc
	ld a, [hl]
	ld [$d265], a
	ld de, BattleMonItem
	ld hl, BattleMonPPMove1
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3c9d2
	ld de, EnemyMonItem
	ld hl, EnemyMonPPMove1

.asm_3c9d2
	inc de
	pop bc
	ld b, $0
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	pop de
	pop bc
	ld a, [$d265]
	cp [hl]
	jr nz, .asm_3c9f5
	ld a, [hBattleTurn]
	and a
	ld a, [PlayerSubStatus5]
	jr z, .asm_3c9ee
	ld a, [EnemySubStatus5]

.asm_3c9ee
	bit 3, a
	jr nz, .asm_3c9f5
	ld a, [de]
	add b
	ld [de], a

.asm_3c9f5
	callab GetUserItem
	ld a, [hl]
	ld [$d265], a
	xor a
	ld [hl], a
	call Function3df12
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3ca12
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3ca14
	call Function3df1f

.asm_3ca12
	xor a
	ld [hl], a

.asm_3ca14
	call GetItemName
	call Function3c8e4
	call Function3ddc8
	call Function3c8e4
	ld hl, $4899
	jp StdBattleTextBox
; 3ca26

Function3ca26: ; 3ca26
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3ca38
	call SetPlayerTurn
	call .asm_3ca41
	call SetEnemyTurn
	jp .asm_3ca41

.asm_3ca38
	call SetEnemyTurn
	call .asm_3ca41
	call SetPlayerTurn
.asm_3ca41
	ld hl, $c71d
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3ca4c
	ld hl, $c71e

.asm_3ca4c
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
	cp $1
	ret nz
	ld hl, $48b6
	call StdBattleTextBox
	ld a, $10
	call _GetBattleVar
	push af
	ld a, $f8
	ld [hl], a
	callab UpdateMoveData
	xor a
	ld [AttackMissed], a
	ld [AlreadyDisobeyed], a
	ld a, $a
	ld [TypeModifier], a
	callab DoMove
	xor a
	ld [CurDamage], a
	ld [$d257], a
	ld a, $10
	call _GetBattleVar
	pop af
	ld [hl], a
	call UpdateBattleMonInParty
	jp UpdateEnemyMonInParty
; 3ca8f

Function3ca8f: ; 3ca8f
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3ca9a
	call .asm_3ca9d
	jr .asm_3cac9

.asm_3ca9a
	call .asm_3cac9
.asm_3ca9d
	ld a, [BattleMonStatus]
	bit 5, a
	ret z
	ld a, [$c73f]
	and a
	ret nz
	call BattleRandom
	cp $19
	ret nc
	xor a
	ld [BattleMonStatus], a
	ld a, [CurBattleMon]
	ld hl, PartyMon1Status
	call GetPartyLocation
	ld [hl], $0
	call UpdateBattleHuds
	call SetEnemyTurn
	ld hl, $524b
	jp StdBattleTextBox

.asm_3cac9
	ld a, [EnemyMonStatus]
	bit 5, a
	ret z
	ld a, [$c740]
	and a
	ret nz
	call BattleRandom
	cp $19
	ret nc
	xor a
	ld [EnemyMonStatus], a
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3caef
	ld a, [CurOTMon]
	ld hl, OTPartyMon1Status
	call GetPartyLocation
	ld [hl], $0

.asm_3caef
	call UpdateBattleHuds
	call SetPlayerTurn
	ld hl, $524b
	jp StdBattleTextBox
; 3cafb

Function3cafb: ; 3cafb
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3cb06
	call .asm_3cb09
	jr .asm_3cb1c

.asm_3cb06
	call .asm_3cb1c
.asm_3cb09
	ld a, [PlayerScreens]
	bit 2, a
	ret z
	ld hl, $c701
	dec [hl]
	ret nz
	res 2, a
	ld [PlayerScreens], a
	xor a
	jr .asm_3cb2e

.asm_3cb1c
	ld a, [EnemyScreens]
	bit 2, a
	ret z
	ld hl, $c705
	dec [hl]
	ret nz
	res 2, a
	ld [EnemyScreens], a
	ld a, $1

.asm_3cb2e
	ld [hBattleTurn], a
	ld hl, $48d2
	jp StdBattleTextBox
; 3cb36


Function3cb36: ; 3cb36
	ld a, [$ffcb]
	cp 1
	jr z, .Both
	call .CheckPlayer
	jr .CheckEnemy

.Both
	call .CheckEnemy

.CheckPlayer
	call SetPlayerTurn
	ld de, .Your
	call .asm_3cb6f
	ld hl, PlayerScreens
	ld de, PlayerLightScreenCount
	jr .FadeScreens

.CheckEnemy
	call SetEnemyTurn
	ld de, .Enemy
	call .asm_3cb6f
	ld hl, EnemyScreens
	ld de, EnemyLightScreenCount

.FadeScreens
	bit SCREENS_LIGHT_SCREEN, [hl]
	call nz, FadeLightScreen
	bit SCREENS_REFLECT, [hl]
	call nz, FadeReflect
	ret

.asm_3cb6f
	ld hl, StringBuffer1
	jp CopyName2
; 3cb75

.Your
	db "Your@"
.Enemy
	db "Enemy@"
; 3cb80


FadeLightScreen: ; 3cb80
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_LIGHT_SCREEN, [hl]
	push hl
	push de
	ld hl, BattleText_0x808e7
	call StdBattleTextBox
	pop de
	pop hl
	ret
; 3cb91

FadeReflect: ; 3cb91
	inc de
	ld a, [de]
	dec a
	ld [de], a
	ret nz
	res SCREENS_REFLECT, [hl]
	ld hl, BattleText_0x80905
	jp StdBattleTextBox
; 3cb9e

HandleWeather: ; 3cb9e

	ld a, [Weather]
	cp 0
	ret z

	ld hl, WeatherCount
	dec [hl]
	jr z, .asm_3cc13

	ld hl, .WeatherMessages
	call .asm_3cc1e
	ld a, [Weather]
	cp WEATHER_SANDSTORM
	ret nz
	ld a, [$ffcb]
	cp 1
	jr z, .asm_3cbc7

; Player first
	call SetPlayerTurn
	call .asm_3cbd0
	call SetEnemyTurn
	jr .asm_3cbd0

.asm_3cbc7
; Enemy first
	call SetEnemyTurn
	call .asm_3cbd0
	call SetPlayerTurn

.asm_3cbd0
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz

	ld hl, BattleMonType1
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3cbe3
	ld hl, EnemyMonType1

.asm_3cbe3
	ld a, [hli]
	cp ROCK
	ret z
	cp GROUND
	ret z
	cp STEEL
	ret z

	ld a, [hl]
	cp ROCK
	ret z
	cp GROUND
	ret z
	cp STEEL
	ret z

	call Function3c8e4
	xor a
	ld [$cfca], a
	ld de, $010b
	call Function3ee17
	call Function3c8e4
	call GetEighthMaxHP
	call Function3cc3f

	ld hl, BattleText_0x8084d
	jp StdBattleTextBox

.asm_3cc13
	ld hl, .WeatherEndedMessages
	call .asm_3cc1e
	xor a
	ld [Weather], a
	ret

.asm_3cc1e
	ld a, [Weather]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp StdBattleTextBox
; 3cc2d

.WeatherMessages
	dw BattleText_0x8091f
	dw BattleText_0x80938
	dw BattleText_0x80951
.WeatherEndedMessages
	dw BattleText_0x80967
	dw BattleText_0x8097a
	dw BattleText_0x8098f
; 3cc39

Function3cc39: ; 3cc39
	call Function3cc45
	jp Function3cd3c
; 3cc3f

Function3cc3f: ; 3cc3f
	call Function3cc45
	jp Function3cd36
; 3cc45



Function3cc45: ; 3cc45
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3cc50
	ld hl, EnemyMonHPHi

.asm_3cc50
	inc hl
	ld a, [hl]
	ld [$d1ec], a
	sub c
	ld [hld], a
	ld [$d1ee], a
	ld a, [hl]
	ld [$d1ed], a
	sbc b
	ld [hl], a
	ld [$d1ef], a
	ret nc
	ld a, [$d1ec]
	ld c, a
	ld a, [$d1ed]
	ld b, a
	xor a
	ld [hli], a
	ld [hl], a
	ld [$d1ee], a
	ld [$d1ef], a
	ret
; 3cc76

Function3cc76: ; 3cc76
	call GetQuarterMaxHP
	srl c
	srl c
	ld a, c
	and a
	jr nz, .asm_3cc82
	inc c

.asm_3cc82
	ret
; 3cc83


GetEighthMaxHP: ; 3cc83
; output: bc
	call GetQuarterMaxHP
; assumes nothing can have 1024 or more hp
; halve result
	srl c
; round up
	ld a, c
	and a
	jr nz, .end
	inc c
.end
	ret
; 3cc8e


GetQuarterMaxHP: ; 3cc8e
; output: bc
	call GetMaxHP

; quarter result
	srl b
	rr c
	srl b
	rr c

; assumes nothing can have 1024 or more hp
; round up
	ld a, c
	and a
	jr nz, .end
	inc c
.end
	ret
; 3cc9f


GetHalfMaxHP: ; 3cc9f
; output: bc
	call GetMaxHP

; halve reslut
	srl b
	rr c

; floor = 1
	ld a, c
	or b
	jr nz, .end
	inc c
.end
	ret
; 3ccac


GetMaxHP: ; 3ccac
; output: bc, Buffer1-2

; player
	ld hl, BattleMonMaxHP

; whose turn?
	ld a, [hBattleTurn]
	and a
	jr z, .gethp

; enemy
	ld hl, EnemyMonMaxHP

.gethp
	ld a, [hli]
	ld [Buffer2], a
	ld b, a

	ld a, [hl]
	ld [Buffer1], a
	ld c, a
	ret
; 3ccc2

Function3ccc2: ; 3ccc2
	ld hl, BattleMonHP
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3cccd
	ld hl, EnemyMonHP

.asm_3cccd
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	srl b
	rr c
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hl]
	ld [Buffer1], a
	ret
; 3ccde

Function3ccde: ; 3ccde
	ld hl, BattleMonHP + 1
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3cce9
	ld hl, EnemyMonHP + 1

.asm_3cce9
	ld a, c
	sub [hl]
	dec hl
	ld a, b
	sbc [hl]
	ret
; 3ccef


Function3ccef: ; 3ccef
	ld hl, EnemyMonMaxHP
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3ccfa
	ld hl, BattleMonMaxHP

.asm_3ccfa
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hld]
	ld [Buffer1], a
	dec hl
	ld a, [hl]
	ld [$d1ec], a
	add c
	ld [hld], a
	ld [$d1ee], a
	ld a, [hl]
	ld [$d1ed], a
	adc b
	ld [hli], a
	ld [$d1ef], a
	ld a, [Buffer1]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [Buffer2]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .asm_3cd2d
	ld a, b
	ld [hli], a
	ld [$d1ef], a
	ld a, c
	ld [hl], a
	ld [$d1ee], a

.asm_3cd2d
	call Function3c8e4
	call Function3cd36
	jp Function3c8e4
; 3cd36

Function3cd36: ; 3cd36
	call Function3cd3c
	jp UpdateBattleHuds
; 3cd3c


Function3cd3c: ; 3cd3c
	ld hl, $c55e
	ld a, [hBattleTurn]
	and a
	ld a, $1
	jr z, .asm_3cd4a
	ld hl, $c4ca
	xor a

.asm_3cd4a
	push bc
	ld [$d10a], a
	ld a, $b
	call Predef
	pop bc
	ret
; 3cd55

Function3cd55: ; 3cd55
	call Function3cf14
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	call z, Function3cef1
	xor a
	ld [$c6f7], a
	call Function3ce01
	call Function3d873
	ld a, d
	and a
	jp z, LostBattle
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	call nz, Function3df48
	ld a, $1
	ld [hBGMapMode], a
	ld c, $3c
	call DelayFrame ; was DelayFrames
	ld a, [IsInBattle]
	dec a
	jr nz, .asm_3cd8c
	ld a, $1
	ld [BattleEnded], a
	ret

.asm_3cd8c
	call Function3cf35
	jp z, Function3cfa4
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, .asm_3cdba
	call Function3d1f8
	jr nc, .asm_3cda4
	ld a, $1
	ld [BattleEnded], a
	ret

.asm_3cda4
	call Function3d227
	call Function3d2e0
	jp c, Function3c0e5
	ld a, $1
	ld [$d0ec], a
	call Function3cf4a
	jp z, Function3c0e5
	jr asm_3cdca

.asm_3cdba
	ld a, $1
	ld [$d0ec], a
	call Function3cf4a
	jp z, Function3c0e5
	xor a
	ld [$d0ec], a
	ret

asm_3cdca
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3cde6
	call ClearSprites
	ld hl, $c4a1
	ld bc, $040a
	call ClearBox
	call Function3d2b3
	ld a, $1
	call asm_3cf78
	jr .asm_3cdfc

.asm_3cde6
	ld a, [CurPartyMon]
	push af
	ld a, $1
	call asm_3cf78
	call ClearSprites
	call Function309d
	pop af
	ld [CurPartyMon], a
	call Function3d2b3

.asm_3cdfc
	xor a
	ld [$d0ec], a
	ret
; 3ce01

Function3ce01: ; 3ce01
	call UpdateBattleMonInParty
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3ce16
	ld a, [CurOTMon]
	ld hl, OTPartyMon1CurHP
	call GetPartyLocation
	xor a
	ld [hli], a
	ld [hl], a

.asm_3ce16
	ld hl, PlayerSubStatus3
	res 2, [hl]
	xor a
	ld hl, EnemyDamageTaken
	ld [hli], a
	ld [hl], a
	call Function3d834
	call Function3dc18
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3ce2f
	jr .asm_3ce37

.asm_3ce2f
	call Function3ceec
	ld a, $1
	ld [$c6fd], a

.asm_3ce37
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, .asm_3ce47
	ld a, [$c6f7]
	and a
	jr nz, .asm_3ce47
	call Function3d1aa

.asm_3ce47
	call Function3d873
	ld a, d
	and a
	ret z
	ld a, [IsInBattle]
	dec a
	call z, Function3d0ea
	call EmptyBattleTextBox
	call Function309d
	ld a, [$d0ee]
	and $c0
	ld [$d0ee], a
	call Function3ceaa
	jr z, .asm_3ce72
	ld hl, EnemyMonBaseStats
	ld b, $7
.asm_3ce6c
	srl [hl]
	inc hl
	dec b
	jr nz, .asm_3ce6c

.asm_3ce72
	ld hl, EnemyMonBaseStats
	ld de, $c720
	ld bc, $0007
	call CopyBytes
	xor a
	ld [$c71f], a
	call Function3ee3b
	call Function3ceaa
	ret z
	ld a, [$c664]
	push af
	ld a, d
	ld [$c664], a
	ld hl, $c720
	ld de, EnemyMonBaseStats
	ld bc, $0007
	call CopyBytes
	ld a, $1
	ld [$c71f], a
	call Function3ee3b
	pop af
	ld [$c664], a
	ret
; 3ceaa

Function3ceaa: ; 3ceaa
	ld a, [PartyCount]
	ld b, a
	ld hl, PartyMon1Species
	ld c, $1
	ld d, $0
.asm_3ceb5
	push hl
	push bc
	ld bc, $0022
	add hl, bc
	ld a, [hli]
	or [hl]
	pop bc
	pop hl
	jr z, .asm_3ced1
	push hl
	push bc
	ld bc, $0001
	add hl, bc
	pop bc
	ld a, [hl]
	pop hl
	cp $39
	jr nz, .asm_3ced1
	ld a, d
	or c
	ld d, a

.asm_3ced1
	sla c
	push de
	ld de, $0030
	add hl, de
	pop de
	dec b
	jr nz, .asm_3ceb5
	ld a, d
	ld e, $0
	ld b, $6
.asm_3cee1
	srl a
	jr nc, .asm_3cee6
	inc e

.asm_3cee6
	dec b
	jr nz, .asm_3cee1
	ld a, e
	and a
	ret
; 3ceec



Function3ceec: ; 3ceec
	xor a
	ld [Danger], a
	ret
; 3cef1

Function3cef1: ; 3cef1
	call Function3ceec
	call WaitSFX
	ld a, $f0
	ld [CryTracks], a
	ld a, [BattleMonSpecies]
	call Function37b6
	call Function3d43b
	ld hl, $c535
	ld bc, $050b
	call ClearBox
	ld hl, BattleText_0x80a75
	jp StdBattleTextBox
; 3cf14

Function3cf14: ; 3cf14
	call WaitSFX
	ld de, SFX_KINESIS
	call PlaySFX
	call Function3d432
	ld de, SFX_UNKNOWN_2A
	call PlaySFX
	hlcoord 1, 0
	ld bc, $040a
	call ClearBox
	ld hl, BattleText_0x809a8
	jp StdBattleTextBox
; 3cf35

Function3cf35: ; 3cf35
	ld a, [OTPartyCount]
	ld b, a
	xor a
	ld hl, OTPartyMon1CurHP
	ld de, $0030
.asm_3cf40
	or [hl]
	inc hl
	or [hl]
	dec hl
	add hl, de
	dec b
	jr nz, .asm_3cf40
	and a
	ret
; 3cf4a

Function3cf4a: ; 3cf4a
	ld hl, EnemyHPPal
	ld e, $30
	call Function3e12e
	call WaitBGMap
	callba Function2c012
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3cf6d
	call Function3e8e4
	ld a, [$d430]
	cp $f
	ret z
	call Function30b4

.asm_3cf6d
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	ld a, $0
	jr nz, asm_3cf78
	inc a
	ret

asm_3cf78
	push af
	xor a
	ld [$c718], a
	call Function3d834
	call Function3d867
	call Function3dc18
	pop af
	and a
	jr nz, .asm_3cf8f
	call Function3d4e1
	jr .asm_3cf92

.asm_3cf8f
	call asm_3d517

.asm_3cf92
	call Function3d57a
	call SetEnemyTurn
	call Function3dc23
	xor a
	ld [EnemyMoveAnimation], a
	ld [$d0ec], a
	inc a
	ret
; 3cfa4

Function3cfa4: ; 3cfa4
	call Function3ceec
	ld a, $1
	ld [$c6fd], a
	ld [BattleEnded], a
	ld a, [InLinkBattle]
	and a
	ld a, b
	call z, Function3d0ea
	callab Function39939
	ld hl, BattleText_0x809da
	call StdBattleTextBox
	call Function3d2f1
	jr z, .asm_3cff5
	ld a, [InLinkBattle]
	and a
	ret nz
	ld a, [$cfc0]
	bit 0, a
	jr nz, .asm_3d006
	call Function3ebd8
	ld c, $28
	call DelayFrame ; was DelayFrames
	ld a, [BattleType]
	cp $1
	jr nz, .asm_3cfe8
	ld a, $2
	call Predef

.asm_3cfe8
	ld a, [$c2cc]
	bit 0, a
	jr nz, .asm_3cff2
	call Function3718

.asm_3cff2
	jp Function3d02b

.asm_3cff5
	call Function3ebd8
	ld c, $28
	call DelayFrame ; was DelayFrames
	ld c, $4
	callba Function4ea0a
	ret

.asm_3d006
	call Function3ebd8
	ld c, $28
	call DelayFrame ; was DelayFrames
	call EmptyBattleTextBox
	ld c, $3
	callba Function11c000
	call Functiona80
	ld hl, $c6ec
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret nz
	call ClearTileMap
	call WhiteBGMap
	ret
; 3d02b

Function3d02b: ; 3d02b
	ld a, [$c73d]
	and a
	call nz, Function3d099
	call Function3d0b1
	push af
	ld a, $0
	jr nc, .asm_3d044
	ld a, [$d854]
	and $7
	cp $3
	jr nz, .asm_3d044
	inc a

.asm_3d044
	ld b, a
	ld c, $4
.asm_3d047
	ld a, b
	and a
	jr z, .asm_3d052
	call Function3d081
	dec c
	dec b
	jr .asm_3d047

.asm_3d052
	ld a, c
	and a
	jr z, .asm_3d05c
	call Function3d08d
	dec c
	jr .asm_3d052

.asm_3d05c
	call Function3d099
	call Function3d099
	pop af
	jr nc, .asm_3d07b
	ld a, [$d854]
	and $7
	jr z, .asm_3d07b
	ld hl, SentToMomTexts
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp StdBattleTextBox

.asm_3d07b
	ld hl, BattleText_0x809be
	jp StdBattleTextBox
; 3d081

Function3d081: ; 3d081
	push bc
	ld hl, $c688
	ld de, $d853
	call Function3d0be
	pop bc
	ret
; 3d08d

Function3d08d: ; 3d08d
	push bc
	ld hl, $c688
	ld de, $d850
	call Function3d0be
	pop bc
	ret
; 3d099

Function3d099: ; 3d099
	ld hl, $c688
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret
; 3d0ab

SentToMomTexts: ; 3d0ab
	dw BattleText_0x809fc
	dw BattleText_0x80a2a
	dw BattleText_0x80a3d
; 3d0b1


Function3d0b1: ; 3d0b1
	ld hl, $d853
	ld a, [hld]
	cp $3f
	ld a, [hld]
	sbc $42
	ld a, [hl]
	sbc $f
	ret
; 3d0be

Function3d0be: ; 3d0be
	ld c, $3
	and a
	push de
	push hl
	push bc
	ld b, h
	ld c, l
	callba Function106008
	pop bc
	pop hl
.asm_3d0ce
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .asm_3d0ce
	pop hl
	ld a, [hld]
	cp $3f
	ld a, [hld]
	sbc $42
	ld a, [hl]
	sbc $f
	ret c
	ld [hl], $f
	inc hl
	ld [hl], $42
	inc hl
	ld [hl], $3f
	ret
; 3d0ea

Function3d0ea: ; 3d0ea
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_WILD_VICTORY
	ld a, [IsInBattle]
	dec a
	jr nz, .asm_3d113
	push de
	call Function3ceaa
	pop de
	jr nz, .asm_3d11e
	ld hl, $c6ec
	ld a, [hli]
	or [hl]
	jr nz, .asm_3d11e
	ld a, [$c664]
	and a
	jr z, .asm_3d121
	jr .asm_3d11e

.asm_3d113
	ld de, MUSIC_GYM_VICTORY
	call IsJohtoGymLeader
	jr c, .asm_3d11e
	ld de, MUSIC_TRAINER_VICTORY

.asm_3d11e
	call PlayMusic

.asm_3d121
	pop de
	ret
; 3d123



; These functions check if the current opponent is a gym leader or one of a
; few other special trainers.

; Note: KantoGymLeaders is a subset of JohtoGymLeaders. If you wish to
; differentiate between the two, call IsKantoGymLeader first.

; The Lance and Red entries are unused for music checks; those trainers are
; accounted for elsewhere.

IsKantoGymLeader: ; 0x3d123
	ld hl, KantoGymLeaders
	jr IsGymLeaderCommon

IsJohtoGymLeader: ; 0x3d128
	ld hl, JohtoGymLeaders
IsGymLeaderCommon:
	push de
	ld a, [OtherTrainerClass]
	ld de, $0001
	call IsInArray
	pop de
	ret
; 0x3d137

JohtoGymLeaders:
	db FALKNER
	db WHITNEY
	db BUGSY
	db MORTY
	db PRYCE
	db JASMINE
	db CHUCK
	db CLAIR
	db WILL
	db BRUNO
	db KAREN
	db KOGA
; fallthrough
; these two entries are unused
	db CHAMPION
	db RED
; fallthrough
KantoGymLeaders:
	db BROCK
	db MISTY
	db LT_SURGE
	db ERIKA
	db JANINE
	db SABRINA
	db BLAINE
	db BLUE
	db $ff


Function3d14e: ; 3d14e
	call Function3cef1
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	call z, Function3cf14
	ld a, $1
	ld [$c6f7], a
	call Function3d1aa
	call Function3d873
	ld a, d
	and a
	jp z, LostBattle
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	jr nz, .asm_3d185
	call Function3ce01
	ld a, [IsInBattle]
	dec a
	jr nz, .asm_3d17f
	ld a, $1
	ld [BattleEnded], a
	ret

.asm_3d17f
	call Function3cf35
	jp z, Function3cfa4

.asm_3d185
	call Function3d1f8
	jr nc, .asm_3d190
	ld a, $1
	ld [BattleEnded], a
	ret

.asm_3d190
	call Function3d227
	call Function3d2e0
	jp c, Function3c0e5
	ld a, c
	and a
	ret nz
	ld a, $1
	ld [$d0ec], a
	call Function3cf4a
	jp z, Function3c0e5
	jp asm_3cdca
; 3d1aa

Function3d1aa: ; 3d1aa
	ld a, [CurBattleMon]
	ld c, a
	ld hl, $c664
	ld b, $0
	ld a, $3
	call Predef
	ld hl, EnemySubStatus3
	res 2, [hl]
	xor a
	ld [Danger], a
	ld hl, PlayerDamageTaken
	ld [hli], a
	ld [hl], a
	ld [BattleMonStatus], a
	call UpdateBattleMonInParty
	ld c, $6
	ld a, [BattleMonLevel]
	add $1e
	ld b, a
	ld a, [EnemyMonLevel]
	cp b
	jr c, .asm_3d1dc
	ld c, $8

.asm_3d1dc
	ld a, [CurBattleMon]
	ld [CurPartyMon], a
	callab ChangeHappiness
	ld a, [$d0ee]
	and $c0
	add $1
	ld [$d0ee], a
	ld a, [$c6f7]
	and a
	ret z
	ret
; 3d1f8

Function3d1f8: ; 3d1f8
	call EmptyBattleTextBox
	call Function309d
	ld a, [IsInBattle]
	and a
	dec a
	ret nz
	ld hl, BattleText_0x80a83
	call StdBattleTextBox
.asm_3d20a
	lb bc, 1, 7
	call PlaceYesNoBox
	ld a, [$cfa9]
	jr c, .asm_3d217
	and a
	ret

.asm_3d217
	ld a, [$cfa9]
	cp $1
	jr z, .asm_3d20a
	ld hl, PartyMon1Spd
	ld de, EnemyMonSpd
	jp Function3d8b3
; 3d227

Function3d227: ; 3d227
	call EmptyBattleTextBox
	call Function1d6e
	call Function3d2f7
	call Function3d362
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3d241
	ld a, $1
	ld [$d0ec], a
	call Function3e8e4

.asm_3d241
	xor a
	ld [$d0ec], a
	call Function3d2e0
	jr c, .asm_3d251
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	jr nz, .asm_3d26c

.asm_3d251
	call ClearSprites
	call WhiteBGMap
	call Function3eda6
	call Function1c07
	call Function309d
	call WaitBGMap
	call ClearSGB
	call Function32f9
	xor a
	ld c, a
	ret

.asm_3d26c
	call ClearSprites
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	call Function3d581
	call Function3da0d
	call Function3dab1
	call ClearPalettes
	call DelayFrame
	call Function3eda6
	call Function1c17
	call ClearSGB
	call Function32f9
	call Function3f26d
	call Function3dbde
	call Function3dc18
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	call SetPlayerTurn
	call Function3dc23
	ld a, $1
	and a
	ld c, a
	ret
; 3d2b3

Function3d2b3: ; 3d2b3
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	call Function3d581
	call Function3da0d
	call Function3dab1
	call Function3f26d
	call Function3dbde
	call Function3dc18
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	call SetPlayerTurn
	jp Function3dc23
; 3d2e0



Function3d2e0: ; 3d2e0
	ld a, [InLinkBattle]
	cp $4
	jr nz, .asm_3d2ef
	ld a, [$cd2b]
	and a
	jr z, .asm_3d2ef
	scf
	ret

.asm_3d2ef
	xor a
	ret
; 3d2f1

Function3d2f1: ; 3d2f1
	ld a, [InLinkBattle]
	cp $4
	ret
; 3d2f7

Function3d2f7: ; 3d2f7
	call WhiteBGMap
Function3d2fa: ; 3d2fa
	callba Function5004f
	callba Function50405
	callba Function8e85
	callba Function503e0
	ret
; 3d313

Function3d313: ; 3d313
	callba WritePartyMenuTilemap
	callba PrintPartyMenuText
	call WaitBGMap
	call Function32f9
	call DelayFrame
	ret
; 3d329

Function3d329: ; 3d329
	call Function3d2f1
	jr z, .asm_3d335
	callba PartyMenuSelect
	ret

.asm_3d335
	callba Function100cb5
	ret
; 3d33c

Function3d33c: ; 3d33c
.asm_3d33c
	ld a, $2
	ld [PartyMenuActionText], a
	call Function3d313
	call Function3d329
	ret c
	call Function3d887
	jr z, .asm_3d33c
	xor a
	ret
; 3d34f

Function3d34f: ; 3d34f
	ld hl, CurBattleMon
	ld a, [CurPartyMon]
	cp [hl]
	jr nz, .asm_3d360
	ld hl, BattleText_0x80c0d
	call StdBattleTextBox
	scf
	ret

.asm_3d360
	xor a
	ret
; 3d362

Function3d362: ; 3d362
.asm_3d362
	call Function3d33c
	ret nc
	call Function3d2e0
	ret c
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	jr .asm_3d362
; 3d375



Function3d375: ; 3d375
.asm_3d375
	call Function3d33c
	ret c
	call Function3d34f
	jr c, .asm_3d375
	xor a
	ret
; 3d380

Function3d380: ; 3d380
.asm_3d380
	call Function3d362
	call Function3d2e0
	ret c
	call Function3d34f
	jr c, .asm_3d380
	xor a
	ret
; 3d38e


LostBattle: ; 3d38e
	ld a, 1
	ld [BattleEnded], a

	ld a, [$cfc0]
	bit 0, a
	jr nz, .asm_3d3bd

	ld a, [BattleType]
	cp BATTLETYPE_CANLOSE
	jr nz, .asm_3d3e3

; Remove the enemy from the screen.
	hlcoord 0, 0
	ld bc, $0815
	call ClearBox
	call Function3ebd8

	ld c, 40
	call DelayFrame ; was DelayFrames

	ld a, [$c2cc]
	bit 0, a
	jr nz, .asm_3d3bc
	call Function3718
.asm_3d3bc
	ret

.asm_3d3bd
; Remove the enemy from the screen.
	hlcoord 0, 0
	ld bc, $0815
	call ClearBox
	call Function3ebd8

	ld c, 40
	call DelayFrame ; was DelayFrames

	call EmptyBattleTextBox
	ld c, 2
	callba Function11c000
	call Functiona80
	call ClearTileMap
	call WhiteBGMap
	ret

.asm_3d3e3
	ld a, [InLinkBattle]
	and a
	jr nz, .LostLinkBattle

; Greyscale
	ld b, 0
	call GetSGBLayout
	call Function32f9
	jr .end

.LostLinkBattle
	call UpdateEnemyMonInParty
	call Function3cf35
	jr nz, .asm_3d40a
	ld hl, TiedAgainstText
	ld a, [$d0ee]
	and $c0
	add 2
	ld [$d0ee], a
	jr .asm_3d412

.asm_3d40a
	ld hl, LostAgainstText
	call Function3d2f1
	jr z, .asm_3d417

.asm_3d412
	call StdBattleTextBox

.end
	scf
	ret

.asm_3d417
; Remove the enemy from the screen.
	hlcoord 0, 0
	ld bc, $0815
	call ClearBox
	call Function3ebd8

	ld c, 40
	call DelayFrame ; was DelayFrames

	ld c, $3
	callba Function4ea0a
	scf
	ret
; 3d432


Function3d432: ; 3d432
	ld hl, $c510
	ld de, $c524
	jp Function3d444
; 3d43b

Function3d43b: ; 3d43b
	ld hl, $c569
	ld de, $c57d
	jp Function3d444
; 3d444

Function3d444: ; 3d444
	ld a, [$cfbe]
	push af
	set 6, a
	ld [$cfbe], a
	ld b, $7
.asm_3d44f
	push bc
	push de
	push hl
	ld b, $6
.asm_3d454
	push bc
	push hl
	push de
	ld bc, $0007
	call CopyBytes
	pop de
	pop hl
	ld bc, -20
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jr nz, .asm_3d454
	ld bc, 20
	add hl, bc
	ld de, .Spaces
	call PlaceString
	ld c, 2
	call DelayFrame ; was DelayFrames
	pop hl
	pop de
	pop bc
	dec b
	jr nz, .asm_3d44f
	pop af
	ld [$cfbe], a
	ret
; 3d488

.Spaces
	db "       @"
; 3d490


Function3d490: ; 3d490
	ld [hConnectionStripLength], a
	ld c, a
.asm_3d493
	push bc
	push hl
	ld b, $7
.asm_3d497
	push hl
	call Function3d4ae
	pop hl
	ld de, 20
	add hl, de
	dec b
	jr nz, .asm_3d497
	ld c, 2
	call DelayFrame ; was DelayFrames
	pop hl
	pop bc
	dec c
	jr nz, .asm_3d493
	ret
; 3d4ae

Function3d4ae: ; 3d4ae
	ld a, [hConnectionStripLength]
	ld c, a
	cp $8
	jr nz, .asm_3d4bc
.asm_3d4b5
	ld a, [hli]
	ld [hld], a
	dec hl
	dec c
	jr nz, .asm_3d4b5
	ret

.asm_3d4bc
	ld a, [hld]
	ld [hli], a
	inc hl
	dec c
	jr nz, .asm_3d4bc
	ret
; 3d4c3


Function3d4c3: ; 3d4c3
	call Function3d557
	ld a, [$c718]
	dec a
	ld b, a
	call Function3d6ca
	call Function3d7a0
	call Function3d834
	call Function3d867
	call Function3d7c7
	call Function3dc18
	call Function3d57a
	ret
; 3d4e1


Function3d4e1: ; 3d4e1
	call Function3d714
	jr nc, asm_3d517
	call Function3d557
	call Function3d533
	jr c, .asm_3d4f1
	call Function3d599

.asm_3d4f1
	call Function3d6ca
	call Function3d74b
	push af
	call Function3d7a0
	call Function3d7b8
	call Function3d7c7
	pop af
	ret c
	xor a
	ld [$c664], a
	ld [$c6fc], a
	ld [$d0ec], a
	inc a
	ld [$c711], a
	call Function309d
	jp Function3e3ad

asm_3d517
	call Function3d557
	call Function3d533
	jr c, .asm_3d522
	call Function3d599

.asm_3d522
	call Function3d6ca
	ld a, $1
	ld [$c711], a
	call Function3d7a0
	call Function3d7b8
	jp Function3d7c7
; 3d533

Function3d533: ; 3d533
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3d541
	ld a, [$d430]
	sub $4
	ld b, a
	jr .asm_3d555

.asm_3d541
	ld a, [$c718]
	and a
	jr z, .asm_3d54b
	dec a
	ld b, a
	jr .asm_3d555

.asm_3d54b
	ld a, [$d264]
	and a
	ld b, $0
	jr nz, .asm_3d555
	and a
	ret

.asm_3d555
	scf
	ret
; 3d557

Function3d557: ; 3d557
	xor a
	ld [LastEnemyCounterMove], a
	ld [LastPlayerCounterMove], a
	ld [LastEnemyMove], a
	ld [CurEnemyMove], a
	dec a
	ld [$c6e6], a
	xor a
	ld [$c730], a
	ld hl, $c4b2
	ld a, $8
	call Function3d490
	call EmptyBattleTextBox
	jp Function1d6e
; 3d57a

Function3d57a: ; 3d57a
	xor a
	ld [$c664], a
	ld [$c6fc], a
Function3d581: ; 3d581
	ld a, [CurBattleMon]
	ld c, a
	ld hl, $c664
	ld b, $1
	push bc
	ld a, $3
	call Predef
	pop bc
	ld hl, $c6fc
	ld a, $3
	jp Predef
; 3d599

Function3d599: ; 3d599
	ld b, $ff
	ld a, $1
	ld [Buffer1], a
	ld [Buffer2], a
.asm_3d5a3
	ld hl, Buffer1
	sla [hl]
	inc hl
	sla [hl]
	inc b
	ld a, [OTPartyCount]
	cp b
	jp z, Function3d672
	ld a, [CurOTMon]
	cp b
	jr z, .asm_3d5d0
	ld hl, OTPartyMon1CurHP
	push bc
	ld a, b
	call GetPartyLocation
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	pop bc
	jr z, .asm_3d5d0
	call Function3d5d7
	call Function3d618
	jr .asm_3d5a3

.asm_3d5d0
	ld hl, Buffer2
	set 0, [hl]
	jr .asm_3d5a3
; 3d5d7

Function3d5d7: ; 3d5d7
	push bc
	ld hl, OTPartyMon1Move1
	ld a, b
	call GetPartyLocation
	pop bc
	ld e, $5
.asm_3d5e2
	dec e
	jr z, .asm_3d617
	ld a, [hli]
	and a
	jr z, .asm_3d617
	push hl
	push de
	push bc
	dec a
	ld hl, $5afb
	ld bc, $0007
	call AddNTimes
	ld de, EnemyMoveAnimation
	ld a, $10
	call FarCopyBytes
	call SetEnemyTurn
	callab Function0x347c8
	pop bc
	pop de
	pop hl
	ld a, [$d265]
	cp $b
	jr c, .asm_3d5e2
	ld hl, Buffer1
	set 0, [hl]
	ret

.asm_3d617
	ret
; 3d618

Function3d618: ; 3d618
	push bc
	ld hl, OTPartyCount
	ld a, b
	inc a
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	dec a
	ld hl, $542b
	ld bc, $0020
	call AddNTimes
	ld de, EnemyMonType1
	ld bc, $0002
	ld a, $14
	call FarCopyBytes
	ld a, [BattleMonType1]
	ld [PlayerMoveType], a
	call SetPlayerTurn
	callab Function0x347c8
	ld a, [$d265]
	cp $b
	jr nc, .asm_3d663
	ld a, [BattleMonType2]
	ld [PlayerMoveType], a
	callab Function0x347c8
	ld a, [$d265]
	cp $b
	jr nc, .asm_3d663
	pop bc
	ret

.asm_3d663
	pop bc
	ld hl, Buffer1
	bit 0, [hl]
	jr nz, .asm_3d66f
	inc hl
	set 0, [hl]
	ret

.asm_3d66f
	res 0, [hl]
	ret
; 3d672

Function3d672: ; 3d672
.asm_3d672
	ld hl, Buffer1
	sla [hl]
	inc hl
	sla [hl]
	jr nc, .asm_3d672
	ld a, [OTPartyCount]
	ld b, a
	ld c, [hl]
.asm_3d681
	sla c
	jr nc, .asm_3d68a
	dec b
	jr z, .asm_3d6a7
	jr .asm_3d681

.asm_3d68a
	ld a, [Buffer1]
	and a
	jr z, .asm_3d69a
	ld b, $ff
	ld c, a
.asm_3d693
	inc b
	sla c
	jr nc, .asm_3d693
	jr .asm_3d6c9

.asm_3d69a
	ld b, $ff
	ld a, [Buffer2]
	ld c, a
.asm_3d6a0
	inc b
	sla c
	jr c, .asm_3d6a0
	jr .asm_3d6c9

.asm_3d6a7
	ld a, [OTPartyCount]
	ld b, a
	call BattleRandom
	and $7
	cp b
	jr nc, .asm_3d6a7
	ld b, a
	ld a, [CurOTMon]
	cp b
	jr z, .asm_3d6a7
	ld hl, OTPartyMon1CurHP
	push bc
	ld a, b
	call GetPartyLocation
	pop bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	jr z, .asm_3d6a7

.asm_3d6c9
	ret
; 3d6ca

Function3d6ca: ; 3d6ca
	ld a, b
	ld [CurPartyMon], a
	ld hl, OTPartyMon1Level
	call GetPartyLocation
	ld a, [hl]
	ld [CurPartyLevel], a
	ld a, [CurPartyMon]
	inc a
	ld hl, OTPartyCount
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [TempEnemyMonSpecies], a
	ld [CurPartySpecies], a
	call LoadEnemyMon
	ld a, [CurPartySpecies]
	cp $c9
	jr nz, .asm_3d708
	ld a, [$def4]
	and a
	jr nz, .asm_3d708
	ld hl, EnemyMonAtkDefDV
	ld a, $2d
	call Predef
	ld a, [UnownLetter]
	ld [$def4], a

.asm_3d708
	ld hl, EnemyMonHPHi
	ld a, [hli]
	ld [$c6ea], a
	ld a, [hl]
	ld [$c6eb], a
	ret
; 3d714

Function3d714: ; 3d714
	ld a, [$d264]
	dec a
	jp z, .asm_3d749
	ld a, [PartyCount]
	dec a
	jp z, .asm_3d749
	ld a, [InLinkBattle]
	and a
	jp nz, .asm_3d749
	ld a, [Options]
	bit 6, a
	jr nz, .asm_3d749
	ld a, [CurPartyMon]
	push af
	ld a, [CurBattleMon]
	ld [CurPartyMon], a
	callba Functione538
	pop bc
	ld a, b
	ld [CurPartyMon], a
	jr c, .asm_3d749
	scf
	ret

.asm_3d749
	and a
	ret
; 3d74b

Function3d74b: ; 3d74b
	ld a, [CurPartyMon]
	push af
	callab Function39939
	ld hl, BattleText_0x80aca
	call StdBattleTextBox
	lb bc, 1, 7
	call PlaceYesNoBox
	ld a, [$cfa9]
	dec a
	jr nz, .asm_3d79a
	call Function3d2f7
	call Function3d375
	jr c, .asm_3d791
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	call ClearPalettes
	call DelayFrame
	call Function3eda6
	pop af
	ld [CurPartyMon], a
	xor a
	ld [CurEnemyMove], a
	ld [CurPlayerMove], a
	and a
	ret

.asm_3d791
	call ClearPalettes
	call DelayFrame
	call Function3eda6

.asm_3d79a
	pop af
	ld [CurPartyMon], a
	scf
	ret
; 3d7a0

Function3d7a0: ; 3d7a0
	xor a
	ld [hBGMapMode], a
	call Function1c07
	call ClearSprites
	ld hl, $c4a1
	ld bc, $040a
	call ClearBox
	call WaitBGMap
	jp Function3ee27
; 3d7b8

Function3d7b8: ; 3d7b8
	callab Function39939
	ld hl, BattleText_0x80af8
	call StdBattleTextBox
	jp WaitBGMap
; 3d7c7

Function3d7c7: ; 3d7c7
	ld a, [TempEnemyMonSpecies]
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData
	ld a, $1
	ld [MonType], a
	ld a, $1f
	call Predef
	call Function3f47c
	xor a
	ld [$cfca], a
	ld [$c689], a
	call SetEnemyTurn
	ld de, $0101
	call Function3ee17
	call Function3da79
	jr nc, .asm_3d800
	ld a, $1
	ld [$c689], a
	ld de, $0101
	call Function3ee17

.asm_3d800
	ld bc, TempMonSpecies
	callba Function4e53f
	jr c, .asm_3d82c
	callba CheckBattleScene
	jr c, .asm_3d821
	ld hl, $c4ac
	ld d, $0
	ld e, $0
	ld a, $47
	call Predef
	jr .asm_3d82c

.asm_3d821
	ld a, $f
	ld [CryTracks], a
	ld a, [TempEnemyMonSpecies]
	call Function37b6

.asm_3d82c
	call Function3e036
	ld a, $1
	ld [hBGMapMode], a
	ret
; 3d834

Function3d834: ; 3d834
	xor a
	ld [LastEnemyCounterMove], a
	ld [LastPlayerCounterMove], a
	ld [LastEnemyMove], a
	ld hl, EnemySubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [EnemyDisableCount], a
	ld [EnemyFuryCutterCount], a
	ld [$c681], a
	ld [$c72c], a
	ld [EnemyDisabledMove], a
	ld [$c6fa], a
	ld [$c730], a
	ld [$c731], a
	ld [EnemyTurnsTaken], a
	ld hl, PlayerSubStatus5
	res 7, [hl]
	ret
; 3d867

Function3d867: ; 3d867
	ld a, $7
	ld b, $8
	ld hl, EnemyAtkLevel
.asm_3d86e
	ld [hli], a
	dec b
	jr nz, .asm_3d86e
	ret
; 3d873

Function3d873: ; 3d873
	ld a, [PartyCount]
	ld e, a
	xor a
	ld hl, PartyMon1CurHP
	ld bc, $002f
.asm_3d87e
	or [hl]
	inc hl
	or [hl]
	add hl, bc
	dec e
	jr nz, .asm_3d87e
	ld d, a
	ret
; 3d887


Function3d887: ; 3d887
	ld a, [CurPartyMon]
	ld hl, PartyMon1CurHP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	ret nz
	ld a, [$d264]
	and a
	jr nz, .asm_3d8b1
	ld hl, PartySpecies
	ld a, [CurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp EGG
	ld hl, BattleText_0x80b26
	jr z, .asm_3d8ae
	ld hl, BattleText_0x80b0b

.asm_3d8ae
	call StdBattleTextBox

.asm_3d8b1
	xor a
	ret
; 3d8b3


Function3d8b3: ; 3d8b3
	ld a, [BattleType]
	cp $2
	jp z, .asm_3d9a2
	cp $6
	jp z, .asm_3d9a2
	cp $9
	jp z, .asm_3d98d
	cp $b
	jp z, .asm_3d98d
	cp $7
	jp z, .asm_3d98d
	cp $c
	jp z, .asm_3d98d

	ld a, [InLinkBattle]
	and a
	jp nz, .asm_3d9a2

	ld a, [IsInBattle]
	dec a
	jp nz, .asm_3d992

	ld a, [EnemySubStatus5]
	bit 7, a
	jp nz, .asm_3d98d

	ld a, [$c730]
	and a
	jp nz, .asm_3d98d

	push hl
	push de
	ld a, [BattleMonItem]
	ld [$d265], a
	ld b, a
	callab GetItem
	ld a, b
	cp $48
	pop de
	pop hl
	jr nz, .asm_3d916

	call SetPlayerTurn
	call GetItemName
	ld hl, BattleText_0x80b89
	call StdBattleTextBox
	jp .asm_3d9a2

.asm_3d916
	ld a, [$d267]
	inc a
	ld [$d267], a
	ld a, [hli]
	ld [$ffb5], a
	ld a, [hl]
	ld [$ffb6], a
	ld a, [de]
	inc de
	ld [$ffb1], a
	ld a, [de]
	ld [$ffb2], a
	call Function30b4
	ld de, $ffb5
	ld hl, $ffb1
	ld c, $2
	call StringCmp
	jr nc, .asm_3d9a2
	xor a
	ld [hMultiplicand], a
	ld a, $20
	ld [hMultiplier], a
	call Multiply
	ld a, [$ffb5]
	ld [hProduct], a
	ld a, [$ffb6]
	ld [hMultiplicand], a
	ld a, [$ffb1]
	ld b, a
	ld a, [$ffb2]
	srl b
	rr a
	srl b
	rr a
	and a
	jr z, .asm_3d9a2
	ld [hMultiplier], a
	ld b, $2
	call Divide
	ld a, [$ffb5]
	and a
	jr nz, .asm_3d9a2
	ld a, [$d267]
	ld c, a
.asm_3d96c
	dec c
	jr z, .asm_3d97a
	ld b, $1e
	ld a, [$ffb6]
	add b
	ld [$ffb6], a
	jr c, .asm_3d9a2
	jr .asm_3d96c

.asm_3d97a
	call BattleRandom
	ld b, a
	ld a, [$ffb6]
	cp b
	jr nc, .asm_3d9a2
	ld a, $1
	ld [$d0ec], a
	ld hl, BattleText_0x80b3b
	jr .asm_3d995

.asm_3d98d
	ld hl, BattleText_0x80ba0
	jr .asm_3d995

.asm_3d992
	ld hl, BattleText_0x80b49

.asm_3d995
	call StdBattleTextBox
	ld a, $1
	ld [$d266], a
	call Function309d
	and a
	ret

.asm_3d9a2
	ld a, [InLinkBattle]
	and a
	ld a, $2
	jr z, .asm_3d9cf
	call Function309d
	xor a
	ld [$d0ec], a
	ld a, $f
	ld [CurMoveNum], a
	xor a
	ld [CurPlayerMove], a
	call Function3e8e4
	call Function30b4
	call Function3d2e0
	jr c, .asm_3d9f5

; Got away safely
	ld a, [$d430]
	cp $f
	ld a, $2
	jr z, .asm_3d9cf
	dec a
.asm_3d9cf
	ld b, a
	ld a, [$d0ee]
	and $c0
	add b
	ld [$d0ee], a
	call Function3ceec
	push de
	ld de, SFX_RUN
	call WaitPlaySFX
	pop de
	call WaitSFX
	ld hl, BattleText_0x80b77
	call StdBattleTextBox
	call WaitSFX
	call Function309d
	scf
	ret

.asm_3d9f5
	call Function3ceec
	ld hl, $cd2a
	bit 4, [hl]
	jr nz, .asm_3da05
	ld hl, BattleText_0x81863
	call StdBattleTextBox

.asm_3da05
	call WaitSFX
	call Function309d
	scf
	ret
; 3da0d


Function3da0d: ; 3da0d
	ld a, $0
	call GetPartyParamLocation
	ld de, BattleMonSpecies
	ld bc, $0006
	call CopyBytes
	ld bc, $000f
	add hl, bc
	ld de, BattleMonAtkDefDV
	ld bc, $0007
	call CopyBytes
	inc hl
	inc hl
	inc hl
	ld de, BattleMonLevel
	ld bc, $0011
	call CopyBytes
	ld a, [BattleMonSpecies]
	ld [TempBattleMonSpecies], a
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData
	ld a, [BaseType1]
	ld [BattleMonType1], a
	ld a, [BaseType2]
	ld [BattleMonType2], a
	ld hl, PartyMon1Nickname
	ld a, [CurBattleMon]
	call SkipNames
	ld de, BattleMonNick
	ld bc, $000b
	call CopyBytes
	ld hl, BattleMonAtk
	ld de, PlayerStats
	ld bc, $000a
	call CopyBytes
	call Function3ec2c
	call BadgeStatBoosts
	ret
; 3da74

Function3da74: ; 3da74
	call Function3da85
	jr asm_3da7c

Function3da79: ; 3da79
	call Function3da97

asm_3da7c
	ld b, h
	ld c, l
	callab CheckShininess
	ret
; 3da85

Function3da85: ; 3da85
	ld hl, BattleMonAtkDefDV
	ld a, [PlayerSubStatus5]
	bit 3, a
	ret z
	ld hl, PartyMon1DVs
	ld a, [CurBattleMon]
	jp GetPartyLocation
; 3da97

Function3da97: ; 3da97
	ld hl, EnemyMonAtkDefDV
	ld a, [EnemySubStatus5]
	bit 3, a
	ret z
	ld hl, $c6f2
	ld a, [IsInBattle]
	dec a
	ret z
	ld hl, OTPartyMon1AtkDefDV
	ld a, [CurOTMon]
	jp GetPartyLocation
; 3dab1

Function3dab1: ; 3dab1
	ld a, $7
	ld b, $8
	ld hl, PlayerAtkLevel
.asm_3dab8
	ld [hli], a
	dec b
	jr nz, .asm_3dab8
	ret
; 3dabd


Function3dabd: ; 3dabd
	ld a, [CurPartyMon]
	ld hl, OTPartyMon1Species
	call GetPartyLocation
	ld de, EnemyMonSpecies
	ld bc, $0006
	call CopyBytes
	ld bc, $000f
	add hl, bc
	ld de, EnemyMonAtkDefDV
	ld bc, $0007
	call CopyBytes
	inc hl
	inc hl
	inc hl
	ld de, EnemyMonLevel
	ld bc, $0011
	call CopyBytes
	ld a, [EnemyMonSpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld hl, OTPartyMon1Nickname
	ld a, [CurPartyMon]
	call SkipNames
	ld de, EnemyMonNick
	ld bc, $000b
	call CopyBytes
	ld hl, EnemyMonAtk
	ld de, EnemyStats
	ld bc, $000a
	call CopyBytes
	call Function3ec30
	ld hl, BaseType1
	ld de, EnemyMonType1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, BaseHP
	ld de, EnemyMonBaseStats
	ld b, $5
.asm_3db25
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .asm_3db25
	ld a, [CurPartyMon]
	ld [CurOTMon], a
	ret
; 3db32


Function3db32: ; 3db32
	call ClearSprites
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	call Function3d581
	call Function3da0d
	call Function3dab1
	call Function3dbde
	call Function3dc18
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	ret
; 3db5f


Function3db5f: ; 3db5f
	ld hl, BattleMonAtkDefDV
	ld a, $2d
	call Predef
	ld hl, $c505
	ld b, $7
	ld c, $8
	call ClearBox
	call WaitBGMap
	xor a
	ld [hBGMapMode], a
	call Function3f43d
	xor a
	ld [$ffad], a
	ld [$d0d2], a
	ld [CurMoveNum], a
	ld [TypeModifier], a
	ld [PlayerMoveAnimation], a
	ld [LastEnemyCounterMove], a
	ld [LastPlayerCounterMove], a
	ld [LastPlayerMove], a
	call Function3e4a8
	call Function3ee27
	xor a
	ld [$c731], a
	call SetPlayerTurn
	xor a
	ld [$cfca], a
	ld [$c689], a
	ld de, $0101
	call Function3ee17
	call Function3da74
	jr nc, .asm_3dbbc
	ld a, $1
	ld [$c689], a
	ld de, $0101
	call Function3ee17

.asm_3dbbc
	ld a, $0
	call GetPartyParamLocation
	ld b, h
	ld c, l
	callba Function4e53f
	jr c, .asm_3dbd6
	ld a, $f0
	ld [CryTracks], a
	ld a, [CurPartySpecies]
	call Function37b6

.asm_3dbd6
	call Function3df48
	ld a, $1
	ld [hBGMapMode], a
	ret
; 3dbde

Function3dbde: ; 3dbde
	xor a
	ld [LastEnemyCounterMove], a
	ld [LastPlayerCounterMove], a
	ld [LastPlayerMove], a
	ld hl, PlayerSubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, PlayerUsedMoves
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [PlayerDisableCount], a
	ld [PlayerFuryCutterCount], a
	ld [$c679], a
	ld [$c72b], a
	ld [DisabledMove], a
	ld [$c6fe], a
	ld [$c731], a
	ld [$c730], a
	ld [PlayerTurnsTaken], a
	ld hl, EnemySubStatus5
	res 7, [hl]
	ret
; 3dc18

Function3dc18: ; 3dc18
	ld hl, PlayerSubStatus1
	res 7, [hl]
	ld hl, EnemySubStatus1
	res 7, [hl]
	ret
; 3dc23

Function3dc23: ; 3dc23
	ld hl, PlayerScreens
	ld de, BattleMonType1
	ld bc, Function3df48
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3dc3a
	ld hl, EnemyScreens
	ld de, EnemyMonType1
	ld bc, Function3e036

.asm_3dc3a
	bit 0, [hl]
	ret z
	ld a, [de]
	cp $2
	ret z
	inc de
	ld a, [de]
	cp $2
	ret z
	push bc
	ld hl, BattleText_0x80bae
	call StdBattleTextBox
	call GetEighthMaxHP
	call Function3cc39
	pop hl
	call Function3dc5a
	jp WaitBGMap
; 3dc5a

Function3dc5a: ; 3dc5a
	jp [hl]
; 3dc5b

Function3dc5b: ; 3dc5b
	ld a, $10
	call GetBattleVar
	ld b, a
	call Function3c5ec
	ld a, b
	cp $80
	jr nz, .asm_3dce4
	ld a, [CurBattleMon]
	push af
	ld hl, DoPlayerTurn
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3dc7e
	ld hl, DoEnemyTurn
	ld a, [$c71a]
	ld [CurBattleMon], a

.asm_3dc7e
	ld a, BANK(DoPlayerTurn)
	rst FarCall
	ld a, $10
	call _GetBattleVar
	ld a, $ff
	ld [hl], a
	pop af
	ld [CurBattleMon], a
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3dcc0
	ld a, [$c71a]
	call Function399f
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, .asm_3dce4
	ld a, $f0
	ld [CryTracks], a
	ld a, [BattleMonSpecies]
	call Function37b6
	ld a, [$c71a]
	ld c, a
	ld hl, $c664
	ld b, $0
	ld a, $3
	call Predef
	call Function3d43b
	ld hl, BattleText_0x80a75
	jr .asm_3dcdf

.asm_3dcc0
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	jr nz, .asm_3dce4
	ld de, SFX_KINESIS
	call PlaySFX
	call WaitSFX
	ld de, SFX_UNKNOWN_2A
	call PlaySFX
	call WaitSFX
	call Function3d432
	ld hl, BattleText_0x809a8

.asm_3dcdf
	call StdBattleTextBox
	scf
	ret

.asm_3dce4
	and a
	ret
; 3dce6

Function3dce6: ; 3dce6
	ld a, [hBattleTurn]
	push af
	xor a
	ld [hBattleTurn], a
	ld [$cfca], a
	ld de, $0102
	call Function3ee17
	pop af
	ld [hBattleTurn], a
	ret
; 3dcf9

Function3dcf9: ; 3dcf9
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3dd17
	call SetPlayerTurn
	call Function3dd2f
	call Function3dde9
	call Function3de51
	call SetEnemyTurn
	call Function3dd2f
	call Function3dde9
	jp Function3de51

.asm_3dd17
	call SetEnemyTurn
	call Function3dd2f
	call Function3dde9
	call Function3de51
	call SetPlayerTurn
	call Function3dd2f
	call Function3dde9
	jp Function3de51
; 3dd2f

Function3dd2f: ; 3dd2f
	callab GetOpponentItem
	ld a, b
	cp $1
	ret nz
	ld de, EnemyMonHPLo
	ld hl, EnemyMonMaxHPHi
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3dd4a
	ld de, $c63d
	ld hl, BattleMonMaxHP

.asm_3dd4a
	push bc
	ld a, [de]
	ld [$d1ec], a
	add a
	ld c, a
	dec de
	ld a, [de]
	inc de
	ld [$d1ed], a
	adc a
	ld b, a
	ld a, b
	cp [hl]
	ld a, c
	pop bc
	jr z, .asm_3dd62
	jr c, .asm_3dd66
	ret

.asm_3dd62
	inc hl
	cp [hl]
	dec hl
	ret nc

.asm_3dd66
	call Function3ddc8
	ld a, [hli]
	ld [Buffer2], a
	ld a, [hl]
	ld [Buffer1], a
	ld a, [de]
	add c
	ld [$d1ee], a
	ld c, a
	dec de
	ld a, [de]
	adc $0
	ld [$d1ef], a
	ld b, a
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jr nc, .asm_3dd8d
	ld a, [hli]
	ld [$d1ef], a
	ld a, [hl]
	ld [$d1ee], a

.asm_3dd8d
	ld a, [$d1ef]
	ld [de], a
	inc de
	ld a, [$d1ee]
	ld [de], a
	ld a, [hBattleTurn]
	ld [$d10a], a
	and a
	ld hl, $c4ca
	jr z, .asm_3dda4
	ld hl, $c55e

.asm_3dda4
	ld [$d10a], a
	ld a, $b
	call Predef
Function3ddac:
	call RefreshBattleHuds
	callab GetOpponentItem
	ld a, [hl]
	ld [$d265], a
	call GetItemName
	callab Function27192
	ld hl, RecoveredUsingText
	jp StdBattleTextBox
; 3ddc8


Function3ddc8: ; 3ddc8
	push hl
	push de
	push bc
	call EmptyBattleTextBox
	ld a, $69
	ld [FXAnimIDLo], a
	call Function3c8e4
	xor a
	ld [$cfca], a
	ld [FXAnimIDHi], a
	ld a, $37
	call Predef
	call Function3c8e4
	pop bc
	pop de
	pop hl
	ret
; 3dde9

Function3dde9: ; 3dde9
	callab GetOpponentItem
	ld hl, .Statuses
.asm_3ddf2
	ld a, [hli]
	cp $ff
	ret z
	inc hl
	cp b
	jr nz, .asm_3ddf2
	dec hl
	ld b, [hl]
	ld a, $b
	call _GetBattleVar
	and b
	ret z
	xor a
	ld [hl], a
	push bc
	call UpdateOpponentInParty
	pop bc
	ld a, $9
	call _GetBattleVar
	and [hl]
	res 0, [hl]
	ld a, $5
	call _GetBattleVar
	and [hl]
	res 0, [hl]
	ld a, b
	cp $7f
	jr nz, .asm_3de26
	ld a, $7
	call _GetBattleVar
	res 7, [hl]

.asm_3de26
	ld hl, Function0x365fd
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3de31
	ld hl, Function0x365d7

.asm_3de31
	call Function3c8e4
	ld a, BANK(Function0x365fd)
	rst FarCall
	call Function3c8e4
	call Function3ddc8
	call Function3ddac
	ld a, $1
	and a
	ret
; 3de44

.Statuses ; 3de44
	db HELD_HEAL_POISON, 1 << PSN
	db HELD_HEAL_FREEZE, 1 << FRZ
	db HELD_HEAL_BURN, 1 << BRN
	db HELD_HEAL_SLEEP, SLP
	db HELD_HEAL_PARALYZE, 1 << PAR
	db HELD_HEAL_STATUS, 1 << PSN | 1 << FRZ | 1 << BRN | SLP | 1 << PAR
	db $ff
; 3de51


Function3de51: ; 3de51
	ld a, $7
	call GetBattleVar
	bit 7, a
	ret z
	callab GetOpponentItem
	ld a, b
	cp $10
	jr z, .asm_3de67
	cp $f
	ret nz

.asm_3de67
	ld a, [hl]
	ld [$d265], a
	ld a, $7
	call _GetBattleVar
	res 7, [hl]
	call GetItemName
	call Function3ddc8
	ld hl, BattleText_0x80dab
	call StdBattleTextBox
	ld a, [hBattleTurn]
	and a
	jr nz, .asm_3de90
	call Function3df1f
	xor a
	ld [bc], a
	ld a, [IsInBattle]
	dec a
	ret z
	ld [hl], $0
	ret

.asm_3de90
	call Function3df12
	xor a
	ld [bc], a
	ld [hl], a
	ret
; 3de97

Function3de97: ; 3de97
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3dea3
	call Function3dea9
	jp Function3deb1

.asm_3dea3
	call Function3deb1
	jp Function3dea9
; 3dea9

Function3dea9: ; 3dea9
	call Function3df12
	ld a, $0
	jp Function3deb6
; 3deb1

Function3deb1: ; 3deb1
	call Function3df1f
	ld a, $1
Function3deb6: ; 3deb6
	ld [hBattleTurn], a
	ld d, h
	ld e, l
	push de
	push bc
	ld a, [bc]
	ld b, a
	callab GetItem
	ld hl, .data_3defc
.asm_3dec7
	ld a, [hli]
	cp $ff
	jr z, .asm_3def9
	inc hl
	inc hl
	cp b
	jr nz, .asm_3dec7
	pop bc
	ld a, [bc]
	ld [$d265], a
	push bc
	dec hl
	dec hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(BattleCommand70)
	rst FarCall
	pop bc
	pop de
	ld a, [FailedMessage]
	and a
	ret nz
	xor a
	ld [bc], a
	ld [de], a
	call GetItemName
	ld hl, BattleText_0x80bde
	call StdBattleTextBox
	callab BattleCommand8c
	ret

.asm_3def9
	pop bc
	pop de
	ret
; 3defc

.data_3defc
	dbw $1f, BattleCommand70
	dbw $20, BattleCommand71
	dbw $21, BattleCommand72
	dbw $22, BattleCommand73
	dbw $23, BattleCommand74
	dbw $24, BattleCommand75
	dbw $25, BattleCommand76
	db $ff
; 3df12


Function3df12: ; 3df12
	ld hl, PartyMon1Item
	ld a, [CurBattleMon]
	call GetPartyLocation
	ld bc, BattleMonItem
	ret
; 3df1f

Function3df1f: ; 3df1f
	ld hl, OTPartyMon1Item
	ld a, [CurOTMon]
	call GetPartyLocation
	ld bc, EnemyMonItem
	ret
; 3df2c

Function3df2c: ; 3df2c
	push hl
	push de
	push bc
	call DrawPlayerHUD
	ld hl, PlayerHPPal
	call SetHPPal
	call CheckDanger
	call Function3e043
	ld hl, EnemyHPPal
	call SetHPPal
	pop bc
	pop de
	pop hl
	ret
; 3df48



Function3df48: ; 3df48
	push hl
	push de
	push bc
	call DrawPlayerHUD
	call UpdatePlayerHPPal
	call CheckDanger
	pop bc
	pop de
	pop hl
	ret
; 3df58

DrawPlayerHUD: ; 3df58
	xor a
	ld [hBGMapMode], a

; Clear the area
	hlcoord 9, 7
	ld bc, $050b
	call ClearBox

	callba DrawPlayerExpBar

	hlcoord 18, 9
	ld [hl], $73 ; vertical bar
	call PrintPlayerHUD

; HP bar
	hlcoord 10, 9
	ld b, OTPARTYMON
	xor a
	ld [MonType], a
	ld a, PREDEF_DRAW_PLAYER_HP
	call Predef

; Exp bar
	push de
	ld a, [CurBattleMon]
	ld hl, PartyMon1Exp + 2
	call GetPartyLocation
	ld d, h
	ld e, l

	hlcoord 10, 11
	ld a, [TempMonLevel]
	ld b, a
	call FillInExpBar
	pop de
	ret
; 3df98

UpdatePlayerHPPal: ; 3df98
	ld hl, PlayerHPPal
	jp Function3e12e
; 3df9e

CheckDanger: ; 3df9e
	ld hl, BattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .asm_3dfb2
	ld a, [$c6fd]
	and a
	jr nz, .asm_3dfbe
	ld a, [PlayerHPPal]
	cp $2
	jr z, .asm_3dfb9

.asm_3dfb2
	ld hl, Danger
	res 7, [hl]
	jr .asm_3dfbe

.asm_3dfb9
	ld hl, Danger
	set 7, [hl]

.asm_3dfbe
	ret
; 3dfbf

PrintPlayerHUD: ; 3dfbf
	ld de, BattleMonNick
	hlcoord 10, 7
	call Function3e138
	call PlaceString

	push bc

	ld a, [CurBattleMon]
	ld hl, PartyMon1DVs
	call GetPartyLocation
	ld de, TempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, BattleMonLevel
	ld de, TempMonLevel
	ld bc, $0011
	call CopyBytes
	ld a, [CurBattleMon]
	ld hl, PartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [CurPartySpecies], a
	ld [CurSpecies], a
	call GetBaseData

	pop hl
	dec hl

	ld a, $3
	ld [MonType], a
	callab GetGender
	ld a, $7f
	jr c, .asm_3e013
	ld a, $ef
	jr nz, .asm_3e013
	ld a, $f5

.asm_3e013
	ld hl, $c551
	ld [hl], a
	ld hl, $c54e
	push af
	push hl
	ld de, BattleMonStatus
	ld a, $21
	call Predef
	pop hl
	pop bc
	ret nz
	ld a, b
	cp $7f
	jr nz, .asm_3e02d
	dec hl

.asm_3e02d
	ld a, [BattleMonLevel]
	ld [TempMonLevel], a
	jp PrintLevel
; 3e036

Function3e036: ; 3e036
	push hl
	push de
	push bc
	call Function3e043
	call Function3e127
	pop bc
	pop de
	pop hl
	ret
; 3e043

Function3e043: ; 3e043
	xor a
	ld [hBGMapMode], a
	ld hl, $c4a1
	ld bc, $040b
	call ClearBox
	callba Function2c0c5
	ld a, [TempEnemyMonSpecies]
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	call GetBaseData
	ld de, EnemyMonNick
	ld hl, $c4a1
	call Function3e138
	call PlaceString
	ld h, b
	ld l, c
	dec hl
	ld hl, EnemyMonAtkDefDV
	ld de, TempMonDVs
	ld a, [EnemySubStatus5]
	bit 3, a
	jr z, .asm_3e080
	ld hl, $c6f2

.asm_3e080
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld a, $3
	ld [MonType], a
	callab GetGender
	ld a, $7f
	jr c, .asm_3e09a
	ld a, $ef
	jr nz, .asm_3e09a
	ld a, $f5

.asm_3e09a
	ld hl, $c4bd
	ld [hl], a
	ld hl, $c4ba
	push af
	push hl
	ld de, EnemyMonStatus
	ld a, $21
	call Predef
	pop hl
	pop bc
	jr nz, .asm_3e0be
	ld a, b
	cp $7f
	jr nz, .asm_3e0b5
	dec hl

.asm_3e0b5
	ld a, [EnemyMonLevel]
	ld [TempMonLevel], a
	call PrintLevel

.asm_3e0be
	ld hl, EnemyMonHPHi
	ld a, [hli]
	ld [$ffb5], a
	ld a, [hld]
	ld [$ffb6], a
	or [hl]
	jr nz, .asm_3e0d1
	ld c, a
	ld e, a
	ld d, $6
	jp .asm_3e11a

.asm_3e0d1
	xor a
	ld [hMultiplicand], a
	ld a, $30
	ld [hMultiplier], a
	call Multiply
	ld hl, EnemyMonMaxHPHi
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld [hMultiplier], a
	ld a, b
	and a
	jr z, .asm_3e105
	ld a, [hMultiplier]
	srl b
	rr a
	srl b
	rr a
	ld [hMultiplier], a
	ld a, [$ffb5]
	ld b, a
	srl b
	ld a, [$ffb6]
	rr a
	srl b
	rr a
	ld [$ffb6], a
	ld a, b
	ld [$ffb5], a

.asm_3e105
	ld a, [$ffb5]
	ld [hProduct], a
	ld a, [$ffb6]
	ld [hMultiplicand], a
	ld a, $2
	ld b, a
	call Divide
	ld a, [$ffb6]
	ld e, a
	ld a, $6
	ld d, a
	ld c, a
.asm_3e11a
	xor a
	ld [$d10a], a
	ld hl, $c4ca
	ld b, $0
	call DrawHPBar
	ret
; 3e127

Function3e127: ; 3e127
	ld hl, EnemyHPPal
	call Function3e12e
	ret
; 3e12e

Function3e12e: ; 3e12e
	ld b, [hl]
	call SetHPPal
	ld a, [hl]
	cp b
	ret z
	jp Function3ee27
; 3e138

Function3e138: ; 3e138
	ret
; 3e139

Function3e139: ; 3e139
	xor a
	ld [hBGMapMode], a
	call Function30bf
	ld a, [BattleType]
	cp $2
	jr z, .asm_3e156
	cp $3
	jr z, .asm_3e156
	call EmptyBattleTextBox
	call UpdateBattleHuds
	call EmptyBattleTextBox
	call Function309d

.asm_3e156
	ld a, [BattleType]
	cp $6
	jr nz, .asm_3e165
	callba Function24f13
	jr .asm_3e175

.asm_3e165
	ld a, [InputType]
	or a
	jr z, .asm_3e171
	callba Function1de294
.asm_3e171
	call Function3e19b
	ret c

.asm_3e175
	ld a, $1
	ld [hBGMapMode], a
	ld a, [$d0d2]
	cp $1
	jp z, Function3e192
	cp $3
	jp z, Function3e1c7
	cp $2
	jp z, Function3e28d
	cp $4
	jp z, Function3e489
	jr .asm_3e156
; 3e192

Function3e192: ; 3e192
	xor a
	ld [$d267], a
	call Function30b4
	and a
	ret
; 3e19b

Function3e19b: ; 3e19b
	call Function3d2f1
	jr z, .asm_3e1a8
	callba LoadBattleMenuDataHeader
	and a
	ret

.asm_3e1a8
	callba Function100b12
	ld a, [$cd2b]
	and a
	ret z
	ld hl, $cd2a
	bit 4, [hl]
	jr nz, .asm_3e1c5
	ld hl, $5863
	call StdBattleTextBox
	ld c, $3c
	call DelayFrame ; was DelayFrames

.asm_3e1c5
	scf
	ret
; 3e1c7

Function3e1c7: ; 3e1c7
	ld a, [InLinkBattle]
	and a
	jp nz, Function3e22b
	ld a, [$cfc0]
	and a
	jp nz, Function3e22b
	call Function1d6e
	ld a, [BattleType]
	cp $3
	jr z, .asm_3e1f1
	cp $6
	jr z, .asm_3e201
	callba Function10493
	ld a, [$d0ec]
	and a
	jr z, .asm_3e20d
	jr .asm_3e209

.asm_3e1f1
	callba Function107bb
	ld a, $5
	ld [CurItem], a
	call DoItemEffect
	jr .asm_3e209

.asm_3e201
	ld a, $b1
	ld [CurItem], a
	call DoItemEffect

.asm_3e209
	call Function3e234
	ret

.asm_3e20d
	call ClearPalettes
	call DelayFrame
	call Function3ed9f
	call Function3f43d
	call Function3f47c
	call Function1c07
	call WaitBGMap
	call Function3ee27
	call Function309d
	jp Function3e139
; 3e22b

Function3e22b: ; 3e22b
	ld hl, BattleText_0x80bf3
	call StdBattleTextBox
	jp Function3e139
; 3e234

Function3e234: ; 3e234
	ld a, [$c64e]
	and a
	jr nz, .asm_3e279
	callab CheckItemPocket
	ld a, [$d142]
	cp $3
	jr z, .asm_3e24a
	call WhiteBGMap

.asm_3e24a
	xor a
	ld [hBGMapMode], a
	call Function3ed9f
	call ClearSprites
	ld a, [BattleType]
	cp $3
	jr z, .asm_3e25d
	call Function3f43d

.asm_3e25d
	call Function3f47c
	ld a, $1
	ld [$cfa9], a
	call Function1c07
	call Function3df2c
	call WaitBGMap
	call Function309d
	call Function1fbf
	call Function3ee27
	and a
	ret

.asm_3e279
	xor a
	ld [$c64e], a
	ld a, [$d0ee]
	and $c0
	ld [$d0ee], a
	call Function1fbf
	call Function32f9
	scf
	ret
; 3e28d

Function3e28d: ; 3e28d
	call Function1d6e
Function3e290:
	call Function1c07
	call Function1d6e
	call WhiteBGMap
Function3e299:
	call Function3d2fa
	xor a
	ld [PartyMenuActionText], a
	call Function3d313
	call Function3d329
	jr c, .asm_3e2da
.asm_3e2a8
	callba Function8ea4a
	call Function3e2f5
	jr c, .asm_3e2c8
	call Function1bee
	ld a, [$cfa9]
	cp $1
	jp z, Function3e358
	cp $2
	jr z, .asm_3e2cf
	cp $3
	jr z, .asm_3e2da
	jr .asm_3e2a8

.asm_3e2c8
	call Function3d2e0
	jr c, .asm_3e2da
	jr Function3e299

.asm_3e2cf
	call Function3e308
	call Function3d2e0
	jr c, .asm_3e2da
	jp Function3e290

.asm_3e2da
	call ClearSprites
	call ClearPalettes
	call DelayFrame
	call Function3eda6
	call Function1c17
	call Function309d
	call ClearSGB
	call Function32f9
	jp Function3e139
; 3e2f5

Function3e2f5: ; 3e2f5
	call Function3d2f1
	jr z, .asm_3e301
	callba Function24e99
	ret

.asm_3e301
	callba Function100d22
	ret
; 3e308

Function3e308: ; 3e308
	call DisableLCD
	ld hl, $9310
	ld de, VTiles0
	ld bc, $0110
	call CopyBytes
	ld hl, VTiles2
	ld de, $8110
	ld bc, $0310
	call CopyBytes
	call EnableLCD
	call ClearSprites
	call LowVolume
	xor a
	ld [MonType], a
	callba Function4dc7b
	call MaxVolume
	call DisableLCD
	ld hl, VTiles0
	ld de, $9310
	ld bc, $0110
	call CopyBytes
	ld hl, $8110
	ld de, VTiles2
	ld bc, $0310
	call CopyBytes
	call EnableLCD
	ret
; 3e358


Function3e358: ; 3e358
	ld a, [CurBattleMon]
	ld d, a
	ld a, [CurPartyMon]
	cp d
	jr nz, .asm_3e36b
	ld hl, BattleText_0x80c0d
	call StdBattleTextBox
	jp Function3e299

.asm_3e36b
	ld a, [$c730]
	and a
	jr nz, .asm_3e378
	ld a, [EnemySubStatus5]
	bit 7, a
	jr z, .asm_3e381

.asm_3e378
	ld hl, BattleText_0x80c22
	call StdBattleTextBox
	jp Function3e299

.asm_3e381
	call Function3d887
	jp z, Function3e299
	ld a, [CurBattleMon]
	ld [$c71a], a
	ld a, $2
	ld [$d0ec], a
	call ClearPalettes
	call DelayFrame
	call ClearSprites
	call Function3eda6
	call Function1c17
	call ClearSGB
	call Function32f9
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	; fallthrough
; 3e3ad

Function3e3ad: ; 3e3ad
	ld a, $1
	ld [$c710], a
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3e3c1
	call Function1d6e
	call Function3e8e4
	call Function1c17

.asm_3e3c1
	call Function3e7c1
	ld a, [InLinkBattle]
	and a
	jr nz, .asm_3e3cf

.asm_3e3ca
	call Function3e40b
	and a
	ret

.asm_3e3cf
	ld a, [$d430]
	cp $e
	jp z, .asm_3e3ca
	cp $d
	jp z, .asm_3e3ca
	cp $4
	jp c, .asm_3e3ca
	cp $f
	jr nz, .asm_3e3e9
	call Function3c0e5
	ret

.asm_3e3e9
	ld a, [$ffcb]
	cp $1
	jr z, .asm_3e3f7
	call Function3e40b
	call Function3e3ff
	and a
	ret

.asm_3e3f7
	call Function3e3ff
	call Function3e40b
	and a
	ret
; 3e3ff

Function3e3ff: ; 3e3ff
	callab Function3846c
	call SetEnemyTurn
	jp Function3dc23
; 3e40b

Function3e40b: ; 3e40b
	call Function3f2f4
	ld c, $32
	call DelayFrame ; was DelayFrames
	ld hl, PlayerSubStatus4
	res 6, [hl]
	call SetEnemyTurn
	call Function3dc5b
	jr c, .asm_3e423
	call Function3dce6

.asm_3e423
	ld hl, $c535
	ld bc, $050b
	call ClearBox
	ld a, [CurBattleMon]
	ld [CurPartyMon], a
	call Function3d581
	call Function3da0d
	call Function3dab1
	call Function3f26d
	call Function3dbde
	call Function3dc18
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	call SetPlayerTurn
	call Function3dc23
	ld a, $2
	ld [$cfa9], a
	ret
; 3e459

Function3e459: ; 3e459
	ld c, $32
	call DelayFrame ; was DelayFrames
	ld hl, $c535
	ld bc, $050b
	call ClearBox
	ld a, [CurPartyMon]
	ld [CurBattleMon], a
	call Function3d581
	call Function3da0d
	xor a
	ld [$d265], a
	call Function3ecab
	call Function3db5f
	call EmptyBattleTextBox
	call Function309d
	call SetPlayerTurn
	jp Function3dc23
; 3e489



Function3e489: ; 3e489
	call Function30b4
	ld a, $3
	ld [$cfa9], a
	ld hl, BattleMonSpd
	ld de, EnemyMonSpd
	call Function3d8b3
	ld a, $0
	ld [$d266], a
	ret c
	ld a, [$d0ec]
	and a
	ret nz
	jp Function3e139
; 3e4a8



Function3e4a8: ; 3e4a8
	ld a, [BattleMonItem]
	ld b, a
	callab GetItem
	ld a, b
	cp $4c
	ret nz
	ld a, $1
	ld [$c73d], a
	ret
; 3e4bc

Function3e4bc: ; 3e4bc
	call Function3d2f1
	jr nz, .asm_3e4c8
	callba Function100b9f
	ret

.asm_3e4c8
	ld hl, EnemyMonMove1
	ld a, [$d235]
	dec a
	jr z, .asm_3e4e2
	dec a
	jr z, .asm_3e4dd
	call Function3e786
	ret z
	ld hl, BattleMonMove1
	jr .asm_3e4e2

.asm_3e4dd
	ld a, $2
	call GetPartyParamLocation

.asm_3e4e2
	ld de, $d25e
	ld bc, $0004
	call CopyBytes
	xor a
	ld [hBGMapMode], a
	ld hl, $c594
	ld b, $4
	ld c, $e
	ld a, [$d235]
	cp $2
	jr nz, .asm_3e503
	ld hl, $c544
	ld b, $4
	ld c, $e

.asm_3e503
	call TextBox
	ld hl, $c5aa
	ld a, [$d235]
	cp $2
	jr nz, .asm_3e513
	ld hl, $c55a

.asm_3e513
	ld a, $14
	ld [Buffer1], a
	ld a, $20
	call Predef
	ld b, $5
	ld a, [$d235]
	cp $2
	ld a, $d
	jr nz, .asm_3e52c
	ld b, $5
	ld a, $9

.asm_3e52c
	ld [$cfa1], a
	ld a, b
	ld [$cfa2], a
	ld a, [$d235]
	cp $1
	jr z, .asm_3e53e
	ld a, [CurMoveNum]
	inc a

.asm_3e53e
	ld [$cfa9], a
	ld a, $1
	ld [$cfaa], a
	ld a, [$d0eb]
	inc a
	ld [$cfa3], a
	ld a, $1
	ld [$cfa4], a
	ld c, $2c
	ld a, [$d235]
	dec a
	ld b, $c1
	jr z, .asm_3e569
	dec a
	ld b, $c3
	jr z, .asm_3e569
	ld a, [InLinkBattle]
	and a
	jr nz, .asm_3e569
	ld b, $c7

.asm_3e569
	ld a, b
	ld [$cfa8], a
	ld a, c
	ld [$cfa5], a
	xor a
	ld [$cfa6], a
	ld a, $10
	ld [$cfa7], a
.asm_3e57a
	ld a, [$d235]
	and a
	jr z, .asm_3e58e
	dec a
	jr nz, .asm_3e5a3
	ld hl, $c5c3
	ld de, .string_3e61c
	call PlaceString
	jr .asm_3e5a3

.asm_3e58e
	call MoveInfoBox
	ld a, [$d0e3]
	and a
	jr z, .asm_3e5a3
	ld hl, $c5a9
	ld bc, $0014
	dec a
	call AddNTimes
	ld [hl], $ec

.asm_3e5a3
	ld a, $1
	ld [hBGMapMode], a
	call Function1bd3
	bit 6, a
	jp nz, .asm_3e61d
	bit 7, a
	jp nz, .asm_3e62e
	bit 2, a
	jp nz, Function3e643
	bit 1, a
	push af
	xor a
	ld [$d0e3], a
	ld a, [$cfa9]
	dec a
	ld [$cfa9], a
	ld b, a
	ld a, [$d235]
	dec a
	jr nz, .asm_3e5d0
	pop af
	ret

.asm_3e5d0
	dec a
	ld a, b
	ld [CurMoveNum], a
	jr nz, .asm_3e5d9
	pop af
	ret

.asm_3e5d9
	pop af
	ret nz
	ld hl, BattleMonPPMove1
	ld a, [$cfa9]
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, .asm_3e610
	ld a, [PlayerDisableCount]
	swap a
	and $f
	dec a
	cp c
	jr z, .asm_3e60b
	ld a, [$c6e1]
	and a
	jr nz, .asm_3e606
	ld a, [$cfa9]
	ld hl, BattleMonMove1
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]

.asm_3e606
	ld [CurPlayerMove], a
	xor a
	ret

.asm_3e60b
	ld hl, BattleText_0x80c5b
	jr .asm_3e613

.asm_3e610
	ld hl, Function3cc39

.asm_3e613
	call StdBattleTextBox
	call Function30b4
	jp Function3e4bc
; 3e61c

.string_3e61c ; 3e61c
	db "@"
; 3e61d

.asm_3e61d
	ld a, [$cfa9]
	and a
	jp nz, .asm_3e57a
	ld a, [$d0eb]
	inc a
	ld [$cfa9], a
	jp .asm_3e57a
; 3e62e

.asm_3e62e: ; 3e62e
	ld a, [$cfa9]
	ld b, a
	ld a, [$d0eb]
	inc a
	inc a
	cp b
	jp nz, .asm_3e57a
	ld a, $1
	ld [$cfa9], a
	jp .asm_3e57a
; 3e643

Function3e643: ; 3e643
	ld a, [$d0e3]
	and a
	jr z, .asm_3e6bf
	ld hl, BattleMonMoves
	call .asm_3e6a5
	ld hl, BattleMonPP
	call .asm_3e6a5
	ld hl, PlayerDisableCount
	ld a, [hl]
	swap a
	and $f
	ld b, a
	ld a, [$cfa9]
	cp b
	jr nz, .asm_3e671
	ld a, [hl]
	and $f
	ld b, a
	ld a, [$d0e3]
	swap a
	add b
	ld [hl], a
	jr .asm_3e682

.asm_3e671
	ld a, [$d0e3]
	cp b
	jr nz, .asm_3e682
	ld a, [hl]
	and $f
	ld b, a
	ld a, [$cfa9]
	swap a
	add b
	ld [hl], a

.asm_3e682
	ld a, [PlayerSubStatus5]
	bit 3, a
	jr nz, .asm_3e69e
	ld hl, PartyMon1Moves
	ld a, [CurBattleMon]
	call GetPartyLocation
	push hl
	call .asm_3e6a5
	pop hl
	ld bc, $0015
	add hl, bc
	call .asm_3e6a5

.asm_3e69e
	xor a
	ld [$d0e3], a
	jp Function3e4bc

.asm_3e6a5
	push hl
	ld a, [$d0e3]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [$cfa9]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

.asm_3e6bf
	ld a, [$cfa9]
	ld [$d0e3], a
	jp Function3e4bc
; 3e6c8

MoveInfoBox: ; 3e6c8
	xor a
	ld [hBGMapMode], a

	hlcoord 0, 8
	ld b, 3
	ld c, 9
	call TextBox
	call MobileTextBorder

	ld a, [PlayerDisableCount]
	and a
	jr z, .asm_3e6f4

	swap a
	and $f
	ld b, a
	ld a, [$cfa9]
	cp b
	jr nz, .asm_3e6f4

	hlcoord 1, 10
	ld de, .Disabled
	call PlaceString
	jr .done

.asm_3e6f4
	ld hl, $cfa9
	dec [hl]
	call SetPlayerTurn
	ld hl, BattleMonMoves
	ld a, [$cfa9]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [CurPlayerMove], a

	ld a, [CurBattleMon]
	ld [CurPartyMon], a
	ld a, WILDMON
	ld [MonType], a
	callab Functionf8ec

	ld hl, $cfa9
	ld c, [hl]
	inc [hl]
	ld b, 0
	ld hl, BattleMonPP
	add hl, bc
	ld a, [hl]
	and $3f
	ld [StringBuffer1], a
	call Function3e75f

	hlcoord 1, 9
	ld de, .Type
	call PlaceString

	hlcoord 7, 11
	ld [hl], "/"

	callab UpdateMoveData
	ld a, [PlayerMoveAnimation]
	ld b, a
	hlcoord 2, 10
	ld a, PREDEF_PRINT_MOVE_TYPE
	call Predef

.done
	ret
; 3e74f

.Disabled
	db "Disabled!@"
.Type
	db "TYPE/@"
; 3e75f


Function3e75f: ; 3e75f
	hlcoord 5, 11
	ld a, [InLinkBattle]
	cp $4
	jr c, .asm_3e76c
	hlcoord 5, 11

.asm_3e76c
	push hl
	ld de, StringBuffer1
	ld bc, $0102
	call PrintNum
	pop hl
	inc hl
	inc hl
	ld [hl], "/"
	inc hl
	ld de, $d265
	ld bc, $0102
	call PrintNum
	ret
; 3e786

Function3e786: ; 3e786
	ld a, STRUGGLE
	ld [CurPlayerMove], a
	ld a, [PlayerDisableCount]
	and a
	ld hl, BattleMonPP
	jr nz, .asm_3e79f

	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	and $3f
	ret nz
	jr .asm_3e7b4

.asm_3e79f
	swap a
	and $f
	ld b, a
	ld d, $5
	xor a
.asm_3e7a7
	dec d
	jr z, .asm_3e7b2
	ld c, [hl]
	inc hl
	dec b
	jr z, .asm_3e7a7
	or c
	jr .asm_3e7a7

.asm_3e7b2
	and a
	ret nz

.asm_3e7b4
	ld hl, BattleText_0x80c72
	call StdBattleTextBox
	ld c, 60
	call DelayFrame ; was DelayFrames
	xor a
	ret
; 3e7c1



Function3e7c1: ; 3e7c1
	ld a, [$c711]
	and a
	ret nz
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3e817
	call EmptyBattleTextBox
	call Function309d
	ld a, [$d0ec]
	and a
	call z, Function3e8e4
	call Function30b4
	ld a, [$d430]
	cp $e
	jp z, .asm_3e8bd
	cp $d
	jp z, .asm_3e82c
	cp $4
	jp nc, Function3e8c1
	ld [CurEnemyMoveNum], a
	ld c, a
	ld a, [EnemySubStatus1]
	bit 6, a
	jp nz, .asm_3e882
	ld a, [EnemySubStatus3]
	and $13
	jp nz, .asm_3e882
	ld hl, EnemySubStatus5
	bit 4, [hl]
	ld a, [LastEnemyMove]
	jp nz, .asm_3e87f
	ld hl, EnemyMonMove1
	ld b, $0
	add hl, bc
	ld a, [hl]
	jp .asm_3e87f

.asm_3e817
	ld hl, EnemySubStatus5
	bit 4, [hl]
	jr z, .asm_3e824
	ld a, [LastEnemyMove]
	jp .asm_3e87f

.asm_3e824
	call Function3e8d1
	jp nz, Function3e8c1
	jr .asm_3e830

.asm_3e82c
	ld a, $ff
	jr .asm_3e87f

.asm_3e830
	ld hl, EnemyMonMove1
	ld de, EnemyMonPPMove1
	ld b, $4
.asm_3e838
	ld a, [hl]
	and a
	jp z, .asm_3e8bd
	ld a, [EnemyDisabledMove]
	cp [hl]
	jr z, .asm_3e848
	ld a, [de]
	and $3f
	jr nz, .asm_3e84f

.asm_3e848
	inc hl
	inc de
	dec b
	jr nz, .asm_3e838
	jr .asm_3e8bd

.asm_3e84f
	ld a, [IsInBattle]
	dec a
	jr nz, .asm_3e882
.asm_3e855
	ld hl, EnemyMonMove1
	call BattleRandom
	and $3
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [EnemyDisableCount]
	swap a
	and $f
	dec a
	cp c
	jr z, .asm_3e855
	ld a, [hl]
	and a
	jr z, .asm_3e855
	ld hl, EnemyMonPPMove1
	add hl, bc
	ld b, a
	ld a, [hl]
	and $3f
	jr z, .asm_3e855
	ld a, c
	ld [CurEnemyMoveNum], a
	ld a, b

.asm_3e87f
	ld [CurEnemyMove], a

.asm_3e882
	call SetEnemyTurn
	callab UpdateMoveData
	call Function3e8d1
	jr nz, .asm_3e894
	xor a
	ld [$c733], a

.asm_3e894
	ld a, [EnemyMoveEffect]
	cp $77
	jr z, .asm_3e89f
	xor a
	ld [EnemyFuryCutterCount], a

.asm_3e89f
	ld a, [EnemyMoveEffect]
	cp $51
	jr z, .asm_3e8af
	ld hl, EnemySubStatus4
	res 6, [hl]
	xor a
	ld [$c72c], a

.asm_3e8af
	ld a, [EnemyMoveEffect]
	cp $6f
	ret z
	cp $74
	ret z
	xor a
	ld [$c681], a
	ret

.asm_3e8bd
	ld a, $a5
	jr .asm_3e87f
; 3e8c1

Function3e8c1: ; 3e8c1
	xor a
	ld [EnemyFuryCutterCount], a
	ld [$c681], a
	ld [$c72c], a
	ld hl, EnemySubStatus4
	res 6, [hl]
	ret
; 3e8d1

Function3e8d1: ; 3e8d1
	ld a, [EnemySubStatus4]
	and $20
	ret nz
	ld hl, EnemySubStatus3
	ld a, [hl]
	and $13
	ret nz
	ld hl, EnemySubStatus1
	bit 6, [hl]
	ret
; 3e8e4

Function3e8e4: ; 3e8e4
	callba Function100a09
	ret
; 3e8eb


LoadEnemyMon: ; 3e8eb
; Initialize enemy monster parameters
; To do this we pull the species from TempEnemyMonSpecies

; Notes:
;   BattleRandom is used to ensure sync between Game Boys

; Clear the whole EnemyMon struct
	xor a
	ld hl, EnemyMonSpecies
	ld bc, EnemyMonEnd - EnemyMon
	call ByteFill
	
; We don't need to be here if we're in a link battle
	ld a, [InLinkBattle]
	and a
	jp nz, Function3dabd
	
	ld a, [$cfc0] ; ????
	bit 0, a
	jp nz, Function3dabd
	
; Make sure everything knows what species we're working with
	ld a, [TempEnemyMonSpecies]
	ld [EnemyMonSpecies], a
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	
; Grab the BaseData for this species
	call GetBaseData
	

; Let's get the item:

; Is the item predetermined?
	ld a, [IsInBattle]
	dec a
	jr z, .WildItem
	
; If we're in a trainer battle, the item is in the party struct
	ld a, [CurPartyMon]
	ld hl, OTPartyMon1Item
	call GetPartyLocation ; bc = PartyMon[CurPartyMon] - PartyMons
	ld a, [hl]
	jr .UpdateItem
	
	
.WildItem
; In a wild battle, we pull from the item slots in BaseData

; Force Item1
; Used for Ho-Oh, Lugia and Snorlax encounters
	ld a, [BattleType]
	cp BATTLETYPE_FORCEITEM
	ld a, [BaseItems]
	jr z, .UpdateItem
	
; Failing that, it's all up to chance
;  Effective chances:
;    75% None
;    23% Item1
;     2% Item2

; 25% chance of getting an item
	call BattleRandom
	cp a, $c0
	ld a, NO_ITEM
	jr c, .UpdateItem
	
; From there, an 8% chance for Item2
	call BattleRandom
	cp a, $14 ; 8% of 25% = 2% Item2
	ld a, [BaseItems]
	jr nc, .UpdateItem
	ld a, [BaseItems+1]
	
	
.UpdateItem
	ld [EnemyMonItem], a
	
	
; Initialize DVs
	
; If we're in a trainer battle, DVs are predetermined
	ld a, [IsInBattle]
	and a
	jr z, .InitDVs
	
; ????
	ld a, [EnemySubStatus5]
	bit 3, a
	jr z, .InitDVs
	
; Unknown
	ld hl, $c6f2
	ld de, EnemyMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jp .Happiness
	
	
.InitDVs
	
; Trainer DVs
	
; All trainers have preset DVs, determined by class
; See GetTrainerDVs for more on that
	callba GetTrainerDVs
; These are the DVs we'll use if we're actually in a trainer battle
	ld a, [IsInBattle]
	dec a
	jr nz, .UpdateDVs
	
	
; Wild DVs
; Here's where the fun starts

; Roaming monsters (Entei, Raikou) work differently
; They have their own structs, which are shorter than normal
	ld a, [BattleType]
	cp a, BATTLETYPE_ROAMING
	jr nz, .NotRoaming
	
; Grab HP
	call GetRoamMonHP
	ld a, [hl]
; Check if the HP has been initialized
	and a
; We'll do something with the result in a minute
	push af
	
; Grab DVs
	call GetRoamMonDVs
	inc hl
	ld a, [hld]
	ld c, a
	ld b, [hl]

; Get back the result of our check
	pop af
; If the RoamMon struct has already been initialized, we're done
	jr nz, .UpdateDVs
	
; If it hasn't, we need to initialize the DVs
; (HP is initialized at the end of the battle)
	call GetRoamMonDVs
	inc hl
	call BattleRandom
	ld [hld], a
	ld c, a
	call BattleRandom
	ld [hl], a
	ld b, a
; We're done with DVs
	jr .UpdateDVs

	
.NotRoaming
; Register a contains BattleType

; Forced shiny battle type
; Used by Red Gyarados at Lake of Rage
	cp a, BATTLETYPE_SHINY
	jr nz, .GenerateDVs

	ld b, ATKDEFDV_SHINY ; $ea
	ld c, SPDSPCDV_SHINY ; $aa
	jr .UpdateDVs
	
.GenerateDVs
; Generate new random DVs
	call BattleRandom
	ld b, a
	call BattleRandom
	ld c, a
	
.UpdateDVs
; Input DVs in register bc
	ld hl, EnemyMonDVs
	ld a, b
	ld [hli], a
	ld [hl], c
	
	
; We've still got more to do if we're dealing with a wild monster
	ld a, [IsInBattle]
	dec a
	jr nz, .Happiness
	
	
; Species-specfic:
	
	
; Unown
	ld a, [TempEnemyMonSpecies]
	cp a, UNOWN
	jr nz, .Magikarp
	
; Get letter based on DVs
	ld hl, EnemyMonDVs
	ld a, PREDEF_GET_UNOWN_LETTER
	call Predef
; Can't use any letters that haven't been unlocked
; If combined with forced shiny battletype, causes an infinite loop
	call CheckUnownLetter
	jr c, .GenerateDVs ; try again
	
	
.Magikarp
; Skimming this part recommended
	
	ld a, [TempEnemyMonSpecies]
	cp a, MAGIKARP
	jr nz, .Happiness
	
; Get Magikarp's length
	ld de, EnemyMonDVs
	ld bc, PlayerID
	callab CalcMagikarpLength
	
; We're clear if the length is < 1536
	ld a, [MagikarpLength]
	cp a, $06 ; $600 = 1536
	jr nz, .CheckMagikarpArea
	
; 5% chance of skipping size checks
	call Random
	cp a, $0c ; / $100
	jr c, .CheckMagikarpArea
; Try again if > 1614
	ld a, [MagikarpLength + 1]
	cp a, $50
	jr nc, .GenerateDVs
	
; 20% chance of skipping this check
	call Random
	cp a, $32 ; / $100
	jr c, .CheckMagikarpArea
; Try again if > 1598
	ld a, [MagikarpLength + 1]
	cp a, $40
	jr nc, .GenerateDVs
	
.CheckMagikarpArea
; The z checks are supposed to be nz
; Instead, all maps in GROUP_LAKE_OF_RAGE (mahogany area)
; and routes 20 and 44 are treated as Lake of Rage
	
; This also means Lake of Rage Magikarp can be smaller than ones
; caught elsewhere rather than the other way around
	
; Intended behavior enforces a minimum size at Lake of Rage
; The real behavior prevents size flooring in the Lake of Rage area
	ld a, [MapGroup]
	cp a, GROUP_LAKE_OF_RAGE
	jr z, .Happiness
	ld a, [MapNumber]
	cp a, MAP_LAKE_OF_RAGE
	jr z, .Happiness
; 40% chance of not flooring
	call Random
	cp a, $64 ; / $100
	jr c, .Happiness
; Floor at length 1024
	ld a, [MagikarpLength]
	cp a, 1024 >> 8
	jr c, .GenerateDVs ; try again
	
	
; Finally done with DVs
	
.Happiness
; Set happiness
	ld a, BASE_HAPPINESS
	ld [EnemyMonHappiness], a
; Set level
	ld a, [CurPartyLevel]
	ld [EnemyMonLevel], a
; Fill stats
	ld de, EnemyMonMaxHP
	ld b, $00
	ld hl, $d201 ; ?
	ld a, PREDEF_FILLSTATS
	call Predef
	
; If we're in a trainer battle,
; get the rest of the parameters from the party struct
	ld a, [IsInBattle]
	cp a, TRAINER_BATTLE
	jr z, .OpponentParty
	
; If we're in a wild battle, check wild-specific stuff
	and a
	jr z, .TreeMon
	
; ????
	ld a, [EnemySubStatus5]
	bit 3, a
	jp nz, .Moves
	
.TreeMon
; If we're headbutting trees, some monsters enter battle asleep
	call CheckSleepingTreeMon
	ld a, 7 ; Asleep for 7 turns
	jr c, .UpdateStatus
; Otherwise, no status
	xor a
	
.UpdateStatus
	ld hl, EnemyMonStatus
	ld [hli], a
	
; Unused byte
	xor a
	ld [hli], a
	
; Full HP...
	ld a, [EnemyMonMaxHPHi]
	ld [hli], a
	ld a, [EnemyMonMaxHPLo]
	ld [hl], a
	
; ...unless it's a RoamMon
	ld a, [BattleType]
	cp a, BATTLETYPE_ROAMING
	jr nz, .Moves
	
; Grab HP
	call GetRoamMonHP
	ld a, [hl]
; Check if it's been initialized again
	and a
	jr z, .InitRoamHP
; Update from the struct if it has
	ld a, [hl]
	ld [EnemyMonHPLo], a
	jr .Moves
	
.InitRoamHP
; HP only uses the lo byte in the RoamMon struct since
; Raikou/Entei/Suicune will have < 256 hp at level 40
	ld a, [EnemyMonHPLo]
	ld [hl], a
	jr .Moves
	
	
.OpponentParty
; Get HP from the party struct
	ld hl, (PartyMon1CurHP + 1) - PartyMon1 + OTPartyMon1
	ld a, [CurPartyMon]
	call GetPartyLocation
	ld a, [hld]
	ld [EnemyMonHPLo], a
	ld a, [hld]
	ld [EnemyMonHPHi], a
	
; Make sure everything knows which monster the opponent is using
	ld a, [CurPartyMon]
	ld [CurOTMon], a
	
; Get status from the party struct
	dec hl
	ld a, [hl] ; OTPartyMonStatus
	ld [EnemyMonStatus], a
	
	
.Moves
; ????
	ld hl, BaseType1
	ld de, EnemyMonType1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	
; Get moves
	ld de, EnemyMonMoves
; Are we in a trainer battle?
	ld a, [IsInBattle]
	cp a, TRAINER_BATTLE
	jr nz, .WildMoves
; Then copy moves from the party struct
	ld hl, OTPartyMon1Moves
	ld a, [CurPartyMon]
	call GetPartyLocation
	ld bc, NUM_MOVES
	call CopyBytes
	jr .PP
	
.WildMoves
; Clear EnemyMonMoves
	xor a
	ld h, d
	ld l, e
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
; Make sure the predef knows this isn't a partymon
	ld [MagikarpLength], a
; Fill moves based on level
	ld a, PREDEF_FILLMOVES
	call Predef
	
.PP
; Trainer battle?
	ld a, [IsInBattle]
	cp a, TRAINER_BATTLE
	jr z, .TrainerPP
	
; Fill wild PP
	ld hl, EnemyMonMoves
	ld de, EnemyMonPP
	ld a, PREDEF_FILLPP
	call Predef
	jr .Finish
	
.TrainerPP
; Copy PP from the party struct
	ld hl, OTPartyMon1PP
	ld a, [CurPartyMon]
	call GetPartyLocation
	ld de, EnemyMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	
.Finish
; Only the first five base stats are copied...
	ld hl, BaseStats
	ld de, EnemyMonBaseStats
	ld b, BaseSpecialDefense - BaseStats
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	ld a, [BaseCatchRate]
	ld [de], a
	inc de

	ld a, [BaseExp]
	ld [de], a

	ld a, [TempEnemyMonSpecies]
	ld [$d265], a

	call GetPokemonName

; Did we catch it?
	ld a, [IsInBattle]
	and a
	ret z

; Update enemy nick
	ld hl, StringBuffer1
	ld de, EnemyMonNick
	ld bc, PKMN_NAME_LENGTH
	call CopyBytes

; Caught this mon
	ld a, [TempEnemyMonSpecies]
	dec a
	ld c, a
	ld b, 1 ; set
	ld hl, PokedexSeen
	ld a, PREDEF_FLAG
	call Predef

	ld hl, EnemyMonStats
	ld de, EnemyStats
	ld bc, EnemyMonStatsEnd - EnemyMonStats
	call CopyBytes

	ret
; 3eb38


CheckSleepingTreeMon: ; 3eb38
; Return carry if species is in the list
; for the current time of day

; Don't do anything if this isn't a tree encounter
	ld a, [BattleType]
	cp a, BATTLETYPE_TREE
	jr nz, .NotSleeping
	
; Get list for the time of day
	ld hl, .Morn
	ld a, [TimeOfDay]
	cp a, DAY
	jr c, .Check
	ld hl, .Day
	jr z, .Check
	ld hl, .Nite
	
.Check
	ld a, [TempEnemyMonSpecies]
	ld de, 1 ; length of species id
	call IsInArray
; If it's a match, the opponent is asleep
	ret c
	
.NotSleeping
	and a
	ret

.Nite
	db CATERPIE
	db METAPOD
	db BUTTERFREE
	db WEEDLE
	db KAKUNA
	db BEEDRILL
	db SPEAROW
	db EKANS
	db EXEGGCUTE
	db LEDYBA
	db AIPOM
	db $ff ; end

.Day
	db VENONAT
	db HOOTHOOT
	db NOCTOWL
	db SPINARAK
	db HERACROSS
	db $ff ; end

.Morn
	db VENONAT
	db HOOTHOOT
	db NOCTOWL
	db SPINARAK
	db HERACROSS
	db $ff ; end
; 3eb75


CheckUnownLetter: ; 3eb75
; Return carry if the Unown letter hasn't been unlocked yet
	
	ld a, [UnlockedUnowns]
	ld c, a
	ld de, 0
	
.loop
	
; Don't check this set unless it's been unlocked
	srl c
	jr nc, .next
	
; Is our letter in the set?
	ld hl, .LetterSets
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	
	push de
	ld a, [UnownLetter]
	ld de, 1
	push bc
	call IsInArray
	pop bc
	pop de
	
	jr c, .match
	
.next
; Make sure we haven't gone past the end of the table
	inc e
	inc e
	ld a, e
	cp a, .Set1 - .LetterSets
	jr c, .loop
	
; Hasn't been unlocked, or the letter is invalid
	scf
	ret
	
.match
; Valid letter
	and a
	ret
	
.LetterSets
	dw .Set1
	dw .Set2
	dw .Set3
	dw .Set4
	
.Set1
	;  A   B   C   D   E   F   G   H   I   J   K
	db 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, $ff
.Set2
	;  L   M   N   O   P   Q   R
	db 12, 13, 14, 15, 16, 17, 18, $ff
.Set3
	;  S   T   U   V   W
	db 19, 20, 21, 22, 23, $ff
.Set4
	;  X   Y   Z
	db 24, 25, 26, $ff
	
; 3ebc7


Function3ebc7: ; 3ebc7
	push bc
	ld a, [BattleMonLevel]
	ld b, a
	ld a, [EnemyMonLevel]
	ld [BattleMonLevel], a
	ld a, b
	ld [EnemyMonLevel], a
	pop bc
	ret
; 3ebd8

Function3ebd8: ; 3ebd8
	xor a
	ld [TempEnemyMonSpecies], a
	call Function3ee27
	ld a, [OtherTrainerClass]
	ld [TrainerClass], a
	ld de, VTiles2
	callab Function5120d
	ld hl, $c4b3
	ld c, $0
.asm_3ebf3
	inc c
	ld a, c
	cp $7
	ret z
	xor a
	ld [hBGMapMode], a
	ld [hBGMapThird], a
	ld d, $0
	push bc
	push hl
.asm_3ec01
	call Function3ec1a
	inc hl
	ld a, $7
	add d
	ld d, a
	dec c
	jr nz, .asm_3ec01
	ld a, $1
	ld [hBGMapMode], a
	ld c, $4
	call DelayFrame ; was DelayFrames
	pop hl
	pop bc
	dec hl
	jr .asm_3ebf3
; 3ec1a

Function3ec1a: ; 3ec1a
	push hl
	push de
	push bc
	ld e, $7
.asm_3ec1f
	ld [hl], d
	ld bc, $0014
	add hl, bc
	inc d
	dec e
	jr nz, .asm_3ec1f
	pop bc
	pop de
	pop hl
	ret
; 3ec2c


Function3ec2c: ; 3ec2c
	ld a, 1
	jr Function3ec31
; 3ec30

Function3ec30: ; 3ec30
	xor a
; 3ec31

Function3ec31: ; 3ec31
	ld [hBattleTurn], a
	call Function3ec39
	jp Function3ec76
; 3ec39

Function3ec39: ; 3ec39
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3ec5a
	ld a, [BattleMonStatus]
	and $40
	ret z
	ld hl, $c645
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .asm_3ec58
	ld b, $1

.asm_3ec58
	ld [hl], b
	ret

.asm_3ec5a
	ld a, [EnemyMonStatus]
	and $40
	ret z
	ld hl, $d21f
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .asm_3ec74
	ld b, $1

.asm_3ec74
	ld [hl], b
	ret
; 3ec76

Function3ec76: ; 3ec76
	ld a, [hBattleTurn]
	and a
	jr z, .asm_3ec93
	ld a, [BattleMonStatus]
	and $10
	ret z
	ld hl, $c641
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .asm_3ec91
	ld b, $1

.asm_3ec91
	ld [hl], b
	ret

.asm_3ec93
	ld a, [EnemyMonStatus]
	and $10
	ret z
	ld hl, $d21b
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .asm_3eca9
	ld b, $1

.asm_3eca9
	ld [hl], b
	ret
; 3ecab

Function3ecab: ; 3ecab
	ld c, 0
.asm_3ecad
	call Function3ecb7
	inc c
	ld a, c
	cp 5
	jr nz, .asm_3ecad
	ret
; 3ecb7

Function3ecb7: ; 3ecb7
	push bc
	push bc
	ld a, [$d265]
	and a
	ld a, c
	ld hl, BattleMonAtk
	ld de, PlayerStats
	ld bc, PlayerAtkLevel
	jr z, .asm_3ecd2
	ld hl, EnemyMonAtk
	ld de, EnemyStats
	ld bc, EnemyAtkLevel

.asm_3ecd2
	add c
	ld c, a
	jr nc, .asm_3ecd7
	inc b
.asm_3ecd7
	ld a, [bc]
	pop bc
	ld b, a
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, .asm_3ece6
	inc d
.asm_3ece6
	pop bc
	push hl
	ld hl, .StatLevelMultipliers
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	xor a
	ld [hMultiplicand], a
	ld a, [de]
	ld [$ffb5], a
	inc de
	ld a, [de]
	ld [$ffb6], a
	ld a, [hli]
	ld [hMultiplier], a
	call Multiply
	ld a, [hl]
	ld [hMultiplier], a
	ld b, $4
	call Divide
	pop hl

; Cap at 999.
	ld a, [$ffb6]
	sub 999 % $100
	ld a, [$ffb5]
	sbc 999 / $100
	jp c, .asm_3ed1e

	ld a, 999 / $100
	ld [$ffb5], a
	ld a, 999 % $100
	ld [$ffb6], a

.asm_3ed1e
	ld a, [$ffb5]
	ld [hli], a
	ld b, a
	ld a, [$ffb6]
	ld [hl], a
	or b
	jr nz, .asm_3ed29
	inc [hl]

.asm_3ed29
	pop bc
	ret
; 3ed2b

.StatLevelMultipliers
;	      /
	db 25, 100 ; 25%
	db 28, 100 ; 28%
	db 33, 100 ; 33%
	db 40, 100 ; 40%
	db 50, 100 ; 50%
	db 66, 100 ; 66%

	db  1,  1 ; 100%

	db 15, 10 ; 150%
	db  2,  1 ; 200%
	db 25, 10 ; 250%
	db  3,  1 ; 300%
	db 35, 10 ; 350%
	db  4,  1 ; 400%
; 3ed45


BadgeStatBoosts: ; 3ed45
; Raise BattleMon stats depending on which badges have been obtained.

; Every other badge boosts a stat, starting from the first.

; 	ZephyrBadge:  Attack
; 	PlainBadge:   Speed
; 	MineralBadge: Defense
; 	GlacierBadge: Special Attack
; 	RisingBadge:  Special Defense

; The boosted stats are in order, except PlainBadge and MineralBadge's boosts are swapped.

	ld a, [InLinkBattle]
	and a
	ret nz

	ld a, [$cfc0]
	and a
	ret nz

	ld a, [JohtoBadges]

; Swap badges 3 (PlainBadge) and 5 (MineralBadge).
	ld d, a
	and %00000100
	add a
	add a
	ld b, a
	ld a, d
	and %00010000
	rrca
	rrca
	ld c, a
	ld a, d
	and %11101011
	or b
	or c
	ld b, a

	ld hl, BattleMonAtk
	ld c, 4
.CheckBadge
	ld a, b
	srl b
	call c, BoostStat
	inc hl
	inc hl
; Check every other badge.
	srl b
	dec c
	jr nz, .CheckBadge
; And the last one (RisingBadge) too.
	srl a
	call c, BoostStat
	ret
; 3ed7c


BoostStat: ; 3ed7c
; Raise stat at hl by 1/8.

	ld a, [hli]
	ld d, a
	ld e, [hl]
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hli], a

; Cap at 999.
	ld a, [hld]
	sub 999 % $100
	ld a, [hl]
	sbc 999 / $100
	ret c
	ld a, 999 / $100
	ld [hli], a
	ld a, 999 % $100
	ld [hld], a
	ret
; 3ed9f


Function3ed9f: ; 3ed9f
	callab Functionfb4f2
	ret
; 3eda6

Function3eda6: ; 3eda6
	callab Functionfb50d
	ret
; 3edad


Function3edad: ; 3edad
	ld de, $4ac0
	ld hl, $96c0
	ld bc, $3e04
	call Get1bpp
	ld de, $4ae0
	ld hl, $9730
	ld bc, $3e06
	call Get1bpp
	ld de, $4b10
	ld hl, $9550
	ld bc, $3e08
	jp Get2bpp
; 3edd1


EmptyBattleTextBox: ; 3edd1
	ld hl, .empty
	jp BattleTextBox
.empty
	db "@"
; 3edd8


_BattleRandom: ; 3edd8
; If the normal RNG is used in a link battle it'll desync.
; To circumvent this a shared PRNG is used instead.

; But if we're in a non-link battle we're safe to use it
	ld a, [InLinkBattle]
	and a
	jp z, Random

; The PRNG operates in streams of 10 values.

; Which value are we trying to pull?
	push hl
	push bc
	ld a, [LinkBattleRNCount]
	ld c, a
	ld b, 0
	ld hl, LinkBattleRNs
	add hl, bc
	inc a
	ld [LinkBattleRNCount], a

; If we haven't hit the end yet, we're good
	cp 10 - 1 ; Exclude last value. See the closing comment
	ld a, [hl]
	pop bc
	pop hl
	ret c

; If we have, we have to generate new pseudorandom data
; Instead of having multiple PRNGs, ten seeds are used
	push hl
	push bc
	push af

; Reset count to 0
	xor a
	ld [LinkBattleRNCount], a
	ld hl, LinkBattleRNs
	ld b, 10 ; number of seeds

; Generate next number in the sequence for each seed
; The algorithm takes the form *5 + 1 % 256
.loop
	; get last #
	ld a, [hl]

	; a * 5 + 1
	ld c, a
	add a
	add a
	add c
	inc a

	; update #
	ld [hli], a
	dec b
	jr nz, .loop

; This has the side effect of pulling the last value first,
; then wrapping around. As a result, when we check to see if
; we've reached the end, we check the one before it.

	pop af
	pop bc
	pop hl
	ret
; 3ee0f


Function3ee0f: ; 3ee0f
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
; 3ee17

Function3ee17: ; 3ee17
	ld a, e
	ld [FXAnimIDLo], a
	ld a, d
	ld [FXAnimIDHi], a
	call WaitBGMap
	ld a, $37
	jp Predef
; 3ee27

Function3ee27: ; 3ee27
	push af
	push bc
	push de
	push hl
	ld b, $1
	call GetSGBLayout
	call Function32f9
	call DelayFrame
	pop hl
	pop de
	pop bc
	pop af
	ret
; 3ee3b


Function3ee3b: ; 3ee3b
	ld a, [InLinkBattle]
	and a
	ret nz
	ld a, [$cfc0]
	bit 0, a
	ret nz
	call Function3f0d4
	xor a
	ld [CurPartyMon], a
	ld bc, PartyMon1Species

.asm_3ee50
	ld hl, $0022
	add hl, bc
	ld a, [hli]
	or [hl]
	jp z, .asm_3f0b9
	push bc
	ld hl, $c664
	ld a, [CurPartyMon]
	ld c, a
	ld b, $2
	ld d, $0
	ld a, $3
	call Predef
	ld a, c
	and a
	pop bc
	jp z, .asm_3f0b9
	ld hl, $000c
	add hl, bc
	ld d, h
	ld e, l
	ld hl, EnemyMonType2
	push bc
	ld c, $5
.asm_3ee7c
	inc hl
	ld a, [de]
	add [hl]
	ld [de], a
	jr nc, .asm_3ee89
	dec de
	ld a, [de]
	inc a
	jr z, .asm_3eea4
	ld [de], a
	inc de

.asm_3ee89
	push hl
	push bc
	ld a, $1c
	call GetPartyParamLocation
	ld a, [hl]
	and a
	pop bc
	pop hl
	jr z, .asm_3eea9
	ld a, [de]
	add [hl]
	ld [de], a
	jr nc, .asm_3eea9
	dec de
	ld a, [de]
	inc a
	jr z, .asm_3eea4
	ld [de], a
	inc de
	jr .asm_3eea9

.asm_3eea4
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a

.asm_3eea9
	inc de
	inc de
	dec c
	jr nz, .asm_3ee7c
	xor a
	ld [hMultiplicand], a
	ld [$ffb5], a
	ld a, [EnemyMonBaseExp]
	ld [$ffb6], a
	ld a, [EnemyMonLevel]
	ld [hMultiplier], a
	call Multiply
	ld a, $7
	ld [hMultiplier], a
	ld b, $4
	call Divide
	pop bc
	ld hl, $0006
	add hl, bc
	ld a, [PlayerID]
	cp [hl]
	jr nz, .asm_3eedd
	inc hl
	ld a, [$d47c]
	cp [hl]
	ld a, $0
	jr z, .asm_3eee2

.asm_3eedd
	call Function3f106
	ld a, $1

.asm_3eee2
	ld [$d088], a
	ld a, [IsInBattle]
	dec a
	call nz, Function3f106
	push bc
	ld a, $1
	call GetPartyParamLocation
	ld a, [hl]
	cp $7e
	call z, Function3f106
	ld a, [$ffb6]
	ld [$d087], a
	ld a, [$ffb5]
	ld [StringBuffer2], a
	ld a, [CurPartyMon]
	ld hl, PartyMon1Nickname
	call GetNick
	ld hl, UnknownText_0x3f11b
	call BattleTextBox
	ld a, [$d087]
	ld [$ffb6], a
	ld a, [StringBuffer2]
	ld [$ffb5], a
	pop bc
	call Function3f136
	push bc
	call Function309d
	pop bc
	ld hl, $000a
	add hl, bc
	ld d, [hl]
	ld a, [$ffb6]
	add d
	ld [hld], a
	ld d, [hl]
	ld a, [$ffb5]
	adc d
	ld [hl], a
	jr nc, .asm_3ef3d
	dec hl
	inc [hl]
	jr nz, .asm_3ef3d
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.asm_3ef3d
	ld a, [CurPartyMon]
	ld e, a
	ld d, $0
	ld hl, PartySpecies
	add hl, de
	ld a, [hl]
	ld [CurSpecies], a
	call GetBaseData
	push bc
	ld d, $64
	callab Function50e47
	pop bc
	ld hl, $000a
	add hl, bc
	push bc
	ld a, [hMultiplicand]
	ld b, a
	ld a, [$ffb5]
	ld c, a
	ld a, [$ffb6]
	ld d, a
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .asm_3ef74
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

.asm_3ef74
	xor a
	ld [MonType], a
	ld a, $1f
	call Predef
	callab Function50e1b
	pop bc
	ld hl, $001f
	add hl, bc
	ld a, [hl]
	cp $64
	jp nc, .asm_3f0b9
	cp d
	jp z, .asm_3f0b9
	ld [$c719], a
	ld a, [CurPartyLevel]
	push af
	ld a, d
	ld [CurPartyLevel], a
	ld [hl], a
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	ld [CurSpecies], a
	ld [$d265], a
	call GetBaseData
	ld hl, $0025
	add hl, bc
	ld a, [hld]
	ld e, a
	ld d, [hl]
	push de
	ld hl, $0024
	add hl, bc
	ld d, h
	ld e, l
	ld hl, $000a
	add hl, bc
	push bc
	ld b, $1
	ld a, $c
	call Predef
	pop bc
	pop de
	ld hl, $0025
	add hl, bc
	ld a, [hld]
	sub e
	ld e, a
	ld a, [hl]
	sbc d
	ld d, a
	dec hl
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	ld a, [CurBattleMon]
	ld d, a
	ld a, [CurPartyMon]
	cp d
	jr nz, .asm_3f035
	ld de, BattleMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, BattleMonMaxHP
	push bc
	ld bc, $000c
	call CopyBytes
	pop bc
	ld hl, $001f
	add hl, bc
	ld a, [hl]
	ld [BattleMonLevel], a
	ld a, [PlayerSubStatus5]
	bit 3, a
	jr nz, .asm_3f012
	ld hl, $0026
	add hl, bc
	ld de, PlayerStats
	ld bc, $000a
	call CopyBytes

.asm_3f012
	xor a
	ld [$d265], a
	call Function3ecab
	callab Function3ec2c
	callab BadgeStatBoosts
	callab Function3df48
	call EmptyBattleTextBox
	call Function309d
	ld a, $1
	ld [hBGMapMode], a

.asm_3f035
	callba Function2709e
	ld a, [CurBattleMon]
	ld b, a
	ld a, [CurPartyMon]
	cp b
	jr z, .asm_3f057
	ld de, SFX_HIT_END_OF_EXP_BAR
	call PlaySFX
	call WaitSFX
	ld hl, BattleText_0x80c9c
	call StdBattleTextBox
	call Function309d

.asm_3f057
	xor a
	ld [MonType], a
	ld a, $1f
	call Predef
	ld hl, $c4a9
	ld b, $a
	ld c, $9
	call TextBox
	ld hl, $c4bf
	ld bc, $0004
	ld a, $28
	call Predef
	ld c, $1e
	call DelayFrame ; was DelayFrames
	call Functiona80
	call Function30b4
	xor a
	ld [MonType], a
	ld a, [CurSpecies]
	ld [$d265], a
	ld a, [CurPartyLevel]
	push af
	ld c, a
	ld a, [$c719]
	ld b, a

.asm_3f093
	inc b
	ld a, b
	ld [CurPartyLevel], a
	push bc
	ld a, $1a
	call Predef
	pop bc
	ld a, b
	cp c
	jr nz, .asm_3f093
	pop af
	ld [CurPartyLevel], a
	ld hl, EvolvableFlags
	ld a, [CurPartyMon]
	ld c, a
	ld b, $1
	ld a, $3
	call Predef
	pop af
	ld [CurPartyLevel], a

.asm_3f0b9
	ld a, [PartyCount]
	ld b, a
	ld a, [CurPartyMon]
	inc a
	cp b
	jr z, .asm_3f0d1
	ld [CurPartyMon], a
	ld a, $0
	call GetPartyParamLocation
	ld b, h
	ld c, l
	jp .asm_3ee50

.asm_3f0d1
	jp Function3d57a
; 3f0d4

Function3f0d4: ; 3f0d4
	ld a, [$c664]
	ld b, a
	ld c, $6
	ld d, $0
.asm_3f0dc
	xor a
	srl b
	adc d
	ld d, a
	dec c
	jr nz, .asm_3f0dc
	cp $2
	ret c
	ld [$d265], a
	ld hl, EnemyMonBaseStats
	ld c, $7
.asm_3f0ef
	xor a
	ld [hProduct], a
	ld a, [hl]
	ld [hMultiplicand], a
	ld a, [$d265]
	ld [hMultiplier], a
	ld b, $2
	call Divide
	ld a, [$ffb6]
	ld [hli], a
	dec c
	jr nz, .asm_3f0ef
	ret
; 3f106

Function3f106: ; 3f106
	push bc
	ld a, [$ffb5]
	ld b, a
	ld a, [$ffb6]
	ld c, a
	srl b
	rr c
	add c
	ld [$ffb6], a
	ld a, [$ffb5]
	adc b
	ld [$ffb5], a
	pop bc
	ret
; 3f11b

UnknownText_0x3f11b: ; 3f11b
	text_jump UnknownText_0x1c029c
	start_asm
	ld hl, UnknownText_0x3f131
	ld a, [$d088] ; IsTradedMon
	and a
	ret z
	ld hl, UnknownText_0x3f12c
	ret
; 3f12c

UnknownText_0x3f12c: ; 3f12c
	text_jump UnknownText_0x1c02a9
	db "@"
; 3f131

UnknownText_0x3f131: ; 3f131
	text_jump UnknownText_0x1c02c9
	db "@"
; 3f136


Function3f136: ; 3f136

	push bc

	ld hl, CurPartyMon
	ld a, [CurBattleMon]
	cp [hl]
	jp nz, .asm_3f219

	ld a, [BattleMonLevel]
	cp MAX_LEVEL
	jp nc, .asm_3f219

	ld a, [$ffb6]
	ld [$d004], a
	push af
	ld a, [$ffb5]
	ld [$d003], a
	push af
	xor a
	ld [DefaultFlypoint], a
	xor a
	ld [MonType], a
	ld a, $1f
	call Predef
	ld a, [TempMonLevel]
	ld b, a
	ld e, a
	push de
	ld de, $d118
	call Function3f39c
	push bc
	ld hl, $d118
	ld a, [$d004]
	add [hl]
	ld [hld], a
	ld a, [$d003]
	adc [hl]
	ld [hld], a
	jr nc, .asm_3f186
	inc [hl]
	jr nz, .asm_3f186
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.asm_3f186
	ld d, $64
	callab Function50e47
	ld a, [hMultiplicand]
	ld b, a
	ld a, [$ffb5]
	ld c, a
	ld a, [$ffb6]
	ld d, a
	ld hl, $d118
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .asm_3f1a8
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

.asm_3f1a8
	callab Function50e1b
	ld a, d
	pop bc
	pop de
	ld d, a
	cp e
	jr nc, .asm_3f1b7
	ld a, e
	ld d, a

.asm_3f1b7
	ld a, e
	cp $64
	jr nc, .asm_3f1ff
	cp d
	jr z, .asm_3f1ff
	inc a
	ld [TempMonLevel], a
	ld [CurPartyLevel], a
	ld [BattleMonLevel], a
	push de
	call Function3f21b
	ld c, $40
	call Function3f22c
	call PrintPlayerHUD
	ld hl, BattleMonNick
	ld de, StringBuffer1
	ld bc, $000b
	call CopyBytes
	call Function3dfe
	ld de, SFX_HIT_END_OF_EXP_BAR
	call PlaySFX
	callba Function8e79d
	call WaitSFX
	ld hl, BattleText_0x80c9c
	call StdBattleTextBox
	pop de
	inc e
	ld b, $0
	jr .asm_3f1b7

.asm_3f1ff
	push bc
	ld b, d
	ld de, $d118
	call Function3f39c
	ld a, b
	pop bc
	ld c, a
	call Function3f21b
	call Function3f22c
	call Function3dfe
	pop af
	ld [$ffb5], a
	pop af
	ld [$ffb6], a

.asm_3f219
	pop bc
	ret
; 3f21b

Function3f21b: ; 3f21b
	push bc
	call WaitSFX
	ld de, SFX_EXP_BAR
	call PlaySFX
	ld c, 10
	call DelayFrame ; was DelayFrames
	pop bc
	ret
; 3f22c

Function3f22c: ; 3f22c
	ld d, $3
	dec b
.asm_3f22f
	inc b
	push bc
	push de
	ld hl, $c58d
	call Function3f41c
	pop de
	ld a, $1
	ld [hBGMapMode], a
	ld c, d
	call DelayFrame ; was DelayFrames
	xor a
	ld [hBGMapMode], a
	pop bc
	ld a, c
	cp b
	jr z, .asm_3f268
	inc b
	push bc
	push de
	ld hl, $c58d
	call Function3f41c
	pop de
	ld a, $1
	ld [hBGMapMode], a
	ld c, d
	call DelayFrame ; was DelayFrames
	xor a
	ld [hBGMapMode], a
	dec d
	jr nz, .asm_3f263
	ld d, $1

.asm_3f263
	pop bc
	ld a, c
	cp b
	jr nz, .asm_3f22f

.asm_3f268
	ld a, $1
	ld [hBGMapMode], a
	ret
; 3f26d



Function3f26d: ; 3f26d
; SendOutMonText?

	ld a, [InLinkBattle]
	and a
	jr z, .asm_3f27c
	ld hl, UnknownText_0x3f2d1
	ld a, [$d264]
	and a
	jr nz, .asm_3f2ce

.asm_3f27c
	ld hl, EnemyMonHPHi
	ld a, [hli]
	or [hl]
	ld hl, UnknownText_0x3f2d1
	jr z, .asm_3f2ce
	xor a
	ld [hMultiplicand], a
	ld hl, EnemyMonHPHi
	ld a, [hli]
	ld [$c6ea], a
	ld [$ffb5], a
	ld a, [hl]
	ld [$c6eb], a
	ld [$ffb6], a
	ld a, $19
	ld [hMultiplier], a
	call Multiply
	ld hl, EnemyMonMaxHPHi
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, $4
	ld [hMultiplier], a
	call Divide
	ld a, [$ffb6]
	ld hl, UnknownText_0x3f2d1
	cp $46
	jr nc, .asm_3f2ce
	ld hl, UnknownText_0x3f2d8
	cp $28
	jr nc, .asm_3f2ce
	ld hl, UnknownText_0x3f2df
	cp $a
	jr nc, .asm_3f2ce
	ld hl, UnknownText_0x3f2e6

.asm_3f2ce
	jp BattleTextBox
; 3f2d1


UnknownText_0x3f2d1: ; 3f2d1
	text_jump UnknownText_0x1c02df
	start_asm
	jr Function3f2eb
; 3f2d6

UnknownText_0x3f2d8: ; 3f2d8
	text_jump UnknownText_0x1c02e6
	start_asm
	jr Function3f2eb
; 3f2dd

UnknownText_0x3f2df: ; 3f2df
	text_jump UnknownText_0x1c02f0
	start_asm
	jr Function3f2eb
; 3f2e4

UnknownText_0x3f2e6: ; 3f2e6
	text_jump UnknownText_0x1c02fe
	start_asm
; 3f2eb

Function3f2eb: ; 3f2eb
	ld hl, UnknownText_0x3f2ef
	ret
; 3f2ef

UnknownText_0x3f2ef: ; 3f2ef
	text_jump UnknownText_0x1c0317
	db "@"
; 3f2f4


Function3f2f4: ; 3f2f4
	ld hl, UnknownText_0x3f2fa
	jp BattleTextBox
; 3f2fa

UnknownText_0x3f2fa: ; 3f2fa
	text_jump UnknownText_0x1c031d
	start_asm
; 3f2ff

Function3f2ff: ; 3f2ff
	push de
	push bc
	ld hl, EnemyMonHPLo
	ld de, $c6eb
	ld b, [hl]
	dec hl
	ld a, [de]
	sub b
	ld [$ffb6], a
	dec de
	ld b, [hl]
	ld a, [de]
	sbc b
	ld [$ffb5], a
	ld a, $19
	ld [hMultiplier], a
	call Multiply
	ld hl, EnemyMonMaxHPHi
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, $4
	ld [hMultiplier], a
	call Divide
	pop bc
	pop de
	ld a, [$ffb6]
	ld hl, UnknownText_0x3f348
	and a
	ret z
	ld hl, UnknownText_0x3f35b
	cp $1e
	ret c
	ld hl, UnknownText_0x3f34d
	cp $46
	ret c
	ld hl, UnknownText_0x3f352
	ret
; 3f348

UnknownText_0x3f348: ; 3f348
	text_jump UnknownText_0x1c0324
	db "@"
; 3f34d

UnknownText_0x3f34d: ; 3f34d
	text_jump UnknownText_0x1c0340
	db "@"
; 3f352

UnknownText_0x3f352: ; 3f352
	text_jump UnknownText_0x1c0352
	db "@"
; 3f357

Function3f357: ; 3f357
	ld hl, UnknownText_0x3f35b
	ret
; 3f35b

UnknownText_0x3f35b: ; 3f35b
	text_jump UnknownText_0x1c0366
	db "@"
; 3f360


Function3f360: ; 3f360
	ld hl, $c6f0
	ld a, [hl]
	and a
	jr z, .asm_3f36d
	dec [hl]
	ld hl, BattleText_0x80cba
	jr .asm_3f388

.asm_3f36d
	dec hl
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld hl, BattleText_0x80cd1
	jr nz, .asm_3f388
	push hl
	ld a, [EnemyMonSpecies]
	ld [CurSpecies], a
	call GetBaseData
	ld a, [BaseCatchRate]
	ld [EnemyMonCatchRate], a
	pop hl

.asm_3f388
	push hl
	call Function30b4
	pop hl
	jp StdBattleTextBox
; 3f390


FillInExpBar: ; 3f390
	push hl
	call Function3f39c
	pop hl
	ld de, $0007
	add hl, de
	jp Function3f41c
; 3f39c

Function3f39c: ; 3f39c
	push de
	ld d, b
	push de
	callab Function50e47
	pop de
	ld hl, hMultiplicand
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	inc d
	callab Function50e47
	ld hl, $ffb6
	ld a, [hl]
	ld [$ffba], a
	pop bc
	sub b
	ld [hld], a
	ld a, [hl]
	ld [$ffb9], a
	pop bc
	sbc b
	ld [hld], a
	ld a, [hl]
	ld [hMathBuffer], a
	pop bc
	sbc b
	ld [hl], a
	pop de
	ld hl, $ffb5
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	ld a, [de]
	dec de
	ld c, a
	ld a, [$ffba]
	sub c
	ld [hld], a
	ld a, [de]
	dec de
	ld b, a
	ld a, [$ffb9]
	sbc b
	ld [hld], a
	ld a, [de]
	ld c, a
	ld a, [hMathBuffer]
	sbc c
	ld [hld], a
	xor a
	ld [hl], a
	ld a, $40
	ld [hMultiplier], a
	call Multiply
	pop af
	ld c, a
	pop af
	ld b, a
.asm_3f3f4
	ld a, b
	and a
	jr z, .asm_3f40c
	srl b
	rr c
	ld hl, hProduct
	srl [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	jr .asm_3f3f4

.asm_3f40c
	ld a, c
	ld [hMultiplier], a
	ld b, $4
	call Divide
	ld a, [$ffb6]
	ld b, a
	ld a, $40
	sub b
	ld b, a
	ret
; 3f41c

Function3f41c: ; 3f41c
	ld c, $8
.asm_3f41e
	ld a, b
	sub $8
	jr c, .asm_3f42c
	ld b, a
	ld a, $6a
	ld [hld], a
	dec c
	jr z, .asm_3f43c
	jr .asm_3f41e

.asm_3f42c
	add $8
	jr z, .asm_3f434
	add $54
	jr .asm_3f436

.asm_3f434
	ld a, $62

.asm_3f436
	ld [hld], a
	ld a, $62
	dec c
	jr nz, .asm_3f434

.asm_3f43c
	ret
; 3f43d

Function3f43d: ; 3f43d
	ld a, [PlayerSubStatus4]
	bit 4, a
	ld hl, BattleAnimCmd_DD
	jr nz, asm_3f46f
Function3f447: ; 3f447
	ld a, [$c6fe]
	and a
	ld hl, BattleAnimCmd_E2
	jr nz, asm_3f46f
	ld a, [CurPartySpecies]
	push af
	ld a, [BattleMonSpecies]
	ld [CurPartySpecies], a
	ld hl, BattleMonAtkDefDV
	ld a, $2d
	call Predef
	ld de, $9310
	ld a, $3d
	call Predef
	pop af
	ld [CurPartySpecies], a
	ret

asm_3f46f
	ld a, [hBattleTurn]
	push af
	xor a
	ld [hBattleTurn], a
	ld a, BANK(BattleAnimCommands)
	rst FarCall
	pop af
	ld [hBattleTurn], a
	ret
; 3f47c

Function3f47c: ; 3f47c
	ld a, [EnemySubStatus4]
	bit 4, a
	ld hl, BattleAnimCmd_DD
	jr nz, asm_3f4b4
Function3f486: ; 3f486
	ld a, [$c6fa]
	and a
	ld hl, BattleAnimCmd_E2
	jr nz, asm_3f4b4
	ld a, [CurPartySpecies]
	push af
	ld a, [EnemyMonSpecies]
	ld [CurSpecies], a
	ld [CurPartySpecies], a
	call GetBaseData
	ld hl, EnemyMonAtkDefDV
	ld a, $2d
	call Predef
	ld de, VTiles2
	ld a, $3e
	call Predef
	pop af
	ld [CurPartySpecies], a
	ret

asm_3f4b4
	ld a, [hBattleTurn]
	push af
	call SetEnemyTurn
	ld a, BANK(BattleAnimCommands)
	rst FarCall
	pop af
	ld [hBattleTurn], a
	ret
; 3f4c1


StartBattle: ; 3f4c1
	ld a, [PartyCount]
	and a
	ret z
	ld a, [TimeOfDayPal]
	push af
	call Function3f4dd
	call Function3c000
	call Function3f69e
	pop af
	ld [TimeOfDayPal], a
	scf
	ret
; 3f4d9


Function3f4d9: ; 3f4d9
	call Function3c000
	ret
; 3f4dd


Function3f4dd: ; 3f4dd
	callba Function106050
	call Function3f54e
	xor a
	ld [TempBattleMonSpecies], a
	ld [$d0d2], a
	xor a
	ld [$ffde], a
	callba PlayBattleMusic
	callba Function2ee18
	callba Function2ee2f
	call Function2ed3
	callba ClearBattleRAM
	call Function3f55e
	call Function3f568
	ld b, $0
	call GetSGBLayout
	ld hl, rLCDC
	res 6, [hl]
	call Function3fb6c
	call BattleStartMessage
	ld hl, rLCDC
	set 6, [hl]
	xor a
	ld [hBGMapMode], a
	call EmptyBattleTextBox
	hlcoord 9, 7
	ld bc, 5 << 8 + 11
	call ClearBox
	hlcoord 1, 0
	ld bc, 4 << 8 + 10
	call ClearBox
	call ClearSprites
	ld a, [IsInBattle]
	cp $1
	call z, Function3e036
	ld a, $1
	ld [hBGMapMode], a
	ret
; 3f54e

Function3f54e: ; 3f54e
	ld a, [OtherTrainerClass]
	and a
	jr nz, .asm_3f55a
	ld a, [$d22e]
	ld [CurPartySpecies], a

.asm_3f55a
	ld [TempEnemyMonSpecies], a
	ret
; 3f55e

Function3f55e: ; 3f55e
	ld a, [OtherTrainerClass]
	and a
	jp nz, Function3f594
	jp Function3f607
; 3f568

Function3f568: ; 3f568
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	ld hl, $d000
	ld bc, VBlank5
	ld a, $2
	call ByteFill
	ld a, [rVBK]
	push af
	ld a, $1
	ld [rVBK], a
	ld de, $d000
	ld hl, VBGMap0
	ld bc, $0f40
	call Request2bpp
	pop af
	ld [rVBK], a
	pop af
	ld [rSVBK], a
	ret
; 3f594

Function3f594: ; 3f594
	ld [TrainerClass], a
	callba Function10606a
	xor a
	ld [TempEnemyMonSpecies], a
	callab Function3957b
	callab Function39771
	ld a, [TrainerClass]
	cp $9
	jr nz, .asm_3f5b8
	xor a
	ld [OTPartyMon1Item], a

.asm_3f5b8
	ld de, VTiles2
	callab Function5120d
	xor a
	ld [$ffad], a
	dec a
	ld [$c6e6], a
	ld hl, $c4ac
	ld bc, $0707
	ld a, $13
	call Predef
	ld a, $ff
	ld [CurOTMon], a
	ld a, $2
	ld [IsInBattle], a
	call IsJohtoGymLeader
	jr nc, .asm_3f606
	xor a
	ld [CurPartyMon], a
	ld a, [PartyCount]
	ld b, a
.asm_3f5ea
	push bc
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	or [hl]
	jr z, .asm_3f5fc
	ld c, $4
	callab ChangeHappiness

.asm_3f5fc
	pop bc
	dec b
	jr z, .asm_3f606
	ld hl, CurPartyMon
	inc [hl]
	jr .asm_3f5ea

.asm_3f606
	ret
; 3f607

Function3f607: ; 3f607
	ld a, $1
	ld [IsInBattle], a
	callba Function10605d
	call LoadEnemyMon
	ld hl, EnemyMonMove1
	ld de, $c735
	ld bc, $0004
	call CopyBytes
	ld hl, EnemyMonPPMove1
	ld de, $c739
	ld bc, $0004
	call CopyBytes
	ld hl, EnemyMonAtkDefDV
	ld a, $2d
	call Predef
	ld a, [CurPartySpecies]
	cp $c9
	jr nz, .asm_3f648
	ld a, [$def4]
	and a
	jr nz, .asm_3f648
	ld a, [UnownLetter]
	ld [$def4], a

.asm_3f648
	ld de, VTiles2
	ld a, $3e
	call Predef
	xor a
	ld [TrainerClass], a
	ld [$ffad], a
	ld hl, $c4ac
	ld bc, $0707
	ld a, $13
	call Predef
	ret
; 3f662

Function3f662: ; 3f662
	ld hl, EnemyMonMove1
	ld de, $d25e
	ld b, $4
.asm_3f66a
	ld a, [de]
	inc de
	ld [hli], a
	and a
	jr z, .asm_3f690
	push bc
	push hl
	push hl
	dec a
	ld hl, $5b00
	ld bc, $0007
	call AddNTimes
	ld a, $10
	call GetFarByte
	pop hl
	ld bc, $0005
	add hl, bc
	ld [hl], a
	pop hl
	pop bc
	dec b
	jr nz, .asm_3f66a
	ret

.asm_3f68e
	xor a
	ld [hli], a

.asm_3f690
	push bc
	push hl
	ld bc, $0005
	add hl, bc
	xor a
	ld [hl], a
	pop hl
	pop bc
	dec b
	jr nz, .asm_3f68e
	ret
; 3f69e


Function3f69e: ; 3f69e
	call Function3f6a5
	call Function3f6d0
	ret
; 3f6a5

Function3f6a5: ; 3f6a5
	ld a, [InLinkBattle]
	and a
	jr z, .asm_3f6b7
	call Function3f759
	ld c, $96
	call DelayFrame ; was DelayFrames
	call Function3f77c
	ret

.asm_3f6b7
	ld a, [$d0ee]
	and $f
	ret nz
	call Function3f71d
	xor a
	ld [$d1e9], a
	ld a, $1c
	call Predef
	callba Function2ed44
	ret
; 3f6d0

Function3f6d0: ; 3f6d0
	call Function3f998
	xor a
	ld [Danger], a
	ld [IsInBattle], a
	ld [BattleType], a
	ld [AttackMissed], a
	ld [$d22e], a
	ld [OtherTrainerClass], a
	ld [$d266], a
	ld [$d267], a
	ld [$d232], a
	ld [$d0d8], a
	ld [$d0da], a
	ld [$d0d9], a
	ld [$d0d2], a
	ld [CurMoveNum], a
	ld [$d0db], a
	ld [$d0d6], a
	ld [$d0e4], a
	ld [$d0e0], a
	ld [$d0df], a
	ld [$d0e1], a
	ld hl, PlayerSubStatus1
	ld b, $18
.asm_3f715
	ld [hli], a
	dec b
	jr nz, .asm_3f715
	call WaitSFX
	ret
; 3f71d

Function3f71d: ; 3f71d
	ld hl, $c6ec
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret z
	ld a, [$c73d]
	and a
	jr z, .asm_3f73d
	ld hl, $c6ee
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, .asm_3f73d
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.asm_3f73d
	ld hl, $c6ee
	ld de, $d850
	call Function3d0be
	ld hl, BattleText_0x80730
	call StdBattleTextBox
	ld a, [$cfc0]
	bit 0, a
	ret z
	call ClearTileMap
	call WhiteBGMap
	ret
; 3f759

Function3f759: ; 3f759
	callba Function1060df
	callba Function106187
	ld a, [CurOTMon]
	ld hl, OTPartyMon1Status
	call GetPartyLocation
	ld a, [EnemyMonStatus]
	ld [hl], a
	call ClearTileMap
	callba Function2c1b2
	ret
; 3f77c

Function3f77c: ; 3f77c
	callba Function3d2e0
	jp c, Function3f80f
	call Function3f830
	jr nz, .asm_3f797
	ld hl, $cd2a
	bit 4, [hl]
	jr z, .asm_3f797
	callba Function2b930

.asm_3f797
	ld a, [$d0ee]
	and $f
	cp $1
	jr c, .asm_3f7ad
	jr z, .asm_3f7b8
	callba Function106107
	ld de, .Draw
	jr .asm_3f7c3

.asm_3f7ad
	callba Function1060fb
	ld de, .Win
	jr .asm_3f7c3

.asm_3f7b8
	callba Function106101
	ld de, .Lose
	jr .asm_3f7c3

.asm_3f7c3
	ld hl, $c546
	call PlaceString
	callba Function106187
	ld c, $c8
	call DelayFrame ; was DelayFrames
	ld a, $1
	call GetSRAMBank
	call Function3fa42
	call Function3f85f
	call CloseSRAM
	call Function3f830
	jr z, .asm_3f7ee
	call Functiona80
	call ClearTileMap
	ret

.asm_3f7ee
	ld c, $c8
	call DelayFrame ; was DelayFrames
	call ClearTileMap
	ret
; 3f7f7

.Win
	db "YOU WIN@"
.Lose
	db "YOU LOSE@"
.Draw
	db "  DRAW@"
; 3f80f


Function3f80f: ; 3f80f
	ld hl, $c546
	ld de, .Invalid
	call PlaceString
	ld c, $c8
	call DelayFrame ; was DelayFrames
	call ClearTileMap
	ret
; 3f821

.Invalid
	db "INVALID BATTLE@"
; 3f830


Function3f830: ; 3f830
	ld a, [InLinkBattle]
	cp $4
	ret
; 3f836


Function3f836: ; 3f836
	ld a, $1
	call GetSRAMBank
	call Function3f85f
	call CloseSRAM
	ld hl, AttrMap
	xor a
	ld bc, $0168
	call ByteFill
	call Function3200
	ld b, $8
	call GetSGBLayout
	call Function32f9
	ld c, $8
	call DelayFrame ; was DelayFrames
	call Functiona80
	ret
; 3f85f


Function3f85f: ; 3f85f
	call ClearTileMap
	call ClearSprites
	call .asm_3f8e0
	ld hl, $c540
	ld b, $5
	ld de, $b268
.asm_3f870
	push bc
	push hl
	push de
	ld a, [de]
	and a
	jr z, .asm_3f8c9
	ld a, [$d4b4]
	and a
	jr z, .asm_3f8c9
	push hl
	push hl
	ld h, d
	ld l, e
	ld de, DefaultFlypoint
	ld bc, $000a
	call CopyBytes
	ld a, $50
	ld [de], a
	inc de
	ld bc, $0006
	call CopyBytes
	ld de, DefaultFlypoint
	pop hl
	call PlaceString
	pop hl
	ld de, $001a
	add hl, de
	push hl
	ld de, $d00d
	ld bc, $0204
	call PrintNum
	pop hl
	ld de, $0005
	add hl, de
	push hl
	ld de, $d00f
	ld bc, $0204
	call PrintNum
	pop hl
	ld de, $0005
	add hl, de
	ld de, $d011
	ld bc, $0204
	call PrintNum
	jr .asm_3f8cf

.asm_3f8c9
	ld de, .Format
	call PlaceString

.asm_3f8cf
	pop hl
	ld bc, $0012
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, $0028
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_3f870
	ret

.asm_3f8e0
	ld hl, $c4a1
	ld de, .Record
	call PlaceString

	ld hl, $c518
	ld de, .Result
	call PlaceString

	ld hl, $c4c8
	ld de, .Total
	call PlaceString

	ld hl, $c4f6
	ld de, $b260
	call .asm_3f92b
	jr c, .asm_3f92a

	ld bc, $0204
	call PrintNum

	ld hl, $c4fb
	ld de, $b262
	call .asm_3f92b

	ld bc, $0204
	call PrintNum

	ld hl, $c500
	ld de, $b264
	call .asm_3f92b

	ld bc, $0204
	call PrintNum

.asm_3f92a
	ret

.asm_3f92b
	ld a, [$d4b4]
	and a
	ret nz
	ld de, .Scores
	call PlaceString
	scf
	ret
; 3f938

.Scores
	db "   0    0    0@"
; 3f947

.Format ; 3f947
	db "  ---  ", $22, "         -    -    -@"
.Record ; 3f964
	db $52, "'s RECORD@"
.Result ; 3f96e
	db "RESULT WIN LOSE DRAW@"
.Total ; 3f983
	db "TOTAL  WIN LOSE DRAW@"
; 3f998


Function3f998: ; 3f998
	ld a, [BattleType]
	cp BATTLETYPE_ROAMING
	jr nz, .asm_3f9c4
	ld a, [$d0ee]
	and $f
	jr z, .asm_3f9af
	call GetRoamMonHP
	ld a, [EnemyMonHPLo]
	ld [hl], a
	jr .asm_3f9ca

.asm_3f9af
	call GetRoamMonHP
	ld [hl], $0
	call GetRoamMonMapGroup
	ld [hl], $ff
	call GetRoamMonMapNumber
	ld [hl], $ff
	call GetRoamMonSpecies
	ld [hl], $0
	ret

.asm_3f9c4
	call BattleRandom
	and $f
	ret nz

.asm_3f9ca
	callab Function2a30d
	ret
; 3f9d1

GetRoamMonMapGroup: ; 3f9d1
	ld a, [TempEnemyMonSpecies]
	ld b, a
	ld a, [RoamMon1Species]
	cp b
	ld hl, RoamMon1MapGroup
	ret z
	ld a, [RoamMon2Species]
	cp b
	ld hl, RoamMon2MapGroup
	ret z
	ld hl, RoamMon3MapGroup
	ret
; 3f9e9

GetRoamMonMapNumber: ; 3f9e9
	ld a, [TempEnemyMonSpecies]
	ld b, a
	ld a, [RoamMon1Species]
	cp b
	ld hl, RoamMon1MapNumber
	ret z
	ld a, [RoamMon2Species]
	cp b
	ld hl, RoamMon2MapNumber
	ret z
	ld hl, RoamMon3MapNumber
	ret
; 3fa01

GetRoamMonHP: ; 3fa01
; output: hl = RoamMonCurHP
	ld a, [TempEnemyMonSpecies]
	ld b, a
	ld a, [RoamMon1Species]
	cp b
	ld hl, RoamMon1CurHP
	ret z
	ld a, [RoamMon2Species]
	cp b
	ld hl, RoamMon2CurHP
	ret z
	ld hl, RoamMon3CurHP
	ret
; 3fa19

GetRoamMonDVs: ; 3fa19
; output: hl = RoamMonDVs
	ld a, [TempEnemyMonSpecies]
	ld b, a
	ld a, [RoamMon1Species]
	cp b
	ld hl, RoamMon1DVs
	ret z
	ld a, [RoamMon2Species]
	cp b
	ld hl, RoamMon2DVs
	ret z
	ld hl, RoamMon3DVs
	ret
; 3fa31

GetRoamMonSpecies: ; 3fa31
	ld a, [TempEnemyMonSpecies]
	ld hl, RoamMon1Species
	cp [hl]
	ret z
	ld hl, RoamMon2Species
	cp [hl]
	ret z
	ld hl, RoamMon3Species
	ret
; 3fa42


Function3fa42: ; 3fa42
	ld hl, $d276
	ld de, StringBuffer1
	ld bc, $0002
	call CopyBytes
	ld hl, $d26b
	ld bc, $000a
	call CopyBytes
	ld hl, $b254
	call Function3faa0
	ld hl, $b266
	ld d, $5
.asm_3fa62
	push hl
	inc hl
	inc hl
	ld a, [hl]
	dec hl
	dec hl
	and a
	jr z, .asm_3fa85
	push de
	ld bc, $000c
	ld de, StringBuffer1
	call CompareLong
	pop de
	pop hl
	jr c, .asm_3fa99
	ld bc, $0012
	add hl, bc
	dec d
	jr nz, .asm_3fa62
	ld bc, $ffee
	add hl, bc
	push hl

.asm_3fa85
	ld d, h
	ld e, l
	ld hl, StringBuffer1
	ld bc, $000c
	call CopyBytes
	ld b, $6
	xor a
.asm_3fa93
	ld [de], a
	inc de
	dec b
	jr nz, .asm_3fa93
	pop hl

.asm_3fa99
	call Function3faa0
	call Function3fac8
	ret
; 3faa0

Function3faa0: ; 3faa0
	ld a, [$d0ee]
	and $f
	cp $1
	ld bc, $000d
	jr c, .asm_3fab4
	ld bc, $000f
	jr z, .asm_3fab4
	ld bc, $0011

.asm_3fab4
	add hl, bc
	call Function3fabe
	ret nc
	inc [hl]
	ret nz
	dec hl
	inc [hl]
	ret
; 3fabe

Function3fabe: ; 3fabe
	dec hl
	ld a, [hl]
	inc hl
	cp $27
	ret c
	ld a, [hl]
	cp $f
	ret
; 3fac8

Function3fac8: ; 3fac8
	ld b, $5
	ld hl, $b277
	ld de, DefaultFlypoint
.asm_3fad0
	push bc
	push de
	push hl
	call Function3fb54
	pop hl
	ld a, e
	pop de
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de
	ld bc, $0012
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_3fad0
	ld b, $0
	ld c, $1
.asm_3faed
	ld a, b
	add b
	add b
	ld e, a
	ld d, $0
	ld hl, DefaultFlypoint
	add hl, de
	push hl
	ld a, c
	add c
	add c
	ld e, a
	ld d, $0
	ld hl, DefaultFlypoint
	add hl, de
	ld d, h
	ld e, l
	pop hl
	push bc
	ld c, $3
	call StringCmp
	pop bc
	jr z, .asm_3fb10
	jr nc, .asm_3fb1f

.asm_3fb10
	inc c
	ld a, c
	cp $5
	jr nz, .asm_3faed
	inc b
	ld c, b
	inc c
	ld a, b
	cp $4
	jr nz, .asm_3faed
	ret

.asm_3fb1f
	push bc
	ld a, b
	ld bc, $0012
	ld hl, $b266
	call AddNTimes
	push hl
	ld de, DefaultFlypoint
	ld bc, $0012
	call CopyBytes
	pop hl
	pop bc
	push hl
	ld a, c
	ld bc, $0012
	ld hl, $b266
	call AddNTimes
	pop de
	push hl
	ld bc, $0012
	call CopyBytes
	ld hl, DefaultFlypoint
	ld bc, $0012
	pop de
	call CopyBytes
	ret
; 3fb54

Function3fb54: ; 3fb54
	ld e, $0
	ld a, [hld]
	ld c, a
	ld a, [hld]
	ld b, a
	ld a, [hld]
	add c
	ld c, a
	ld a, [hld]
	adc b
	ld b, a
	jr nc, .asm_3fb63
	inc e

.asm_3fb63
	ld a, [hld]
	add c
	ld c, a
	ld a, [hl]
	adc b
	ld b, a
	ret nc
	inc e
	ret
; 3fb6c

Function3fb6c: ; 3fb6c
	call Function3fbf8
	ld hl, $c590
	ld b, $4
	ld c, $12
	call TextBox
	callba MobileTextBorder
	ld hl, $c505
	ld bc, $0307
	call ClearBox
	call Functione51
	call Function3ed9f
	call Function3fbd6
	xor a
	ld [$ffde], a
	ld [hSCY], a
	ld a, $90
	ld [hWY], a
	ld [rWY], a
	call WaitBGMap
	xor a
	ld [hBGMapMode], a
	callba Function4e980
	ld a, $1
	ld [hBGMapMode], a
	ld a, $31
	ld [$ffad], a
	ld hl, $c51a
	ld bc, $0606
	ld a, $13
	call Predef
	xor a
	ld [hWY], a
	ld [rWY], a
	call WaitBGMap
	call HideSprites
	ld b, $1
	call GetSGBLayout
	call Function32f9
	ld a, $90
	ld [hWY], a
	xor a
	ld [hSCX], a
	ret
; 3fbd6

Function3fbd6: ; 3fbd6
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	ld hl, $d000
	ld bc, VBlank5
	ld a, $7f
	call ByteFill
	ld de, $d000
	ld hl, VBGMap0
	ld bc, $0f40
	call Request2bpp
	pop af
	ld [rSVBK], a
	ret
; 3fbf8

Function3fbf8: ; 3fbf8
	call GetBattleBackpic
	call Function3fc30
	ret
; 3fbff


GetBattleBackpic: ; 3fbff
; Load the player character's backpic (6x6) into VRAM starting from $9310.

; Special exception for Dude.
	ld b, BANK(DudeBackpic)
	ld hl, DudeBackpic
	ld a, [BattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .Decompress

; What gender are we?
	ld a, [$d45b]
	bit 2, a
	jr nz, .Chris
	ld a, [PlayerGender]
	bit 0, a
	jr z, .Chris

; It's a girl.
	callba GetKrisBackpic
	ret

.Chris
; It's a boy.
	ld b, BANK(ChrisBackpic)
	ld hl, ChrisBackpic

.Decompress
	ld de, $9310
	ld c, $31
	ld a, PREDEF_DECOMPRESS
	call Predef
	ret
; 3fc30


Function3fc30: ; 3fc30
	ld a, [rSVBK]
	push af
	ld a, $6
	ld [rSVBK], a
	ld hl, VTiles0
	ld de, $9310
	ld a, [hROMBank]
	ld b, a
	ld c, $31
	call Get2bpp
	pop af
	ld [rSVBK], a
	call Function3fc5b
	ld a, $31
	ld [$ffad], a
	ld hl, $c51a
	ld bc, $0606
	ld a, $13
	call Predef
	ret
; 3fc5b

Function3fc5b: ; 3fc5b
	ld hl, Sprites
	xor a
	ld [hConnectionStripLength], a
	ld b, $6
	ld e, $a8
.asm_3fc65
	ld c, $3
	ld d, $40
.asm_3fc69
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld a, [hConnectionStripLength]
	ld [hli], a
	inc a
	ld [hConnectionStripLength], a
	ld a, $1
	ld [hli], a
	ld a, d
	add $8
	ld d, a
	dec c
	jr nz, .asm_3fc69
	ld a, [hConnectionStripLength]
	add $3
	ld [hConnectionStripLength], a
	ld a, e
	add $8
	ld e, a
	dec b
	jr nz, .asm_3fc65
	ret
; 3fc8b


BattleStartMessage: ; 3fc8b
	ld a, [IsInBattle]
	dec a
	jr z, .asm_3fcaa

	ld de, SFX_SHINE
	call PlaySFX
	call WaitSFX

	ld c, 20
	call DelayFrame ; was DelayFrames

	callba Function39939

	ld hl, WantsToBattleText
	jr .asm_3fd0e

.asm_3fcaa
	call Function3da79
	jr nc, .asm_3fcc2

	xor a
	ld [$cfca], a
	ld a, 1
	ld [hBattleTurn], a
	ld a, 1
	ld [$c689], a
	ld de, $0101
	call Function3ee17

.asm_3fcc2
	callba CheckSleepingTreeMon
	jr c, .asm_3fceb

	callba CheckBattleScene
	jr c, .asm_3fce0

	hlcoord 12, 0
	ld d, $0
	ld e, $1
	ld a, $47
	call Predef
	jr .asm_3fceb

.asm_3fce0
	ld a, $0f
	ld [CryTracks], a
	ld a, [TempEnemyMonSpecies]
	call Function37b6

.asm_3fceb
	ld a, [BattleType]
	cp BATTLETYPE_FISH
	jr nz, .asm_3fcfd

	callba Function106086

	ld hl, HookedPokemonAttackedText
	jr .asm_3fd0e

.asm_3fcfd
	ld hl, PokemonFellFromTreeText
	cp BATTLETYPE_TREE
	jr z, .asm_3fd0e
	ld hl, WildPokemonAppearedText2
	cp $b
	jr z, .asm_3fd0e
	ld hl, WildPokemonAppearedText

.asm_3fd0e
	push hl
	callba Function2c000
	pop hl
	call StdBattleTextBox

	call Function3f830
	ret nz

	ld c, $2
	callba Function4ea0a

	ret
; 3fd26

