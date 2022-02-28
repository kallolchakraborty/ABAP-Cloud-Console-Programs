CLASS zminmax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
* Mandatory Declaration:
    INTERFACES if_oo_adt_classrun.
* Creation of range table
    TYPES lty_type TYPE RANGE OF i.
    DATA  lr_table TYPE lty_type.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zminmax IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
* Filling of the range table
    lr_table = VALUE lty_type(
                            sign   = 'I'
                            option = 'EQ'
                               ( low = '10' )
                               ( low = '20' )
                               ( low = '50' )
                               ( low = '30' )
                               ( low = '40' )
                               ( low = '60' )
                               ( low = '70' )
                               ( low = '90' )
                              ).
* Sorting in ascending order
    SORT lr_table ASCENDING BY low.
* Display
    out->write( |Mininmum: | && |{ lr_table[ 1 ]-low }| ).
    out->write( |Maximum: | && |{ lr_table[ lines( lr_table ) ]-low }| ).

  ENDMETHOD.
  
ENDCLASS.
