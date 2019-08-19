*&---------------------------------------------------------------------*
*&      Form  yf_om_display_alv_org
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM yf_om_display_alv_org.

  DATA: my_table     TYPE REF TO cl_salv_table,
        my_functions TYPE REF TO cl_salv_functions_list,
        my_columns   TYPE REF TO cl_salv_columns_table,
        my_column    TYPE REF TO cl_salv_column_table.

  IF ( ti_log IS INITIAL ).
    MESSAGE s000(yfi) WITH text-m08.
  ENDIF.

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = my_table
        CHANGING
          t_table      = ti_log ).
    CATCH cx_salv_msg.
      MESSAGE i002(sy) WITH TEXT-E01 DISPLAY LIKE cc_e.
  ENDTRY.

  my_functions = my_table->get_functions( ).
  my_functions->set_all( abap_true ).

  my_columns = my_table->get_columns( ).
  my_columns->set_optimize( abap_true ).

  TRY.
      my_column ?= my_columns->get_column( 'DATUM' ).
      my_column->set_long_text( 'Data' )                  ##NO_TEXT.
      my_column->set_medium_text( 'Data' )                ##NO_TEXT.
      my_column->set_short_text( 'Data' )                 ##NO_TEXT.
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      my_column ?= my_columns->get_column( 'UZEIT' ).
      my_column->set_long_text( 'Hora' )                  ##NO_TEXT.
      my_column->set_medium_text( 'Hora' )                ##NO_TEXT.
      my_column->set_short_text( 'Hora' )                 ##NO_TEXT.
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      my_column ?= my_columns->get_column( 'STATUS' ).
      my_column->set_long_text( 'Status' )                ##NO_TEXT.
      my_column->set_medium_text( 'Status' )              ##NO_TEXT.
      my_column->set_short_text( 'Status' )               ##NO_TEXT.
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      my_column ?= my_columns->get_column( 'DESC_TABLE' ).
      my_column->set_long_text( 'Nome da tabela' )        ##NO_TEXT.
      my_column->set_medium_text( 'Nome tabela' )         ##NO_TEXT.
      my_column->set_short_text( 'Tabela' )               ##NO_TEXT.
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      my_column ?= my_columns->get_column( 'OBJID' ).
      my_column->set_long_text( 'ID Objeto' )             ##NO_TEXT.
      my_column->set_medium_text( 'ID Objeto' )           ##NO_TEXT.
      my_column->set_short_text( 'ID Obj' )               ##NO_TEXT.
    CATCH cx_salv_not_found.
  ENDTRY.

  my_table->display( ).

ENDFORM.                    "yf_om_display_alv_org
