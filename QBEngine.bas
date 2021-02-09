' Written by Omer B. Hijazi (github: omerhijazi404)
' You may modify and do whatever you want with it with the only exception: keep this comment and the one above it intact

OPTION _EXPLICIT
OPTION BASE 0

' A coordinate containing an X and Y
TYPE Coordinate
    X AS INTEGER
    Y AS INTEGER
END TYPE

' The Sprites of an object
TYPE Sprite
    Image AS LONG
    Color AS LONG
    A AS Coordinate
    B AS Coordinate
    C AS Coordinate
    D AS Coordinate
    E AS Coordinate
    Points AS INTEGER
END TYPE

' The objects to be used in the game
TYPE Object
    Name AS STRING
    Scale AS Coordinate
    Sprite AS Sprite
    Empty AS INTEGER
END TYPE

DIM SHARED Objects(999) AS Object

DIM SHARED True AS INTEGER
DIM SHARED False AS INTEGER
True = -1
False = 0

DIM SHARED CollisionsEnabled AS INTEGER
CollisionsEnabled = True

DIM SHARED Background AS LONG

Background = _NEWIMAGE(800, 600, 32)
SCREEN Background

EmptyObjects

DO
    DIM obj AS Object
    obj.Empty = False
    obj.Sprite.Points = 2
    obj.Sprite.A.X = 100
    obj.Sprite.A.Y = 100
    obj.Sprite.B.X = 200
    obj.Sprite.B.Y = 200
    obj.Sprite.Color = _RGB32(55, 194, 89)
    Objects(FirstEmptyObject%) = obj
    IF CollisionsEnabled THEN CheckCollisions
    DisplayObjects
    _LIMIT 60
LOOP

' SUBS AND FUNCTIONS

FUNCTION OnCollide (object1 AS Object, object2 AS Object)
    PRINT "Collision!"
END FUNCTION

SUB DisplayObjects
    DIM i%
    FOR i% = 0 TO 999
        IF Objects(i%).Empty THEN GOTO nexti
        IF Objects(i%).Sprite.Image = 0 THEN
            SELECT CASE Objects(i%).Sprite.Points
                CASE 1:
                    PSET (Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y), Objects(i%).Sprite.Color
                CASE 2:
                    LINE (Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y)-(Objects(i%).Sprite.B.X, Objects(i%).Sprite.B.Y), Objects(i%).Sprite.Color
                CASE 3:
            END SELECT
        END IF
        nexti:
    NEXT i%
END SUB

SUB EmptyObjects
    DIM i%
    FOR i% = 0 TO 999
        Objects(i%).Empty = True
    NEXT i%
END SUB

FUNCTION FirstEmptyObject%
    DIM i%
    FOR i% = 0 TO 999
        IF Objects(i%).Empty THEN
            FirstEmptyObject% = i%
            GOTO exitfor
        END IF
    NEXT i%
    exitfor:
END FUNCTION

SUB EmptyObject (ObjectNumber AS INTEGER)
    DIM FreeObject AS Object
    FreeObject.Empty = True
    Objects(ObjectNumber) = FreeObject
END SUB

SUB CheckCollisions
END SUB
