class ZCL_ADVENT_TYLER_2023 definition
  public
  final
  create public .

public section.

  class-methods DAY1A
    importing
      !INPUT type STRING_TABLE
    exporting
      !OUTPUT type INT8 .
  class-methods DAY1B
    importing
      !INPUT type STRING_TABLE
    exporting
      !OUTPUT type INT8 .
  class-methods DAY2
    importing
      !INPUT type STRING_TABLE
    exporting
      !OUTPUT type INT8
      !OUTPUT2 type INT8 .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ADVENT_TYLER_2023 IMPLEMENTATION.


  METHOD DAY1A.
    "This code is for day 1 of Advent of Code 2023!
    DATA: first_int     TYPE string,
          second_int    TYPE string,
          combined_ints TYPE TABLE OF int4.


    LOOP AT input INTO DATA(string).


      TRANSLATE string TO LOWER CASE.

      FIND FIRST OCCURRENCE OF PCRE '\d' IN string
       RESULTS DATA(first_number).

      first_int = string+first_number-offset(first_number-length).

      string = reverse( string ).
      FIND FIRST OCCURRENCE OF PCRE '\d' IN string
       RESULTS DATA(last_number).
      second_int = reverse( string+last_number-offset(last_number-length) ).

      APPEND |{ first_int }{ second_int }| TO combined_ints.

    ENDLOOP.

    output = REDUCE #( INIT val = 0
                            FOR row IN combined_ints NEXT val = val + row ).


  ENDMETHOD.


  METHOD DAY1B.
    "This code is for day 1 of Advent of Code 2023!
    DATA: first_int     TYPE string,
          second_int    TYPE string,
          combined_ints TYPE TABLE OF int4.


    LOOP AT input INTO DATA(string).

      TRANSLATE string TO LOWER CASE.

      FIND FIRST OCCURRENCE OF PCRE '\d|one|two|three|four|five|six|seven|eight|nine' IN string
       RESULTS DATA(first_number).

      first_int = string+first_number-offset(first_number-length).

      string = reverse( string ).
      FIND FIRST OCCURRENCE OF PCRE '\d|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno' IN string
       RESULTS DATA(last_number).
      second_int = reverse( string+last_number-offset(last_number-length) ).

      REPLACE ALL OCCURRENCES OF 'one' IN first_int WITH '1'.
      REPLACE ALL OCCURRENCES OF 'two' IN first_int WITH '2'.
      REPLACE ALL OCCURRENCES OF 'three' IN first_int WITH '3'.
      REPLACE ALL OCCURRENCES OF 'four' IN first_int WITH '4'.
      REPLACE ALL OCCURRENCES OF 'five' IN first_int WITH '5'.
      REPLACE ALL OCCURRENCES OF 'six' IN first_int WITH '6'.
      REPLACE ALL OCCURRENCES OF 'seven' IN first_int WITH '7'.
      REPLACE ALL OCCURRENCES OF 'eight' IN first_int WITH '8'.
      REPLACE ALL OCCURRENCES OF 'nine' IN first_int WITH '9'.


      REPLACE ALL OCCURRENCES OF 'one' IN second_int WITH '1'.
      REPLACE ALL OCCURRENCES OF 'two' IN second_int WITH '2'.
      REPLACE ALL OCCURRENCES OF 'three' IN second_int WITH '3'.
      REPLACE ALL OCCURRENCES OF 'four' IN second_int WITH '4'.
      REPLACE ALL OCCURRENCES OF 'five' IN second_int WITH '5'.
      REPLACE ALL OCCURRENCES OF 'six' IN second_int WITH '6'.
      REPLACE ALL OCCURRENCES OF 'seven' IN second_int WITH '7'.
      REPLACE ALL OCCURRENCES OF 'eight' IN second_int WITH '8'.
      REPLACE ALL OCCURRENCES OF 'nine' IN second_int WITH '9'.

      APPEND |{ first_int }{ second_int }| TO combined_ints.

    ENDLOOP.

    output = REDUCE #( INIT val = 0
                            FOR row IN combined_ints NEXT val = val + row ).


  ENDMETHOD.


  METHOD day2.
    "    This code is for day 2 of Advent of Code 2023!
    CONSTANTS:
      red_maximum   TYPE int4 VALUE '12',
      green_maximum TYPE int4 VALUE '13',
      blue_maximum  TYPE int4 VALUE '14'.

    DATA: bad_game    TYPE boolean,
          red_count   TYPE int2,
          green_count TYPE int2,
          blue_count  TYPE int2.

    LOOP AT input INTO DATA(games_string).

      SPLIT games_string AT ': ' INTO TABLE DATA(games).
      READ TABLE games INDEX 2 INTO DATA(sets_string).

      SPLIT sets_string AT '; ' INTO TABLE DATA(sets).
      LOOP AT sets INTO DATA(set).
        SPLIT set  AT ', ' INTO TABLE DATA(color_groups).
        LOOP AT color_groups INTO DATA(color_count).
          SPLIT color_count AT space INTO DATA(count) DATA(color).
          CASE color.
            WHEN 'red'.
              IF count GT red_count.
                red_count = count.
              ENDIF.
            WHEN 'green'.
              IF count GT green_count.
                green_count = count.
              ENDIF.
            WHEN 'blue'.
              IF count GT blue_count.
                blue_count = count.
              ENDIF.
          ENDCASE.
        ENDLOOP.
      ENDLOOP.
      IF NOT red_count GT red_maximum AND NOT green_count GT green_maximum AND NOT blue_count GT blue_maximum.
        READ TABLE games INDEX 1 INTO DATA(game_string).
        SPLIT game_string AT space INTO DATA(title) DATA(game_number).
        output = output + game_number.
      ENDIF.
      output2 = output2 + ( red_count * green_count * blue_count ).
      CLEAR red_count.
      CLEAR green_count.
      CLEAR blue_count.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
