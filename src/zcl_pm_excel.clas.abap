class ZCL_PM_EXCEL definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF t_head,
        htext TYPE string,
        field TYPE string,
        ftype TYPE /u4a/e_bndtyp,
        reffd TYPE string,
        colfd TYPE string,
        color TYPE /u4a/e_style_color_argb,
        align TYPE /u4a/e_alignment,
        fkind TYPE char1,
        ischg TYPE flag,
        width TYPE i,
      END OF t_head .
  types:
    tt_head TYPE TABLE OF t_head .

  data MT_HEAD type TT_HEAD .
  data MV_TAB_NAME type STRING .

  methods CONSTRUCTOR .
  methods DOWNLOAD_S
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !IV_TABLE_ID type STRING
      !IV_FILE_NAME type STRING optional
      !IV_NO_FORMAT type FLAG optional
      value(IV_PASSWORD) type C optional .
  methods DOWNLOAD
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !IV_FILE_NAME type STRING optional
      !IV_NO_FORMAT type FLAG optional
      value(IV_PASSWORD) type C optional .
protected section.
private section.

  data MO_EXCEL type ref to /U4A/CL_XL .
  data MO_STYLES type ref to CL_OBJECT_MAP .
  data MT_MSG type STRING_TABLE .
  constants MC_HEAD type STRING value 'HEAD' ##NO_TEXT.

  methods ADD_HEAD
    importing
      !IV_HTEXT type STRING
      !IV_FIELD type STRING
      !IV_FTYPE type /U4A/E_BNDTYP optional
      !IV_REFFD type STRING optional
      !IV_COLFD type STRING optional
      !IV_COLOR type /U4A/E_STYLE_COLOR_ARGB optional
      !IV_WIDTH type I default '20' .
  methods ADD_STYLE
    importing
      !KEY type ANY optional
      !BOLD_FLAG type FLAG optional
      !BACK_COLOR type /U4A/E_STYLE_COLOR_ARGB default 'FFFFFFFF'
      !FONT_COLOR type /U4A/E_STYLE_COLOR_ARGB default 'FF000000'
      !FORMAT_CODE type /U4A/E_NUMBER_FORMAT optional
      !HORIZONTAL type /U4A/E_ALIGNMENT default 'center'
      !VERTICAL type /U4A/E_ALIGNMENT default 'center' .
  methods CONV_RGB_TO_ARGB
    importing
      !IV_RGB type ANY
    returning
      value(RV_ARGB) type /U4A/E_STYLE_COLOR_ARGB .
  methods CREATE_HEAD
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !IV_TABLE_ID type STRING .
  methods CREATE_STYLE
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !IV_TABLE_ID type STRING optional
      !IV_TAB_NAME type STRING optional .
  methods SPLIT_FIELD
    importing
      !IV_STR type ANY
    exporting
      !EV_TNAME type STRING
      !EV_FNAME type STRING .
ENDCLASS.



CLASS ZCL_PM_EXCEL IMPLEMENTATION.


  METHOD add_head.

    DATA ls_head LIKE LINE OF me->mt_head.

    ls_head-htext = iv_htext.
    ls_head-field = iv_field.
    ls_head-ftype = iv_ftype.
    ls_head-reffd = iv_reffd.
    ls_head-colfd = iv_colfd.
    ls_head-color = iv_color.
    ls_head-width = iv_width.

    TRANSLATE ls_head-field TO UPPER CASE.
    TRANSLATE ls_head-reffd TO UPPER CASE.
    TRANSLATE ls_head-colfd TO UPPER CASE.

    APPEND ls_head TO me->mt_head. CLEAR ls_head.
  ENDMETHOD.


  METHOD add_style.

    DATA lo_border TYPE REF TO /u4a/cl_xl_style_border.
    CREATE OBJECT lo_border.
    lo_border->border_color-rgb = /u4a/cl_xl_style_color=>c_black.
    lo_border->border_style     = /u4a/cl_xl_style_border=>c_border_thin.
*
    DATA lo_style TYPE REF TO /u4a/cl_xl_style.
    lo_style                        = me->mo_excel->add_new_style( ).
    lo_style->font->name            = '맑은 고딕'.
    lo_style->font->size            = 10.
    lo_style->font->bold            = bold_flag.
    lo_style->font->color-rgb       = font_color.
    lo_style->fill->filltype        = /u4a/cl_xl_style_fill=>c_fill_solid.

    IF back_color IS INITIAL.
      lo_style->fill->fgcolor-rgb = /u4a/cl_xl_style_color=>c_white.
    ELSE.
      lo_style->fill->fgcolor-rgb = back_color.
    ENDIF.

    lo_style->alignment->horizontal = horizontal.
    lo_style->alignment->vertical   = vertical.
    lo_style->borders->allborders   = lo_border.

    IF format_code IS NOT INITIAL.
      lo_style->number_format->format_code = format_code.
    ENDIF.
*
    CALL METHOD me->mo_styles->put
      EXPORTING
        key   = key
        value = lo_style.

  ENDMETHOD.


  METHOD constructor.

    CREATE OBJECT me->mo_excel.
    CREATE OBJECT me->mo_styles.

    CALL METHOD me->add_style
      EXPORTING
        key        = me->mc_head
        bold_flag  = abap_true
        back_color = /u4a/cl_xl_style_color=>c_gray.

  ENDMETHOD.


  METHOD conv_rgb_to_argb.
    CLEAR rv_argb.
    rv_argb = iv_rgb.
    REPLACE `#` IN rv_argb WITH `FF`.
  ENDMETHOD.


  METHOD create_head.
    DATA lo_table TYPE REF TO /u4a/cl_uo01139.
    lo_table ?= io_view->get_ui_instance( iv_table_id ).
    CHECK lo_table IS BOUND.
*
    DATA lo_object TYPE REF TO object.
    lo_object ?= io_view->control.
*
    DATA lo_column       TYPE REF TO /u4a/cl_uo01127.
    DATA lo_label        TYPE REF TO /u4a/cl_uo00319.
    DATA lo_text         TYPE REF TO /u4a/cl_uo00452.
    DATA lo_link         TYPE REF TO /u4a/cl_uo00324.
    DATA lo_input        TYPE REF TO /u4a/cl_uo00314. "추가
    DATA lo_objectstatus TYPE REF TO /u4a/cl_uo00368. "추가
    DATA lo_checkbox     TYPE REF TO /u4a/cl_uo00253. "추가
    DATA lo_datepicker   TYPE REF TO /u4a/cl_uo00261. "추가

    DATA ls_head   LIKE LINE OF me->mt_head.

    FIELD-SYMBOLS <fs_bind> TYPE any.
    DATA  lo_contr    TYPE REF TO object.

    LOOP AT lo_table->child INTO DATA(lo_child) WHERE table_line->uiobk EQ 'UO01127'.

      CLEAR: lo_column, ls_head.

      lo_column ?= lo_child.

      IF lo_column->bp01127_visible IS NOT INITIAL.
        ASSIGN lo_object->(lo_column->bp01127_visible) TO FIELD-SYMBOL(<visible>).
        IF <visible> IS ASSIGNED AND <visible> IS INITIAL.
          CONTINUE.
        ENDIF.
      ENDIF.

      IF lo_column->pp01127_visible EQ 'false'.
        CONTINUE.
      ENDIF.

      IF lo_column->ep01127_markcellcolor IS NOT INITIAL.
        ls_head-color = me->conv_rgb_to_argb( lo_column->ep01127_markcellcolor ).
      ELSEIF lo_column->eb01127_markcellcolor IS NOT INITIAL.
        CALL METHOD me->split_field
          EXPORTING
            iv_str   = lo_column->eb01127_markcellcolor
          IMPORTING
            ev_fname = ls_head-colfd.
      ENDIF.

      LOOP AT lo_column->child INTO DATA(lo_element).

        CLEAR: lo_label, lo_text.

        CASE lo_element->uiobk.
          WHEN 'UO00319'.
            lo_label ?= lo_element.
            IF lo_label->pp00319_text IS NOT INITIAL.
              ls_head-htext = lo_label->pp00319_text.
            ELSE.
              " Data Binding 된 Label 내역은 값이 없음...control 오브젝트 값 사용..
              UNASSIGN <fs_bind>.
              lo_contr ?= io_view->control.
              IF lo_contr IS BOUND.
                ASSIGN lo_contr->(lo_label->bp00319_text) TO <fs_bind>.
                IF <fs_bind> IS ASSIGNED.
                  ls_head-htext = <fs_bind>.
                ENDIF.
              ENDIF.

            ENDIF.

          WHEN 'UO00452'.
            lo_text ?= lo_element.

            DELETE lo_text->at_addt_binfo WHERE ftype IS INITIAL.
            IF lo_text->at_addt_binfo[] IS NOT INITIAL.
              ls_head-ftype = lo_text->at_addt_binfo[ 1 ]-ftype.
              CALL METHOD me->split_field
                EXPORTING
                  iv_str   = lo_text->at_addt_binfo[ 1 ]-reffd
                IMPORTING
                  ev_fname = ls_head-reffd.
            ENDIF.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_text->bp00452_text
              IMPORTING
                ev_fname = ls_head-field.

          WHEN 'UO00324'.
            lo_link ?= lo_element.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_link->bp00324_text
              IMPORTING
                ev_fname = ls_head-field.

          WHEN 'UO00314'.
            lo_input ?= lo_element.

            DELETE lo_input->at_addt_binfo WHERE ftype IS INITIAL.
            IF lo_input->at_addt_binfo[] IS NOT INITIAL.
              ls_head-ftype = lo_input->at_addt_binfo[ 1 ]-ftype.
              CALL METHOD me->split_field
                EXPORTING
                  iv_str   = lo_input->at_addt_binfo[ 1 ]-reffd
                IMPORTING
                  ev_fname = ls_head-reffd.
            ENDIF.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_input->bp00315_value
              IMPORTING
                ev_fname = ls_head-field.

          WHEN 'UO00368'.
            lo_objectstatus ?= lo_element.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_objectstatus->bp00368_text
              IMPORTING
                ev_fname = ls_head-field.

          WHEN 'UO00253'.
            lo_checkbox  ?= lo_element.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_checkbox->bp00253_selected
              IMPORTING
                ev_fname = ls_head-field.

          WHEN 'UO00261'.
            lo_datepicker  ?= lo_element.

            CALL METHOD me->split_field
              EXPORTING
                iv_str   = lo_datepicker->bp00315_value
              IMPORTING
                ev_fname = ls_head-field.

        ENDCASE.
      ENDLOOP.

      ls_head-width = 20."Default
      CALL METHOD me->add_head
        EXPORTING
          iv_htext = ls_head-htext
          iv_field = ls_head-field
          iv_ftype = ls_head-ftype
          iv_reffd = ls_head-reffd
          iv_colfd = ls_head-colfd
          iv_color = ls_head-color
          iv_width = ls_head-width.

    ENDLOOP.

  ENDMETHOD.


  method CREATE_STYLE.
    IF iv_table_id IS INITIAL AND iv_tab_name IS INITIAL.
      RETURN.
    ENDIF.
*
    DATA lt_0015  TYPE /u4a/y9999.
    DATA ls_0015  LIKE LINE OF lt_0015.
    DATA lv_guinr TYPE /u4a/e_guinr.
    DATA lo_table TYPE REF TO /u4a/cl_uo01139.

    IF iv_tab_name IS INITIAL.
      SELECT SINGLE guinr
        FROM /u4a/t0011
        INTO @lv_guinr
       WHERE appid EQ @io_view->appid.
      IMPORT tab = lt_0015 FROM DATABASE /u4a/t0015(oa) ID lv_guinr.
      me->mv_tab_name = lt_0015[ f03 = iv_table_id f08 = 'UO01139' f10 = 'ROWS' ]-f05.
    ELSE.
      me->mv_tab_name = iv_tab_name.
    ENDIF.
*
    DATA lo_object TYPE REF TO object.
    lo_object ?= io_view->control.
*
    DATA strty TYPE REF TO cl_abap_structdescr.
    DATA tabty TYPE REF TO cl_abap_tabledescr.
    FIELD-SYMBOLS <table> TYPE ANY TABLE.

    ASSIGN lo_object->(me->mv_tab_name) TO <table>.
    CHECK <table> IS ASSIGNED AND <table>[] IS NOT INITIAL.
    tabty ?= cl_abap_typedescr=>describe_by_data( <table> ).
    strty ?= tabty->get_table_line_type( ).
*
    DATA lo_style  TYPE REF TO /u4a/cl_xl_style.
    DATA lv_color  TYPE /u4a/e_style_color_argb.
    DATA lv_key    TYPE char30.
    DATA lv_format TYPE /u4a/e_number_format.

    LOOP AT <table> ASSIGNING FIELD-SYMBOL(<line>).

      LOOP AT me->mt_head ASSIGNING FIELD-SYMBOL(<head>).

        ASSIGN COMPONENT <head>-field OF STRUCTURE <line> TO FIELD-SYMBOL(<field>).
        CHECK <field> IS ASSIGNED.

        CLEAR lv_color.
        IF <head>-color IS NOT INITIAL.
          lv_color = me->conv_rgb_to_argb( <head>-color ).
        ELSEIF <head>-colfd IS NOT INITIAL.
          ASSIGN COMPONENT <head>-colfd OF STRUCTURE <line> TO FIELD-SYMBOL(<colfd>).
          lv_color = me->conv_rgb_to_argb( <colfd> ).
        ENDIF.

        CLEAR lv_format.
        READ TABLE strty->components INTO DATA(ls_components) WITH KEY name = <head>-field.
        <head>-fkind = ls_components-type_kind.
        CASE <head>-fkind.
          WHEN 'N' OR 'I'.
            <head>-align = /u4a/cl_xl_style_alignment=>c_horizontal_right.
          WHEN 'P'.
            IF <head>-reffd IS NOT INITIAL AND <head>-ftype IS NOT INITIAL.
              lv_format = '#,###'.
              <head>-ischg = abap_true.
            ELSE.
              lv_format = '0,000.'.
              DO ls_components-decimals TIMES.
                CONCATENATE lv_format '0' INTO lv_format.
              ENDDO.
            ENDIF.
            <head>-align = /u4a/cl_xl_style_alignment=>c_horizontal_right.
          WHEN 'D'.
            lv_format = 'yyyy.mm.dd'.
          WHEN 'T'.
            lv_format = 'hh:mm:ss'.
          WHEN OTHERS.
            <head>-align = /u4a/cl_xl_style_alignment=>c_horizontal_left.
        ENDCASE.
*
        CLEAR lv_key.
        lv_key = |{ <head>-ischg }{ <head>-align }{ <head>-fkind }{ lv_color }|.

        CLEAR lo_style.
        lo_style ?= me->mo_styles->get( lv_key ).
        IF lo_style IS NOT BOUND.
          CALL METHOD me->add_style
            EXPORTING
              key         = lv_key
              back_color  = lv_color
              format_code = lv_format
              horizontal  = <head>-align.
        ENDIF.
      ENDLOOP.
    ENDLOOP.


  endmethod.


  METHOD download.

    DATA lo_object TYPE REF TO object.
    lo_object ?= io_view->control.
*
    DATA strty TYPE REF TO cl_abap_structdescr.
    DATA tabty TYPE REF TO cl_abap_tabledescr.
    FIELD-SYMBOLS <table> TYPE ANY TABLE.

    ASSIGN lo_object->(me->mv_tab_name) TO <table>.
    CHECK <table> IS ASSIGNED AND <table>[] IS NOT INITIAL.
    tabty ?= cl_abap_typedescr=>describe_by_data( <table> ).
    strty ?= tabty->get_table_line_type( ).
*
    DATA lo_worksheet     TYPE REF TO /u4a/cl_xl_worksheet.
    DATA column_dimension TYPE REF TO /u4a/cl_xl_worksheet_coldime.

    TRY.
        CALL METHOD me->mo_excel->set_active_sheet_index( 1 ).
        CALL METHOD me->mo_excel->get_active_worksheet
          RECEIVING
            eo_worksheet = lo_worksheet.
      CATCH /u4a/cx_xl.
    ENDTRY.
*
    DATA lv_row   TYPE i.
    DATA lv_col   TYPE i.
    DATA lo_style TYPE REF TO /u4a/cl_xl_style.
    DATA lv_style TYPE /u4a/e_cell_style.

    TRY.
        lv_row += 1.
        LOOP AT me->mt_head ASSIGNING FIELD-SYMBOL(<head>).
          lv_col += 1.

          lo_style ?= me->mo_styles->get( me->mc_head ).

          CALL METHOD lo_worksheet->set_cell
            EXPORTING
              ip_column = /u4a/cl_xl_common=>convert_column2alpha( lv_col )
              ip_row    = lv_row
              ip_value  = <head>-htext
              ip_style  = lo_style->get_guid( ).

          TRY.
              column_dimension = lo_worksheet->get_column_dimension( ip_column = /u4a/cl_xl_common=>convert_column2alpha( lv_col ) ).
              column_dimension->set_width( ip_width = <head>-width ).
            CATCH /u4a/cx_xl. " Exceptions for ABAP2XLSX

          ENDTRY.

        ENDLOOP.
      CATCH /u4a/cx_xl.
    ENDTRY.
*
    DATA lv_color TYPE /u4a/e_style_color_argb.
    DATA lv_value_c TYPE char50.
    DATA lv_value_s TYPE string.
*    DATA lv_value_i TYPE i." 큰 금액 conversion 오류발생..
    DATA lv_value_i TYPE dec_25.
    FIELD-SYMBOLS <value> TYPE any.

    TRY.
        LOOP AT <table> ASSIGNING FIELD-SYMBOL(<line>).
          lv_row += 1.

          CLEAR lv_col.
          LOOP AT me->mt_head ASSIGNING <head>.
            lv_col += 1.

            ASSIGN COMPONENT <head>-field OF STRUCTURE <line> TO FIELD-SYMBOL(<field>).
            CHECK <field> IS ASSIGNED.

            CLEAR lv_color.
            IF <head>-color IS NOT INITIAL.
              lv_color = me->conv_rgb_to_argb( <head>-color ).
            ELSEIF <head>-colfd IS NOT INITIAL.
              ASSIGN COMPONENT <head>-colfd OF STRUCTURE <line> TO FIELD-SYMBOL(<colfd>).
              lv_color = me->conv_rgb_to_argb( <colfd> ).
            ENDIF.

            CLEAR: lo_style, lv_style.
            lo_style ?= me->mo_styles->get( |{ <head>-ischg }{ <head>-align }{ <head>-fkind }{ lv_color }| ).
            IF lo_style IS BOUND.
              lv_style = lo_style->get_guid( ).
            ENDIF.

            CLEAR lv_value_c.
            IF <head>-reffd IS NOT INITIAL.
              ASSIGN COMPONENT <head>-reffd OF STRUCTURE <line> TO FIELD-SYMBOL(<reffd>).
              CASE <head>-ftype.
                WHEN '1'.
                  WRITE <field> TO lv_value_c CURRENCY <reffd> NO-GAP.
                WHEN '2'.
                  WRITE <field> TO lv_value_c UNIT <reffd> NO-GAP.
              ENDCASE.
              REPLACE ALL OCCURRENCES OF ',' IN lv_value_c WITH ''.
              CONDENSE lv_value_c NO-GAPS.
              IF iv_no_format IS NOT INITIAL.
                ASSIGN lv_value_c TO <value>.
              ELSE.
                CLEAR lv_value_i.
                lv_value_i = lv_value_c.
                ASSIGN lv_value_i TO <value>.
              ENDIF.
              CALL METHOD lo_worksheet->set_cell
                EXPORTING
                  ip_column = /u4a/cl_xl_common=>convert_column2alpha( lv_col )
                  ip_row    = lv_row
                  ip_value  = <value>
                  ip_style  = lv_style.
            ELSE.
              IF iv_no_format IS NOT INITIAL.
                lv_value_s = <field>.
                ASSIGN lv_value_s TO <value>.
              ELSE.
                ASSIGN <field> TO <value>.
              ENDIF.

              CALL METHOD lo_worksheet->set_cell
                EXPORTING
                  ip_column = /u4a/cl_xl_common=>convert_column2alpha( lv_col )
                  ip_row    = lv_row
                  ip_value  = <value>
                  ip_style  = lv_style.
            ENDIF.
          ENDLOOP.
        ENDLOOP.
      CATCH /u4a/cx_xl.
    ENDTRY.
*
    DATA lo_writer TYPE REF TO /u4a/if_xl_writer.
    DATA lv_file_name TYPE string.

    CREATE OBJECT lo_writer TYPE /u4a/cl_xl_writer_2007.

    IF iv_file_name IS NOT INITIAL.
      lv_file_name = |{ iv_file_name }.xlsx|.
    ELSE.
      lv_file_name = |EXPORT_{ sy-datum }{ sy-uzeit }.xlsx|.
    ENDIF.

    IF iv_password IS INITIAL.
      CALL METHOD /u4a/cl_utilities=>file_down
        EXPORTING
          io_view    = io_view
          i_filename = lv_file_name
          contents   = lo_writer->write_file( me->mo_excel ).

    ELSE.
      "파일 암호화 다운로드.
      CALL METHOD /u4a/cl_xlsx_utilities=>set_workbook_protect_pass
        EXPORTING
          io_view     = io_view                                    " [U4A] UI Element Super Class
          i_filename  = lv_file_name                                   " File name
          i_contents  = lo_writer->write_file( me->mo_excel )
          i_encryp_pw = iv_password.
                 "
    ENDIF.

  ENDMETHOD.


  METHOD download_s.

    CALL METHOD me->create_head
      EXPORTING
        io_view     = io_view
        iv_table_id = iv_table_id.

    CALL METHOD me->create_style
      EXPORTING
        io_view     = io_view
        iv_table_id = iv_table_id.

    CALL METHOD me->download
      EXPORTING
        io_view      = io_view
        iv_file_name = iv_file_name
        iv_no_format = iv_no_format
        iv_password  = iv_password.


  ENDMETHOD.


  METHOD split_field.
    SPLIT iv_str AT `,` INTO TABLE DATA(lt_split1).
    SPLIT lt_split1[ 1 ] AT `-` INTO TABLE DATA(lt_split2).
    ev_tname = lt_split2[ 1 ].
    ev_fname = lt_split2[ 2 ].

  ENDMETHOD.
ENDCLASS.
