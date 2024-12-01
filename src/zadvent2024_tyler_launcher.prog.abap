*&---------------------------------------------------------------------*
*& Report ZADVENT2024_TYLER_LAUNCHER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zadvent2024_tyler_launcher.

DATA: puzzle_input TYPE TABLE OF string,
      output       TYPE int8,
      output2      TYPE int8,
      day_text     TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK details WITH FRAME TITLE TEXT-s01.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT (55) TEXT-c01.
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT (77) TEXT-c02.
  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK details.

SELECTION-SCREEN BEGIN OF BLOCK dayselection WITH FRAME TITLE TEXT-s02.
  PARAMETERS : day1 RADIOBUTTON GROUP day DEFAULT 'X',
               day2  RADIOBUTTON GROUP day.
SELECTION-SCREEN END OF BLOCK dayselection.

SELECTION-SCREEN BEGIN OF BLOCK file.
  PARAMETERS: file TYPE string.
  DATA: rc    TYPE i,
        files TYPE filetable.
SELECTION-SCREEN END OF BLOCK file.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR file.
  CALL METHOD cl_gui_frontend_services=>file_open_dialog(
    CHANGING
      file_table = files
      rc         = rc ).
  IF rc GT 0.
    READ TABLE files INDEX 1 INTO file.
  ENDIF.

START-OF-SELECTION.

  cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename                = file
      filetype                = 'ASC'
    CHANGING
      data_tab                = puzzle_input ).
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  IF day1 = 'X'.
    zcl_advent_tyler_2024=>day1(
    EXPORTING
      input  = puzzle_input
    IMPORTING
      output = output
      output2 = output2
  ).
    day_text = TEXT-d01.

  ENDIF.

  IF output2 IS NOT INITIAL.
    WRITE: |{ 'Your puzzle output for' } { day_text } { 'part A is' } { output } { 'and part B is' } { output2 }{ '.' }|.
  ELSE.
    WRITE: |{ 'Your puzzle output for' } { day_text } { 'is' } { output }{ '.' }|.
  ENDIF.
