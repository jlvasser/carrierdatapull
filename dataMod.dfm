object dmPull: TdmPull
  OldCreateOrder = False
  Height = 219
  Width = 781
  object providerSAFER: TOracleUniProvider
    Left = 120
    Top = 16
  end
  object dbSAFER: TUniConnection
    AutoCommit = False
    ProviderName = 'Oracle'
    SpecificOptions.Strings = (
      'Oracle.Direct=True'
      'Oracle.IPVersion=ivIPBoth')
    Options.KeepDesignConnected = False
    Username = 'READ423'
    Server = 'safer.safersys.org:1526/safer.safersys.org'
    LoginPrompt = False
    Left = 32
    Top = 16
    EncryptedPassword = '8CFF9EFF99FF9AFF8DFFCBFFCDFFCCFF'
  end
  object qryISS: TUniQuery
    SQLRefresh.Strings = (
      'SELECT SAFETY_RATING, RATING_DATE FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_SEQ_NUMBER = :CARRIER_SEQ_NUMBER')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM DOT423.CARRIER'
      ''
      ')')
    DataTypeMap = <
      item
        FieldName = 'USDOTNUM'
        FieldType = ftString
        FieldLength = 8
      end>
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  distinct(LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39')) "USDOTNUM",'
      
        '  NVL(QUANTITY_INSPECTIONS_LAST30, '#39'0'#39') "QUANTITY_INSPECTIONS_LA' +
        'ST30",'
      
        '  NVL(VEHICLE_INSPECTIONS_LAST30,'#39'0'#39') "VEHICLE_INSPECTIONS_LAST3' +
        '0",'
      
        '  NVL(DRIVER_INSPECTIONS_LAST30,'#39'0'#39') "DRIVER_INSPECTIONS_LAST30"' +
        ','
      
        '  NVL(QUANTITY_HAZMAT_PRESENT_LAST30,'#39'0'#39') "QUANTITY_HAZMAT_PRESE' +
        'NT_LAST30",'
      '  NVL(OOS_ALL_TYPES_LAST30,'#39'0'#39') "OOS_ALL_TYPES_LAST30",'
      
        '  NVL(OOS_VEHICLE_INSPECTIONS_LAST30,'#39'0'#39') "OOS_VEHICLE_INSPECTIO' +
        'NS_LAST30",'
      
        '  NVL(OOS_DRIVER_INSPECTIONS_LAST30,'#39'0'#39') "OOS_DRIVER_INSPECTIONS' +
        '_LAST30",'
      '  SAFETY_RATING,'
      '  RATING_DATE,'
      '  NVL(VIOLATION_BRAKES,'#39'0'#39') "VIOLATION_BRAKES",'
      '  NVL(VIOLATION_WHEELS,'#39'0'#39') "VIOLATION_WHEELS",'
      '  NVL(VIOLATION_STEERING,'#39'0'#39') "VIOLATION_STEERING",'
      
        '  NVL(VIOLATION_MEDICAL_CERTIFICATE,'#39'0'#39') "VIOLATION_MEDICAL_CERT' +
        'IFICATE",'
      '  NVL(VIOLATION_LOGS,'#39'0'#39') "VIOLATION_LOGS",'
      '  NVL(VIOLATION_HOURS,'#39'0'#39') "VIOLATION_HOURS",'
      '  NVL(VIOLATION_LICENSE,'#39'0'#39') "VIOLATION_LICENSE",'
      '  NVL(VIOLATION_DRUGS,'#39'0'#39') "VIOLATION_DRUGS",'
      '  NVL(VIOLATION_TRAFFIC,'#39'0'#39') "VIOLATION_TRAFFIC",'
      '  NVL(VIOLATION_PAPERS,'#39'0'#39') "VIOLATION_PAPERS",'
      '  NVL(VIOLATION_PLACARDS,'#39'0'#39') "VIOLATION_PLACARDS",'
      '  NVL(VIOLATION_OP_EMER_RESP,'#39'0'#39') "VIOLATION_OP_EMER_RESP",'
      '  NVL(VIOLATION_TANK,'#39'0'#39') "VIOLATION_TANK",'
      '  NVL(VIOLATION_OTHER,'#39'0'#39') "VIOLATION_OTHER",'
      
        '  decode(OOS_VEHICLE_INSPECTIONS_LAST30, 0, 0, (OOS_VEHICLE_INSP' +
        'ECTIONS_LAST30 / VEHICLE_INSPECTIONS_LAST30)) "VEHICLE_OOS_RATE"' +
        ','
      
        '  decode(OOS_DRIVER_INSPECTIONS_LAST30, 0, 0, (OOS_DRIVER_INSPEC' +
        'TIONS_LAST30 / DRIVER_INSPECTIONS_LAST30)) "DRIVER_OOS_RATE",'
      
        '  decode(OOS_VEHICLE_INSPECTIONS_LAST30, 0, 0, (OOS_VEHICLE_INSP' +
        'ECTIONS_LAST30 / VEHICLE_INSPECTIONS_LAST30) * 100) "VEHICLE_OOS' +
        '_PERCENT",'
      
        '  decode(OOS_DRIVER_INSPECTIONS_LAST30, 0, 0, (OOS_DRIVER_INSPEC' +
        'TIONS_LAST30 / DRIVER_INSPECTIONS_LAST30) * 100) "DRIVER_OOS_PER' +
        'CENT",'
      
        '  decode(VEHICLE_INSPECTIONS_LAST30, 0, 0, (VIOLATION_BRAKES / V' +
        'EHICLE_INSPECTIONS_LAST30)) "BRAKES_RATE",'
      
        '  decode(VEHICLE_INSPECTIONS_LAST30, 0, 0, (VIOLATION_WHEELS / V' +
        'EHICLE_INSPECTIONS_LAST30)) "WHEEL_RATE",'
      
        '  decode(VEHICLE_INSPECTIONS_LAST30, 0, 0, (VIOLATION_STEERING /' +
        ' VEHICLE_INSPECTIONS_LAST30)) "STEER_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_MEDICAL_CER' +
        'TIFICATE / DRIVER_INSPECTIONS_LAST30)) "MEDICAL_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_LOGS / DRIV' +
        'ER_INSPECTIONS_LAST30)) "LOGS_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_HOURS / DRI' +
        'VER_INSPECTIONS_LAST30)) "HOURS_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_LICENSE / D' +
        'RIVER_INSPECTIONS_LAST30)) "DQ_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_DRUGS / DRI' +
        'VER_INSPECTIONS_LAST30)) "DRUGS_RATE",'
      
        '  decode(DRIVER_INSPECTIONS_LAST30, 0, 0, (VIOLATION_TRAFFIC / D' +
        'RIVER_INSPECTIONS_LAST30)) "TRAFFIC_RATE" ,'
      
        '  decode(QUANTITY_HAZMAT_PRESENT_LAST30, 0, 0, (VIOLATION_PAPERS' +
        ' / QUANTITY_HAZMAT_PRESENT_LAST30)) "HM_PAPER_RATE" ,'
      
        '  decode(QUANTITY_HAZMAT_PRESENT_LAST30, 0, 0, (VIOLATION_PLACAR' +
        'DS / QUANTITY_HAZMAT_PRESENT_LAST30)) "HM_PLAC_RATE" ,'
      
        '  decode(QUANTITY_HAZMAT_PRESENT_LAST30, 0, 0, (VIOLATION_OP_EME' +
        'R_RESP / QUANTITY_HAZMAT_PRESENT_LAST30)) "HM_OPER_RATE" ,'
      
        '  decode(QUANTITY_HAZMAT_PRESENT_LAST30, 0, 0, (VIOLATION_TANK /' +
        ' QUANTITY_HAZMAT_PRESENT_LAST30)) "HM_TANK_RATE" ,'
      
        '  decode(QUANTITY_HAZMAT_PRESENT_LAST30, 0, 0, (VIOLATION_OTHER ' +
        '/ QUANTITY_HAZMAT_PRESENT_LAST30)) "HM_OTHR_RATE"'
      'from'
      '  dot423.CARRIER'
      'where'
      '  ( QUANTITY_INSPECTIONS_LAST30 > 0 or ISS_INDICATOR <> '#39'I'#39' ) '
      ' --and MCMIS_STATUS = '#39'A'#39
      ' and CARRIER_ID_NUMBER = :sDOT')
    Options.TrimVarChar = True
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.LongStrings = False
    Options.RemoveOnRefresh = False
    Left = 109
    Top = 84
    ParamData = <
      item
        DataType = ftString
        Name = 'sDOT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object qryCarrier: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  LPAD(c.CARRIER_ID_NUMBER,8,'#39'0'#39') "USDOTNUM",'
      '  c.MAIL_STREET "ADDRESS",'
      '  c.MAIL_ZIP_CODE "ZIPCODE",'
      '  c.TELEPHONE_NUMBER "PHONE",'
      
        '  decode(c.ICC_NUMBER_1, null, null, to_char(c.ICC_NUMBER_1,'#39'099' +
        '99999'#39')) "ICC_NUM",'
      
        '  --decode(c.ICC_NUMBER_1, null, null, to_char(c.ICC_NUMBER_1,'#39'0' +
        '99999'#39')) "ICC_NUM",'
      '  c.ISS_SCORE "INSPECTION_VALUE",'
      '  c.ISS_INDICATOR "INDICATOR",'
      '  c.ENTITY_TYPE "ENTITY_TYPE",'
      '  c.MCSIP_LEVEL "MCSIP_STATUS",'
      '  NVL(c.QUANTITY_POWER_UNITS,0) "TOTAL_VEHICLES",'
      '  NVL(c.QUANTITY_DRIVERS,0) "TOTAL_DRIVERS",'
      '  decode(c.CARRIER_INTERSTATE, '#39'1'#39', '#39'A'#39', '
      '  decode(c.CARRIER_INTRASTATE_HM, '#39'1'#39', '#39'B'#39', '
      
        '  decode(c.CARRIER_INTRASTATE_NHM, '#39'1'#39', '#39'C'#39', '#39#39'))) "CARRIER_OPER' +
        'ATION",'
      '  c.COUNTRY "COUNTRY",'
      '  ca.NEW_ENTRANT_CODE "NEW_ENTRANT_CODE",'
      '  ca.PA_UNDELIVERABLE_CODE "UNDELIVERABLE_PA",'
      '  ca.MA_UNDELIVERABLE_CODE "UNDELIVERABLE_MA",'
      '  '#39'A'#39' "STATUS",'
      '  SYSDATE "LAST_UPDATE_DATE",'
      '  ca.POWER_UNIT_FLAG "HAS_POWER_UNITS",'
      '  v.OOS_DATE "OOS_DATE",'
      '  v.OOS_TEXT "OOS_TEXT",'
      '  V.OOS_REASON "OOS_REASON",'
      
        '  NVL(dot423.FN_GET_AUTH_STATUS(c.carrier_id_number),'#39'Not Applic' +
        'able'#39') "OPER_AUTH_STATUS"'
      'from'
      
        '  dot423.CARRIER c, dot423.CARRIER_AUX_1 ca, dot423.V_SAFER_CARR' +
        'IER_MCSIP_OOS v'
      'where'
      '      c.CARRIER_SEQ_NUMBER = ca.CARRIER_SEQ_NUMBER'
      '  and c.CARRIER_ID_NUMBER = v.DOT_NUMBER(+)  '
      '  and c.MCMIS_STATUS = '#39'A'#39
      '')
    FetchRows = 1000
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    AutoCalcFields = False
    Left = 32
    Top = 84
  end
  object qryUCR: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select distinct LPAD(u.dot_number,8,'#39'0'#39') "USDOTNUM",'
      '       SUBSTR(U.BASE_STATE,3,2) "BASE_STATE",'
      '       U.FEE_PAYMENT_FLAG "PAYMENT_FLAG", '
      '       TO_CHAR(U.REGISTRATION_YEAR) "REGISTRATION_YEAR",'
      '       U.FEE_PAYMENT_UPDATE_DATE "PAYMENT_DATE",'
      '       U.INTRASTATE_FLAG "INTRASTATE_VEHICLES"'
      '  from dot423.UCR_REGISTRATION u, dot423.CARRIER c '
      ' where (c.CARRIER_ID_NUMBER = u.DOT_NUMBER) '
      
        '   --and (nvl(c.ICC_NUMBER_1,0) = nvl(u.MC_NUMBER,0)) --why is t' +
        'his here?'
      '   --and c.MCMIS_STATUS = '#39'A'#39
      '   and u.REGISTRATION_YEAR > :iRegYear'
      '   and CARRIER_ID_NUMBER = :sDOT'
      '')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    SpecificOptions.Strings = (
      'Oracle.TemporaryLobUpdate=False')
    Left = 576
    Top = 84
    ParamData = <
      item
        DataType = ftInteger
        Name = 'iRegYear'
        ParamType = ptInput
        Value = nil
      end
      item
        DataType = ftString
        Name = 'sDOT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object qryNAME: TUniQuery
    SQLLock.Strings = (
      'SELECT CARRIER_NAME, MAIL_CITY, MAIL_STATE FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_ID_NUMBER = :Old_CARRIER_ID_NUMBER'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT CARRIER_NAME, MAIL_CITY, MAIL_STATE FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_ID_NUMBER = :CARRIER_ID_NUMBER')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM DOT423.CARRIER'
      ''
      ')')
    Connection = dbSAFER
    SQL.Strings = (
      'select distinct(LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39')) "USDOTNUM",'
      '       LTRIM(CARRIER_NAME) "NAME",'
      '       MAIL_CITY "CITY",'
      '       MAIL_STATE "STATE",'
      '       '#39'1'#39' "NAME_TYPE_ID"'
      '  from dot423.CARRIER'
      ' where CARRIER_ID_NUMBER = :sDOT'
      '   --and MCMIS_STATUS='#39'A'#39)
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    Left = 187
    Top = 84
    ParamData = <
      item
        DataType = ftString
        Name = 'sDOT'
        ParamType = ptInput
        Value = nil
      end>
    object qryNAMEUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 4000
    end
    object qryNAMENAME: TStringField
      FieldName = 'NAME'
      ReadOnly = True
      Size = 120
    end
    object qryNAMECITY: TStringField
      FieldName = 'CITY'
      Size = 25
    end
    object qryNAMESTATE: TStringField
      FieldName = 'STATE'
      FixedChar = True
      Size = 2
    end
    object qryNAMENAME_TYPE_ID: TStringField
      FieldName = 'NAME_TYPE_ID'
      ReadOnly = True
      FixedChar = True
      Size = 32
    end
  end
  object qryNAME2: TUniQuery
    SQLLock.Strings = (
      'SELECT CARRIER_NAME, MAIL_CITY, MAIL_STATE FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_ID_NUMBER = :Old_CARRIER_ID_NUMBER'
      'FOR UPDATE NOWAIT')
    SQLRefresh.Strings = (
      'SELECT CARRIER_NAME, MAIL_CITY, MAIL_STATE FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_ID_NUMBER = :CARRIER_ID_NUMBER')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM DOT423.CARRIER'
      ''
      ')')
    Connection = dbSAFER
    SQL.Strings = (
      'Select distinct(LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39')) "USDOTNUM",'
      '       LTRIM(DBA_NAME) "NAME",'
      '       MAIL_CITY "CITY",'
      '       MAIL_STATE "STATE",'
      '       '#39'2'#39' "NAME_TYPE_ID"'
      '  from dot423.CARRIER'
      ' where DBA_NAME IS NOT NULL'
      '   and CARRIER_ID_NUMBER = :sDOT'
      '   --and MCMIS_STATUS='#39'A'#39)
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    Left = 265
    Top = 84
    ParamData = <
      item
        DataType = ftString
        Name = 'sDOT'
        ParamType = ptInput
        Value = nil
      end>
  end
  object qryHMPermit: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  distinct(LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39')) "USDOTNUM",'
      '  HM_PERMIT_TYPE,'
      '  HM_PERMIT_STATUS,'
      '  HM_PERMIT_EFFECTIVE_DATE,'
      '  HM_PERMIT_EXPIRATION_DATE,'
      '  OPERATING_UNDER_APPEAL_FLAG'
      'from'
      '  dot423.CARRIER '
      'where HM_PERMIT_TYPE IS NOT NULL'
      '  --and MCMIS_STATUS = '#39'A'#39
      '  and CARRIER_ID_NUMBER = :sDOT'
      '')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    Left = 342
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'sDOT'
        Value = nil
      end>
  end
  object qryINS: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select LPAD(c.carrier_id_number,8,'#39'0'#39') "USDOTNUM", '
      '       DECODE(li.LIABILITY_INSURANCE_STATUS,'#39'1'#39', '#39'OK'#39','
      
        '       DECODE(li.LIABILITY_INSURANCE_STATUS,'#39'0'#39','#39'NOT OK'#39')) "LIAB' +
        'ILITY_STATUS",'
      '       li.LIABILITY_INSURANCE_AMOUNT "LIABILITY_REQUIRED",'
      '       DECODE(li.CARGO_INSURANCE_STATUS,'#39'1'#39','#39'OK'#39','
      
        '       DECODE(li.CARGO_INSURANCE_STATUS,'#39'0'#39','#39'NOT OK'#39')) "CARGO_ST' +
        'ATUS",'
      '       DECODE(li.BOND_TRUST_FUND_STATUS,'#39'1'#39','#39'OK'#39','
      
        '       DECODE(li.BOND_TRUST_FUND_STATUS,'#39'0'#39','#39'NOT OK'#39')) "BOND_STA' +
        'TUS", '
      '       li.MEXICAN_TERRITORY "MEX_TERRITORY"'
      '  from dot423.carrier c, dot423.carrier_li_primary li '
      ' where c.ICC_NUMBER_1 = li.docket_number '
      '   and c.carrier_seq_number = li.carrier_seq_number'
      '   --and c.MCMIS_STATUS = '#39'A'#39' '
      '   and CARRIER_ID_NUMBER = :sDOT')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    Left = 420
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'sDOT'
        Value = nil
      end>
  end
  object qryBASICS: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select LPAD(C.CARRIER_ID_NUMBER,8,'#39'0'#39')  "USDOTNUM",'
      '       b.basics_id "BASIC",'
      '       B.BASICS_PERCENTILE "BASICPERCENTILE",'
      '       B.BASICS_DEFICIENCY_IND "BASICSDEFIND",'
      '       B.BASICS_RUN_DATE "BASICSRUNDATE",'
      '       B.INVESTIGATION_DATE "INVESTIGATIONDATE",'
      '       B.ROAD_DISPLAY_TEXT "ROAD_DISPLAY_TEXT",'
      '       B.INVESTIGATION_DISPLAY_TEXT "INVEST_DISPLAY_TEXT",'
      '       B.OVERALL_DISPLAY_TEXT "OVERALL_DISPLAY_TEXT"'
      '  from dot423.CARRIER c, dot423.CARRIER_BASICS_DETAIL b'
      ' where c.CARRIER_ID_NUMBER = b.DOT_NUMBER'
      '   --and c.MCMIS_STATUS = '#39'A'#39' '
      '   and CARRIER_ID_NUMBER = :sDOT')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    Left = 498
    Top = 84
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'sDOT'
        Value = nil
      end>
  end
end
