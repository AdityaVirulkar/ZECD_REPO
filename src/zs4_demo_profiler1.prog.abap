REPORT zs4_demo_profiler1.

PARAMETERS: p_date TYPE sy-datum.

TYPES:
  BEGIN OF ty_vbuk,
    v_mandt  TYPE vbuk-mandt,
    v_vbeln  TYPE vbuk-vbeln,
    v_rfstk  TYPE vbuk-rfstk,
    v_vrfgsk TYPE vbuk-rfgsk,
    v_bestk  TYPE vbuk-bestk,
  END OF ty_vbuk.

DATA: lv_date      TYPE sy-datum,
      lv_weekday   TYPE c LENGTH 10,
      lv_shorttext TYPE char2,
      lv_longtext  TYPE char20,
      lo_vbuk      TYPE TABLE OF ty_vbuk,
      lv_knumv     TYPE knumv,
      lv_vbeln     TYPE vbeln.

SELECT-OPTIONS : s_knumv FOR lv_knumv.

lv_date = p_date.

*-----Case 1 - Obsolete FM Replacement-----*
"DATE_TO_DAY
CALL FUNCTION 'DATE_TO_DAY'
EXPORTING
    date    = lv_date
  IMPORTING
    weekday = lv_weekday.

**-----Case 2 - Tables no longer use in S/4 systems-----*

"KONV (also a pool/cluster table impacted in HANA DB)
SELECT SINGLE * FROM konv INTO @DATA(it_konv) WHERE knumv IN @s_knumv.

*-----Case 3 - T881 Table-----*

SELECT SINGLE curt1 FROM t881 INTO @DATA(lw_t881) WHERE rldnr = '01'.

DATA wa_ska1 type ska1.
SELECT SINGLE saknr gvtyp INTO wa_ska1 FROM ska1 where saknr = ''.
