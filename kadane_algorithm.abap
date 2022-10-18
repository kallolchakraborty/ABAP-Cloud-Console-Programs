* ----------------------------------------------------------------- */
* Description : Kadane's Algorithm(max sub-array sum of an array)  */
* Author      : Kallol Chakraborty                                */
* Date        : 18/10/2022                                       */
* Version     : Initial Version                                 */
* ------------------------------------------------------------ */
CLASS zkadane_algorithm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

* Mandatory declaration
    INTERFACES if_oo_adt_classrun.

* variables
    DATA : lt_integers TYPE STANDARD TABLE OF i WITH EMPTY KEY,
           lv_msf      TYPE i VALUE 0, "max so far
           lv_meh      TYPE i VALUE 0, "max ending here
           lv_temp     TYPE i VALUE 0, "sum
           lv_start    TYPE i VALUE 0, "start
           lv_end      TYPE i VALUE 0. "end

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zkadane_algorithm IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

* filling of the table
*    lt_integers = VALUE #( ( -2 ) ( -3 ) ( 4 ) ( -1 ) ( -2 ) ( 1 ) ( 5 ) ( -3 ) ).
    lt_integers = VALUE #( ( -2 ) ( 1 ) ( -3 ) ( 4 ) ( -1 ) ( 2 ) ( 1 ) ( -5 ) ( 4 ) ).

    LOOP AT lt_integers ASSIGNING FIELD-SYMBOL(<lf_wa>).
* incrementing
      lv_meh = lv_meh + <lf_wa>.

      IF ( lv_msf < lv_meh ).
        lv_msf = lv_meh.
        lv_start = lv_temp.
        lv_end = ( sy-tabix -  1 ).
      ENDIF.

      IF ( lv_meh < 0 ).
        lv_meh = 0.
        lv_temp = ( sy-tabix - 1 )  + 1.
      ENDIF.

    ENDLOOP.

* printing the output
    out->write( |Max Continuos Array: | && |{ lv_msf }| ).
    out->write( |Starting Index: | && |{ lv_start }| && | | && |Ending Index: | && |{ lv_end }| ).


    UNASSIGN <lf_wa>.
    CLEAR :  lv_msf,
             lv_meh,
             lv_temp,
             lv_start,
             lv_end.

  ENDMETHOD.

ENDCLASS.
