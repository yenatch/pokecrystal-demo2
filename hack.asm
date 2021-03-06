HackPredef:
    ; save hl
    ld a, h
    ld [TempH], a
    ld a, l
    ld [TempL], a
    
    push bc
    ld hl, HackPredefTable
    ld b, 0
    ld a, [hTempA] ; old a
    ld c, a
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a
    push bc
    pop hl
    pop bc
    
    push hl
    ld a, [TempH]
    ld h, a
    ld a, [TempL]
    ld l, a
    ret ; jumps to hl
    ;ld a, [$CD60]
    ;ld h, a
    ;ld a, [$CD61]
    ;ld h, a

HackPredefTable:
    dw WriteCharAdvice ; 0
    dw ResetVWFString ; 1
    dw NamingScreenDisableVWF ; 2
    dw NamingScreenEnableVWF ; 3
    dw ResetVWFNewline ; 4
    dw DecStringDepth ; 5
    dw VWFResetDisable ; 6
    dw VWFResetEnableAfterOne ; 7

WriteCharAdvice:
    ld a, [VWFDisabled]
    and a
    ld a, [hChar]
    jr nz, .disabled
    
    call WriteChar
    ret
.disabled
    ld [hli], a
    ret

VWFFont:
    INCBIN "gfx/vwffont.1bpp"
    
VWFTable:
    INCLUDE "vwftable.asm" ; maybe move it

WaitDMA:
    ; wait until DMA completes
    ld a, [$FF55]
    bit 7, a
    jr z, WaitDMA
    ret

ResetVWF:
    push af
    push hl
    xor a
    ;ld [W_VWF_LETTERNUM], a
    ;ld [W_VWF_CURTILENUM], a
    ;ld [VWFCurTileRow], a
    ld [VWFCurTileCol], a
    ld hl, VWFCurTileNum
    inc [hl]
    ;ld [W_VWF_CURROW], a ; This should probably be reset elsewhere..
    ;ld de, $8ba0
    ;ld hl, $7000 ; look at me I'm copying zeros
    ;ld c, $8f
    ;call DoDMA
    ;call WaitDMA
    ;ld de, $8ca0
    ;call DoDMA
    ;call WaitDMA
    ;ld de, $8da0
    ;ld c, $82
    ;call DoDMA
    ;ld c, $24
    ;ld b, 0
    ;call DelayFrame
    ;ld a, 0
    ;call ByteFill ; bc*a starting at hl
    pop hl
    pop af
	ret

ResetVWFString:
    ld a, [VWFResetDisabled]
    cp $ff
    jr z, .once
    cp $0
    ret nz
    ld a, [StringDepth] ; if not substring
    and a
    jr z, ResetVWF
    ret
.once
    xor a
    ld [VWFResetDisabled], a
    ret
    
ResetVWFNewline:
    jr ResetVWF

CopyColumn:
    ; b = source column
    ; c = dest column
    ; de = source number
    ; hl = dest number
    push hl
    push de
    ld a, $08
    ;ld [VWFCurTileRow], a
.Copy
    push af
    ld a, [de]
    and a, b
    jr nz, .CopyOne
.CopyZero
    ld a, %11111111
    xor c
    and [hl]
    jp .Next
.CopyOne
    ld a, c
    or [hl]
.Next
    ld [hli],a
    inc de
    ;ld a, [VWFCurTileRow]
    pop af
    dec a
    ;ld [VWFCurTileRow], a
    jp nz, .Copy
    pop de
    pop hl
    ret

WriteChar:
    push de
    push hl
    ld [VWFChar], a
    ; Store the original tile location.
    push hl
    pop de
    ld hl, VWFTileLoc
    ld [hl], d
    inc hl
    ld [hl], e
    
    ; Check if VWF is enabled, bail if not.
    ;ld a, [W_VWF_ENABLED]
    ;dec a
    
    ; write to tilemap
    pop hl
    ld a, [VWFCurTileNum]
    add $80
    ;push af
    ld [hl], a
    push hl
    
    ; Get the character in VWF's font.
    ld a, [VWFChar]
    cp $80
    jr c, .high
    sub a, $80
    jr .gotchar
.high
    add a, $20
.gotchar
    ld [VWFChar], a
    ; Store the character tile in BuildArea0.
    ld hl, VWFFont
    ld b, 0
    ld c, a
    ld a, $8
    call AddNTimes
    ld bc, $0008
    ld de, VWFBuildArea0
    call CopyBytes ; copy bc source bytes from hl to de
    
    ld a, $1
    ld [VWFNumTilesUsed], a
    
    ; Get the character length from the width table.
    ld a, [VWFChar]
    ld c, a
    ld b, $00
    ld hl, VWFTable
    add hl, bc
    ld a, [hl]
    ld [VWFCharWidth], a
.WidthWritten
    ; Set up some things for building the tile.
    ; Special cased to fix column $0, which is invalid (not a power of 2)
    ld de, VWFBuildArea0
    ld hl, VWFBuildArea2
    ;ld b, a
    ld b, %10000000
    ld a, [VWFCurTileCol]
    and a
    jr nz, .ColumnIsFine
    ld a, $80
.ColumnIsFine
    ld c, a ; a
.DoColumn
    ; Copy the column.
    call CopyColumn
    rr c
    jr c, .TileOverflow
    rrc b
    ld a, [VWFCharWidth]
    dec a
    ld [VWFCharWidth], a
    jr nz, .DoColumn 
    jr .Done
.TileOverflow
    ld c, $80
    ld a, $2
    ld [VWFNumTilesUsed], a
    ld hl, VWFBuildArea3
    jr .ShiftB
.DoColumnTile2
    call CopyColumn
    rr c
.ShiftB
    rrc b
    ld a, [VWFCharWidth]
    dec a
    ld [VWFCharWidth], a
    jr nz, .DoColumnTile2
.Done
    ld a, c
    ld [VWFCurTileCol], a
    
    ;ld de, W_VWF_BUILDAREA1
    ;ld hl, W_VWF_BUILDAREA3

    ; 1bpp -> 2bpp
    ld b, 0
    ld c, $10
    ld hl, VWFBuildArea2
    ;call DelayFrame
    ld de, VWFCopyArea
    call FarCopyBytesDouble ; copy bc*2 bytes from a:hl to de ; XXX don't far

    ; Get the tileset offset.
    ld hl, $8800 ; $8ba0
    ld a, [VWFCurTileNum]
    ld b, $0
    ld c, a
    ld a, 16
    call AddNTimes
    
    push hl
    pop de
    
    ; Write the new tile(s)
    ; Let's try DMA instead!

    ld hl, VWFCopyArea
    ld a, h
    ld [$ff51], a
    ld a, l
    ld [$ff52], a
    ld a, d
    ld [$ff53], a
    ld a, e
    ld [$ff54], a
    ld a, $81
    ld [$ff55], a


    ld a, [VWFNumTilesUsed]
    dec a
    dec a
    jr nz, .SecondAreaUnused
    
    ; If we went over one tile, make sure we start with it next time.
    ; also move through the tilemap.
    ld a, [VWFCurTileNum]
    inc a
    ld [VWFCurTileNum], a
    ld a, $00
    ld hl, VWFBuildArea3
    ld de, VWFBuildArea2
    ld bc, $0008
    call CopyBytes
    ld hl, VWFBuildArea3
    ld a, $0
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a ; lazy
    
    pop hl
    inc hl
    ld a, [VWFCurTileNum]
    add $80
    ld [hl], a
    push hl
    jr .FixOverflow
.SecondAreaUnused
    ; stupid bugfix for when the char didn't overflow, but the next char starts on the next tile.
    ;ld a, [VWFCurTileCol]
    ;cp $1
    ;jr nz, .FixOverflow
    ;pop hl
    ;inc hl
    ;push hl
.FixOverflow
    ; If we went over the last character allocated for VWF tiles, wrap around.
    ld a, [VWFCurTileNum]
    cp $e1-$80 ; may need tweaking
    jr c, .AlmostDone
    ld a, $00
    ld [VWFCurTileNum], a ; Prevent overflow
.AlmostDone
    call WaitDMA
    pop hl
    pop de
    ret
    
NamingScreenDisableVWF:
    ld a, 1
    ld [VWFDisabled], a
    
    ;ld hl, $c6d0 ; original code
    ret


NamingScreenEnableVWF:
    xor a
    ld [VWFDisabled], a
    
    ;call $092f ; original code
    ret

DecStringDepth:
    ld a, [StringDepth]
    dec a
    ld [StringDepth], a
    ret

VWFResetDisable:
    ld a, $1
    ld [VWFResetDisabled], a
    ret

VWFResetEnableAfterOne:
    ld a, $ff
    ld [VWFResetDisabled], a
    ret

VWFResetEnable:
    xor a
    ld [VWFResetDisabled], a
    ret
