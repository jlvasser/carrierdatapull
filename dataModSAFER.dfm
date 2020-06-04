object dmSAFER: TdmSAFER
  OldCreateOrder = False
  Height = 219
  Width = 781
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
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  distinct(CARRIER_ID_NUMBER) "USDOTNUM",'
      '  --distinct(LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39')) "PAD_USDOTNUM",'
      
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
      ' --and CARRIER_ID_NUMBER = :sDOT')
    Options.TrimVarChar = True
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.LongStrings = False
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM'
    Left = 113
    Top = 88
    object qryISSUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 8
    end
    object qryISSQUANTITY_INSPECTIONS_LAST30: TFloatField
      FieldName = 'QUANTITY_INSPECTIONS_LAST30'
      ReadOnly = True
    end
    object qryISSVEHICLE_INSPECTIONS_LAST30: TFloatField
      FieldName = 'VEHICLE_INSPECTIONS_LAST30'
      ReadOnly = True
    end
    object qryISSDRIVER_INSPECTIONS_LAST30: TFloatField
      FieldName = 'DRIVER_INSPECTIONS_LAST30'
      ReadOnly = True
    end
    object qryISSQUANTITY_HAZMAT_PRESENT_LAST30: TFloatField
      FieldName = 'QUANTITY_HAZMAT_PRESENT_LAST30'
      ReadOnly = True
    end
    object qryISSOOS_ALL_TYPES_LAST30: TFloatField
      FieldName = 'OOS_ALL_TYPES_LAST30'
      ReadOnly = True
    end
    object qryISSOOS_VEHICLE_INSPECTIONS_LAST30: TFloatField
      FieldName = 'OOS_VEHICLE_INSPECTIONS_LAST30'
      ReadOnly = True
    end
    object qryISSOOS_DRIVER_INSPECTIONS_LAST30: TFloatField
      FieldName = 'OOS_DRIVER_INSPECTIONS_LAST30'
      ReadOnly = True
    end
    object qryISSSAFETY_RATING: TWideStringField
      FieldName = 'SAFETY_RATING'
      FixedChar = True
      Size = 1
    end
    object qryISSRATING_DATE: TDateTimeField
      FieldName = 'RATING_DATE'
    end
    object qryISSVIOLATION_BRAKES: TFloatField
      FieldName = 'VIOLATION_BRAKES'
      ReadOnly = True
    end
    object qryISSVIOLATION_WHEELS: TFloatField
      FieldName = 'VIOLATION_WHEELS'
      ReadOnly = True
    end
    object qryISSVIOLATION_STEERING: TFloatField
      FieldName = 'VIOLATION_STEERING'
      ReadOnly = True
    end
    object qryISSVIOLATION_MEDICAL_CERTIFICATE: TFloatField
      FieldName = 'VIOLATION_MEDICAL_CERTIFICATE'
      ReadOnly = True
    end
    object qryISSVIOLATION_LOGS: TFloatField
      FieldName = 'VIOLATION_LOGS'
      ReadOnly = True
    end
    object qryISSVIOLATION_HOURS: TFloatField
      FieldName = 'VIOLATION_HOURS'
      ReadOnly = True
    end
    object qryISSVIOLATION_LICENSE: TFloatField
      FieldName = 'VIOLATION_LICENSE'
      ReadOnly = True
    end
    object qryISSVIOLATION_DRUGS: TFloatField
      FieldName = 'VIOLATION_DRUGS'
      ReadOnly = True
    end
    object qryISSVIOLATION_TRAFFIC: TFloatField
      FieldName = 'VIOLATION_TRAFFIC'
      ReadOnly = True
    end
    object qryISSVIOLATION_PAPERS: TFloatField
      FieldName = 'VIOLATION_PAPERS'
      ReadOnly = True
    end
    object qryISSVIOLATION_PLACARDS: TFloatField
      FieldName = 'VIOLATION_PLACARDS'
      ReadOnly = True
    end
    object qryISSVIOLATION_OP_EMER_RESP: TFloatField
      FieldName = 'VIOLATION_OP_EMER_RESP'
      ReadOnly = True
    end
    object qryISSVIOLATION_TANK: TFloatField
      FieldName = 'VIOLATION_TANK'
      ReadOnly = True
    end
    object qryISSVIOLATION_OTHER: TFloatField
      FieldName = 'VIOLATION_OTHER'
      ReadOnly = True
    end
    object qryISSVEHICLE_OOS_RATE: TFloatField
      FieldName = 'VEHICLE_OOS_RATE'
      ReadOnly = True
    end
    object qryISSDRIVER_OOS_RATE: TFloatField
      FieldName = 'DRIVER_OOS_RATE'
      ReadOnly = True
    end
    object qryISSVEHICLE_OOS_PERCENT: TFloatField
      FieldName = 'VEHICLE_OOS_PERCENT'
      ReadOnly = True
    end
    object qryISSDRIVER_OOS_PERCENT: TFloatField
      FieldName = 'DRIVER_OOS_PERCENT'
      ReadOnly = True
    end
    object qryISSBRAKES_RATE: TFloatField
      FieldName = 'BRAKES_RATE'
      ReadOnly = True
    end
    object qryISSWHEEL_RATE: TFloatField
      FieldName = 'WHEEL_RATE'
      ReadOnly = True
    end
    object qryISSSTEER_RATE: TFloatField
      FieldName = 'STEER_RATE'
      ReadOnly = True
    end
    object qryISSMEDICAL_RATE: TFloatField
      FieldName = 'MEDICAL_RATE'
      ReadOnly = True
    end
    object qryISSLOGS_RATE: TFloatField
      FieldName = 'LOGS_RATE'
      ReadOnly = True
    end
    object qryISSHOURS_RATE: TFloatField
      FieldName = 'HOURS_RATE'
      ReadOnly = True
    end
    object qryISSDQ_RATE: TFloatField
      FieldName = 'DQ_RATE'
      ReadOnly = True
    end
    object qryISSDRUGS_RATE: TFloatField
      FieldName = 'DRUGS_RATE'
      ReadOnly = True
    end
    object qryISSTRAFFIC_RATE: TFloatField
      FieldName = 'TRAFFIC_RATE'
      ReadOnly = True
    end
    object qryISSHM_PAPER_RATE: TFloatField
      FieldName = 'HM_PAPER_RATE'
      ReadOnly = True
    end
    object qryISSHM_PLAC_RATE: TFloatField
      FieldName = 'HM_PLAC_RATE'
      ReadOnly = True
    end
    object qryISSHM_OPER_RATE: TFloatField
      FieldName = 'HM_OPER_RATE'
      ReadOnly = True
    end
    object qryISSHM_TANK_RATE: TFloatField
      FieldName = 'HM_TANK_RATE'
      ReadOnly = True
    end
    object qryISSHM_OTHR_RATE: TFloatField
      FieldName = 'HM_OTHR_RATE'
      ReadOnly = True
    end
  end
  object qryCarrier: TUniQuery
    SQLRefresh.Strings = (
      'SELECT CARRIER_ID_NUMBER FROM DOT423.CARRIER'
      'WHERE'
      '  CARRIER_ID_NUMBER = :CARRIER_ID_NUMBER')
    SQLRecCount.Strings = (
      'SELECT Count(*) FROM ('
      'SELECT * FROM DOT423.CARRIER'
      ''
      ')')
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  c.CARRIER_ID_NUMBER "USDOTNUM",'
      '  LPAD(c.CARRIER_ID_NUMBER,8,'#39'0'#39') "PAD_USDOTNUM",'
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
      '  -- and c.CARRIER_ID_NUMBER = :dot'
      '')
    FetchRows = 10000
    Options.RequiredFields = False
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    AutoCalcFields = False
    Left = 48
    Top = 88
    object qryCarrierUSDOTNUM: TWideStringField
      DisplayWidth = 8
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 8
    end
    object qryCarrierPAD_USDOTNUM: TWideStringField
      DisplayWidth = 8
      FieldName = 'PAD_USDOTNUM'
      ReadOnly = True
      Size = 8
    end
    object qryCarrierADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Size = 50
    end
    object qryCarrierZIPCODE: TWideStringField
      FieldName = 'ZIPCODE'
      Size = 10
    end
    object qryCarrierPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 13
    end
    object qryCarrierICC_NUM: TWideStringField
      FieldName = 'ICC_NUM'
      ReadOnly = True
      Size = 4000
    end
    object qryCarrierINSPECTION_VALUE: TSmallintField
      FieldName = 'INSPECTION_VALUE'
    end
    object qryCarrierINDICATOR: TWideStringField
      FieldName = 'INDICATOR'
      FixedChar = True
      Size = 1
    end
    object qryCarrierENTITY_TYPE: TWideStringField
      FieldName = 'ENTITY_TYPE'
      Size = 8
    end
    object qryCarrierMCSIP_STATUS: TSmallintField
      FieldName = 'MCSIP_STATUS'
    end
    object qryCarrierTOTAL_VEHICLES: TFloatField
      FieldName = 'TOTAL_VEHICLES'
      ReadOnly = True
    end
    object qryCarrierTOTAL_DRIVERS: TFloatField
      FieldName = 'TOTAL_DRIVERS'
      ReadOnly = True
    end
    object qryCarrierCARRIER_OPERATION: TWideStringField
      FieldName = 'CARRIER_OPERATION'
      ReadOnly = True
      Size = 32
    end
    object qryCarrierCOUNTRY: TWideStringField
      FieldName = 'COUNTRY'
      FixedChar = True
      Size = 2
    end
    object qryCarrierNEW_ENTRANT_CODE: TWideStringField
      FieldName = 'NEW_ENTRANT_CODE'
      ReadOnly = True
      Size = 1
    end
    object qryCarrierUNDELIVERABLE_PA: TWideStringField
      FieldName = 'UNDELIVERABLE_PA'
      ReadOnly = True
      Size = 1
    end
    object qryCarrierUNDELIVERABLE_MA: TWideStringField
      FieldName = 'UNDELIVERABLE_MA'
      ReadOnly = True
      Size = 1
    end
    object qryCarrierSTATUS: TWideStringField
      FieldName = 'STATUS'
      ReadOnly = True
      FixedChar = True
      Size = 32
    end
    object qryCarrierLAST_UPDATE_DATE: TDateTimeField
      FieldName = 'LAST_UPDATE_DATE'
      ReadOnly = True
    end
    object qryCarrierHAS_POWER_UNITS: TWideStringField
      FieldName = 'HAS_POWER_UNITS'
      ReadOnly = True
      Size = 1
    end
    object qryCarrierOOS_DATE: TWideStringField
      FieldName = 'OOS_DATE'
      ReadOnly = True
      Size = 10
    end
    object qryCarrierOOS_TEXT: TWideStringField
      FieldName = 'OOS_TEXT'
      ReadOnly = True
      Size = 50
    end
    object qryCarrierOOS_REASON: TWideStringField
      FieldName = 'OOS_REASON'
      ReadOnly = True
      Size = 3
    end
    object qryCarrierOPER_AUTH_STATUS: TWideStringField
      FieldName = 'OPER_AUTH_STATUS'
      ReadOnly = True
      Size = 4000
    end
  end
  object qryUCR: TUniQuery
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select distinct u.dot_number "USDOTNUM",'
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
      '  -- and CARRIER_ID_NUMBER = :sDOT'
      '')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    SpecificOptions.Strings = (
      'Oracle.TemporaryLobUpdate=False')
    IndexFieldNames = 'USDOTNUM'
    Left = 576
    Top = 84
    ParamData = <
      item
        DataType = ftInteger
        Name = 'iRegYear'
        ParamType = ptInput
        Value = nil
      end>
    object qryUCRUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Size = 12
    end
    object qryUCRBASE_STATE: TWideStringField
      FieldName = 'BASE_STATE'
      ReadOnly = True
      Size = 4
    end
    object qryUCRPAYMENT_FLAG: TWideStringField
      FieldName = 'PAYMENT_FLAG'
      Required = True
      FixedChar = True
      Size = 1
    end
    object qryUCRREGISTRATION_YEAR: TWideStringField
      FieldName = 'REGISTRATION_YEAR'
      ReadOnly = True
      Size = 40
    end
    object qryUCRPAYMENT_DATE: TDateTimeField
      FieldName = 'PAYMENT_DATE'
      Required = True
    end
    object qryUCRINTRASTATE_VEHICLES: TWideStringField
      FieldName = 'INTRASTATE_VEHICLES'
      Required = True
      FixedChar = True
      Size = 1
    end
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
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select distinct(CARRIER_ID_NUMBER) "USDOTNUM",'
      '       --LPAD(CARRIER_ID_NUMBER,8,'#39'0'#39') "PAD_USDOTNUM",'
      '       LTRIM(CARRIER_NAME) "NAME",'
      '       MAIL_CITY "CITY",'
      '       MAIL_STATE "STATE",'
      '       '#39'1'#39' "NAME_TYPE_ID"'
      '  from dot423.CARRIER'
      ' --where CARRIER_ID_NUMBER = :sDOT'
      '   --and MCMIS_STATUS='#39'A'#39)
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM'
    Left = 187
    Top = 84
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
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'Select distinct(CARRIER_ID_NUMBER) "USDOTNUM",'
      '       LTRIM(DBA_NAME) "NAME",'
      '       MAIL_CITY "CITY",'
      '       MAIL_STATE "STATE",'
      '       '#39'2'#39' "NAME_TYPE_ID"'
      '  from dot423.CARRIER'
      ' where DBA_NAME IS NOT NULL'
      '   --and CARRIER_ID_NUMBER = :sDOT'
      '   --and MCMIS_STATUS='#39'A'#39)
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM'
    Left = 265
    Top = 84
    object qryNAME2USDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 12
    end
    object qryNAME2NAME: TWideStringField
      FieldName = 'NAME'
      ReadOnly = True
      Size = 120
    end
    object qryNAME2CITY: TWideStringField
      FieldName = 'CITY'
      Size = 25
    end
    object qryNAME2STATE: TWideStringField
      FieldName = 'STATE'
      FixedChar = True
      Size = 2
    end
    object qryNAME2NAME_TYPE_ID: TWideStringField
      FieldName = 'NAME_TYPE_ID'
      ReadOnly = True
      FixedChar = True
      Size = 32
    end
  end
  object qryHMPermit: TUniQuery
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  distinct(CARRIER_ID_NUMBER) "USDOTNUM",'
      '  HM_PERMIT_TYPE,'
      '  HM_PERMIT_STATUS,'
      '  HM_PERMIT_EFFECTIVE_DATE,'
      '  HM_PERMIT_EXPIRATION_DATE,'
      '  OPERATING_UNDER_APPEAL_FLAG'
      'from'
      '  dot423.CARRIER '
      'where HM_PERMIT_TYPE IS NOT NULL'
      '  --and MCMIS_STATUS = '#39'A'#39
      '  --and CARRIER_ID_NUMBER = :sDOT'
      '')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM'
    Left = 342
    Top = 84
    object qryHMPermitUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 12
    end
    object qryHMPermitHM_PERMIT_TYPE: TWideStringField
      FieldName = 'HM_PERMIT_TYPE'
      Size = 1
    end
    object qryHMPermitHM_PERMIT_STATUS: TWideStringField
      FieldName = 'HM_PERMIT_STATUS'
      Size = 1
    end
    object qryHMPermitHM_PERMIT_EFFECTIVE_DATE: TDateTimeField
      FieldName = 'HM_PERMIT_EFFECTIVE_DATE'
    end
    object qryHMPermitHM_PERMIT_EXPIRATION_DATE: TDateTimeField
      FieldName = 'HM_PERMIT_EXPIRATION_DATE'
    end
    object qryHMPermitOPERATING_UNDER_APPEAL_FLAG: TWideStringField
      FieldName = 'OPERATING_UNDER_APPEAL_FLAG'
      Size = 1
    end
  end
  object qryINS: TUniQuery
    SmartFetch.LiveBlock = False
    Connection = dbSAFER
    SQL.Strings = (
      'select c.carrier_id_number "USDOTNUM", '
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
      '   --and CARRIER_ID_NUMBER = :sDOT')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM'
    Left = 420
    Top = 84
    object qryINSUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Size = 12
    end
    object qryINSLIABILITY_STATUS: TWideStringField
      FieldName = 'LIABILITY_STATUS'
      ReadOnly = True
      Size = 32
    end
    object qryINSLIABILITY_REQUIRED: TLargeintField
      FieldName = 'LIABILITY_REQUIRED'
      ReadOnly = True
    end
    object qryINSCARGO_STATUS: TWideStringField
      FieldName = 'CARGO_STATUS'
      ReadOnly = True
      Size = 32
    end
    object qryINSBOND_STATUS: TWideStringField
      FieldName = 'BOND_STATUS'
      ReadOnly = True
      Size = 32
    end
    object qryINSMEX_TERRITORY: TWideStringField
      FieldName = 'MEX_TERRITORY'
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
  end
  object qryBASICS: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select C.CARRIER_ID_NUMBER  "USDOTNUM",'
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
      '  -- and CARRIER_ID_NUMBER = :sDOT')
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    IndexFieldNames = 'USDOTNUM;BASIC'
    Left = 498
    Top = 84
    object qryBASICSUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Size = 12
    end
    object qryBASICSBASIC: TFloatField
      FieldName = 'BASIC'
      ReadOnly = True
      Required = True
    end
    object qryBASICSBASICPERCENTILE: TFloatField
      FieldName = 'BASICPERCENTILE'
      ReadOnly = True
    end
    object qryBASICSBASICSDEFIND: TWideStringField
      FieldName = 'BASICSDEFIND'
      ReadOnly = True
      Size = 1
    end
    object qryBASICSBASICSRUNDATE: TDateTimeField
      FieldName = 'BASICSRUNDATE'
      ReadOnly = True
    end
    object qryBASICSINVESTIGATIONDATE: TDateTimeField
      FieldName = 'INVESTIGATIONDATE'
      ReadOnly = True
    end
    object qryBASICSROAD_DISPLAY_TEXT: TWideStringField
      FieldName = 'ROAD_DISPLAY_TEXT'
      ReadOnly = True
      Size = 64
    end
    object qryBASICSINVEST_DISPLAY_TEXT: TWideStringField
      FieldName = 'INVEST_DISPLAY_TEXT'
      ReadOnly = True
      Size = 64
    end
    object qryBASICSOVERALL_DISPLAY_TEXT: TWideStringField
      FieldName = 'OVERALL_DISPLAY_TEXT'
      ReadOnly = True
      Size = 64
    end
  end
  object dbSAFER: TUniConnection
    AutoCommit = False
    ProviderName = 'Oracle'
    SpecificOptions.Strings = (
      'Oracle.Direct=True'
      'Oracle.IPVersion=ivIPBoth'
      'Oracle.UseUnicode=True')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Options.DefaultSortType = stCaseInsensitive
    Username = 'READ423'
    Server = '10.75.161.103:1526/safer.safersys.org'
    LoginPrompt = False
    Left = 268
    Top = 20
    EncryptedPassword = '8CFF9EFF99FF9AFF8DFFCBFFCDFFCCFF'
  end
  object providerSAFER: TOracleUniProvider
    Left = 344
    Top = 24
  end
  object qryCensus: TUniQuery
    Connection = dbSAFER
    SQL.Strings = (
      'select'
      '  c.CARRIER_ID_NUMBER,'
      '  LPAD(c.CARRIER_ID_NUMBER,8,'#39'0'#39') "USDOTNUM",'
      '  '#39'A'#39' "STATUS",'
      '  SYSDATE "LAST_UPDATE_DATE"'
      'from'
      '  dot423.CARRIER c'
      'where'
      '  c.MCMIS_STATUS = '#39'A'#39
      '')
    FetchRows = 10000
    Options.RequiredFields = False
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.RemoveOnRefresh = False
    AutoCalcFields = False
    Left = 48
    Top = 28
    object qryCensusCARRIER_ID_NUMBER: TWideStringField
      FieldName = 'CARRIER_ID_NUMBER'
      Size = 12
    end
    object qryCensusUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      ReadOnly = True
      Size = 4000
    end
    object qryCensusSTATUS: TWideStringField
      FieldName = 'STATUS'
      ReadOnly = True
      FixedChar = True
      Size = 32
    end
    object qryCensusLAST_UPDATE_DATE: TDateTimeField
      FieldName = 'LAST_UPDATE_DATE'
      ReadOnly = True
    end
  end
end
