class ZCL_PM_UI5 definition
  public
  final
  create public .

public section.

  class-data DEV_UNAME type UNAME value 'B112199' ##NO_TEXT.

  class-methods AS_MNG_NO_F4
    importing
      !IV_BUKRS type BUKRS optional
      !IV_KOSTL type KOSTL optional
      !IV_PUBOFC_FG type ZFIT0040-PUBOFC_FG default 'C012700012'
      !IV_UP_PUBOFC_NO type ZFIT0040-UP_PUBOFC_NO optional
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT .
  class-methods LIFNR_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT .
  class-methods AUFNR_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT .
  class-methods FINCODE_F4
    importing
      value(I_FIKRS) type FIKRS optional
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT .
  class-methods GET_INVEST_KEY
    exporting
      !EV_KEY type ANY .
  class-methods INVNR_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_KOKRS type CSKT-KOKRS optional .
  class-methods EQUNR_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_KOKRS type CSKT-KOKRS optional
      !I_WRKART_ST type ZPMT2010-WRKART_ST optional .
  class-methods KOSTL_C_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_KOKRS type CSKT-KOKRS optional .
  class-methods KOSTL_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_KOKRS type CSKT-KOKRS optional .
  class-methods LEASE_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_FLAG type FLAG
      !I_SEVENT_NAME type CLIKE .
  class-methods UITABLE_CONFIG
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !TID type ANY optional
      !ROWS type INT4 optional
      !FT_YN type FLAG optional
      !ST_YN type FLAG optional
      !AUTO_WIDTH type FLAG optional .
  class-methods GET_ARTNUM_KEY
    returning
      value(RV_KEY) type CHAR14 .
  class-methods GET_PSNUM_KEY
    returning
      value(RV_KEY) type CHAR12 .
  class-methods TITLE_COUNT
    importing
      !IV_CNT type I
    returning
      value(RV_TXT) type STRING .
  class-methods CALL_F4_APP
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_APP_CONTAINER_ID type ANY
      !I_APPID type ANY
      !I_HELP_NM type ANY optional
      value(I_CB_METHOD) type ANY optional
      value(IT_PARAM) type TIHTTPNVP optional .
  class-methods SEARCH_HELP
    importing
      !IO_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_SEVENT_NAME type CLIKE
      !I_TITLE type CLIKE optional
      !IT_DATA type STANDARD TABLE optional
      !IT_FLD_INFO type /U4A/CL_F4_HNADL=>GTT_FLD_INFO optional
      !I_SHLPNAME type ANY optional
      !I_HEIGHT type CLIKE optional
      !I_WIDTH type CLIKE default '666px'
      !I_MULTSEL type ABAP_BOOL optional .
  class-methods ARTIST_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_SEVENT_NAME type CLIKE .
  class-methods PERNR_F4
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_SEVENT_NAME type CLIKE .
  class-methods GW_DOC_VIEWER
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
      !I_DOCID type ZCKE_SETTLEMENT
      !I_USERID type UNAME default SY-UNAME .
  class-methods ADDR_API
    importing
      !I_KEY type ZE_KEYWORD
    exporting
      !ET_JUSO type ZPMS9010T
      !EV_MSG type STRING .
  class-methods GET_USER_INFO
    importing
      !AR_VIEW type ref to /U4A/CL_UI_ELEMENT
    exporting
      !ES_PERSON type ZHRS0015
      !ET_PERSON type ZCKT0280 .
  PROTECTED SECTION.
private section.
ENDCLASS.



CLASS ZCL_PM_UI5 IMPLEMENTATION.


  METHOD addr_api.

    DATA lo_proxy TYPE REF TO zhrif_co_hr00600_so.
    DATA ls_send TYPE zhrif_mt_hr00600_send.
    DATA lt_resp TYPE zhrif_mt_hr00600_send_response.
    DATA lv_key TYPE ze_keyword.
    DATA ls_juso TYPE zpms9010.
    DATA lv_cnt TYPE char10.

    lv_key = i_key.

    CONDENSE lv_key NO-GAPS.
    IF lv_key IS INITIAL.
      ev_msg = TEXT-018. RETURN.
    ENDIF.
    IF strlen( lv_key ) < 2.
      ev_msg = TEXT-019. RETURN.
    ENDIF.
    IF zcl_pm_util=>numeric_check( lv_key ) IS NOT INITIAL.
      ev_msg = TEXT-020. RETURN.
    ENDIF.

    ls_send-mt_hr00600_send-zkeyw = i_key.

    TRY.
        CREATE OBJECT lo_proxy.

        CALL METHOD lo_proxy->hr00600_so
          EXPORTING
            output = ls_send
          IMPORTING
            input  = lt_resp.

      CATCH cx_ai_system_fault INTO DATA(lo_ref).
        DATA(lv_msg) = lo_ref->get_text( ).
        ev_msg = lv_msg.
        RETURN.
    ENDTRY.


    LOOP AT lt_resp-mt_hr00600_send_response-pa0006 INTO DATA(ls_result).
      ls_juso-pstlz = ls_result-zipcode.
      ls_juso-doro = |{ ls_result-sido } { ls_result-doro } { ls_result-dorono }{ ls_result-dororef2 }|.
      ls_juso-jibun = |{ ls_result-sido } { ls_result-jibun } { ls_result-jibunno }|.
      APPEND ls_juso TO et_juso. CLEAR ls_juso.
    ENDLOOP.

    lv_cnt = lines( et_juso ).
    CONDENSE lv_cnt NO-GAPS.

    ev_msg = TEXT-021.
    REPLACE '&1' IN ev_msg WITH i_key.
    REPLACE '&2' IN ev_msg WITH lv_cnt.



  ENDMETHOD.


  METHOD ARTIST_F4.

    DATA LT_INFO TYPE /U4A/CL_F4_HNADL=>GTT_FLD_INFO.
    DATA : BEGIN OF LS_LIST,
             PARTNER        TYPE BUT000-PARTNER,
             NAME_ORG1      TYPE BU_NAMEOR1,
             CHULSIN_SCH_NM TYPE ZE_CHULSIN_SCH_NM,
           END OF LS_LIST.
    DATA LT_LIST LIKE TABLE OF LS_LIST.
    DATA LV_TITLE TYPE STRING.
*--------------------------------------------------------------------*
    CLEAR : LT_INFO,
            LS_LIST, LT_LIST,
            LV_TITLE.

    CLEAR : LT_LIST.
    SELECT A~PARTNER,         " 작가코드
           A~NAME_ORG1,       " 작가명
           B~CHULSIN_SCH_NM  " 출신학교
      FROM BUT000           AS A
      JOIN ZMMT1601         AS B
        ON A~PARTNER        EQ B~PARTNER
     WHERE B~OUTSID_FG  EQ '2'
       AND A~XDELE IS INITIAL
*       AND A~MC_NAME1       IN @LR_NAME_FIRST
*       AND B~CHULSIN_SCH_NM IN @LR_CHULSIN_SCH_NM
*       AND B~BIRTH_DT       IN @LR_BIRTH_DT
      INTO CORRESPONDING FIELDS OF TABLE @LT_LIST.

    APPEND VALUE #( FNAME  = 'PARTNER'
                    LABEL  = '작가 코드'
                    ISSH   = 'X'
                    NOZERO = 'X' ) TO LT_INFO.
    APPEND VALUE #( FNAME  = 'NAME_ORG1'
                    LABEL  = '작가 내역'
                    ISSH   = 'X'
                    NOZERO = '' ) TO LT_INFO.
    APPEND VALUE #( FNAME  = 'CHULSIN_SCH_NM'
                    LABEL  = '출신 학교'
                    ISSH   = 'X'
                    NOZERO = '' ) TO LT_INFO.

    CLEAR : LV_TITLE.
    LV_TITLE = TEXT-017. " 작가코드

    CALL METHOD ZCL_PM_UI5=>SEARCH_HELP
      EXPORTING
        IO_VIEW       = AR_VIEW
        I_TITLE       = LV_TITLE
        I_SEVENT_NAME = I_SEVENT_NAME
        IT_FLD_INFO   = LT_INFO
        IT_DATA       = LT_LIST.

  ENDMETHOD.


  METHOD as_mng_no_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA lt_list TYPE TABLE OF zpms2200.
    DATA lr_bukrs TYPE RANGE OF bukrs.
    DATA lr_kostl TYPE RANGE OF kostl.
    DATA lr_pubofc_fg TYPE RANGE OF zfit0040-pubofc_fg.
    DATA lr_up_pubofc_no TYPE RANGE OF zfit0040-up_pubofc_no.

    zcl_pm_util=>ranges_convert( EXPORTING low     = iv_bukrs
                                 CHANGING  et_data = lr_bukrs ).

    zcl_pm_util=>ranges_convert( EXPORTING low     = iv_kostl
                                 CHANGING  et_data = lr_kostl ).

    zcl_pm_util=>ranges_convert( EXPORTING low     = iv_pubofc_fg
                                 CHANGING  et_data = lr_pubofc_fg ).

    zcl_pm_util=>ranges_convert( EXPORTING low     = iv_up_pubofc_no
                                 CHANGING  et_data = lr_up_pubofc_no ).

    SELECT * FROM zfit0040 AS a
      INNER JOIN t001 AS b
      ON a~bukrs = b~bukrs
      INTO CORRESPONDING FIELDS OF TABLE lt_list
      WHERE a~bukrs IN lr_bukrs
        AND a~kostl IN lr_kostl
        AND a~pubofc_fg = 'C012700012'
        AND a~up_pubofc_no IN lr_up_pubofc_no
        AND a~use_yn = 'Y'.

    APPEND VALUE #( fname = 'PUBOFC_NO' label = '관직번호' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'PUBOFC_NM' label = '관직명' issh = 'X' nozero = '' ) TO lt_info.
    APPEND VALUE #( fname = 'BUTXT' label = '회사코드명' issh = '' nozero = '' ) TO lt_info.
    APPEND VALUE #( fname = 'KOSTL' label = '코스트 센터' issh = '' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'KTEXT' label = '코스트 센터명' issh = '' nozero = '' ) TO lt_info.

*    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic
*      EXPORTING
*        io_view                      = ar_view
*        i_draggable                  = abap_true
*        i_resizable                  = abap_true
**       i_height                     = '500px'
**       i_width                      = '800px'
*        i_title                      = TEXT-008
*        i_sevent_name                = 'EV_AS_MNG_NO_F4_RET'
*        it_fld_info                  = lt_info
*        it_data                      = lt_list
*      EXCEPTIONS
*        process_stru_does_not_format = 1
*        data_does_not_exist          = 2
*        field_type_not_allowed       = 3
*        columns_exceeded             = 4
*        row_exceeded                 = 5
*        OTHERS                       = 6.

    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_width       = '800px'
        i_title       = TEXT-008
        i_sevent_name = 'EV_AS_MNG_NO_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.


  ENDMETHOD.


  METHOD aufnr_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            aufnr TYPE aufk-aufnr,
            ktext TYPE aufk-ktext,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.

    SELECT * FROM aufk
      INTO CORRESPONDING FIELDS OF TABLE lt_list
      WHERE auart = 'Z100'.

    APPEND VALUE #( fname = 'AUFNR' label = '오더번호' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'KTEXT' label = '오더번호명' issh = 'X' nozero = '' ) TO lt_info.


    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = TEXT-011
        i_sevent_name = 'EV_AUFNR_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.

**    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic
**      EXPORTING
**        io_view                      = ar_view
**        i_draggable                  = abap_true
**        i_resizable                  = abap_true
***       i_height                     = '500px'
**        i_width                      = '666px'
**        i_title                      = TEXT-011
**        i_sevent_name                = 'EV_AUFNR_F4_RET'
**        it_fld_info                  = lt_info
**        it_data                      = lt_list
**      EXCEPTIONS
**        process_stru_does_not_format = 1
**        data_does_not_exist          = 2
**        field_type_not_allowed       = 3
**        columns_exceeded             = 4
**        row_exceeded                 = 5
**        OTHERS                       = 6.
  ENDMETHOD.


  method CALL_F4_APP.


    CONSTANTS : lc_app_helpname TYPE char30 VALUE 'lo_app->IV_HELPNAME'.  " 도움말 구분명
    CONSTANTS : lc_app_method   TYPE char30 VALUE 'lo_app->EV_CB_METHOD'. " CALL BACK 메소드명
    CONSTANTS : lc_app_it_param TYPE char30 VALUE 'lo_app->IT_PARAM'.     " 전송될 파라미터

    DATA lo_obj TYPE REF TO object.
    DATA lo_app TYPE REF TO object.

    CHECK io_view IS NOT INITIAL.

    CALL METHOD /u4a/cl_utilities=>reset_usage_app
      EXPORTING
        io_view   = io_view
        iv_app_nm = i_app_container_id.

    CALL METHOD /u4a/cl_utilities=>rendering_usage_app
      EXPORTING
        io_view            = io_view
        i_app_container_id = i_app_container_id
        i_appid            = i_appid
      RECEIVING
        eo_controller      = lo_obj.

    lo_app ?= lo_obj.
    CHECK lo_app IS BOUND.

    "
    FIELD-SYMBOLS : <fs_hname> TYPE any.
    FIELD-SYMBOLS : <fs_method> TYPE any.

*--------------------------------------------------------------------*

    ASSIGN (lc_app_helpname) TO <fs_hname>.
    IF <fs_hname> IS ASSIGNED .
      <fs_hname> = i_help_nm .
    ENDIF.

*--------------------------------------------------------------------*

    ASSIGN (lc_app_method) TO <fs_method>.
    IF <fs_method> IS ASSIGNED .
      <fs_method> = i_cb_method .
    ENDIF.

*--------------------------------------------------------------------*
    FIELD-SYMBOLS : <fs_param> TYPE any.

    ASSIGN (lc_app_it_param) TO <fs_param>.
    IF <fs_param> IS ASSIGNED .
      <fs_param> = it_param .
    ENDIF.
*--------------------------------------------------------------------*

  endmethod.


  METHOD equnr_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            equnr TYPE equi-equnr,
            eqktx TYPE v_equi-eqktx,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.
    DATA lr_sts TYPE RANGE OF zpmt2010-wrkart_st.

    zcl_pm_util=>ranges_convert( EXPORTING low     = i_wrkart_st
                                 CHANGING  et_data = lr_sts ).

    SELECT a~* FROM v_equi AS a
      INNER JOIN zpmt2010 AS b
      ON a~equnr = b~equnr
      INTO CORRESPONDING FIELDS OF TABLE @lt_list
      WHERE a~eqtyp = 'Y'
        AND b~wrkart_st IN @lr_sts.

    APPEND VALUE #( fname = 'EQUNR' label = 'SAP 미술품 번호' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'EQKTX' label = '미술품명' issh = 'X' nozero = '' ) TO lt_info.


    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = TEXT-013
        i_sevent_name = 'EV_EQUNR_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.
  ENDMETHOD.


  METHOD fincode_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            fincode    TYPE zfms1150-fincode,
            fincode_nm TYPE zfms1150-fincode_nm,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.
    DATA lr_fikrs TYPE RANGE OF fmfint-fikrs.
    DATA lt_out TYPE TABLE OF zfms1150.

    zcl_pm_util=>ranges_convert( EXPORTING low     = i_fikrs
                                 CHANGING  et_data = lr_fikrs ).

    APPEND VALUE #( fname = 'FINCODE' label = '사업코드' issh = 'X' nozero = '' ) TO lt_info.
    APPEND VALUE #( fname = 'FINCODE_NM' label = '사업코드명' issh = 'X' nozero = '' ) TO lt_info.

*    SELECT * FROM fmfint
*      INTO CORRESPONDING FIELDS OF TABLE lt_list
*      WHERE spras = sy-langu
*        AND fikrs IN lr_fikrs.
    CALL FUNCTION 'ZFM_FUNDLIST'
      EXPORTING
        i_fikrs   = i_fikrs
        i_langu   = '3'
        i_keydate = sy-datum
      TABLES
        et_out    = lt_out.
    lt_list = CORRESPONDING #( lt_out ).

    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = TEXT-012
        i_sevent_name = 'EV_FINCODE_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.
*
*    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic
*      EXPORTING
*        io_view                      = ar_view
*        i_draggable                  = abap_true
*        i_resizable                  = abap_true
**       i_height                     = '500px'
*        i_width                      = '666px'
*        i_title                      = TEXT-012
*        i_sevent_name                = 'EV_FINCODE_F4_RET'
*        it_fld_info                  = lt_info
*        it_data                      = lt_list
*      EXCEPTIONS
*        process_stru_does_not_format = 1
*        data_does_not_exist          = 2
*        field_type_not_allowed       = 3
*        columns_exceeded             = 4
*        row_exceeded                 = 5
*        OTHERS                       = 6.


  ENDMETHOD.


  METHOD get_artnum_key.

    DATA lv_num TYPE char14.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZPM_ARTNUM'
        toyear                  = sy-datum+0(4)
      IMPORTING
        number                  = lv_num
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    rv_key = lv_num.

  ENDMETHOD.


  METHOD get_invest_key.


    DATA lv_no TYPE char8.

    CLEAR: ev_key.
    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZMM_INVEST'
      IMPORTING
        number                  = lv_no
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc = 0.
      ev_key = lv_no.
    ENDIF.



  ENDMETHOD.


  METHOD get_psnum_key.

    DATA lv_num TYPE n LENGTH 8.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZMM_PSNUM'
        toyear                  = sy-datum+0(4)
      IMPORTING
        number                  = lv_num
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc EQ 0.
      rv_key = 'PS' && sy-datum+2(2) && lv_num.
    ENDIF.

  ENDMETHOD.


  METHOD get_user_info.

    DATA lv_msg TYPE string.
    DATA lv_zgibh    TYPE pa9002-zgibh.

    SELECT SINGLE cname FROM zmmt9001
      INTO @DATA(lv_uname)
      WHERE uname = @sy-uname.
    IF lv_uname IS INITIAL.
      lv_uname = sy-uname.
    ENDIF.

*사용자 아이디 체크
    CLEAR es_person.
    zcl_hrui_common=>get_login_person( EXPORTING i_uname   = lv_uname
                                       IMPORTING es_person = es_person
                                                 e_subrc   = DATA(lv_subrc) ).

    IF es_person IS INITIAL.
      lv_msg = TEXT-022.
      zcl_ck_u4a_common=>set_error_dialog_open(
        EXPORTING
          io_view       = ar_view
          iv_error_text = lv_msg
      ).
      RETURN.
    ENDIF.

*권한 체크
    lv_zgibh = lv_uname.
    CLEAR et_person.
    CALL FUNCTION 'ZCK_SAPID_INFORMATION'
      EXPORTING
        iv_zgibh = lv_zgibh
      TABLES
        et_data  = et_person.

  ENDMETHOD.


  METHOD gw_doc_viewer.

    DATA lv_url TYPE string.

    CHECK i_docid IS NOT INITIAL.

    CALL FUNCTION 'ZCK_GW_SELECT'
      EXPORTING
        i_docid  = i_docid
        i_userid = i_userid
        i_u4a    = 'X'
      IMPORTING
        e_url    = lv_url.

    CHECK lv_url IS NOT INITIAL.

    CALL METHOD /u4a/cl_utilities=>ext_win_open
      EXPORTING
        io_view = ar_view
        url     = lv_url.

  ENDMETHOD.


  METHOD invnr_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            invnr TYPE v_equi-invnr,
            eqktx TYPE v_equi-eqktx,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.

    SELECT * FROM v_equi
      INTO CORRESPONDING FIELDS OF TABLE lt_list
      WHERE eqtyp = 'Y'.
    DELETE lt_list WHERE invnr = ''.

    APPEND VALUE #( fname = 'INVNR' label = '미술품 대장번호' issh = 'X' nozero = '' ) TO lt_info.
    APPEND VALUE #( fname = 'EQKTX' label = '미술품명' issh = 'X' nozero = '' ) TO lt_info.

*    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic
*      EXPORTING
*        io_view                      = ar_view
*        i_draggable                  = abap_true
*        i_resizable                  = abap_true
*        i_width                      = '666px'
*        i_title                      = TEXT-013
*        i_sevent_name                = 'EV_INVNR_F4_RET'
*        it_fld_info                  = lt_info
*        it_data                      = lt_list
*      EXCEPTIONS
*        process_stru_does_not_format = 1
*        data_does_not_exist          = 2
*        field_type_not_allowed       = 3
*        columns_exceeded             = 4
*        row_exceeded                 = 5
*        OTHERS                       = 6.

    zcl_pm_ui5=>search_help(
      io_view       = ar_view
      i_sevent_name = 'EV_INVNR_F4_RET'
      i_title       = TEXT-014
      it_data       = lt_list
      it_fld_info   = lt_info
    ).


  ENDMETHOD.


  METHOD KOSTL_C_F4.


    DATA : LS_LAYO TYPE /U4A/CL_F4_HNADL=>TY_DYN_F4LAYO_CONF.

    DATA : LS_SEARCH_FIELD TYPE /U4A/CL_F4_HNADL=>TY_SET_DYN_SEARCH_LAYO, "검색조건 필드 정보.
           LS_RESULT_FIELD TYPE /U4A/CL_F4_HNADL=>TY_SET_DYN_RESULT_LAYO. "결과리스트 COLUMN 필드 정보.

    DATA : BEGIN OF LS_KOSTL,
             KOSTL TYPE KOSTL,
             KTEXT TYPE KTEXT,
           END OF LS_KOSTL.
    DATA : LT_KOSTL LIKE TABLE OF LS_KOSTL.

    DATA : LV_MSG TYPE STRING.

*--------------------------------------------------------------------*
    CLEAR : LS_LAYO,
            LS_SEARCH_FIELD,
            LS_RESULT_FIELD,
            LS_KOSTL,
            LT_KOSTL,
            LV_MSG.

*-- 계약부서 데이터 조회
    CLEAR : LT_KOSTL.
    SELECT LTRIM( KOSTL, '0' ) AS KOSTL,
           KTEXT
      FROM CSKT
     WHERE SPRAS EQ @SY-LANGU
       AND KOKRS EQ @I_KOKRS
       AND DATBI >= @SY-DATUM
      INTO CORRESPONDING FIELDS OF TABLE @LT_KOSTL.
    IF LT_KOSTL IS NOT INITIAL.
      SORT LT_KOSTL BY KOSTL.
    ENDIF.


*-- F4 HELP DYNAMIC LAYOUT 정보 설정.
    CALL METHOD ZCL_CK_U4A_COMMON=>SET_F4_DYN_LAYO_02
      EXPORTING
        IV_WIDTH    = '600PX'       " F4 팝업 넓이(500px, 60%)
        IV_HEIGHT   = '800PX'       " F4 팝업 높이(500px, 60%)
        IV_TITLE    = '계약부서'    " 팝업 TITLE
        IV_MULTSEL  = '00'          " 결과리스트 멀티선택 여부(예: 00 = DEFAULT 단일선택, 01 = 멀티선택, 02 = 단일선택 )
        IV_EXPANDED = '00'          " 검색조건 영역 펼침 처리 여부(예: 00 = DEFAULT 펼침, 01 = 펼침, 02 = 접힘 )
      CHANGING
        CS_LAYO     = LS_LAYO.      " F4_SEARCH_HELP_DYNAMIC2 CONFIG 구조

    LS_SEARCH_FIELD-FNAME        = 'ORGEH'.            "필드명
    LS_SEARCH_FIELD-LABEL        = '계약부서'.         "라벨
    LS_SEARCH_FIELD-INITVALUE    = ''.                 "조회조건 Init Value.
    LS_SEARCH_FIELD-WIDTH        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
    LS_SEARCH_FIELD-NOZERO       = '01'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
    LS_SEARCH_FIELD-PLACEHOLDER  = ''.                 "자리 표시자
    LS_SEARCH_FIELD-CONVEXIT     = ''.                 "Conversion routine (예: ALPHA )
    LS_SEARCH_FIELD-ENABLE       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
    LS_SEARCH_FIELD-ISFOCUS      = '00'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
    LS_SEARCH_FIELD-VISIBLE      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
    LS_SEARCH_FIELD-ALIGN        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
    LS_SEARCH_FIELD-REFTYPE      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
    LS_SEARCH_FIELD-REFFIELD     = ''.                 "참조필드명.
    LS_SEARCH_FIELD-ISNUM_FORMAT = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
    APPEND LS_SEARCH_FIELD TO LS_LAYO-SEARCH_FIELD.
    CLEAR LS_SEARCH_FIELD.

    LS_SEARCH_FIELD-FNAME        = 'KTEXT'.        "필드명
    LS_SEARCH_FIELD-LABEL        = '계약부서명'.   "라벨
    LS_SEARCH_FIELD-INITVALUE    = ''.             "조회조건 Init Value.
    LS_SEARCH_FIELD-WIDTH        = ''.             "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
    LS_SEARCH_FIELD-NOZERO       = '00'.           "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
    LS_SEARCH_FIELD-PLACEHOLDER  = ''.             "자리 표시자
    LS_SEARCH_FIELD-CONVEXIT     = ''.             "Conversion routine (예: ALPHA )
    LS_SEARCH_FIELD-ENABLE       = '00'.           "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
    LS_SEARCH_FIELD-ISFOCUS      = '01'.           "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
    LS_SEARCH_FIELD-VISIBLE      = '00'.           "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
    LS_SEARCH_FIELD-ALIGN        = '00'.           "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
    LS_SEARCH_FIELD-REFTYPE      = ''.             "참조필드 유형.(1 = Currency, 2 = Quantity...)
    LS_SEARCH_FIELD-REFFIELD     = ''.             "참조필드명.
    LS_SEARCH_FIELD-ISNUM_FORMAT = '00'.           "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
    APPEND LS_SEARCH_FIELD TO LS_LAYO-SEARCH_FIELD.
    CLEAR : LS_SEARCH_FIELD.

*-- 결과리스트 COLUMN 설정.

    " 계약부서
    LS_RESULT_FIELD-FNAME         = 'KOSTL'.     "필드명
    LS_RESULT_FIELD-LABEL         = '계약부서'.  "라벨
    LS_RESULT_FIELD-WIDTH         = ''.          "column width (EX:10px,30%...)
    LS_RESULT_FIELD-MWIDTH        = ''.          "컬럼 최소 width(100)
    LS_RESULT_FIELD-NOZERO        = '01'.        "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
    LS_RESULT_FIELD-CONVEXIT      = ''.          "Conversion routine (예: ALPHA )

    LS_RESULT_FIELD-ISFIX_COL     = '00'.        "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
    LS_RESULT_FIELD-COL_ALIGN     = '02'.        "컬럼 ALIGN(예: 00 = DEFAULT Begin).
    LS_RESULT_FIELD-TXT_ALIGN     = '02'.        "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)

    LS_RESULT_FIELD-VISIBLE       = '00'.        "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
    LS_RESULT_FIELD-RESIZABLE     = '00'.        "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
    LS_RESULT_FIELD-FILTER_OPTION = '00'.        "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
    LS_RESULT_FIELD-ENABLE_FILTER = '01'.        "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
    LS_RESULT_FIELD-ENABLE_SORTER = '01'.        "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
    LS_RESULT_FIELD-WRAPPING      = '02'.        "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
    LS_RESULT_FIELD-REFTYPE       = ''.          "참조필드 유형.(1 = Currency, 2 = Quantity...)
    LS_RESULT_FIELD-REFFIELD      = ''.          "참조필드명.
    LS_RESULT_FIELD-ISNUM_FORMAT  = ''.          "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
    APPEND LS_RESULT_FIELD TO LS_LAYO-RESULT_FIELD.
    CLEAR LS_RESULT_FIELD.

    " 계약부서명
    LS_RESULT_FIELD-FNAME         = 'KTEXT'.      "필드명
    LS_RESULT_FIELD-LABEL         = '계약부서명'. "라벨
    LS_RESULT_FIELD-WIDTH         = ''.           "column width (EX:10px,30%...)
    LS_RESULT_FIELD-MWIDTH        = ''.           "컬럼 최소 width(100)
    LS_RESULT_FIELD-NOZERO        = '00'.         "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
    LS_RESULT_FIELD-CONVEXIT      = ''.           "Conversion routine (예: ALPHA )

    LS_RESULT_FIELD-ISFIX_COL     = '00'.         "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
    LS_RESULT_FIELD-COL_ALIGN     = '02'.         "컬럼 ALIGN(예: 00 = DEFAULT Begin).
    LS_RESULT_FIELD-TXT_ALIGN     = '01'.         "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)

    LS_RESULT_FIELD-VISIBLE       = '00'.         "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
    LS_RESULT_FIELD-RESIZABLE     = '00'.         "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
    LS_RESULT_FIELD-FILTER_OPTION = '00'.         "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
    LS_RESULT_FIELD-ENABLE_FILTER = '01'.         "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
    LS_RESULT_FIELD-ENABLE_SORTER = '01'.         "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
    LS_RESULT_FIELD-WRAPPING      = '02'.         "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
    LS_RESULT_FIELD-REFTYPE       = ''.           "참조필드 유형.(1 = Currency, 2 = Quantity...)
    LS_RESULT_FIELD-REFFIELD      = ''.           "참조필드명.
    LS_RESULT_FIELD-ISNUM_FORMAT  = ''.           "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
    APPEND LS_RESULT_FIELD TO LS_LAYO-RESULT_FIELD.
    CLEAR : LS_RESULT_FIELD.

    CALL METHOD /U4A/CL_F4_HNADL=>F4_SEARCH_HELP_DYNAMIC2
      EXPORTING
        IO_VIEW            = AR_VIEW               " [U4A] UI Element Super Class
        I_SEVENT_NAME      = 'EV_KOSTL_F4_RET'     " CALL BACK 서버 이벤트 명
        IS_DYN_F4LAYO_CONF = LS_LAYO               " F4 엔트리 컨피그레이션
        IT_DATA            = LT_KOSTL.             " 출력 정보 인터널 테이블 값


  ENDMETHOD.


  METHOD KOSTL_F4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            kokrs TYPE cskt-kokrs,
            kostl TYPE cskt-kostl,
            ltext TYPE cskt-ltext,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.
    DATA lr_kokrs TYPE RANGE OF cskt-kokrs.

    zcl_pm_util=>ranges_convert( EXPORTING low     = i_kokrs
                                 CHANGING  et_data = lr_kokrs ).

    SELECT * FROM cskt
      INTO CORRESPONDING FIELDS OF TABLE lt_list
      WHERE spras = sy-langu
        AND kokrs IN lr_kokrs
        AND datbi = '99991231'.

    APPEND VALUE #( fname = 'KOKRS' label = '관리회계 영역' issh = 'X' nozero = 'X' initvalue = i_kokrs ) TO lt_info.
    APPEND VALUE #( fname = 'KOSTL' label = '코스트 센터' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'LTEXT' label = '코스트 센터명' issh = 'X' nozero = '' ) TO lt_info.
*
*    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic
*      EXPORTING
*        io_view                      = ar_view
*        i_draggable                  = abap_true
*        i_resizable                  = abap_true
*        i_width                      = '666px'
*        i_title                      = TEXT-010
*        i_sevent_name                = 'EV_KOSTL_F4_RET'
*        it_fld_info                  = lt_info
*        it_data                      = lt_list
*      EXCEPTIONS
*        process_stru_does_not_format = 1
*        data_does_not_exist          = 2
*        field_type_not_allowed       = 3
*        columns_exceeded             = 4
*        row_exceeded                 = 5
*        OTHERS                       = 6.

    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = TEXT-010
        i_sevent_name = 'EV_KOSTL_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.


  ENDMETHOD.


  METHOD lease_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            ls_fg TYPE ddtext,
            code  TYPE but000-partner,
            text  TYPE ddtext,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.
    DATA lv_title TYPE string.
    DATA: BEGIN OF ls_kostl ,
            partner TYPE but000-partner,
            kostl   TYPE kostl,
          END OF ls_kostl.
    DATA lt_kostl LIKE TABLE OF ls_kostl.


    CASE i_flag.
      WHEN '1'.
        lv_title = TEXT-015.
        SELECT '대내' AS ls_fg,
               objid AS code,
               stext AS text
          FROM hrp1000
          INTO TABLE @lt_list
          WHERE plvar = '01'
            AND otype = 'O'
            AND istat = '1'
            AND begda <= @sy-datum
            AND endda >= @sy-datum
            AND langu = @sy-langu.
      WHEN '2'.
        lv_title = TEXT-016.

        SELECT '대외' AS ls_fg, "#EC CI_NOFIELD
               partner AS code,
               name_org1 AS text
          FROM but000
          INTO TABLE @lt_list
          WHERE bu_group = 'ZF01'
            AND xdele = ''.
        IF lt_list IS NOT INITIAL.
          SELECT a~partner, lpad( a~name_org4, 10, '0' ) AS kostl
            FROM but000 AS a
            JOIN @lt_list AS b
              ON a~partner EQ b~code
            INTO TABLE @lt_kostl.
          SORT lt_kostl BY partner.
          IF lt_kostl IS NOT INITIAL.
            SELECT * FROM cskt
              INTO TABLE @DATA(lt_cskt)
              FOR ALL ENTRIES IN @lt_kostl
              WHERE kostl = @lt_kostl-kostl
                AND spras = @sy-langu.
            SORT lt_cskt BY kostl.
          ENDIF.
          LOOP AT lt_list ASSIGNING FIELD-SYMBOL(<fs>).
            DATA(lv_seq) = sy-tabix.
            READ TABLE lt_kostl INTO ls_kostl WITH KEY partner = <fs>-code BINARY SEARCH.
            IF sy-subrc = 0.
              READ TABLE lt_cskt WITH KEY kostl = ls_kostl-kostl BINARY SEARCH TRANSPORTING NO FIELDS.
              IF sy-subrc = 0.
                DELETE lt_list INDEX lv_seq.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.


      WHEN OTHERS.
        RETURN.
    ENDCASE.


    APPEND VALUE #( fname = 'LS_FG' label = '대내외구분' issh = '' nozero = 'X' initvalue = '' ) TO lt_info.
    APPEND VALUE #( fname = 'CODE' label = '임차기관 코드' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'TEXT' label = '임차기관 내역' issh = 'X' nozero = '' ) TO lt_info.

    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = lv_title
        i_sevent_name = i_sevent_name
        it_fld_info   = lt_info
        it_data       = lt_list.

  ENDMETHOD.


  METHOD lifnr_f4.

    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
    DATA: BEGIN OF ls_list ,
            lifnr TYPE lfa1-lifnr,
            name1 TYPE lfa1-name1,
          END OF ls_list.
    DATA lt_list LIKE TABLE OF ls_list.

    SELECT * FROM lfa1
      WHERE ktokk NE 'E3'
      INTO CORRESPONDING FIELDS OF TABLE @lt_list.

    APPEND VALUE #( fname = 'LIFNR' label = '거래처코드' issh = 'X' nozero = 'X' ) TO lt_info.
    APPEND VALUE #( fname = 'NAME1' label = '거래처명' issh = 'X' nozero = '' ) TO lt_info.


    CALL METHOD zcl_pm_ui5=>search_help
      EXPORTING
        io_view       = ar_view
        i_title       = TEXT-023
        i_sevent_name = 'EV_LIFNR_F4_RET'
        it_fld_info   = lt_info
        it_data       = lt_list.

  ENDMETHOD.


  METHOD pernr_f4.

**    DATA: BEGIN OF ls_list,
**            pernr TYPE pa0001-pernr,
**            ename TYPE pa0001-ename,
**          END OF ls_list.
**    DATA lt_list LIKE TABLE OF ls_list.
**    DATA lt_info TYPE /u4a/cl_f4_hnadl=>gtt_fld_info.
**
**    SELECT pernr ename FROM pa0001
**      INTO TABLE lt_list
**      WHERE begda <= sy-datum
**        AND endda >= sy-datum.
**
**    APPEND VALUE #( fname = 'PERNR' label = '사원번호' issh = 'X' nozero = 'X' ) TO lt_info.
**    APPEND VALUE #( fname = 'ENAME' label = '성명' issh = 'X' nozero = '' ) TO lt_info.
**
**    CALL METHOD zcl_pm_ui5=>search_help
**      EXPORTING
**        io_view       = ar_view
**        i_title       = TEXT-001
**        i_sevent_name = i_sevent_name
**        it_fld_info   = lt_info
**        it_data       = lt_list.
*    DEFINE __free.
*      FREE: &1.
*      CLEAR: &1.
*    END-OF-DEFINITION.
*
*    TYPES:
**--  업무담당자 팝업 구조 .
*      BEGIN OF ty_persno,
*        pernr       TYPE zfit1010-persno,   " 담당자 .
*        ename       TYPE pa0001-ename,      " 담당자 명 .
*        email       TYPE pa0105-usrid,      " 이메일 .
*        contact_num TYPE pa0105-usrid_long, " 전화번호 .
*        oldid       TYPE pa0105-usrid,      " 통합사번 .
*      END OF ty_persno .
*
*    DATA: ls_layo TYPE /u4a/cl_f4_hnadl=>ty_dyn_f4layo_conf.
*
*    DATA: ls_search_field TYPE /u4a/cl_f4_hnadl=>ty_set_dyn_search_layo, "검색조건 필드 정보.
*          ls_result_field TYPE /u4a/cl_f4_hnadl=>ty_set_dyn_result_layo. "결과리스트 COLUMN 필드 정보.
*
*    DATA: lt_persno TYPE TABLE OF ty_persno.
*
*    DATA: lv_msg TYPE string.
*
*    CONSTANTS: lc_0010 TYPE c LENGTH 4 VALUE '0010',
*               lc_9040 TYPE c LENGTH 4 VALUE '9040',
*               lc_0001 TYPE c LENGTH 4 VALUE '0001'.
*
**--------------------------------------------------------------------*
*
*    " 업무담당자 정보 조회 .
*    SELECT a~pernr      AS pernr,
*           a~ename      AS ename,
*           b~usrid_long AS email,
*           c~usrid      AS contact_num,
*           d~usrid      AS oldid
*      INTO CORRESPONDING FIELDS OF TABLE @lt_persno
*      FROM pa0001 AS a  LEFT JOIN pa0105 AS b
*                               ON a~pernr EQ b~pernr
*                              AND b~usrty EQ @lc_0010
*                        LEFT JOIN pa0105 AS c
*                               ON a~pernr EQ c~pernr
*                              AND c~usrty EQ @lc_9040
*                        LEFT JOIN pa0105 AS d
*                               ON a~pernr EQ d~pernr
*                              AND d~usrty EQ @lc_0001
*     WHERE a~begda  LE @sy-datum
*       AND a~endda  EQ @zif_fi_common=>gc_endda.
*
*
*    " 이메일, 연락번호 모두 없는 데이터 삭제 .
*    DELETE lt_persno WHERE contact_num IS INITIAL
*                       AND email       IS INITIAL.
*
*    IF lt_persno[] IS INITIAL.
*
*      " 데이터가 없습니다.
**      MESSAGE e008 INTO lv_msg.
*      lv_msg = TEXT-024.
*
*      CALL METHOD /u4a/cl_utilities=>m_messagetoast
*        EXPORTING
*          io_view    = ar_view                         " [U4A] UI Element Super Class
*          i_msgtx    = lv_msg                         " MESSAGE TEXT
*          i_duration = 10000.
*
*      EXIT.
*
*    ENDIF.
*
*
**-- F4 HELP DYNAMIC LAYOUT 정보 설정.
*    CALL METHOD zcl_ck_u4a_common=>set_f4_dyn_layo_02
*      EXPORTING
*        iv_width    = '800PX'          " F4 팝업 넓이(500px, 60%)
*        iv_height   = ''          " F4 팝업 높이(500px, 60%)
*        iv_title    = '담당자'         " 팝업 TITLE
*        iv_multsel  = '00'             " 결과리스트 멀티선택 여부(예: 00 = DEFAULT 단일선택, 01 = 멀티선택, 02 = 단일선택 )
*        iv_expanded = '00'             " 검색조건 영역 펼침 처리 여부(예: 00 = DEFAULT 펼침, 01 = 펼침, 02 = 접힘 )
*      CHANGING
*        cs_layo     = ls_layo.          " F4_SEARCH_HELP_DYNAMIC2 CONFIG 구조
*
*
**-- 검색조건 필드 설정.
*    ls_search_field-fname        = 'PERNR'.           "필드명
*    ls_search_field-label        = '담당자'.           "라벨
*    ls_search_field-initvalue    = ''.                 "조회조건 Init Value.
*    ls_search_field-width        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
*    ls_search_field-nozero       = '01'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_search_field-placeholder  = ''.                 "자리 표시자
*    ls_search_field-convexit     = ''.                 "Conversion routine (예: ALPHA )
*    ls_search_field-enable       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
*    ls_search_field-isfocus      = '00'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
*    ls_search_field-visible      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_search_field-align        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
*    ls_search_field-reftype      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_search_field-reffield     = ''.                 "참조필드명.
*    ls_search_field-isnum_format = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_search_field TO ls_layo-search_field.
*    __free: ls_search_field.
*
*    ls_search_field-fname        = 'ENAME'.           "필드명
*    ls_search_field-label        = '담당자명'.         "라벨
*    ls_search_field-initvalue    = ''.                 "조회조건 Init Value.
*    ls_search_field-width        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
*    ls_search_field-nozero       = '00'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_search_field-placeholder  = ''.                 "자리 표시자
*    ls_search_field-convexit     = ''.                 "Conversion routine (예: ALPHA )
*    ls_search_field-enable       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
*    ls_search_field-isfocus      = '01'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
*    ls_search_field-visible      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_search_field-align        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
*    ls_search_field-reftype      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_search_field-reffield     = ''.                 "참조필드명.
*    ls_search_field-isnum_format = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_search_field TO ls_layo-search_field.
*    __free: ls_search_field.
*
*    ls_search_field-fname        = 'CONTACT_NUM'.      "필드명
*    ls_search_field-label        = '전화번호'.         "라벨
*    ls_search_field-initvalue    = ''.                 "조회조건 Init Value.
*    ls_search_field-width        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
*    ls_search_field-nozero       = '00'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_search_field-placeholder  = ''.                 "자리 표시자
*    ls_search_field-convexit     = ''.                 "Conversion routine (예: ALPHA )
*    ls_search_field-enable       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
*    ls_search_field-isfocus      = '00'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
*    ls_search_field-visible      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_search_field-align        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
*    ls_search_field-reftype      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_search_field-reffield     = ''.                 "참조필드명.
*    ls_search_field-isnum_format = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_search_field TO ls_layo-search_field.
*    __free: ls_search_field.
*
*    ls_search_field-fname        = 'EMAIL'.            "필드명
*    ls_search_field-label        = '이메일'.           "라벨
*    ls_search_field-initvalue    = ''.                 "조회조건 Init Value.
*    ls_search_field-width        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
*    ls_search_field-nozero       = '00'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_search_field-placeholder  = ''.                 "자리 표시자
*    ls_search_field-convexit     = ''.                 "Conversion routine (예: ALPHA )
*    ls_search_field-enable       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
*    ls_search_field-isfocus      = '00'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
*    ls_search_field-visible      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_search_field-align        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
*    ls_search_field-reftype      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_search_field-reffield     = ''.                 "참조필드명.
*    ls_search_field-isnum_format = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_search_field TO ls_layo-search_field.
*    __free: ls_search_field.
*
*    ls_search_field-fname        = 'OLDID'.            "필드명
*    ls_search_field-label        = '통합사번'.         "라벨
*    ls_search_field-initvalue    = ''.                 "조회조건 Init Value.
*    ls_search_field-width        = ''.                 "조회조건 입력필드 길이 *경고 : 단위 px,%,em 예:100%, 50px...반드시 준수
*    ls_search_field-nozero       = '00'.               "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_search_field-placeholder  = ''.                 "자리 표시자
*    ls_search_field-convexit     = ''.                 "Conversion routine (예: ALPHA )
*    ls_search_field-enable       = '00'.               "input field 입력 가능 여부(예: 00 = DEFAULT 입력가능, 01 = 입력 가능, 02 = 입력 불가)
*    ls_search_field-isfocus      = '00'.               "검색조건 FOCUS 여부(예: 00 = DEFAULT 처리 안함, 01 = FOCUS 처리, 02 = FOCUS 처리 안함)
*    ls_search_field-visible      = '00'.               "검색조건 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_search_field-align        = '00'.               "검색조건 입력필드 좌, 우 정렬(예: 00 = DEFAULT Initial)
*    ls_search_field-reftype      = ''.                 "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_search_field-reffield     = ''.                 "참조필드명.
*    ls_search_field-isnum_format = '00'.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_search_field TO ls_layo-search_field.
*    __free: ls_search_field.
*
*
**-- 결과리스트 COLUMN 설정.
*
*    " 담당자 .
*    ls_result_field-fname         = 'PERNR'.         "필드명
*    ls_result_field-label         = '담당자'.         "라벨
*    ls_result_field-width         = '80PX'.               "column width (EX:10px,30%...)
*    ls_result_field-mwidth        = ''.               "컬럼 최소 width(100)
*    ls_result_field-nozero        = '00'.             "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_result_field-convexit      = ''.               "Conversion routine (예: ALPHA )
*
*    ls_result_field-isfix_col     = '00'.             "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
*    ls_result_field-col_align     = '02'.             "컬럼 ALIGN(예: 00 = DEFAULT Begin).
*    ls_result_field-txt_align     = '02'.             "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)
*
*    ls_result_field-visible       = '00'.             "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_result_field-resizable     = '00'.             "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
*    ls_result_field-filter_option = '00'.             "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
*    ls_result_field-enable_filter = '01'.             "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
*    ls_result_field-enable_sorter = '01'.             "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
*    ls_result_field-wrapping      = '02'.             "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
*    ls_result_field-reftype       = ''.               "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_result_field-reffield      = ''.               "참조필드명.
*    ls_result_field-isnum_format  = ''.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_result_field TO ls_layo-result_field.
*    CLEAR ls_result_field.
*
*    " 담당자명 .
*    ls_result_field-fname         = 'ENAME'.         "필드명
*    ls_result_field-label         = '담당자명'.       "라벨
*    ls_result_field-width         = '120PX'.               "column width (EX:10px,30%...)
*    ls_result_field-mwidth        = ''.               "컬럼 최소 width(100)
*    ls_result_field-nozero        = '00'.             "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_result_field-convexit      = ''.               "Conversion routine (예: ALPHA )
*
*    ls_result_field-isfix_col     = '00'.             "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
*    ls_result_field-col_align     = '02'.             "컬럼 ALIGN(예: 00 = DEFAULT Begin).
*    ls_result_field-txt_align     = '02'.             "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)
*
*    ls_result_field-visible       = '00'.             "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_result_field-resizable     = '00'.             "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
*    ls_result_field-filter_option = '00'.             "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
*    ls_result_field-enable_filter = '01'.             "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
*    ls_result_field-enable_sorter = '01'.             "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
*    ls_result_field-wrapping      = '02'.             "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
*    ls_result_field-reftype       = ''.               "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_result_field-reffield      = ''.               "참조필드명.
*    ls_result_field-isnum_format  = ''.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_result_field TO ls_layo-result_field.
*    CLEAR ls_result_field.
*
*    " 전화번호 .
*    ls_result_field-fname         = 'CONTACT_NUM'.    "필드명
*    ls_result_field-label         = '전화번호'.       "라벨
*    ls_result_field-width         = '150PX'.               "column width (EX:10px,30%...)
*    ls_result_field-mwidth        = ''.               "컬럼 최소 width(100)
*    ls_result_field-nozero        = '00'.             "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_result_field-convexit      = ''.               "Conversion routine (예: ALPHA )
*
*    ls_result_field-isfix_col     = '00'.             "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
*    ls_result_field-col_align     = '02'.             "컬럼 ALIGN(예: 00 = DEFAULT Begin).
*    ls_result_field-txt_align     = '02'.             "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)
*
*    ls_result_field-visible       = '00'.             "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_result_field-resizable     = '00'.             "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
*    ls_result_field-filter_option = '00'.             "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
*    ls_result_field-enable_filter = '01'.             "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
*    ls_result_field-enable_sorter = '01'.             "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
*    ls_result_field-wrapping      = '02'.             "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
*    ls_result_field-reftype       = ''.               "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_result_field-reffield      = ''.               "참조필드명.
*    ls_result_field-isnum_format  = ''.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_result_field TO ls_layo-result_field.
*    CLEAR ls_result_field.
*
*    " 이메일 .
*    ls_result_field-fname         = 'EMAIL'.          "필드명
*    ls_result_field-label         = '이메일'.         "라벨
*    ls_result_field-width         = ''.               "column width (EX:10px,30%...)
*    ls_result_field-mwidth        = ''.               "컬럼 최소 width(100)
*    ls_result_field-nozero        = '00'.             "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_result_field-convexit      = ''.               "Conversion routine (예: ALPHA )
*
*    ls_result_field-isfix_col     = '00'.             "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
*    ls_result_field-col_align     = '02'.             "컬럼 ALIGN(예: 00 = DEFAULT Begin).
*    ls_result_field-txt_align     = '02'.             "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)
*
*    ls_result_field-visible       = '00'.             "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_result_field-resizable     = '00'.             "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
*    ls_result_field-filter_option = '00'.             "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
*    ls_result_field-enable_filter = '01'.             "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
*    ls_result_field-enable_sorter = '01'.             "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
*    ls_result_field-wrapping      = '02'.             "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
*    ls_result_field-reftype       = ''.               "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_result_field-reffield      = ''.               "참조필드명.
*    ls_result_field-isnum_format  = ''.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_result_field TO ls_layo-result_field.
*    CLEAR ls_result_field.
*
*    ls_result_field-fname         = 'OLDID'.          "필드명
*    ls_result_field-label         = '통합사번'.         "라벨
*    ls_result_field-width         = '80PX'.               "column width (EX:10px,30%...)
*    ls_result_field-mwidth        = ''.               "컬럼 최소 width(100)
*    ls_result_field-nozero        = '00'.             "Value Nozero(예: 00 = DEFAULT 처리 안함, 01 = 처리함, 02 = 처리안함 )
*    ls_result_field-convexit      = ''.               "Conversion routine (예: ALPHA )
*
*    ls_result_field-isfix_col     = '00'.             "결과리스트 컬럼 고정여부(예: 00 = DEFAULT 고정안함, 01 = 고정 처리, 02 = 고정 처리 안함)
*    ls_result_field-col_align     = '02'.             "컬럼 ALIGN(예: 00 = DEFAULT Begin).
*    ls_result_field-txt_align     = '02'.             "결과리스트 CELL의 TEXT 좌, 우 정렬(예: 00 = DEFAULT Initial)
*
*    ls_result_field-visible       = '00'.             "결과리스트 컬럼 활성 여부(예: 00 = DEFAULT 활성, 01 = 활성 처리, 02 = 활성 처리 안함)
*    ls_result_field-resizable     = '00'.             "컬럼 RESIZE 가능 여부(예: 00 = DEFAULT RESIZE가능, 01 = RESIZE가능, 02 = RESIZE불가)
*    ls_result_field-filter_option = '00'.             "결과리스트 필터 OPTION(예: 00 = DEFAULT CP)
*    ls_result_field-enable_filter = '01'.             "결과리스트 FILTER 사용 여부(예: 00 = DEFAULT FILTERT사용, 01 = FILTERT사용, 02, FILTERT사용안함)
*    ls_result_field-enable_sorter = '01'.             "결과리스트 SORTER 사용 여부(예: 00 = DEFAULT SORTER사용, 01 = SORTER사용, 02, SORTER사용안함)
*    ls_result_field-wrapping      = '02'.             "결과리스트 CELL의 TEXT WRAPPING 처리 여부(예: 00 = DEFAULT 처리함, 01 = 처리함, 02 = 처리안함)
*    ls_result_field-reftype       = ''.               "참조필드 유형.(1 = Currency, 2 = Quantity...)
*    ls_result_field-reffield      = ''.               "참조필드명.
*    ls_result_field-isnum_format  = ''.               "ABAP TYPE이 숫자 TYPE인경우 1,000 형식으로 표현할지 여부(예: 00 = DEFAULT 사용안함, 01 = 사용함, 02 = 사용안함)
*    APPEND ls_result_field TO ls_layo-result_field.
*    CLEAR ls_result_field.
*
*
*    " 업무담당자 팝업 호출 .
*    CALL METHOD /u4a/cl_f4_hnadl=>f4_search_help_dynamic2
*      EXPORTING
*        io_view            = ar_view                     " [U4A] UI Element Super Class
*        i_sevent_name      = i_sevent_name         " CALL BACK 서버 이벤트 명
*        is_dyn_f4layo_conf = ls_layo                     " F4 엔트리 컨피그레이션
*        it_data            = lt_persno.                  " 출력 정보 인터널 테이블 값

  ENDMETHOD.


  METHOD search_help.

    DATA ls_f4layo_conf TYPE /u4a/cl_f4_hnadl=>ty_f4layo_conf.
    DATA ls_dyn_f4layo_conf TYPE /u4a/cl_f4_hnadl=>ty_dyn_f4layo_conf.
    DATA ls_dyn_search LIKE LINE OF ls_dyn_f4layo_conf-search_field.
    DATA ls_dyn_result LIKE LINE OF ls_dyn_f4layo_conf-result_field.
    DATA ls_search_field LIKE LINE OF ls_f4layo_conf-search_field.
    DATA ls_result_field LIKE LINE OF ls_f4layo_conf-result_field.

    DATA : l_shlp_def TYPE dd30v-shlpname,
           lt_shlp    TYPE shlp_desct,
           ls_shlp    TYPE shlp_descr.

    IF i_shlpname IS NOT INITIAL.

      zcl_ck_u4a_common=>set_f4_dic_layo_02(
        EXPORTING
          iv_width       = i_width
          iv_height      = i_height
          iv_title       = i_title
          iv_selmult     = '00'
          iv_auto_search = '00'
        CHANGING
          cs_layo        = ls_f4layo_conf
      ).

      ls_f4layo_conf-f4gen_info-maxhit_inp_conf-maxhits = '9999999'.
      ls_f4layo_conf-f4gen_info-maxhit_inp_conf-hit_limit = '0'.

      LOOP AT it_fld_info INTO DATA(ls_info).

        ls_search_field-field_label = ls_info-label.
        ls_search_field-shlpname  = i_shlpname.
        ls_search_field-shlpfield = ls_info-fname.
        ls_search_field-initvalue = ls_info-initvalue.

        IF ls_info-issh IS NOT INITIAL.
          ls_search_field-visible = '01'.
        ELSE.
          ls_search_field-visible = '02'.
        ENDIF.

        CASE i_shlpname.
          WHEN 'ZH_PERS_NO'.
            l_shlp_def = i_shlpname.
            CALL FUNCTION 'DD_SHLP_RUNTIME_GET'
              EXPORTING
                shlpname   = l_shlp_def
              TABLES
                fielddescr = ls_shlp-fielddescr[]
              EXCEPTIONS
                not_found  = 1. ##FM_SUBRC_OK

            LOOP AT ls_shlp-fielddescr INTO DATA(ls_fld) WHERE fieldname = ls_search_field-shlpfield.
              CHECK ls_fld-domname IS NOT INITIAL.
              SELECT domvalue_l, ddtext FROM dd07t
                INTO TABLE @ls_search_field-values
                WHERE domname = @ls_fld-domname
                  AND ddlanguage = @sy-langu.
              IF ls_search_field-values IS NOT INITIAL.
                ls_search_field-uityp = '01'.
              ENDIF.
            ENDLOOP.
          WHEN OTHERS.
        ENDCASE.

        APPEND ls_search_field TO ls_f4layo_conf-search_field.
        CLEAR ls_search_field.


        ls_result_field-shlpname  = i_shlpname.
        ls_result_field-shlpfield = ls_info-fname.
        ls_result_field-field_label = ls_info-label.
        APPEND ls_result_field TO ls_f4layo_conf-result_field.
        CLEAR ls_result_field.

      ENDLOOP.

      /u4a/cl_f4_hnadl=>f4_search_help2(
        io_view        = io_view
        i_shlpname     = i_shlpname
        i_sevent_name  = i_sevent_name
        is_f4layo_conf = ls_f4layo_conf
      ).


    ELSE.
      zcl_ck_u4a_common=>set_f4_dyn_layo_02(
        EXPORTING
          iv_width    = i_width
          iv_height   = i_height
          iv_title    = i_title
          iv_multsel  = '00'
          iv_expanded = '00'
        CHANGING
          cs_layo     = ls_dyn_f4layo_conf
      ).

      ls_dyn_f4layo_conf-f4gen_info-operator_cond_conf-selected = '01'.

      LOOP AT it_fld_info INTO ls_info.
        ls_dyn_search-label = ls_info-label.
        ls_dyn_search-fname = ls_info-fname.
        ls_dyn_search-initvalue = ls_info-initvalue.
        ls_dyn_search-convexit = ls_info-convexit.
        IF ls_info-issh IS NOT INITIAL.
          ls_dyn_search-visible = '01'.
        ELSE.
          ls_dyn_search-visible = '02'.
        ENDIF.
        IF ls_info-nozero IS NOT INITIAL.
          ls_dyn_search-nozero = '01'.
        ELSE.
          ls_dyn_search-nozero = '02'.
        ENDIF.
        APPEND ls_dyn_search TO ls_dyn_f4layo_conf-search_field.
        CLEAR ls_dyn_search.


        ls_dyn_result-label = ls_info-label.
        ls_dyn_result-fname = ls_info-fname.
        IF ls_info-nozero IS NOT INITIAL.
          ls_dyn_result-nozero = '01'.
          ls_dyn_result-convexit = 'ALPHA'.
        ENDIF.
        APPEND ls_dyn_result TO ls_dyn_f4layo_conf-result_field.
        CLEAR ls_dyn_result.
      ENDLOOP.


      /u4a/cl_f4_hnadl=>f4_search_help_dynamic2(
        EXPORTING
          io_view                      = io_view
          i_sevent_name                = i_sevent_name
          is_dyn_f4layo_conf           = ls_dyn_f4layo_conf
          it_data                      = it_data
        EXCEPTIONS
          process_stru_does_not_format = 1
          data_does_not_exist          = 2
          field_type_not_allowed       = 3
          OTHERS                       = 4
      ).
    ENDIF.


  ENDMETHOD.


  method TITLE_COUNT.

    RV_TXT = | [ 총 { iv_cnt } 건 ]|.


  endmethod.


  METHOD uitable_config.

    DATA lo_table TYPE REF TO /u4a/cl_uo01139.  "ui.table
    DATA lo_column TYPE REF TO /u4a/cl_uo01127.  "Column
    DATA lo_text TYPE REF TO /u4a/cl_uo00452.
    DATA lo_link TYPE REF TO /u4a/cl_uo00324.
    DATA lv_index TYPE int4 VALUE '-1'.
    DATA lt_script TYPE string_table.
    DATA lo_control TYPE REF TO /u4a/if_server.
    DATA lv_fld TYPE string.
    DATA lv_etc TYPE string.
    DATA lv_value TYPE string.
    DATA lo_ui TYPE REF TO /u4a/cl_ui_element.
    DATA lo_title TYPE REF TO /u4a/cl_uo01726.

*    DATA lo_app TYPE REF TO object.
*    DATA(lv_ref) = ar_view->appid+0(1) && 'CL_U4A_APP_' && ar_view->appid+1(*).
*
*    CREATE OBJECT lo_app TYPE (lv_ref).

    lo_table ?= ar_view->get_ui_instance( tid ).
    CHECK lo_table IS NOT INITIAL.

    lo_control = ar_view->control.

    " 테이블 Sort 초기화 .
    CALL METHOD /u4a/cl_utilities=>reset_uitable_sort
      EXPORTING
        io_view = ar_view
        i_tabnm = tid.


    " 테이블 Filter 초기화 .
    CALL METHOD /u4a/cl_utilities=>reset_uitable_filter
      EXPORTING
        io_view = ar_view
        i_tabnm = tid.


    LOOP AT lo_table->child INTO DATA(ls_child).

      CHECK ls_child->uiobk = 'UO01127'. "Column
      lo_column ?= ls_child.

      CLEAR : lv_etc, lv_value.
      LOOP AT lo_column->child INTO DATA(ls_colm).

        CASE ls_colm->uiobk.
          WHEN 'UO00452'.
            lo_text ?= ls_colm.
            SPLIT lo_text->bp00452_text AT ',' INTO lv_fld lv_etc.
            SPLIT lv_fld AT '-' INTO lv_etc lv_value.
          WHEN 'UO00324'.
            lo_link ?= ls_colm.
            SPLIT lo_link->bp00324_text AT ',' INTO lv_fld lv_etc.
            SPLIT lv_fld AT '-' INTO lv_etc lv_value.
          WHEN OTHERS.
        ENDCASE.

        IF lv_value IS NOT INITIAL.
          lo_ui ?= ls_colm.
          READ TABLE lo_ui->at_addt_binfo INTO DATA(ls_binfo) INDEX 1.
          IF sy-subrc = 0.
            IF ls_binfo-reffd IS NOT INITIAL.
              DATA(lv_st_n) = 'X'.
            ENDIF.
          ENDIF.
        ENDIF.

      ENDLOOP.

      IF lv_value IS NOT INITIAL.
        IF ft_yn IS NOT INITIAL.
          lo_column->setfilterproperty( lv_value ).
        ENDIF.
        IF st_yn IS NOT INITIAL AND lv_st_n IS INITIAL.
          lo_column->setsortproperty( lv_value ).
        ENDIF.
      ENDIF.
      CLEAR lv_st_n.
**
**      IF lo_column->pp01127_visible = 'false'.
**        RETURN.
**      ENDIF.
**
**      IF auto_width IS NOT INITIAL.
**
**      ENDIF.

    ENDLOOP.
    IF rows IS NOT INITIAL.
      lo_table->setvisiblerowcount( rows ).
    ENDIF.

*    /u4a/cl_utilities=>set_freestyle_script(
*      io_view   = ar_view
*      it_script = lt_script
*    ).

  ENDMETHOD.
ENDCLASS.
