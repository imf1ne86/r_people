REM Физкультура (для населения России)
' автор: Ефремов А. В.

ON ERROR GOTO 13: OPTION BASE 1: DIM x%(100), y%(100), c%(100)

DEF SEG = &HF000
IF NOT PEEK(&HFFFE) = &HFC THEN PRINT "The program needs an IBM PC AT.": GOTO 14

OUT &H70, &HD
IF INP(&H71) < 128 THEN PRINT "Your CMOS battery isn't O. K. - change it!": GOTO 14

OUT &H3D4, &HF: LET z% = INP(&H3D5)
OUT &H3D5, 100: OUT &H3D5, z%
IF INP(&H3D5) = &HFF THEN PRINT "You need a colour EGA-compatible videoadapter.": GOTO 14

IF COMMAND$ <> "" THEN
IF (VAL(COMMAND$) < 1) OR (VAL(COMMAND$) > 100) THEN 11
LET n% = VAL(COMMAND$): GOTO 12
END IF

11 INPUT "Number of people (1 - 100): ", n%
IF (n% < 1) OR (n% > 100) THEN ERROR 6

12 SCREEN 9: RANDOMIZE TIMER

COLOR 4: PRINT "The people of Russia are goin' in for physical culture."

LINE (610, 0)-(639, 5), 7, BF
LINE (610, 6)-(639, 11), 1, BF
LINE (610, 12)-(639, 17), 4, BF

PRINT "Initialization..."; : LOCATE , 1
FOR nr% = 1 TO n%
8 LET x%(nr%) = RND * 590: IF INKEY$ <> "" THEN 3
IF x%(nr%) < 10 THEN 8
9 LET y%(nr%) = RND * 300: IF INKEY$ <> "" THEN 3
IF y%(nr%) < 50 THEN 9
10 LET c%(nr%) = RND * 15: IF INKEY$ <> "" THEN 3
IF c%(nr%) < 1 THEN 10
IF nr% > 1 THEN
FOR z% = 1 TO nr% - 1
IF (ABS(x%(z%) - x%(nr%)) < 20) AND (ABS(y%(z%) - y%(nr%)) < 30) THEN 8
NEXT z%
END IF
NEXT nr%: PRINT SPACE$(17);

GOSUB 5: IF r% = 1 THEN 3

WHILE INKEY$ = ""

' руки в стороны
FOR a% = 1 TO 3
GOSUB 6: IF r% = 1 THEN 3
GOSUB 4: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "H6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "E6"
NEXT nr%: GOSUB 1: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 4)-(x%(nr%) - 9, y%(nr%) - 2), 0
LINE (x%(nr%) + 3, y%(nr%) + 4)-(x%(nr%) + 9, y%(nr%) - 2), 0
PSET (x%(nr%), y%(nr%)), c%(nr%): NEXT nr%
GOSUB 4: IF r% = 1 THEN 3
GOSUB 6: IF r% = 1 THEN 3
GOSUB 5: IF r% = 1 THEN 3
NEXT a%

' прыжки на месте
FOR a% = 1 TO 5: FOR nr% = 1 TO n%
GOSUB 7: NEXT nr%: GOSUB 1: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 15)-(x%(nr%) + 3, y%(nr%) + 20), 0, BF
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 15) + "R2"
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) + 1) + "," + STR$(y%(nr%) + 15) + "R2"
NEXT nr%: GOSUB 1: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 15)-(x%(nr%) + 3, y%(nr%) + 15), 0
GOSUB 7: NEXT nr%: GOSUB 1: IF r% = 1 THEN 3
NEXT a%

' ноги-руки в стороны
FOR a% = 1 TO 8
GOSUB 5: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 11)-(x%(nr%) + 3, y%(nr%) + 20), 0, BF
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 2) + "," + STR$(y%(nr%) + 11) + "G5 F5"
DRAW "R1 L2"
DRAW "BM" + STR$(x%(nr%) + 2) + "," + STR$(y%(nr%) + 11) + "F5 G5"
DRAW "R1 L2"
DRAW "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "G6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "F6"
NEXT nr%: GOSUB 1: IF r% = 1 THEN 3
FOR nr% = 1 TO n%
DRAW "C0 BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "G6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "F6"
DRAW "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 21) + "R6"
DRAW "L1 E5 H5 F5 G5 L4 H5 E5": GOSUB 7
NEXT nr%, a%

GOSUB 5: WEND

3 CLS
14 END

' временная задержка
1 DEF SEG = 0: FOR t% = 1 TO 5: LET z% = PEEK(&H46C)
IF INKEY$ <> "" THEN LET r% = 1: GOTO 2
WHILE z% = PEEK(&H46C): WEND: NEXT t%
2 RETURN

4 FOR nr% = 1 TO n%
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "L6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "R6"
NEXT nr%: GOSUB 1: IF r% = 1 THEN 2
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 4)-(x%(nr%) - 9, y%(nr%) + 4), 0
LINE (x%(nr%) + 3, y%(nr%) + 4)-(x%(nr%) + 9, y%(nr%) + 4), 0
PSET (x%(nr%), y%(nr%)), c%(nr%): NEXT nr%: RETURN

' чувак (без рук)
5 FOR nr% = 1 TO n%: GOSUB 7: NEXT nr%: GOSUB 1: IF r% = 1 THEN 2
FOR nr% = 1 TO n%
DRAW "C0 BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "D6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "D6"
PSET (x%(nr%), y%(nr%)), c%(nr%): NEXT nr%: RETURN

6 FOR nr% = 1 TO n%
DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "G6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "F6"
NEXT nr%: GOSUB 1: IF r% = 1 THEN 2
FOR nr% = 1 TO n%
LINE (x%(nr%) - 3, y%(nr%) + 4)-(x%(nr%) - 9, y%(nr%) + 10), 0
LINE (x%(nr%) + 3, y%(nr%) + 4)-(x%(nr%) + 9, y%(nr%) + 10), 0
PSET (x%(nr%), y%(nr%)), c%(nr%): NEXT nr%: RETURN

7 DRAW "C" + STR$(c%(nr%)) + "BM" + STR$(x%(nr%) - 3) + "," + STR$(y%(nr%) + 4) + "D6"
DRAW "BM" + STR$(x%(nr%) + 3) + "," + STR$(y%(nr%) + 4) + "D6"
LINE (x%(nr%) - 2, y%(nr%) - 2)-(x%(nr%) + 2, y%(nr%) + 2), c%(nr%), BF
LINE (x%(nr%), y%(nr%))-(x%(nr%), y%(nr%) + 4), c%(nr%): DRAW "R2 L4"
LINE (x%(nr%) - 2, y%(nr%) + 4)-(x%(nr%) + 2, y%(nr%) + 10), c%(nr%), BF
DRAW "D10 U10 L4 D10 R1 L2": PSET (x%(nr%) + 1, y%(nr%) + 20), c%(nr%)
PSET (x%(nr%) + 3, y%(nr%) + 20), c%(nr%)
PSET (x%(nr%) - 1, y%(nr%) - 1), 0: PSET (x%(nr%) + 1, y%(nr%) - 1), 0
PSET (x%(nr%), y%(nr%) + 1), 0: RETURN

13 IF ERL = 11 THEN PRINT "Overflow.": RESUME 11
PRINT "Error in the program.": RESUME 14