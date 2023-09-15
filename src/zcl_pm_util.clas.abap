class ZCL_PM_UTIL definition
  public
  final
  create public .

public section.

  class-methods CONV_ALPHA_IN
    changing
      !VALUE type ANY .
  class-methods CONV_ALPHA_OUT
    changing
      !VALUE type ANY .
  class-methods CONV_AMT
    importing
      value(IV_AMT) type ANY
    changing
      !CV_TXT type ANY .
  class-methods CONV_DATE
    importing
      value(IV_DATE) type ANY
    changing
      !CV_TXT type ANY .
  class-methods DELETE_FILE
    importing
      !IV_KEY type ANY .
  class-methods DOWN_WEB_FILE
    importing
      !IV_OBJID type W3OBJID .
  class-methods GET_ANLNR_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_AS_MNG_NO_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_AS_OPER_NO_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_AUFNR_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_COMM_TXT
    importing
      !GRP_CD type ZCKT0130-GRP_CD
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_DOMAIN_TXT
    importing
      !DOMNAME type DD07T-DOMNAME
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_EQUNR_TXT
    importing
      !IV_EQUNR type ZPMT2010-EQUNR
    changing
      !CV_TXT type ANY .
  class-methods GET_FILE_INFO
    importing
      !IV_KEY type ANY
      !IV_LINK_ONLY type FLAG optional
    exporting
      !ET_FILES type /U4A/Y0006
      !EV_URL type STRING
      !ET_URL type ZMMTT9996 .
  class-methods GET_FILE_URL_XSTR
    importing
      !IT_FILES type /U4A/Y0006
    exporting
      !EV_URL type STRING .
  class-methods GET_FINCODE_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_FMFCTR_TXT
    importing
      !IV_FICTR type FMFCTRT-FICTR
    changing
      !CV_TXT type ANY .
  class-methods GET_GDCLS_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_GDNUM_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_KOSTL_TXT
    importing
      !IV_KOSTL type CSKS-KOSTL
    changing
      !CV_TXT type ANY .
  class-methods GET_LIFNR_TEXT
    importing
      value(IV_LIFNR) type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_PARNR_TEXT
    importing
      value(IV_PARNR) type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_PART_INFO
    importing
      !IV_OBJNR type J_OBJNR optional
      !IV_LIFNR type LIFNR optional
    changing
      value(ET_DATA) type ZPMS2012T .
  class-methods GET_PERNR_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_FIPEX_TXT
    importing
      value(IV_KEY) type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_RCOMP_TXT
    importing
      value(IV_KEY) type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_BANKA_TXT
    importing
      !IV_BANKS type BANKS
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_SAKTO_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_INVNR_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_TPLNR_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods MOVE_FILE_INFO
    importing
      !IT_FILES type /U4A/Y0006 optional
      !IS_DATA type ANY optional
    exporting
      !ET_FILES type /U4A/Y0006
    changing
      !CS_DATA type ANY optional .
  class-methods OPEN_DIALOG
    returning
      value(RV_FILENAME) type STRING .
  class-methods RANGES_COND_DATE
    importing
      value(IV_LOW) type DATUM optional
      value(IV_HIGH) type DATUM optional
    exporting
      !ER_BEGDA type RANGE_DATE_T
      !ER_ENDDA type RANGE_DATE_T .
  class-methods RANGES_CONVERT
    importing
      !LOW type ANY
      !HIGH type ANY optional
    changing
      value(ET_DATA) type STANDARD TABLE .
  class-methods SET_LOG
    importing
      !IV_MODE type FLAG optional
    changing
      !IS_LINE type DATA .
  class-methods CALC_AMT_TAX
    importing
      !I_TOTAL type ZMMT1430-USE_AMT
      !I_MWSKZ type MWSKZ
    changing
      !C_AMT type ANY
      !C_TAX type ANY .
  class-methods CONV_AMT_HANGUL
    importing
      !IV_AMT type ANY
    changing
      value(CV_TXT) type ANY .
  class-methods GET_CURRENT_YEAR
    importing
      !BUKRS type BKPF-BUKRS
      !DATE like SY-DATUM
    returning
      value(RV_CURRY) type BKPF-GJAHR .
  class-methods GET_MNGT_BREU_TXT
    importing
      value(IV_KEY) type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_USER_NAME
    importing
      !IV_KEY type ANY
    changing
      value(CV_TXT) type ANY .
  class-methods GET_LANDX_TXT
    importing
      !IV_KEY type ANY
    changing
      !CV_TXT type ANY .
  class-methods GET_GW_STATUS
    importing
      !IV_FLAG type FLAG
    exporting
      !ET_RET type TIHTTPNVP
      !ET_RET_R type RANGE_DOMA .
  class-methods NUMERIC_CHECK
    importing
      !STRING_IN type ANY
    returning
      value(RV_IS_NUMC) type FLAG .
  class-methods CHECK_DATE_VALID
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_ID type ANY .
  class-methods XL_TO_ITAB
    importing
      !IV_ROW_F type INT4
      !IT_ROW_DEL type INT4_TABLE optional
      !IV_FILENAME type ANY
    exporting
      !ET_ITAB type ANY TABLE
      !RV_MSG type BAPIRET2-MESSAGE .
  class-methods GET_SEGMENT_2000
    importing
      !I_FISTL type FISTL
      !I_BUKRS type BUKRS
    exporting
      !E_SEGMENT type FB_SEGMENT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PM_UTIL IMPLEMENTATION.


  METHOD calc_amt_tax.

    DATA lv_value TYPE string.
    DATA lv_amt TYPE p LENGTH 16 DECIMALS 5.
    DATA lv_tax TYPE string.
    DATA lv_total TYPE string.

    CLEAR: c_amt, c_tax.

    CHECK i_total IS NOT INITIAL.
    lv_total = i_total.

    CASE i_mwskz.
      WHEN 'W1' OR 'V1'.

        lv_amt = i_total / '1.1'.

        lv_value = lv_amt.

        PERFORM numerical_value_round IN PROGRAM zpms0 USING '' '0.01' lv_value.

        lv_tax = lv_total - lv_value.

      WHEN OTHERS.

        lv_value = lv_total.

    ENDCASE.

    c_amt = lv_value.
    c_tax = lv_tax.



  ENDMETHOD.


  METHOD check_date_valid.

    DATA lt_script TYPE string_table.

    APPEND |check_date_valid("{ i_id }");| TO lt_script.

    CALL METHOD /u4a/cl_utilities=>set_freestyle_script
      EXPORTING
        io_view   = ar_view
        it_script = lt_script.



  ENDMETHOD.


  METHOD conv_alpha_in.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = value
      IMPORTING
        output = value.



  ENDMETHOD.


  METHOD conv_alpha_out.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
      EXPORTING
        input  = value
      IMPORTING
        output = value.

  ENDMETHOD.


  METHOD conv_amt.
    DATA lv_amtt TYPE char20.

    CHECK iv_amt IS NOT INITIAL.
    WRITE iv_amt TO lv_amtt CURRENCY 'KRW'.
    CONDENSE lv_amtt NO-GAPS.
    cv_txt = lv_amtt.


  ENDMETHOD.


  METHOD conv_amt_hangul.

    DATA lv_amt TYPE wrbtr.
    DATA lv_txt TYPE char200.

    lv_amt = iv_amt.

    CALL FUNCTION 'ZPM_AMT_TO_TEXT'
      EXPORTING
        i_amt      = lv_amt
      IMPORTING
        e_amt_text = lv_txt.

    cv_txt = lv_txt.



  ENDMETHOD.


  METHOD conv_date.

    DATA lv_datet TYPE char10.

    CHECK iv_date IS NOT INITIAL.

    WRITE iv_date TO lv_datet USING EDIT MASK '____.__.__'.

    cv_txt = lv_datet.


  ENDMETHOD.


  METHOD delete_file.

    DATA ls_cond TYPE zmms9997.

    CHECK iv_key IS NOT INITIAL.
    ls_cond-ref_docid = iv_key.

    zcl_mm_utill=>delete_archive_link_files( EXPORTING is_cond = ls_cond ).


  ENDMETHOD.


  METHOD down_web_file.


    DATA: lt_mime      TYPE TABLE OF w3mime,
          ls_wwwdata   TYPE wwwdatatab,
          lv_action    TYPE i,
          lv_file_name TYPE string.

    SELECT SINGLE * FROM wwwdata
      INTO CORRESPONDING FIELDS OF @ls_wwwdata
      WHERE objid = @iv_objid.
    CHECK sy-subrc = 0.

    CALL FUNCTION 'WWWDATA_IMPORT'
      EXPORTING
        key               = ls_wwwdata
      TABLES
        mime              = lt_mime
      EXCEPTIONS
        wrong_object_type = 1
        import_error      = 2
        OTHERS            = 3.

    DATA : lv_filename     TYPE string,
           lv_path         TYPE string,
           lv_fullpath     TYPE string,
           lv_filesize(10),
           lv_size         TYPE i.

    CALL FUNCTION 'WWWPARAMS_READ'
      EXPORTING
        relid = ls_wwwdata-relid
        objid = ls_wwwdata-objid
        name  = 'filesize'
      IMPORTING
        value = lv_filesize.

*    lv_file_name = ls_wwwdata-text.
    lv_filename = |{ ls_wwwdata-text }| & |_Template_| & |{ sy-datum }| & |.xlsx|.

    CALL METHOD cl_gui_frontend_services=>file_save_dialog
      EXPORTING
        default_file_name = lv_filename
        file_filter       = cl_gui_frontend_services=>filetype_excel
      CHANGING
        filename          = lv_filename
        path              = lv_path
        fullpath          = lv_fullpath
        user_action       = lv_action.

    CHECK lv_action IS INITIAL.

    lv_size = lv_filesize.

    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        filename     = lv_fullpath
        filetype     = 'BIN'
        bin_filesize = lv_size
      TABLES
        data_tab     = lt_mime.

  ENDMETHOD.


  METHOD get_anlnr_txt.

    CLEAR cv_txt.
    SELECT SINGLE anlhtxt FROM anlh
      INTO cv_txt
      WHERE anln1 = iv_key.

  ENDMETHOD.


  METHOD get_as_mng_no_txt.

    CLEAR cv_txt.
    SELECT SINGLE pubofc_nm FROM zfit0040
      INTO cv_txt
      WHERE pubofc_no = iv_key
        AND pubofc_fg = zcl_mm_comm_cons=>gc_as_mng_no
        AND use_yn = 'Y'.

  ENDMETHOD.


  METHOD get_as_oper_no_txt.

    CLEAR cv_txt.
    SELECT SINGLE pubofc_nm FROM zfit0040
      INTO cv_txt
      WHERE pubofc_no = iv_key
        AND pubofc_fg = zcl_mm_comm_cons=>gc_as_oper_no
        AND use_yn = 'Y'.

  ENDMETHOD.


  METHOD get_aufnr_txt.

    CLEAR cv_txt.
    SELECT SINGLE ktext FROM aufk
      INTO cv_txt
      WHERE aufnr = iv_key.

  ENDMETHOD.


  METHOD get_banka_txt.

    CLEAR cv_txt.
    SELECT SINGLE banka FROM bnka
      INTO cv_txt
      WHERE banks = iv_banks
        AND bankl = iv_key.

  ENDMETHOD.


  METHOD get_comm_txt.

    CLEAR cv_txt.
    SELECT SINGLE kor_nm FROM zckt0130
      INTO cv_txt
      WHERE grp_cd = grp_cd
        AND cmmn_cd = iv_key
        AND use_yn = 'Y'.


  ENDMETHOD.


  METHOD get_current_year.

**--- 회계연도
    CLEAR rv_curry.
    CALL FUNCTION 'GET_CURRENT_YEAR'
      EXPORTING
        bukrs = bukrs
        date  = date
      IMPORTING
        curry = rv_curry.

  ENDMETHOD.


  METHOD get_domain_txt.

    CLEAR cv_txt.
    SELECT SINGLE ddtext FROM dd07t
    INTO cv_txt
    WHERE domname = domname
      AND ddlanguage = sy-langu
      AND domvalue_l = iv_key.

  ENDMETHOD.


  METHOD get_equnr_txt.

    CLEAR cv_txt.
    SELECT SINGLE wrkart_ttl_kor FROM zpmt2010
      INTO cv_txt
      WHERE equnr = iv_equnr.


  ENDMETHOD.


  METHOD get_file_info.

    DATA ls_cond TYPE zmms9997.
    DATA lt_url TYPE TABLE OF zmms9996.
    DATA ls_file LIKE LINE OF et_files.

    CLEAR et_files.

    ls_cond-ref_docid = iv_key.

    IF iv_link_only = ''.
      zcl_mm_utill=>get_archive_link_data( EXPORTING is_cond = ls_cond
                                           IMPORTING et_data = DATA(lt_data) ).

      IF lt_data IS NOT INITIAL.
        LOOP AT lt_data INTO DATA(ls_data).
          ls_file-fname = ls_data-filename.
          ls_file-content = ls_data-content.
          ls_file-mime = ls_data-mime.
          ls_file-fsize = ls_data-filesize.
          ls_file-exten = ls_data-extension.
          ls_file-path = 'X'.
          APPEND ls_file TO et_files.
          CLEAR ls_file.
        ENDLOOP.
      ENDIF.
    ENDIF.

    zcl_mm_utill=>get_archive_link_url( EXPORTING is_cond = ls_cond
                                        IMPORTING et_data = lt_url ).
    IF lt_url IS NOT INITIAL.
      et_url = lt_url.
      ev_url = lt_url[ 1 ]-url.
    ENDIF.




  ENDMETHOD.


  METHOD get_file_url_xstr.

    CLEAR ev_url.
    IF it_files IS NOT INITIAL.
      CALL FUNCTION 'ZFM_SET_XSTR_URL'
        EXPORTING
          iv_xstring      = it_files[ 1 ]-content
          iv_content_type = it_files[ 1 ]-mime
        IMPORTING
          ev_url          = ev_url.
    ENDIF.

  ENDMETHOD.


  METHOD get_fincode_txt.

    CLEAR cv_txt.
    SELECT SINGLE bezeich FROM fmfint
      INTO cv_txt
      WHERE spras = sy-langu
        AND fincode = iv_key.

  ENDMETHOD.


  METHOD GET_FIPEX_TXT.

    CLEAR cv_txt.

    SELECT SINGLE bezei FROM fmcit
      INTO cv_txt
      WHERE fipex = iv_key
        AND spras = sy-langu.



  ENDMETHOD.


  METHOD GET_FMFCTR_TXT.

    CLEAR CV_TXT.
    SELECT SINGLE BESCHR
      FROM FMFCTRT
      INTO CV_TXT
     WHERE SPRAS = SY-LANGU
       AND FICTR = IV_FICTR
       AND DATBIS >= SY-DATUM
       AND DATAB < '99991231'.

  ENDMETHOD.


  METHOD get_gdcls_txt.

    CLEAR cv_txt.
    SELECT SINGLE gdtxt FROM zmmt0010
      INTO cv_txt
      WHERE gdcls = iv_key
        AND nouse = ''.

  ENDMETHOD.


  METHOD get_gdnum_txt.

    CLEAR cv_txt.
    SELECT SINGLE gdnum_desc FROM zmmt0020
      INTO cv_txt
      WHERE gdnum = iv_key
        AND nouse = ''.

  ENDMETHOD.


  METHOD get_gw_status.

    DATA lr_flag TYPE RANGE OF zckt0071-zckf2_ch.

    CASE iv_flag.
      WHEN '1'.
        zcl_pm_util=>ranges_convert( EXPORTING low     = 'A'
                                     CHANGING  et_data = lr_flag ).
        zcl_pm_util=>ranges_convert( EXPORTING low     = 'B'
                                     CHANGING  et_data = lr_flag ).
      WHEN '2'.
      WHEN OTHERS.
    ENDCASE.

    CLEAR et_ret.

    SELECT zck_code1, zckf1_ch FROM zckt0071
      INTO TABLE @et_ret
      WHERE zckf2_ch IN @lr_flag.
    SORT et_ret BY name.

    LOOP AT et_ret INTO DATA(ls_ret).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_ret-name ) TO et_ret_r.
    ENDLOOP.


  ENDMETHOD.


  METHOD get_invnr_txt.

    CLEAR cv_txt.
    SELECT SINGLE eqktx FROM v_equi
      INTO cv_txt
      WHERE invnr = iv_key.


  ENDMETHOD.


  METHOD get_kostl_txt.

    CLEAR cv_txt.
    SELECT SINGLE ktext FROM cskt
      INTO cv_txt
      WHERE spras = sy-langu
        AND kostl = iv_kostl
        AND datbi >= sy-datum.

  ENDMETHOD.


  METHOD GET_LANDX_TXT.

    SELECT SINGLE LANDX
      INTO CV_TXT
      FROM T005T
     WHERE LAND1 EQ IV_KEY
       AND SPRAS = SY-LANGU.

  ENDMETHOD.


  METHOD get_lifnr_text.

    DATA lv_lifnr TYPE lfa1-lifnr.

    zcl_pm_util=>conv_alpha_out( CHANGING value = iv_lifnr ).
    lv_lifnr = iv_lifnr.
    zcl_pm_util=>conv_alpha_in( CHANGING value = lv_lifnr ).

    CLEAR cv_txt.

    SELECT SINGLE name1 FROM lfa1
      INTO cv_txt
      WHERE lifnr = lv_lifnr.



  ENDMETHOD.


  METHOD GET_MNGT_BREU_TXT.

    SELECT SINGLE STEXT
     INTO CV_TXT
     FROM HRP1000
    WHERE OBJID EQ IV_KEY
      AND PLVAR EQ '01'
      AND OTYPE EQ 'O'
      AND ISTAT EQ '1'
      AND ENDDA <= '99991231'.

  ENDMETHOD.


  METHOD get_parnr_text.


    DATA lv_parnr TYPE but000-partner.
    DATA lv_objid TYPE hrp1000-objid.

    CLEAR cv_txt.

    lv_objid = iv_parnr.
    SELECT SINGLE stext FROM hrp1000
      INTO cv_txt
      WHERE plvar = '01'
        AND otype = 'O'
        AND objid = lv_objid
        AND begda <= sy-datum
        AND endda >= sy-datum
        AND langu = sy-langu.
    CHECK cv_txt IS INITIAL.

    zcl_pm_util=>conv_alpha_out( CHANGING value = iv_parnr ).
    lv_parnr = iv_parnr.
    zcl_pm_util=>conv_alpha_in( CHANGING value = lv_parnr ).

    SELECT SINGLE * FROM but000
      INTO @DATA(ls_but000)
      WHERE partner = @lv_parnr.
*    CASE ls_but000-type.
*      WHEN '1'.
*        cv_txt = ls_but000-name_last.
*      WHEN '2'.
        cv_txt = ls_but000-name_org1.
*    ENDCASE.


  ENDMETHOD.


  METHOD get_part_info.

    DATA lt_part TYPE TABLE OF zpms2012.

    IF iv_objnr IS NOT INITIAL.
      SELECT * FROM ihpa AS a
        INNER JOIN but000 AS b
        ON right( a~parnr, 10 ) = b~partner
*        ON LTRIM( a~parnr, 0 ) = b~partner
        LEFT JOIN but020 AS c
        ON b~partner = c~partner
        WHERE a~objnr = @iv_objnr
          AND a~kzloesch = ''
        INTO CORRESPONDING FIELDS OF TABLE @lt_part.
    ENDIF.

    IF iv_lifnr IS NOT INITIAL.
      SELECT * FROM but000 AS b
        INNER JOIN but020 AS c
        ON b~partner = c~partner
        INTO CORRESPONDING FIELDS OF TABLE @lt_part
        WHERE b~partner = @iv_lifnr.
    ENDIF.

    IF lt_part[] IS NOT INITIAL.
      SELECT * FROM adr2
        INTO TABLE @DATA(lt_adr2)
        FOR ALL ENTRIES IN @lt_part
        WHERE addrnumber = @lt_part-addrnumber
          AND home_flag = 'X'.
      SORT lt_adr2 BY addrnumber.

      SELECT * FROM adr6
        INTO TABLE @DATA(lt_adr6)
        FOR ALL ENTRIES IN @lt_part
        WHERE addrnumber = @lt_part-addrnumber.
      SORT lt_adr6 BY addrnumber.

      SELECT * FROM adrc
        INTO TABLE @DATA(lt_adrc)
        FOR ALL ENTRIES IN @lt_part
        WHERE addrnumber = @lt_part-addrnumber.
      SORT lt_adrc BY addrnumber.

      SELECT * FROM adrct
        INTO TABLE @DATA(lt_adrct)
        FOR ALL ENTRIES IN @lt_part
        WHERE addrnumber = @lt_part-addrnumber
          AND langu = @sy-langu.
      SORT lt_adrct BY addrnumber.

      SELECT * FROM zmmt1601
        INTO TABLE @DATA(lt_1601)
        WHERE partner = @iv_lifnr.
      SORT lt_1601 BY partner.

    ENDIF.

    LOOP AT lt_part ASSIGNING FIELD-SYMBOL(<fs>).

      <fs>-name_last = <fs>-name_org1.

*      READ TABLE lt_adr2 INTO DATA(ls_adr2) WITH KEY addrnumber = <fs>-addrnumber BINARY SEARCH.
*      IF sy-subrc = 0.
*        <fs>-tel_number = ls_adr2-tel_number.
*      ENDIF.

      READ TABLE lt_adr6 INTO DATA(ls_adr6) WITH KEY addrnumber = <fs>-addrnumber BINARY SEARCH.
      IF sy-subrc = 0.
        <fs>-smtp_addr = ls_adr6-smtp_addr.
      ENDIF.

      READ TABLE lt_adrc INTO DATA(ls_adrc) WITH KEY addrnumber = <fs>-addrnumber BINARY SEARCH.
      IF sy-subrc = 0.
        <fs>-street = ls_adrc-street.
      ENDIF.

      READ TABLE lt_1601 INTO DATA(ls_1601) WITH KEY partner = <fs>-partner.
      IF sy-subrc = 0.
        <fs>-birthdt = ls_1601-birth_dt.
        <fs>-deathdt = ls_1601-death_dt.
        <fs>-bu_sort1 = ls_1601-nati_fg.
        <fs>-bu_sort2 = ls_1601-chulsin_sch_nm.
        <fs>-tel_number = ls_1601-cell_no.
      ENDIF.


*      READ TABLE lt_adrct INTO DATA(ls_adrct) WITH KEY addrnumber = <fs>-addrnumber BINARY SEARCH.
*      IF sy-subrc = 0.
*        <fs>-remark = ls_adrct-remark.
*      ENDIF.
*      SPLIT <fs>-remark AT '/' INTO <fs>-rem1 <fs>-rem2.


    ENDLOOP.

    et_data = lt_part.


  ENDMETHOD.


  METHOD get_pernr_txt.
    DATA lv_pernr TYPE pa0001-pernr.

    lv_pernr = iv_key.

    CLEAR cv_txt.
    SELECT SINGLE ename FROM pa0001
      INTO cv_txt
      WHERE pernr = lv_pernr
        AND begda <= sy-datum
        AND endda >= sy-datum.

  ENDMETHOD.


  METHOD GET_RCOMP_TXT.

    DATA lv_rcomp TYPE t880-rcomp.

    zcl_pm_util=>conv_alpha_out( CHANGING value = iv_key ).
    lv_rcomp = iv_key.
    zcl_pm_util=>conv_alpha_in( CHANGING value = lv_rcomp ).

    CLEAR cv_txt.

    SELECT SINGLE name1 FROM t880
      INTO cv_txt
      WHERE rcomp = lv_rcomp.



  ENDMETHOD.


  METHOD get_sakto_txt.

    CLEAR cv_txt.
    SELECT SINGLE txt20 FROM skat
      INTO cv_txt
      WHERE saknr = iv_key
        AND spras = sy-langu
        AND ktopl IN ('1000','2000').


  ENDMETHOD.


  method GET_SEGMENT_2000.
    IF i_fistl IS NOT INITIAL AND i_bukrs IS NOT INITIAL.
    SELECT SINGLE segment INTO @e_segment
      FROM zfit0310
      WHERE bukrs = @i_bukrs
      AND   fistl = @i_fistl.

    ENDIF.
  endmethod.


  METHOD get_tplnr_txt.

    CLEAR cv_txt.
    SELECT SINGLE pltxt FROM iflotx
      INTO cv_txt
      WHERE tplnr = iv_key
        AND spras = sy-langu.

  ENDMETHOD.


  METHOD get_user_name.

    CLEAR cv_txt.
    SELECT SINGLE b~name_text FROM usr21 AS a
      INNER JOIN adrp AS b
      ON a~persnumber = b~persnumber
      INTO cv_txt
      WHERE a~bname = iv_key.


  ENDMETHOD.


  METHOD move_file_info.

    FIELD-SYMBOLS <fs> TYPE any.
    DATA ls_file TYPE /u4a/s0006.

    CLEAR ls_file.

    IF it_files IS NOT INITIAL.
      READ TABLE it_files INTO ls_file INDEX 1.
      CHECK sy-subrc = 0.

      ASSIGN COMPONENT 'FNAME' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-fname.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'FSIZE' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-fsize.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'MIME' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-mime.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'EXTEN' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-exten.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'PATH' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-path.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'CONTENT' OF STRUCTURE cs_data TO <fs>.
      IF sy-subrc EQ 0.
        <fs> = ls_file-content.   UNASSIGN <fs>.
      ENDIF.
    ENDIF.

    IF is_data IS NOT INITIAL.
      ASSIGN COMPONENT 'FNAME' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-fname = <fs>.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'FSIZE' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-fsize = <fs>.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'MIME' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-mime = <fs>.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'EXTEN' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-exten = <fs>.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'PATH' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-path = <fs>.   UNASSIGN <fs>.
      ENDIF.
      ASSIGN COMPONENT 'CONTENT' OF STRUCTURE is_data TO <fs>.
      IF sy-subrc EQ 0.
        ls_file-content = <fs>.   UNASSIGN <fs>.
      ENDIF.
      IF ls_file IS NOT INITIAL.
        APPEND ls_file TO et_files.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD numeric_check.

    DATA lv_htype TYPE dd01v-datatype.

    CALL FUNCTION 'NUMERIC_CHECK'
      EXPORTING
        string_in = string_in
      IMPORTING
        htype     = lv_htype.
    IF lv_htype = 'NUMC'.
      rv_is_numc = 'X'.
    ELSE.
      CLEAR rv_is_numc.
    ENDIF.



  ENDMETHOD.


  METHOD open_dialog.

    DATA : lt_file_table TYPE filetable,
           ls_file_table TYPE file_table,
           l_rc          TYPE i.
    DATA lv_desktop TYPE string.

    cl_gui_frontend_services=>get_desktop_directory(
      CHANGING
        desktop_directory = lv_desktop
    ).
    CALL METHOD cl_gui_cfw=>update_view.
    CALL METHOD cl_gui_frontend_services=>file_open_dialog
      EXPORTING
        window_title            = 'File Open Dialog'
*       default_extension       =
*       default_filename        =
        file_filter             = cl_gui_frontend_services=>filetype_excel
*       with_encoding           =
        initial_directory       = lv_desktop
*       multiselection          =
      CHANGING
        file_table              = lt_file_table
        rc                      = l_rc
*       user_action             =
*       file_encoding           =
      EXCEPTIONS
        file_open_dialog_failed = 1
        cntl_error              = 2
        error_no_gui            = 3
        not_supported_by_gui    = 4
        OTHERS                  = 5.
    IF sy-subrc = 0.
      READ TABLE lt_file_table INTO ls_file_table INDEX 1 .
      rv_filename = ls_file_table-filename.
    ENDIF.


  ENDMETHOD.


  METHOD ranges_cond_date.

    IF iv_low IS NOT INITIAL AND iv_high IS NOT INITIAL.
      er_begda = VALUE #( ( sign = 'I' option = 'LE' low = iv_high ) ).
      er_endda = VALUE #( ( sign = 'I' option = 'GE' low = iv_low ) ).

    ELSEIF iv_low IS NOT INITIAL.
      er_begda = VALUE #( ( sign = 'I' option = 'LE' low = iv_low ) ).
      er_endda = VALUE #( ( sign = 'I' option = 'GE' low = iv_low ) ).

    ELSEIF iv_high IS NOT INITIAL.
      er_begda = VALUE #( ( sign = 'I' option = 'LE' low = iv_high ) ).
      er_endda = VALUE #( ( sign = 'I' option = 'GE' low = iv_high ) ).

    ELSE.

    ENDIF.

  ENDMETHOD.


  METHOD ranges_convert.


    FIELD-SYMBOLS: <fs_data> TYPE any.
    DATA dref TYPE REF TO data.
    DATA lo_elem TYPE REF TO cl_abap_elemdescr.

    CREATE DATA dref LIKE LINE OF et_data.
    ASSIGN dref->* TO <fs_data>.

    FIELD-SYMBOLS: <sign> TYPE any.
    FIELD-SYMBOLS: <option> TYPE any.
    FIELD-SYMBOLS: <low> TYPE any.
    FIELD-SYMBOLS: <high> TYPE any.

    ASSIGN COMPONENT 'SIGN' OF STRUCTURE <fs_data> TO <sign>.
    ASSIGN COMPONENT 'OPTION' OF STRUCTURE <fs_data> TO <option>.
    ASSIGN COMPONENT 'LOW' OF STRUCTURE <fs_data> TO <low>.
    ASSIGN COMPONENT 'HIGH' OF STRUCTURE <fs_data> TO <high>.

    CHECK <sign> IS ASSIGNED.

    IF low IS NOT INITIAL AND high IS INITIAL.
      <sign> = 'I'.
      <option> = 'EQ'.
      <low> = low.
      FIND '*' IN low.
      IF sy-subrc = 0.
        <sign> = 'I'.
        <option> = 'CP'.
        <low> = low.
      ELSE.
*        DESCRIBE FIELD: low TYPE DATA(lv_type)
*                            HELP-ID DATA(lv_elem)
*                            OUTPUT-LENGTH DATA(lv_len).

        DATA(lo_ref) = cl_abap_typedescr=>describe_by_data( low ).
        lo_elem ?= lo_ref.
        IF lo_elem->help_id IS NOT INITIAL.
          SELECT SINGLE domname FROM dd04l
            INTO @DATA(lv_dom)
            WHERE rollname = @lo_elem->help_id.
          IF lv_dom(4) = 'TEXT'.
            <sign> = 'I'.
            <option> = 'CP'.
            <low> = `*` && low && `*`.
          ENDIF.
          CLEAR lv_dom.
        ENDIF.

      ENDIF.
    ELSEIF low IS NOT INITIAL AND  high IS NOT INITIAL.
      <sign> = 'I'.
      <option> = 'BT'.
      <low> = low.
      <high> = high.
    ENDIF.

    IF <fs_data> IS NOT INITIAL.
      APPEND <fs_data> TO et_data[].
    ENDIF.

  ENDMETHOD.


  METHOD set_log.

    FIELD-SYMBOLS <fs> TYPE any.
    DATA lv_uname TYPE uname.
    DATA lv_ip TYPE ze_ip.

    CALL FUNCTION 'ZCK_GET_IP'
      IMPORTING
        e_ip = lv_ip.

    lv_uname = sy-uname.

    CASE iv_mode.
      WHEN 'C'.
        ASSIGN COMPONENT 'ERNAM' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_uname.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'ERDAT' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-datum.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'ERZET' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-uzeit.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'INPT_ID' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_ip.   UNASSIGN <fs>.
        ENDIF.

      WHEN 'U'.
        ASSIGN COMPONENT 'AENAM' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_uname.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'AEDAT' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-datum.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'AEZET' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-uzeit.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'MOD_IP' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_ip.   UNASSIGN <fs>.
        ENDIF.

      WHEN OTHERS.
        ASSIGN COMPONENT 'ERNAM' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_uname.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'ERDAT' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-datum.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'ERZET' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-uzeit.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'INPT_ID' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_ip.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'AENAM' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_uname.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'AEDAT' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-datum.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'AEZET' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = sy-uzeit.   UNASSIGN <fs>.
        ENDIF.

        ASSIGN COMPONENT 'MOD_IP' OF STRUCTURE is_line TO <fs>.
        IF sy-subrc EQ 0.
          <fs> = lv_ip.   UNASSIGN <fs>.
        ENDIF.
    ENDCASE.


  ENDMETHOD.


  METHOD xl_to_itab.

    DATA : ld_tab  TYPE REF   TO data,
           ld_line TYPE REF   TO data,
           lt_fcat TYPE TABLE OF lvc_s_fcat,
           ls_fcat LIKE LINE  OF lt_fcat.

    DATA ld_data TYPE REF TO data.
    DATA lv_filename TYPE rlgrap-filename.

    FIELD-SYMBOLS : <new_tab>  TYPE table,
                    <new_line> TYPE any,
                    <struc>    TYPE any,
                    <fs>       TYPE any.

    DATA lt_xl TYPE TABLE OF zcks0130.
    DATA ls_xl TYPE zcks0130.
    DATA: lr_tabdescr TYPE REF TO cl_abap_structdescr,
          lr_data     TYPE REF TO data,
          lt_dfies    TYPE ddfields.

    lv_filename = iv_filename.

    CREATE DATA ld_data LIKE LINE OF et_itab.
    ASSIGN ld_data->* TO <struc>.

    lr_tabdescr ?= cl_abap_structdescr=>describe_by_data_ref( ld_data ).
    lt_dfies = cl_salv_data_descr=>read_structdescr( lr_tabdescr ).
    SORT lt_dfies BY fieldname.

    CALL FUNCTION 'ZALSM_EXCEL_TO_INTERNAL_TABLE2'
      EXPORTING
        filename                = lv_filename
        i_begin_col             = 1
        i_begin_row             = 1
        i_end_col               = 999
        i_end_row               = 65555
      TABLES
        intern                  = lt_xl
      EXCEPTIONS
        inconsistent_parameters = 1
        upload_ole              = 2
        OTHERS                  = 3.
    CHECK lt_xl IS NOT INITIAL.

    LOOP AT it_row_del INTO DATA(lv_index).
      DELETE lt_xl WHERE row = lv_index.
    ENDLOOP.

    LOOP AT lt_xl INTO ls_xl WHERE row = iv_row_f.
*      APPEND VALUE #( fieldname = ls_xl-value datatype = 'STRG' ) TO lt_fcat.
      READ TABLE lt_dfies INTO DATA(ls_dfies) WITH KEY fieldname = ls_xl-value BINARY SEARCH.
      IF sy-subrc = 0.
        MOVE-CORRESPONDING ls_dfies TO ls_fcat.
        ls_fcat-intlen = ls_dfies-outputlen.
        ls_fcat-outputlen = ls_dfies-outputlen.
        APPEND ls_fcat TO lt_fcat.
        CLEAR ls_fcat.
      ENDIF.
    ENDLOOP.
    CHECK lt_fcat IS NOT INITIAL.
    CALL METHOD cl_alv_table_create=>create_dynamic_table
      EXPORTING
        it_fieldcatalog = lt_fcat
      IMPORTING
        ep_table        = ld_tab.

    ASSIGN ld_tab->*  TO  <new_tab>.
    CREATE DATA ld_line LIKE LINE OF <new_tab>.
    ASSIGN ld_line->* TO <new_line>.

    CHECK <new_tab> IS INITIAL.
    DELETE lt_xl WHERE row = iv_row_f.

    LOOP AT lt_xl INTO ls_xl.
      ASSIGN COMPONENT ls_xl-col OF STRUCTURE  <new_line> TO <fs>.
      IF sy-subrc = 0.
        READ TABLE lt_fcat INTO ls_fcat INDEX ls_xl-col.
        IF sy-subrc = 0.
          CASE ls_fcat-datatype.
            WHEN 'CURR'.
              REPLACE ALL OCCURRENCES OF  ','   IN  ls_xl-value  WITH  ``.
              TRY.
                  ls_xl-value = ls_xl-value / 100.
                CATCH cx_sy_conversion_no_number INTO DATA(lo_ref).
                  DATA(lv_text) = lo_ref->get_text( ).
                  rv_msg = |Row: { ls_xl-row }, Col: { ls_xl-col } Val: { ls_xl-value }|.
                  RETURN.
              ENDTRY.
            WHEN 'DATS' OR 'TIMS'.
              REPLACE ALL OCCURRENCES OF  '.'   IN  ls_xl-value  WITH  ``.
              REPLACE ALL OCCURRENCES OF  ':'   IN  ls_xl-value  WITH  ``.
              REPLACE ALL OCCURRENCES OF  '-'   IN  ls_xl-value  WITH  ``.
              REPLACE ALL OCCURRENCES OF  '/'   IN  ls_xl-value  WITH  ``.
            WHEN OTHERS.
          ENDCASE.

          <fs> = ls_xl-value.

          CASE ls_fcat-convexit.
            WHEN 'ALPHA'.
              <fs> = |{ <fs> ALPHA = IN }|.
            WHEN OTHERS.
          ENDCASE.
        ENDIF.
      ENDIF.
      AT END OF row.
        APPEND <new_line> TO <new_tab>.
        CLEAR <new_line>.
      ENDAT.
    ENDLOOP.


    et_itab[] = CORRESPONDING #( <new_tab> ).

  ENDMETHOD.
ENDCLASS.
