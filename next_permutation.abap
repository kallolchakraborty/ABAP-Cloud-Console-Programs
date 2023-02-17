CLASS zcl_algo_nxtpermut DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* Mandatory declaration
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES ty_nums TYPE STANDARD TABLE OF i WITH EMPTY KEY.
*    DATA lt_nums  TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    METHODS getNextPermutation
      CHANGING lt_nums TYPE STANDARD TABLE.

    METHODS reverseNumbers
      CHANGING lt_nums TYPE ty_nums
               lv_i    TYPE i
               lv_j    TYPE i.

    METHODS swapNumbers
      CHANGING lt_nums TYPE ty_nums
               lv_i    TYPE i
               lv_j    TYPE i.

ENDCLASS.


CLASS zcl_algo_nxtpermut IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    lt_nums = VALUE ty_nums( ( 3 ) ( 2 ) ( 1 ) ).
    DATA(lt_nums) = VALUE ty_nums( ( 1 ) ( 3 ) ( 5 ) ( 4 ) ( 2 ) ).
*    lt_nums = VALUE ty_nums( ( 1 ) ( 2 ) ( 3 ) ).

*   calling the method
    getNextPermutation( CHANGING lt_nums = lt_nums ).

    out->write( |next permutation:------->| ).
    out->write( lt_nums ).

    FREE lt_nums.

  ENDMETHOD.

  METHOD getNextPermutation.

    DATA(lv_i) = 1.
    DATA(lv_j) = 1.

*   step: 1
    LOOP AT lt_nums ASSIGNING FIELD-SYMBOL(<lf_wa>) STEP -1 FROM lines( lt_nums ) - 1.
      IF sy-tabix GE 1 AND <lf_wa> < lt_nums[ sy-tabix + 1 ].
        lv_i = lines( lt_nums ) + 1 - sy-tabix.
        EXIT.
      ENDIF.
    ENDLOOP.

    UNASSIGN <lf_wa>.

*   base condition
    IF lv_i = 1.
      lv_j = lines( lt_nums ).
      swapNumbers( CHANGING lt_nums = lt_nums
                        lv_i = lv_i
                        lv_j = lv_j ).

    ELSE.
*     step: 2
      LOOP AT lt_nums ASSIGNING <lf_wa> FROM 1 TO lv_i.
        IF <lf_wa> > lt_nums[ lv_i ].
          lv_j = sy-tabix - 1.
          EXIT.
        ENDIF.
      ENDLOOP.
*     step: 3
      swapNumbers( CHANGING lt_nums = lt_nums
                            lv_i = lv_i
                            lv_j = lv_j ).
*     step: 4: manipulations
      lv_j += 1.
      lv_i = lines( lt_nums ).
*   step: 5
      reverseNumbers( CHANGING lt_nums = lt_nums
                      lv_i = lv_j
                      lv_j = lv_i ).
    ENDIF.

    UNASSIGN <lf_wa>.
    FREE: lv_i, lv_j.

  ENDMETHOD.

  METHOD reverseNumbers.
    WHILE lv_i < lv_j.
      swapNumbers( CHANGING lt_nums = lt_nums
                            lv_i = lv_i
                            lv_j = lv_j ).

      lv_i += 1.
      lv_j -= 1.
    ENDWHILE.

  ENDMETHOD.

  METHOD swapNumbers.
    DATA(lv_temp) = 0.

*   swapping
    lv_temp = lt_nums[ lv_i ].
    lt_nums[ lv_i ] =  lt_nums[ lv_j ].
    lt_nums[ lv_j ] = lv_temp.

    FREE lv_temp.
  ENDMETHOD.

ENDCLASS.
