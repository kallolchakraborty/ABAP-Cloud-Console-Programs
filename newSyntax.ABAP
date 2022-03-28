*--------------------------------------------------------------------*
TYPES: BEGIN OF lty_type01,
         bukrs TYPE bukrs,
         butxt TYPE string,
       END OF lty_type01.

DATA lt_t002 TYPE TABLE OF lty_type01.
DATA lt_t003 TYPE TABLE OF lty_type01.
*--------------------------------------------------------------------*

* Inline declaration: Variable
DATA(lv_var01) = 1.
DATA(lv_var02) = 'This is a test.'.

*--------------------------------------------------------------------*

* Inline declaration: SQL
* internal table declaration
SELECT bukrs AS column_01,
       butxt AS column_02
  FROM t001 "Company Codes
  INTO TABLE @DATA(lt_t001) "Internal table
  BYPASSING BUFFER.

*--------------------------------------------------------------------*

DATA(lv_string01) = ' kallol'.
* case: in sql with a new column created at runtime
SELECT FROM t001 "Company Codes
  FIELDS 'COMPANY CODE: ' && bukrs AS column_01,
         'COMPANY TEXT: ' && butxt AS column_02,
  CASE
    WHEN kokfi EQ '1'
      THEN 'EQUAL TO 1'
    ELSE
           'GREATER/LESS THAN 1'
  END AS custom_column,
  waers && @lv_string01 AS extra_column
  INTO TABLE @DATA(lt_t004) "Internal table
  BYPASSING BUFFER.

*--------------------------------------------------------------------*

* Inline declaration: loop
LOOP AT lt_t001 INTO DATA(ls_t001).
* Statements
ENDLOOP.

*--------------------------------------------------------------------*

* Inline declaration: Field Symbols
LOOP AT lt_t001 ASSIGNING FIELD-SYMBOL(<fs_t001>).
* statements
ENDLOOP.

*--------------------------------------------------------------------*

* Inline declaration: corresponding operator
lt_t002 = CORRESPONDING #( lt_t001 MAPPING bukrs = column_01
                                           butxt = column_02 ).

*--------------------------------------------------------------------*

* Inline declaration: using cl_abap_corresponding class
cl_abap_corresponding=>create( source      = lt_t001
                               destination = lt_t003
                               mapping = VALUE cl_abap_corresponding=>mapping_table(
                              ( level = 0 kind = 1 srcname = 'column_01' dstname = 'bukrs' )
                              ( level = 0 kind = 1 srcname = 'column_02' dstname = 'butxt' ) )
                              )->execute( EXPORTING source      = lt_t001
                                          CHANGING  destination = lt_t003 ).

*--------------------------------------------------------------------*

* Inline declaration: for loop
TYPES lty_text TYPE STANDARD TABLE OF string WITH EMPTY KEY.
DATA(lt_text01) = VALUE lty_text(
                      FOR ls_t002 IN lt_t002 WHERE ( bukrs = '0001' )
                      ( ls_t002-butxt  )
                      ).

*--------------------------------------------------------------------*

* Inline declaration: reading of internal table by index
DATA(ls_workarea01) = VALUE #( lt_t001[ 1 ] OPTIONAL ).

* Inline declaration: reading of internal table by filtering the column with a particular record
DATA(ls_workarea02) = VALUE #( lt_t002[ bukrs = '0001' ] OPTIONAL ).

* Inline declaration: check for content exist or not in the internal table
IF line_exists( lt_t002[ bukrs = '0001' ] ).
* statements
ENDIF.

* Inline declaration: fetching the line index of a particular record
DATA(ls_index) = line_index( lt_t002[ bukrs = '0001' ] ).

*--------------------------------------------------------------------*

* Inline declaration: concatenation normal
DATA(lv_var03) = |This is a | && |test by | && sy-uname.

* Inline declaration: concatenation using expressions
DATA(lv_var04) = |This is a test by { sy-uname } |.
DATA(lv_var05) = |This is a test by { TEXT-001 } |.

* Inline declaration: formatting using alpha
* Removing leading zeros
DATA(lv_var06) = |{ ls_workarea02-bukrs ALPHA = OUT }|.

* Adding leading zeros
DATA(lv_var07) = |{ ls_workarea02-bukrs ALPHA = IN }|.

*--------------------------------------------------------------------*

* Inline declaration: conversion operator
DATA(lv_var08) = CONV string( lv_var07 ).

*--------------------------------------------------------------------*

* Inline declaration: casting operator
DATA(lt_components) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( 'Z00_PARTNER_EXT' )
                                              )->components.

*--------------------------------------------------------------------*

* Inline declaration: value operator
TYPES lty_type TYPE TABLE OF char4 WITH EMPTY KEY.
* Creating table with two columns: Row, Table_Line
DATA(lt_table01) = VALUE lty_type( ( '0001' )
                                   ( '0002' )
                                   ( '0003' )
                                   ( '0004' ) ).

* Creating range table
DATA  lr_bukrs_01 TYPE RANGE OF bukrs.
lr_bukrs_01 = VALUE #(
                      sign   = 'I'
                      option = 'EQ'
                      ( low = '0100' )
                      ( low = '0200' )
                      ( low = '0300' )
                      ( low = '0400' )
                      ( low = '0500' )
                      ( low = '0600' )
                      ( low = '0700' )
                      ).

*--------------------------------------------------------------------*

* Inline declaration: reduce operator
* Finding the count
DATA(lv_var09) = REDUCE i( INIT k = 0
                           FOR ls_t002 IN lt_t002
                           WHERE ( bukrs = '0001' )
                           NEXT k = k + 1 ).

*--------------------------------------------------------------------*

* Inline declaration: conditional operator
DATA(lv_var10) = COND #(
                          WHEN lv_var09 = '1' THEN 'One'
                          WHEN lv_var09 = '2' THEN 'Two'
                          WHEN lv_var09 = '3' THEN 'Three'
                       ).

*--------------------------------------------------------------------*

* Inline declaration: switch operator
DATA(lv_var11) = SWITCH string( lv_var09
                                WHEN 1 THEN 'One'
                                WHEN 2 THEN 'Two'
                                WHEN 3 THEN 'Three'
                               ).

*--------------------------------------------------------------------*
* Inline declaration: OOPS ABAP
* Object declaration
DATA(lo_object_01) = cl_demo_output=>new( ).

* class definition
CLASS zcl_test_class_01 DEFINITION.
  PUBLIC SECTION.
ENDCLASS.
* class implementation
CLASS zcl_test_class_01 IMPLEMENTATION.
ENDCLASS.
* creation of the object
DATA(lo_object_02) = NEW zcl_test_class_01( ).

*--------------------------------------------------------------------*

* Inline declaration: is instance of
IF lo_object_02 IS INSTANCE OF zcl_test_class_01.
  WRITE: 'Kallol'.
ENDIF.

*--------------------------------------------------------------------*
