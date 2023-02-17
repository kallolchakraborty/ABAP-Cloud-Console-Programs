CLASS zcl_algo_dnf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* Mandatory declaration
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES ty_nums TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    DATA lt_nums  TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS sortNumbers
      CHANGING lt_nums TYPE STANDARD TABLE.

    METHODS swapNumbers
      CHANGING lt_nums TYPE STANDARD TABLE
               lv_i    TYPE i
               lv_j    TYPE i.

ENDCLASS.

CLASS zcl_algo_dnf IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_obj) = NEW zcl_algo_dnf( ).

*   data
    lt_nums = VALUE ty_nums( ( 2 ) ( 0 ) ( 2 ) ( 1 ) ( 1 ) ( 0 ) ).
*   calling the method
    lo_obj->sortNumbers( CHANGING lt_nums = lt_nums ).

    out->write( |after sorting:------->| ).
    out->write( lt_nums ).

    FREE lt_nums.

  ENDMETHOD.

  METHOD sortNumbers.

*   indexes
    DATA(lv_low) = 1.
    DATA(lv_mid) = 1.
    DATA(lv_high) = lines( lt_nums ).

    WHILE lv_mid <= lv_high.
      CASE lt_nums[ lv_mid ].
        WHEN 0.
          swapNumbers( CHANGING lt_nums = lt_nums
                    lv_i = lv_low
                    lv_j = lv_mid ).
          lv_low += 1.
          lv_mid += 1.
        WHEN 1.
          lv_mid += 1.
        WHEN 2.
          swapNumbers( CHANGING lt_nums = lt_nums
                      lv_i = lv_mid
                      lv_j = lv_high ).
          lv_high -= 1.
      ENDCASE.
    ENDWHILE.

    FREE: lv_low, lv_mid, lv_high.

  ENDMETHOD.

  METHOD swapNumbers.

*   local variable
    DATA(lv_temp) = 0.

*   swapping
    lv_temp = lt_nums[ lv_i ].
    lt_nums[ lv_i ] =  lt_nums[ lv_j ].
    lt_nums[ lv_j ] = lv_temp.

    FREE lv_temp.

  ENDMETHOD.

ENDCLASS.