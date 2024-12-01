class ZCL_ADVENT_TYLER_2024 definition
  public
  final
  create public .

public section.

  class-methods DAY1
    importing
      !INPUT type STRING_TABLE
    exporting
      !OUTPUT type INT8
      !OUTPUT2 type INT8 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ADVENT_TYLER_2024 IMPLEMENTATION.


  METHOD day1.
    "This code is for day 1 of Advent of Code 2024!
    DATA: left_column  TYPE TABLE OF int4,
          right_column TYPE TABLE OF int4.

    LOOP AT input INTO DATA(string).
      SPLIT string AT '   ' INTO DATA(value1) DATA(value2).
      APPEND value1 TO left_column.
      APPEND value2 TO right_column.
    ENDLOOP.

    SORT left_column ASCENDING.
    SORT right_column ASCENDING.

    LOOP AT left_column INTO DATA(left_value).
      READ TABLE right_column INTO DATA(right_value) INDEX sy-tabix.
      output = output + abs( right_value - left_value ).

      SELECT COUNT(*) FROM @right_column AS column WHERE table_line EQ @left_value INTO @DATA(count) ##ITAB_KEY_IN_SELECT.
      output2 = output2 + ( left_value * count ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
