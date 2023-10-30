class ZCL_FORM_001 definition
  public
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces Z2UI5_IF_APP .

  types:
    BEGIN OF ty_s_tab,
        selkz            TYPE abap_bool,
        product          TYPE string,
        create_date      TYPE string,
        create_by        TYPE string,
        storage_location TYPE string,
        quantity         TYPE i,
      END OF ty_s_tab .
  types:
    ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH EMPTY KEY .

  data MV_SEARCH_VALUE type STRING .
  data MT_TABLE type TY_T_TABLE .
protected section.

  data CLIENT type ref to Z2UI5_IF_CLIENT .
  data CHECK_INITIALIZED type ABAP_BOOL .

  methods Z2UI5_ON_INIT .
  methods Z2UI5_ON_EVENT .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_FORM_001 IMPLEMENTATION.


  METHOD Z2UI5_IF_APP~MAIN.

    me->client     = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'BUTTON_SEARCH' OR 'BUTTON_START'.
*        z2ui5_set_data( ).
*        z2ui5_set_search( ).
*        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

      WHEN 'SEARCH'.
        WAIT UP TO 1 SECONDS.
*        client->message_box_display( text = 'this is a message box' type = 'error' ).
*
*        client->message_toast_display( 'this is a message toast' ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    FIELD-SYMBOLS <fo> TYPE REF TO zatu_ui.
    DATA(view) = zatu_ui=>factory( client ).

    DATA(lo_atui) = NEW zatu_ui( ).
    ASSIGN lo_atui TO <fo>.
*    <fo> = view.


    DATA(page1) = view->page( id = `page_main`
            title          = 'abap2UI5 - List Report Features'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = abap_true
            class = 'sapUiContentPadding' ).


**    page1->header_content(
**          )->link(
**              text = 'Demo' target = '_blank'
**              href = 'https://twitter.com/abap2UI5/status/1661642823542747138'
**          )->link(
**              text = 'Source_Code' target = '_blank' href = view->hlp_get_source_code_url(  )
**     ).
**
**
    page1->form(
      )->form_toolbar(
        )->overflow_toolbar(
        )->title( text = 'Title1'
        )->toolbar_spacer(
        )->button( text = 'Button' type = 'Emphasized' press = client->_event( 'SEARCH' )
        )->get_parent( )->get_parent(
      )->form_layout(
        )->form_layout_colm(
        )->get_parent( )->get_parent(
      )->form_containers(
        )->form_container(
          )->form_elements(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text1'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text2'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text3'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text4'
                )->get_parent( )->get_parent( )->get_parent(
          )->form_elements(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text11'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text12'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text13'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text14'
                )->get_parent( )->get_parent( )->get_parent(
          )->form_elements(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text21'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text22'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text23'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text24'
                )->get_parent( )->get_parent( )->get_parent(
          )->form_elements(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text31'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text32'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text33'
                )->get_parent( )->get_parent(
            )->form_element(
              )->form_fields(
                )->input( value = 'Text34'
                )->get_parent( )->get_parent( )->get_parent(
      ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
