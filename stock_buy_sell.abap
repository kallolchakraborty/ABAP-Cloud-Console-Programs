CLASS zcl_stock_buy_sell DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

* Mandatory declaration
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES ty_prices TYPE STANDARD TABLE OF i WITH DEFAULT KEY.

    METHODS StockBuySell
      IMPORTING lt_prices            TYPE ty_prices
      RETURNING VALUE(rv_max_profit) TYPE i.

ENDCLASS.


CLASS zcl_stock_buy_sell IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    out->write( |{ StockBuySell( VALUE #( ( 7 ) ( 1 ) ( 5 ) ( 3 ) ( 6 ) ( 4 ) ) ) }| ).
  ENDMETHOD.

  METHOD StockBuySell.

    DATA(lv_min_price) = lt_prices[ 1 ].

    LOOP AT lt_prices ASSIGNING FIELD-SYMBOL(<lfs_wa>).
      lv_min_price = nmin( val1 = lv_min_price
                           val2 = <lfs_wa> ).
      rv_max_profit = nmax( val1 = rv_max_profit
                            val2 = ( <lfs_wa> - lv_min_price ) ).
    ENDLOOP.

    UNASSIGN <lfs_wa>.
    FREE lv_min_price.

  ENDMETHOD.

ENDCLASS.