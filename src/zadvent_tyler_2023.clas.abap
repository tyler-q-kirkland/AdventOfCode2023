class ZADVENT_TYLER_2023 definition
  public
  final
  create public .

public section.

  class-methods DAY1
    exporting
      !OUTPUT type INT8 .
protected section.
private section.
ENDCLASS.



CLASS ZADVENT_TYLER_2023 IMPLEMENTATION.


  METHOD day1.
"This code is for day 1 of Advent of Code 2023!
    DATA: string TYPE string,
          first_int     TYPE string,
          second_int    TYPE string,
          combined_ints TYPE TABLE OF int4.

    SELECT string FROM zadvent_ty_day1 INTO TABLE @DATA(data).

    LOOP AT data INTO string.

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
ENDCLASS.
