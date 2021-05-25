' Written by Omer B. Hijazi (github: omerhijazi404)
' You may do whatever you want with it with only one exception: keep this comment and the one above it intact

OPTION _EXPLICIT
OPTION BASE 0

DIM SHARED FPS AS INTEGER
FPS = 30

' A coordinate containing an X and Y
TYPE Coordinate
    X AS INTEGER
    Y AS INTEGER
END TYPE

' The Sprites of an object
TYPE Sprite
    Image AS LONG
    Color AS LONG
    Center AS Coordinate
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

REDIM SHARED Objects(0) AS Object

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
    CLS
    IF CollisionsEnabled THEN CheckCollisions
    DisplayObjects
    _LIMIT FPS
LOOP

' SUBS AND FUNCTIONS

FUNCTION OnCollide (object1 AS Object, object2 AS Object)
    PRINT "Collision!"
END FUNCTION

SUB DisplayObjects
    CLS
    DIM i%
    FOR i% = 0 TO UBOUND(objects)
        IF Objects(i%).Empty THEN GOTO nexti
        IF Objects(i%).Sprite.Image = 0 THEN
            SELECT CASE Objects(i%).Sprite.Points
                CASE 1:
                    PSET (Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y), Objects(i%).Sprite.Color
                CASE 2:
                    LINE (Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y)-(Objects(i%).Sprite.B.X, Objects(i%).Sprite.B.Y), Objects(i%).Sprite.Color
                CASE 3:
                    LINE (Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y)-(Objects(i%).Sprite.B.X, Objects(i%).Sprite.B.Y), Objects(i%).Sprite.Color
                    LINE (Objects(i%).Sprite.B.X, Objects(i%).Sprite.B.Y)-(Objects(i%).Sprite.C.X, Objects(i%).Sprite.C.Y), Objects(i%).Sprite.Color
                    LINE (Objects(i%).Sprite.C.X, Objects(i%).Sprite.C.Y)-(Objects(i%).Sprite.A.X, Objects(i%).Sprite.A.Y), Objects(i%).Sprite.Color
            END SELECT
        ELSE
            _PUTIMAGE (Objects(i%).Sprite.Center.X, Objects(i%).Sprite.Center.Y), Objects(i%).Sprite.Image
        END IF
        nexti:
    NEXT i%
END SUB

SUB EmptyObjects
    DIM i AS INTEGER
    FOR i = 0 TO UBOUND(objects)
    NEXT i
END SUB

SUB EmptyObject (ObjectNumber AS INTEGER)
    DIM FreeObject AS Object
    FreeObject.Empty = True
    Objects(ObjectNumber) = FreeObject
END SUB

SUB CheckCollisions
END SUB

FUNCTION AddObject% (obj AS Object)
    REDIM _PRESERVE Objects(UBOUND(Objects) + 1) AS Object
    Objects(UBOUND(Objects)) = obj
END FUNCTION
