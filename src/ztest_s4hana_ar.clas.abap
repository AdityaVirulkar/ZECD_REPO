class ZTEST_S4HANA_AR definition
  public
  final
  create public .

public section.

  methods ZHANA_SELECT .
  methods ZS4_SELECT .
protected section.
private section.
ENDCLASS.



CLASS ZTEST_S4HANA_AR IMPLEMENTATION.


METHOD zhana_select.
  TYPES: BEGIN OF ty_demo,
           bukrs TYPE bseg-bukrs,
           gjahr TYPE bseg-gjahr,
           buzei TYPE bseg-buzei,
           buzid TYPE bseg-buzid,
         END OF ty_demo,
         BEGIN OF ty_demo2,
           bukrs TYPE bseg-bukrs,
           belnr TYPE bseg-belnr,
           gjahr TYPE bseg-gjahr,
           buzei TYPE bseg-buzei,
           buzid TYPE bseg-buzid,
         END OF ty_demo2,
         BEGIN OF gv_bseg,
           bukrs TYPE bseg-bukrs,
           belnr TYPE bseg-belnr,
           gjahr TYPE bseg-gjahr,
           buzei TYPE bseg-buzei,
           augbl TYPE bseg-augbl,
           bschl TYPE bseg-bschl,
           koart TYPE bseg-koart,
           shkzg TYPE bseg-shkzg,
           mwskz TYPE bseg-mwskz,
           dmbtr TYPE bseg-dmbtr,
           sgtxt TYPE bseg-sgtxt,
           kostl TYPE bseg-kostl,
           saknr TYPE bseg-saknr,
           hkont TYPE bseg-hkont,
           kunnr TYPE bseg-kunnr,
         END OF gv_bseg,
         BEGIN OF ty_demo3,
           carrid TYPE sflight-carrid,
           fldate TYPE sflight-fldate,
         END OF ty_demo3,
         BEGIN OF ty_demo4,
           carrid TYPE spfli-carrid,
         END OF ty_demo4.
  DATA: ty_bseg    TYPE bseg,
        t_bseg     TYPE TABLE OF bseg,
        lt_bseg    TYPE TABLE OF ty_demo2,
        it_bseg    TYPE TABLE OF ty_demo,
        it_vbfa    TYPE TABLE OF vbfa,
        tt_vbfa    TYPE TABLE OF vbfa,
        tt_vbeln   TYPE vbfa-vbeln,
        ty_vbeln   TYPE vbfa-vbeln,
        ty_vbfa    TYPE vbfa,
        lv_bseg    TYPE TABLE OF gv_bseg,
        t_sflight  TYPE TABLE OF ty_demo3,
        t_spfli    TYPE TABLE OF ty_demo4,
        ty_sf      TYPE ty_demo3,
        ty_sflight TYPE TABLE OF sflight.

  SELECT bukrs
    belnr
    gjahr
    buzei
    augbl
    bschl
    koart
    shkzg
    mwskz
    dmbtr
    sgtxt
    kostl
    saknr
    hkont
    kunnr
    INTO TABLE lv_bseg
    FROM bseg FOR ALL ENTRIES IN t_bseg
    WHERE bukrs EQ t_bseg-bukrs
    AND belnr EQ t_bseg-belnr
    AND gjahr EQ t_bseg-gjahr.

  READ TABLE lt_bseg INTO ty_bseg WITH KEY bukrs = '001'.

  SELECT
    bukrs
    gjahr
    buzei
    buzid
    FROM bseg
    INTO TABLE it_bseg
    FOR ALL ENTRIES IN t_bseg
    WHERE bukrs = t_bseg-bukrs.



  READ TABLE t_bseg INTO ty_bseg WITH KEY bukrs = '001'.

  SELECT
    bukrs
    belnr
    gjahr
    buzei
    buzid
  FROM bseg
    INTO TABLE lt_bseg
    FOR ALL ENTRIES IN it_bseg
  WHERE bukrs = it_bseg-bukrs.

  READ TABLE lt_bseg INTO ty_bseg WITH KEY bukrs = '001'.

  SELECT *
  FROM bseg
    INTO TABLE t_bseg
    FOR ALL ENTRIES IN it_bseg
  WHERE bukrs = it_bseg-bukrs.

  READ TABLE lt_bseg INTO ty_bseg WITH KEY bukrs = '001'.

  SELECT vbeln FROM vbfa INTO TABLE it_vbfa FOR ALL ENTRIES IN tt_vbfa WHERE vbeln = tt_vbfa-vbeln.



  READ TABLE it_vbfa INTO ty_vbfa INDEX 2.


ENDMETHOD.


METHOD zs4_select.
*---------------------------------------------------------------------------------
* S1 - FM case
*---------------------------------------------------------------------------------
  DATA: lv_date      TYPE sy-datum,
        lv_weekday   TYPE c LENGTH 10,
        lv_shorttext TYPE char2,
        lv_longtext  TYPE char20,
        lv_vbeln     TYPE vbeln.

  "ISP_GET_WEEKDAY_NAME

CALL FUNCTION 'ISP_GET_WEEKDAY_NAME'
EXPORTING
    date        = '20210914'
    language    = 'E'
*   WEEKDAY_NUMBER       = ' '
  IMPORTING
*   LANGU_BACK  =
    longtext    = lv_longtext
    shorttext   = lv_shorttext
  EXCEPTIONS
    calendar_id = 1
    date_error  = 2
    not_found   = 3
    wrong_input = 4
    OTHERS      = 5.

  IF sy-subrc <> 0.
    WRITE : / lv_longtext.
  ENDIF.



ENDMETHOD.
ENDCLASS.
