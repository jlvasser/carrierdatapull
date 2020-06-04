object dmISS_FB: TdmISS_FB
  OldCreateOrder = False
  Height = 550
  Width = 521
  object dbISS_LOCAL: TUniConnection
    AutoCommit = False
    ProviderName = 'InterBase'
    Database = 'C:\Projects\DataPull\carrierdatapull\ISSTables\ISS_FED_DATA.FDB'
    SpecificOptions.Strings = (
      'InterBase.UseUnicode=True'
      'InterBase.ClientLibrary=fbclient.dll')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Options.DefaultSortType = stCaseInsensitive
    Username = 'sysdba'
    LoginPrompt = False
    Left = 128
    Top = 16
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object providerISS_LOCAL: TInterBaseUniProvider
    Left = 220
    Top = 16
  end
  object sqlDelete: TUniSQL
    Connection = dbISS_LOCAL
    Left = 36
    Top = 76
  end
  object tblCarriers: TUniTable
    TableName = 'CARRIERS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    AutoCalcFields = False
    OnCalcFields = tblCarriersCalcFields
    Options.SetFieldsReadOnly = False
    Left = 128
    Top = 76
    object tblCarriersUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblCarriersADDRESS: TWideStringField
      FieldName = 'ADDRESS'
      Size = 50
    end
    object tblCarriersZIPCODE: TWideStringField
      FieldName = 'ZIPCODE'
      Size = 10
    end
    object tblCarriersCOUNTRY: TWideStringField
      FieldName = 'COUNTRY'
      Size = 1
    end
    object tblCarriersPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 15
    end
    object tblCarriersICC_NUM: TWideStringField
      FieldName = 'ICC_NUM'
      Size = 8
    end
    object tblCarriersRFC_NUM: TWideStringField
      FieldName = 'RFC_NUM'
      Size = 18
    end
    object tblCarriersINSPECTION_VALUE: TWideStringField
      FieldName = 'INSPECTION_VALUE'
      Size = 3
    end
    object tblCarriersINDICATOR: TWideStringField
      FieldName = 'INDICATOR'
      Size = 1
    end
    object tblCarriersTOTAL_VEHICLES: TIntegerField
      FieldName = 'TOTAL_VEHICLES'
    end
    object tblCarriersTOTAL_DRIVERS: TIntegerField
      FieldName = 'TOTAL_DRIVERS'
    end
    object tblCarriersCARRIER_OPERATION: TWideStringField
      FieldName = 'CARRIER_OPERATION'
      Size = 1
    end
    object tblCarriersNEW_ENTRANT_CODE: TWideStringField
      FieldName = 'NEW_ENTRANT_CODE'
      Size = 1
    end
    object tblCarriersSTATUS: TWideStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object tblCarriersLAST_UPDATE_DATE: TDateTimeField
      FieldName = 'LAST_UPDATE_DATE'
    end
    object tblCarriersENTITY_TYPE: TWideStringField
      FieldName = 'ENTITY_TYPE'
      Size = 1
    end
    object tblCarriersUNDELIVERABLE_PA: TWideStringField
      FieldName = 'UNDELIVERABLE_PA'
      Size = 1
    end
    object tblCarriersUNDELIVERABLE_MA: TWideStringField
      FieldName = 'UNDELIVERABLE_MA'
      Size = 1
    end
    object tblCarriersHAS_POWER_UNITS: TWideStringField
      FieldName = 'HAS_POWER_UNITS'
      Size = 1
    end
    object tblCarriersOPER_AUTH_STATUS: TWideStringField
      FieldName = 'OPER_AUTH_STATUS'
      Size = 40
    end
    object tblCarriersOOS_DATE: TDateField
      FieldName = 'OOS_DATE'
    end
    object tblCarriersOOS_TEXT: TWideStringField
      FieldName = 'OOS_TEXT'
      Size = 60
    end
    object tblCarriersOOS_REASON: TWideStringField
      FieldName = 'OOS_REASON'
      Size = 3
    end
    object tblCarriersMCSIP_STATUS: TWideStringField
      FieldName = 'MCSIP_STATUS'
      Size = 2
    end
    object tblCarriersCountryCalc: TStringField
      FieldKind = fkCalculated
      FieldName = 'CountryCalc'
      Size = 25
      Calculated = True
    end
  end
  object tblDataDate: TUniTable
    TableName = 'DATADATE'
    Connection = dbISS_LOCAL
    Left = 224
    Top = 80
    object tblDataDateDATABASEDATE: TWideStringField
      FieldName = 'DATABASEDATE'
      Size = 30
    end
  end
  object scriptInactivateIdx: TUniScript
    SQL.Strings = (
      'alter sequence UCR_UCR_SEQ_NUM_GEN restart with 0'
      '/'
      ''
      'Alter Index IDX_ICCNUM INACTIVE'
      '/'
      ''
      'Alter Index IDX_NAME INACTIVE'
      '/'
      ''
      'Alter Index IDX_UCR_DOTNUM INACTIVE'
      '/')
    Connection = dbISS_LOCAL
    Left = 36
    Top = 132
  end
  object tblISS: TUniTable
    TableName = 'ISS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    AutoCalcFields = False
    Options.TrimVarChar = True
    Options.SetFieldsReadOnly = False
    Options.RequiredFields = False
    Options.AutoPrepare = True
    SpecificOptions.Strings = (
      'InterBase.AutoCommit=False')
    Left = 128
    Top = 130
    object tblISSUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblISSTOTAL_INSPECTIONS: TWideStringField
      FieldName = 'TOTAL_INSPECTIONS'
      Size = 5
    end
    object tblISSVEHICLE_INSPECTIONS: TWideStringField
      FieldName = 'VEHICLE_INSPECTIONS'
      Size = 5
    end
    object tblISSDRIVER_INSPECTIONS: TWideStringField
      FieldName = 'DRIVER_INSPECTIONS'
      Size = 5
    end
    object tblISSHAZMAT_INSPECTIONS: TWideStringField
      FieldName = 'HAZMAT_INSPECTIONS'
      Size = 5
    end
    object tblISSOOS_TOTAL: TWideStringField
      FieldName = 'OOS_TOTAL'
      Size = 5
    end
    object tblISSOOS_VEHICLE: TWideStringField
      FieldName = 'OOS_VEHICLE'
      Size = 5
    end
    object tblISSOOS_DRIVER: TWideStringField
      FieldName = 'OOS_DRIVER'
      Size = 5
    end
    object tblISSSAFETY_RATING: TWideStringField
      FieldName = 'SAFETY_RATING'
      Size = 1
    end
    object tblISSRATING_DATE: TDateField
      FieldName = 'RATING_DATE'
    end
    object tblISSVIOL_BRAKES: TWideStringField
      FieldName = 'VIOL_BRAKES'
      Size = 6
    end
    object tblISSVIOL_WHEELS: TWideStringField
      FieldName = 'VIOL_WHEELS'
      Size = 6
    end
    object tblISSVIOL_STEERING: TWideStringField
      FieldName = 'VIOL_STEERING'
      Size = 6
    end
    object tblISSVIOL_MEDICAL: TWideStringField
      FieldName = 'VIOL_MEDICAL'
      Size = 6
    end
    object tblISSVIOL_LOGS: TWideStringField
      FieldName = 'VIOL_LOGS'
      Size = 6
    end
    object tblISSVIOL_HOURS: TWideStringField
      FieldName = 'VIOL_HOURS'
      Size = 6
    end
    object tblISSVIOL_DISQUAL: TWideStringField
      FieldName = 'VIOL_DISQUAL'
      Size = 6
    end
    object tblISSVIOL_DRUGS: TWideStringField
      FieldName = 'VIOL_DRUGS'
      Size = 6
    end
    object tblISSVIOL_TRAFFIC: TWideStringField
      FieldName = 'VIOL_TRAFFIC'
      Size = 6
    end
    object tblISSVIOL_HMPAPER: TWideStringField
      FieldName = 'VIOL_HMPAPER'
      Size = 6
    end
    object tblISSVIOL_HMPLAC: TWideStringField
      FieldName = 'VIOL_HMPLAC'
      Size = 6
    end
    object tblISSVIOL_HMOPER: TWideStringField
      FieldName = 'VIOL_HMOPER'
      Size = 6
    end
    object tblISSVIOL_HMTANK: TWideStringField
      FieldName = 'VIOL_HMTANK'
      Size = 6
    end
    object tblISSVIOL_HMOTHR: TWideStringField
      FieldName = 'VIOL_HMOTHR'
      Size = 6
    end
    object tblISSVehicleOOSRate: TFloatField
      DisplayWidth = 13
      FieldKind = fkCalculated
      FieldName = 'VehicleOOSRate'
      Calculated = True
    end
    object tblISSDriverOOSRate: TFloatField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'DriverOOSRate'
      Calculated = True
    end
    object tblISSVehicleOOSPercent: TFloatField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'VehicleOOSPercent'
      Calculated = True
    end
    object tblISSDriverOOSPercent: TFloatField
      DisplayWidth = 14
      FieldKind = fkCalculated
      FieldName = 'DriverOOSPercent'
      Calculated = True
    end
    object tblISSInspPerVehicle: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'InspPerVehicle'
      Calculated = True
    end
    object tblISSInspPerDriver: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'InspPerDriver'
      Calculated = True
    end
    object tblISSv1BrakesRate: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'v1BrakesRate'
      Calculated = True
    end
    object tblISSv1WheelRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1WheelRate'
      Calculated = True
    end
    object tblISSv1SteerRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1SteerRate'
      Calculated = True
    end
    object tblISSv1MedicalRate: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'v1MedicalRate'
      Calculated = True
    end
    object tblISSv1LogsRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1LogsRate'
      Calculated = True
    end
    object tblISSv1HoursRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1HoursRate'
      Calculated = True
    end
    object tblISSv1DQRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1DQRate'
      Calculated = True
    end
    object tblISSv1DrugsRate: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'v1DrugsRate'
      Calculated = True
    end
    object tblISSv1TrafficRate: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'v1TrafficRate'
      Calculated = True
    end
    object tblISSv1HMPaperRate: TFloatField
      DisplayWidth = 13
      FieldKind = fkCalculated
      FieldName = 'v1HMPaperRate'
      Calculated = True
    end
    object tblISSv1HMPlacRate: TFloatField
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'v1HMPlacRate'
      Calculated = True
    end
    object tblISSv1HMOperRate: TFloatField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'v1HMOperRate'
      Calculated = True
    end
    object tblISSv1HMTankRate: TFloatField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'v1HMTankRate'
      Calculated = True
    end
    object tblISSv1HMOthrRate: TFloatField
      DisplayWidth = 12
      FieldKind = fkCalculated
      FieldName = 'v1HMOthrRate'
      Calculated = True
    end
  end
  object tblUpdateStatus: TVirtualTable
    Options = [voPersistentData, voStored, voSetEmptyStrToNull, voSkipUnSupportedFieldTypes]
    Active = True
    IndexFieldNames = 'TableID  ASC'
    FieldDefs = <
      item
        Name = 'TableID'
        DataType = ftInteger
      end
      item
        Name = 'Tag'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TableName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'UpdtStatus'
        DataType = ftInteger
      end
      item
        Name = 'UpdateError'
        DataType = ftInteger
      end>
    Left = 232
    Top = 148
    Data = {
      0400050007005461626C65494403000000000000000300546167010001000000
      000009005461626C654E616D6501001400000000000A00557064745374617475
      7303000000000000000B005570646174654572726F7203000000000000000000
      080000000400000000000000010000004E070000004442414E414D4504000000
      0000000004000000000000000400000001000000010000004E08000000434152
      5249455253040000000000000004000000000000000400000002000000010000
      004E09000000494E535552414E43450400000000000000040000000000000004
      00000003000000010000004E0300000049535304000000000000000400000000
      0000000400000004000000010000004E06000000424153494353040000000000
      000004000000000000000400000005000000010000004E090000004C4547414C
      4E414D4504000000000000000400000000000000040000000600000001000000
      4E08000000484D5045524D495404000000000000000400000000000000040000
      0007000000010000004E03000000554352040000000000000004000000000000
      00}
    object TStringField
      Alignment = taCenter
      DisplayWidth = 4
      FieldName = 'Tag'
      Size = 1
    end
    object TIntegerField
      Alignment = taCenter
      DisplayLabel = 'ID'
      DisplayWidth = 4
      FieldName = 'TableID'
    end
    object TStringField
      DisplayWidth = 13
      FieldName = 'TableName'
    end
    object TStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'StatusDesc'
      Size = 10
      Calculated = True
    end
    object TIntegerField
      Alignment = taCenter
      DisplayWidth = 10
      FieldName = 'UpdateError'
    end
    object TIntegerField
      Alignment = taCenter
      FieldName = 'UpdtStatus'
      Visible = False
    end
  end
  object sqlDataDate: TUniSQL
    Connection = dbISS_LOCAL
    SQL.Strings = (
      'update datadate set databasedate = :newDate')
    Left = 40
    Top = 188
    ParamData = <
      item
        DataType = ftString
        Name = 'newDate'
        ParamType = ptInput
        Value = nil
      end>
  end
  object tblCarrName: TUniTable
    TableName = 'CARRNAME'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    FilterSQL = 'NAME_TYPE_ID = 1'
    Options.SetFieldsReadOnly = False
    Left = 128
    Top = 189
    object tblCarrNameUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblCarrNameNAME: TWideStringField
      FieldName = 'NAME'
      Size = 120
    end
    object tblCarrNameCITY: TWideStringField
      FieldName = 'CITY'
      Size = 40
    end
    object tblCarrNameSTATE: TWideStringField
      FieldName = 'STATE'
      Size = 2
    end
    object tblCarrNameNAME_TYPE_ID: TWideStringField
      FieldName = 'NAME_TYPE_ID'
      Required = True
      Size = 1
    end
  end
  object TransactionLocal: TUniTransaction
    Left = 36
    Top = 244
  end
  object tblName2: TUniTable
    TableName = 'CARRNAME'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    FilterSQL = 'NAME_TYPE_ID = 2'
    Options.SetFieldsReadOnly = False
    Left = 128
    Top = 248
    object tblName2USDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblName2NAME: TWideStringField
      FieldName = 'NAME'
      Size = 120
    end
    object tblName2CITY: TWideStringField
      FieldName = 'CITY'
      Size = 40
    end
    object tblName2STATE: TWideStringField
      FieldName = 'STATE'
      Size = 2
    end
    object tblName2NAME_TYPE_ID: TWideStringField
      FieldName = 'NAME_TYPE_ID'
      Required = True
      Size = 1
    end
  end
  object srcUpdateStatus: TUniDataSource
    DataSet = tblUpdateStatus
    Left = 320
    Top = 148
  end
  object scriptEnableIdx: TUniScript
    SQL.Strings = (
      'Alter Index IDX_ICCNUM ACTIVE'
      '/'
      ''
      'Alter Index IDX_NAME ACTIVE'
      '/'
      ''
      'Alter Index IDX_UCR_DOTNUM ACTIVE'
      '/'
      ''
      'set statistics index IDX_ICCNUM;'
      '/'
      ''
      'set statistics index IDX_NAME;'
      '/'
      ''
      'set statistics index IDX_UCR_DOTNUM;'
      '/')
    Connection = dbISS_LOCAL
    Left = 36
    Top = 308
  end
  object tblHMPermit: TUniTable
    TableName = 'HMPERMIT'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    Options.SetFieldsReadOnly = False
    SpecificOptions.Strings = (
      'InterBase.AutoCommit=False')
    Left = 128
    Top = 307
    object tblHMPermitUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblHMPermitPERMIT_TYPE: TWideStringField
      FieldName = 'PERMIT_TYPE'
      Size = 1
    end
    object tblHMPermitPERMIT_STATUS: TWideStringField
      FieldName = 'PERMIT_STATUS'
      Size = 1
    end
    object tblHMPermitEFFECTIVE_DATE: TDateField
      FieldName = 'EFFECTIVE_DATE'
    end
    object tblHMPermitEXPIRATION_DATE: TDateField
      FieldName = 'EXPIRATION_DATE'
    end
    object tblHMPermitOPERATING_UNDER_APPEAL: TWideStringField
      FieldName = 'OPERATING_UNDER_APPEAL'
      Size = 1
    end
  end
  object sqlGenValue: TUniSQL
    Connection = dbISS_LOCAL
    SQL.Strings = (
      'select GEN_ID(UCR_UCR_SEQ_NUM_GEN,0) from RDB$DATABASE')
    Left = 32
    Top = 392
  end
  object tblCarrIns: TUniTable
    TableName = 'CARRINS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    Options.SetFieldsReadOnly = False
    Left = 128
    Top = 366
    object tblCarrInsUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblCarrInsLIABILITY_STATUS: TWideStringField
      FieldName = 'LIABILITY_STATUS'
      Size = 6
    end
    object tblCarrInsLIABILITY_REQUIRED: TFloatField
      FieldName = 'LIABILITY_REQUIRED'
    end
    object tblCarrInsCARGO_STATUS: TWideStringField
      FieldName = 'CARGO_STATUS'
      Size = 6
    end
    object tblCarrInsBOND_STATUS: TWideStringField
      FieldName = 'BOND_STATUS'
      Size = 6
    end
    object tblCarrInsMEX_TERRITORY: TWideStringField
      FieldName = 'MEX_TERRITORY'
      Size = 2
    end
  end
  object qryGenValue: TUniQuery
    Connection = dbISS_LOCAL
    SQL.Strings = (
      'select GEN_ID(UCR_UCR_SEQ_NUM_GEN,0) from RDB$DATABASE')
    Left = 36
    Top = 464
  end
  object tblBasicsDetail: TUniTable
    TableName = 'BASICSDETAIL'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    Options.SetFieldsReadOnly = False
    Left = 128
    Top = 425
    object tblBasicsDetailUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblBasicsDetailBASIC: TIntegerField
      FieldName = 'BASIC'
      Required = True
    end
    object tblBasicsDetailBASICPERCENTILE: TFloatField
      FieldName = 'BASICPERCENTILE'
    end
    object tblBasicsDetailBASICSDEFIND: TWideStringField
      FieldName = 'BASICSDEFIND'
      Size = 1
    end
    object tblBasicsDetailBASICSRUNDATE: TDateField
      FieldName = 'BASICSRUNDATE'
    end
    object tblBasicsDetailINVESTIGATIONDATE: TDateField
      FieldName = 'INVESTIGATIONDATE'
    end
    object tblBasicsDetailROAD_DISPLAY_TEXT: TWideStringField
      FieldName = 'ROAD_DISPLAY_TEXT'
      Size = 40
    end
    object tblBasicsDetailINVEST_DISPLAY_TEXT: TWideStringField
      FieldName = 'INVEST_DISPLAY_TEXT'
      Size = 40
    end
    object tblBasicsDetailOVERALL_DISPLAY_TEXT: TWideStringField
      FieldName = 'OVERALL_DISPLAY_TEXT'
      Size = 40
    end
  end
  object tblUCR: TUniTable
    TableName = 'UCR'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_LOCAL
    KeyFields = 'UCR_SEQ_NUM'
    Options.SetFieldsReadOnly = False
    Options.QueryRecCount = True
    SpecificOptions.Strings = (
      'InterBase.KeyGenerator=UCR_UCR_SEQ_NUM_GEN'
      'InterBase.AutoCommit=False'
      'InterBase.GeneratorMode=gmInsert')
    Left = 128
    Top = 480
    object tblUCRUCR_SEQ_NUM: TIntegerField
      FieldName = 'UCR_SEQ_NUM'
      Required = True
    end
    object tblUCRUSDOTNUM: TWideStringField
      FieldName = 'USDOTNUM'
      Required = True
      Size = 8
    end
    object tblUCRBASE_STATE: TWideStringField
      FieldName = 'BASE_STATE'
      Required = True
      Size = 2
    end
    object tblUCRPAYMENT_FLAG: TWideStringField
      FieldName = 'PAYMENT_FLAG'
      Size = 1
    end
    object tblUCRREGISTRATION_YEAR: TWideStringField
      FieldName = 'REGISTRATION_YEAR'
      Required = True
      Size = 4
    end
    object tblUCRPAYMENT_DATE: TDateField
      FieldName = 'PAYMENT_DATE'
    end
    object tblUCRINTRASTATE_VEHICLES: TWideStringField
      FieldName = 'INTRASTATE_VEHICLES'
      Size = 1
    end
    object tblUCRINTRA_VEH_TEXT: TStringField
      FieldKind = fkCalculated
      FieldName = 'INTRA_VEH_TEXT'
      Size = 3
      Calculated = True
    end
    object tblUCRPAY_FLAG_TEXT: TStringField
      FieldKind = fkCalculated
      FieldName = 'PAY_FLAG_TEXT'
      Size = 3
      Calculated = True
    end
  end
  object qryV_CarrierInfo: TUniQuery
    Connection = dbISS_LOCAL
    SQL.Strings = (
      'select *'
      'from v_CARRIER_INFO')
    Options.SetFieldsReadOnly = False
    Left = 372
    Top = 344
  end
  object dbReference: TUniConnection
    AutoCommit = False
    ProviderName = 'InterBase'
    Database = 'C:\Projects\DataPull\carrierdatapull\ISSTables\ISS_FED_DATA.FDB'
    SpecificOptions.Strings = (
      'InterBase.UseUnicode=True')
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Username = 'sysdba'
    Connected = True
    LoginPrompt = False
    Left = 260
    Top = 256
    EncryptedPassword = '92FF9EFF8CFF8BFF9AFF8DFF94FF9AFF86FF'
  end
  object qryISS_DOTNUM: TUniQuery
    SQLRefresh.Strings = (
      'SELECT USDOTNUM FROM CARRIERS'
      'WHERE'
      '  USDOTNUM = :USDOTNUM')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM CARRIERS'
      ''
      ') q')
    Connection = dbReference
    SQL.Strings = (
      'SELECT USDOTNUM FROM CARRIERS'
      'ORDER BY USDOTNUM')
    FetchRows = 250
    ReadOnly = True
    Options.RequiredFields = False
    Options.StrictUpdate = False
    Options.QueryRecCount = True
    Options.AutoPrepare = True
    Options.RemoveOnRefresh = False
    SpecificOptions.Strings = (
      'InterBase.AutoCommit=False')
    Active = True
    AutoCalcFields = False
    Left = 260
    Top = 344
  end
  object providerReference: TInterBaseUniProvider
    Left = 368
    Top = 260
  end
end
