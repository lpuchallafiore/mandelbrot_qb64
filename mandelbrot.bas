' Mandelbrot set renderer.
' Jan 2018, Loren Puchalla Fiore.
' -------------------------------

' Define a data type for complex numbers.
TYPE Complex
  re AS DOUBLE
  im AS DOUBLE
END TYPE

' Create a windowed screen surface. 640x480 with 256 colors.
Video& = _NEWIMAGE(640, 480, 256)
SCREEN Video&

' Loop over every pixel on the screen.
FOR y = 0 TO 479
  FOR x = 0 TO 639
    ' Classic XOR pattern for testing.
    ' PSET(x, y), (x XOR y) MOD 256

    ' Mandelbrot set.
    DIM c_x AS SINGLE, c_y AS SINGLE
    DIM C AS Complex, Z AS Complex, Z2 AS Complex
    DIM i AS INTEGER

    ' Initialization.
    c_x = x * 1.0 / 640 - 0.5
    c_y = y * 1.0 / 480 - 0.5
    CALL INIT_C(c_x * 3.0 - 1.0, c_y * 2.0, C)
    CALL INIT_C(0.0, 0.0, Z)

    ' Iterate until escape.
    i = 0
    DO
      CALL MUL_C(Z, Z, Z2)
      CALL SUM_C(Z2, C, Z)
      i = i + 1
    LOOP UNTIL (LENGTH_C(Z) > 4.0 OR i > 512)

    ' Convert escape iteration into a color and set the screen.
    value = i * 255.0 / 150.0
    PSET (x, y), value
  NEXT x
NEXT y

END  ' End of program.

' Subroutines for manipulating complex numbers.
' ------------------------------------------------------------------------------
SUB INIT_C (re AS DOUBLE, im AS DOUBLE, result AS Complex)
  result.re = re
  result.im = im
END SUB

SUB SUM_C (a AS Complex, b AS Complex, result AS Complex)
  result.re = a.re + b.re
  result.im = a.im + b.im
END SUB

SUB MUL_C (a AS Complex, b AS Complex, result AS Complex)
  result.re = a.re * b.re - a.im * b.im
  result.im = a.im * b.re + a.re * b.im
END SUB

FUNCTION LENGTH_C# (c AS Complex)
  LENGTH_C = SQR((c.re * c.re) + (c.im * c.im))
END FUNCTION
