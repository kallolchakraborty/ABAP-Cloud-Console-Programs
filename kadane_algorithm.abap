CLASS zcl_algo_kadane DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* Mandatory declaration
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES ty_nums TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS kadaneAlgorithm
      IMPORTING lt_nums       TYPE STANDARD TABLE
      RETURNING VALUE(rv_msf) TYPE i.

ENDCLASS.


CLASS zcl_algo_kadane IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( |{ kadaneAlgorithm( VALUE ty_nums( ( 5 ) ( 4 ) ( -1 ) ( 7 ) ( 8 ) ) ) }| ).
  ENDMETHOD.

  METHOD kadaneAlgorithm.

* local variables
    DATA : lv_meh   TYPE i VALUE 0, "max ending here
           lv_temp  TYPE i VALUE 0, "sum
           lv_start TYPE i VALUE 0, "start
           lv_end   TYPE i VALUE 0. "end

    rv_msf = VALUE #( lt_nums[ 1 ] OPTIONAL ).

    LOOP AT lt_nums ASSIGNING FIELD-SYMBOL(<lf_wa>).

      lv_meh += <lf_wa>.

      IF ( rv_msf < lv_meh ).
        rv_msf = lv_meh.
        lv_start = lv_temp.
        lv_end = ( sy-tabix -  1 ).
      ENDIF.

      IF ( lv_meh < 0 ).
        lv_meh = 0.
        lv_temp = sy-tabix.
      ENDIF.
    ENDLOOP.

    UNASSIGN <lf_wa>.
    FREE : lv_meh, lv_temp, lv_start, lv_end.

  ENDMETHOD.

ENDCLASS.