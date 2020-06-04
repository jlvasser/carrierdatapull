object dmISS_SQLite: TdmISS_SQLite
  OldCreateOrder = False
  Height = 319
  Width = 822
  object dbISS_Local: TUniConnection
    ProviderName = 'SQLite'
    Database = 'C:\Projects\DataPull\carrierdatapull\ISSTables\ISS_FED_DATA.db'
    Options.AllowImplicitConnect = False
    Options.KeepDesignConnected = False
    Options.DefaultSortType = stCaseInsensitive
    DefaultTransaction = transactionLocal
    LoginPrompt = False
    Left = 52
    Top = 28
  end
  object tblCarriers: TUniTable
    TableName = 'CARRIERS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 52
    Top = 104
    object tblCarriersUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblCarriersADDRESS: TStringField
      FieldName = 'ADDRESS'
      Size = 50
    end
    object tblCarriersZIPCODE: TStringField
      FieldName = 'ZIPCODE'
      Size = 10
    end
    object tblCarriersCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Size = 1
    end
    object tblCarriersPHONE: TStringField
      FieldName = 'PHONE'
      Size = 15
    end
    object tblCarriersICC_NUM: TStringField
      FieldName = 'ICC_NUM'
      Size = 8
    end
    object tblCarriersRFC_NUM: TStringField
      FieldName = 'RFC_NUM'
      Size = 18
    end
    object tblCarriersINSPECTION_VALUE: TStringField
      FieldName = 'INSPECTION_VALUE'
      Size = 3
    end
    object tblCarriersINDICATOR: TStringField
      FieldName = 'INDICATOR'
      Size = 1
    end
    object tblCarriersTOTAL_VEHICLES: TIntegerField
      FieldName = 'TOTAL_VEHICLES'
    end
    object tblCarriersTOTAL_DRIVERS: TIntegerField
      FieldName = 'TOTAL_DRIVERS'
    end
    object tblCarriersCARRIER_OPERATION: TStringField
      FieldName = 'CARRIER_OPERATION'
      Size = 1
    end
    object tblCarriersNEW_ENTRANT_CODE: TStringField
      FieldName = 'NEW_ENTRANT_CODE'
      Size = 1
    end
    object tblCarriersSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object tblCarriersLAST_UPDATE_DATE: TDateTimeField
      FieldName = 'LAST_UPDATE_DATE'
    end
    object tblCarriersENTITY_TYPE: TStringField
      FieldName = 'ENTITY_TYPE'
      Size = 1
    end
    object tblCarriersUNDELIVERABLE_PA: TStringField
      FieldName = 'UNDELIVERABLE_PA'
      Size = 1
    end
    object tblCarriersUNDELIVERABLE_MA: TStringField
      FieldName = 'UNDELIVERABLE_MA'
      Size = 1
    end
    object tblCarriersHAS_POWER_UNITS: TStringField
      FieldName = 'HAS_POWER_UNITS'
      Size = 1
    end
    object tblCarriersOPER_AUTH_STATUS: TStringField
      FieldName = 'OPER_AUTH_STATUS'
      Size = 40
    end
    object tblCarriersOOS_DATE: TDateField
      FieldName = 'OOS_DATE'
    end
    object tblCarriersOOS_TEXT: TStringField
      FieldName = 'OOS_TEXT'
      Size = 60
    end
    object tblCarriersOOS_REASON: TStringField
      FieldName = 'OOS_REASON'
      Size = 3
    end
    object tblCarriersMCSIP_STATUS: TStringField
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
  object tblISS: TUniTable
    TableName = 'ISS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 254
    Top = 104
    object tblISSUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblISSTOTAL_INSPECTIONS: TStringField
      FieldName = 'TOTAL_INSPECTIONS'
      Size = 5
    end
    object tblISSVEHICLE_INSPECTIONS: TStringField
      FieldName = 'VEHICLE_INSPECTIONS'
      Size = 5
    end
    object tblISSDRIVER_INSPECTIONS: TStringField
      FieldName = 'DRIVER_INSPECTIONS'
      Size = 5
    end
    object tblISSHAZMAT_INSPECTIONS: TStringField
      FieldName = 'HAZMAT_INSPECTIONS'
      Size = 5
    end
    object tblISSOOS_TOTAL: TStringField
      FieldName = 'OOS_TOTAL'
      Size = 5
    end
    object tblISSOOS_VEHICLE: TStringField
      FieldName = 'OOS_VEHICLE'
      Size = 5
    end
    object tblISSOOS_DRIVER: TStringField
      FieldName = 'OOS_DRIVER'
      Size = 5
    end
    object tblISSSAFETY_RATING: TStringField
      FieldName = 'SAFETY_RATING'
      Size = 1
    end
    object tblISSRATING_DATE: TDateField
      FieldName = 'RATING_DATE'
    end
    object tblISSVIOL_BRAKES: TStringField
      FieldName = 'VIOL_BRAKES'
      Size = 6
    end
    object tblISSVIOL_WHEELS: TStringField
      FieldName = 'VIOL_WHEELS'
      Size = 6
    end
    object tblISSVIOL_STEERING: TStringField
      FieldName = 'VIOL_STEERING'
      Size = 6
    end
    object tblISSVIOL_MEDICAL: TStringField
      FieldName = 'VIOL_MEDICAL'
      Size = 6
    end
    object tblISSVIOL_LOGS: TStringField
      FieldName = 'VIOL_LOGS'
      Size = 6
    end
    object tblISSVIOL_HOURS: TStringField
      FieldName = 'VIOL_HOURS'
      Size = 6
    end
    object tblISSVIOL_DISQUAL: TStringField
      FieldName = 'VIOL_DISQUAL'
      Size = 6
    end
    object tblISSVIOL_DRUGS: TStringField
      FieldName = 'VIOL_DRUGS'
      Size = 6
    end
    object tblISSVIOL_TRAFFIC: TStringField
      FieldName = 'VIOL_TRAFFIC'
      Size = 6
    end
    object tblISSVIOL_HMPAPER: TStringField
      FieldName = 'VIOL_HMPAPER'
      Size = 6
    end
    object tblISSVIOL_HMPLAC: TStringField
      FieldName = 'VIOL_HMPLAC'
      Size = 6
    end
    object tblISSVIOL_HMOPER: TStringField
      FieldName = 'VIOL_HMOPER'
      Size = 6
    end
    object tblISSVIOL_HMTANK: TStringField
      FieldName = 'VIOL_HMTANK'
      Size = 6
    end
    object tblISSVIOL_HMOTHR: TStringField
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
  object tblCarrName: TUniTable
    TableName = 'CARRNAME'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    FilterSQL = 'NAME_TYPE_ID = 1'
    Left = 119
    Top = 104
    object tblCarrNameUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblCarrNameNAME: TStringField
      FieldName = 'NAME'
      Size = 120
    end
    object tblCarrNameCITY: TStringField
      FieldName = 'CITY'
      Size = 40
    end
    object tblCarrNameSTATE: TStringField
      FieldName = 'STATE'
      Size = 2
    end
    object tblCarrNameNAME_TYPE_ID: TStringField
      FieldName = 'NAME_TYPE_ID'
      Size = 1
    end
  end
  object tblName2: TUniTable
    TableName = 'CARRNAME'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    FilterSQL = 'NAME_TYPE_ID = 2'
    Left = 187
    Top = 104
    object tblName2USDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblName2NAME: TStringField
      FieldName = 'NAME'
      Size = 120
    end
    object tblName2CITY: TStringField
      FieldName = 'CITY'
      Size = 40
    end
    object tblName2STATE: TStringField
      FieldName = 'STATE'
      Size = 2
    end
    object tblName2NAME_TYPE_ID: TStringField
      FieldName = 'NAME_TYPE_ID'
      Size = 1
    end
  end
  object tblHMPermit: TUniTable
    TableName = 'HMPERMIT'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 322
    Top = 104
    object tblHMPermitUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblHMPermitPERMIT_TYPE: TStringField
      FieldName = 'PERMIT_TYPE'
      Size = 1
    end
    object tblHMPermitPERMIT_STATUS: TStringField
      FieldName = 'PERMIT_STATUS'
      Size = 1
    end
    object tblHMPermitEFFECTIVE_DATE: TDateField
      FieldName = 'EFFECTIVE_DATE'
    end
    object tblHMPermitEXPIRATION_DATE: TDateField
      FieldName = 'EXPIRATION_DATE'
    end
    object tblHMPermitOPERATING_UNDER_APPEAL: TStringField
      FieldName = 'OPERATING_UNDER_APPEAL'
      Size = 1
    end
  end
  object tblCarrIns: TUniTable
    TableName = 'CARRINS'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 457
    Top = 104
    object tblCarrInsUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblCarrInsLIABILITY_STATUS: TStringField
      FieldName = 'LIABILITY_STATUS'
      Size = 6
    end
    object tblCarrInsLIABILITY_REQUIRED: TFloatField
      FieldName = 'LIABILITY_REQUIRED'
    end
    object tblCarrInsCARGO_STATUS: TStringField
      FieldName = 'CARGO_STATUS'
      Size = 6
    end
    object tblCarrInsBOND_STATUS: TStringField
      FieldName = 'BOND_STATUS'
      Size = 6
    end
    object tblCarrInsMEX_TERRITORY: TStringField
      FieldName = 'MEX_TERRITORY'
      Size = 2
    end
  end
  object tblUCR: TUniTable
    TableName = 'UCR'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 389
    Top = 104
    object tblUCRUCR_SEQ_NUM: TIntegerField
      FieldName = 'UCR_SEQ_NUM'
    end
    object tblUCRUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblUCRBASE_STATE: TStringField
      FieldName = 'BASE_STATE'
      Size = 2
    end
    object tblUCRPAYMENT_FLAG: TStringField
      FieldName = 'PAYMENT_FLAG'
      Size = 1
    end
    object tblUCRREGISTRATION_YEAR: TStringField
      FieldName = 'REGISTRATION_YEAR'
      Size = 4
    end
    object tblUCRPAYMENT_DATE: TDateField
      FieldName = 'PAYMENT_DATE'
    end
    object tblUCRINTRASTATE_VEHICLES: TStringField
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
  object providerISS_Local: TSQLiteUniProvider
    Left = 160
    Top = 24
  end
  object tblDataDate: TUniTable
    TableName = 'DATADATE'
    Connection = dbISS_Local
    Left = 628
    Top = 108
    object tblDataDateDATABASEDATE: TStringField
      FieldName = 'DATABASEDATE'
      Size = 30
    end
  end
  object tblUpdateStatus: TUniTable
    Connection = dbISS_Local
    Left = 720
    Top = 108
  end
  object srcUpdateStatus: TUniDataSource
    DataSet = tblUpdateStatus
    Left = 724
    Top = 172
  end
  object qryV_CarrierInfo: TUniQuery
    Connection = dbISS_Local
    Left = 628
    Top = 172
  end
  object qryGenValue: TUniQuery
    Connection = dbISS_Local
    Left = 500
    Top = 172
  end
  object sqlDelete: TUniSQL
    Connection = dbISS_Local
    Left = 52
    Top = 176
  end
  object sqlDataDate: TUniSQL
    Connection = dbISS_Local
    SQL.Strings = (
      'update datadate set databasedate = :newDate')
    Left = 116
    Top = 176
    ParamData = <
      item
        DataType = ftString
        Name = 'newDate'
        ParamType = ptInput
        Value = nil
      end>
  end
  object sqlEnableIdx: TUniSQL
    Connection = dbISS_Local
    Left = 184
    Top = 176
  end
  object scriptInactivateIndex: TUniScript
    Connection = dbISS_Local
    Left = 252
    Top = 176
  end
  object scriptEnableIdx: TUniScript
    Connection = dbISS_Local
    Left = 324
    Top = 176
  end
  object transactionLocal: TUniTransaction
    DefaultConnection = dbISS_Local
    Left = 264
    Top = 32
  end
  object tblBasicsDetail: TUniTable
    TableName = 'UCR'
    OrderFields = 'USDOTNUM'
    Connection = dbISS_Local
    Left = 528
    Top = 112
    object tblBasicsDetailUCR_SEQ_NUM: TIntegerField
      FieldName = 'UCR_SEQ_NUM'
    end
    object tblBasicsDetailUSDOTNUM: TStringField
      FieldName = 'USDOTNUM'
      Size = 8
    end
    object tblBasicsDetailBASE_STATE: TStringField
      FieldName = 'BASE_STATE'
      Size = 2
    end
    object tblBasicsDetailPAYMENT_FLAG: TStringField
      FieldName = 'PAYMENT_FLAG'
      Size = 1
    end
    object tblBasicsDetailREGISTRATION_YEAR: TStringField
      FieldName = 'REGISTRATION_YEAR'
      Size = 4
    end
    object tblBasicsDetailPAYMENT_DATE: TDateField
      FieldName = 'PAYMENT_DATE'
    end
    object tblBasicsDetailINTRASTATE_VEHICLES: TStringField
      FieldName = 'INTRASTATE_VEHICLES'
      Size = 1
    end
    object tblBasicsDetailINTRA_VEH_TEXT: TStringField
      FieldKind = fkCalculated
      FieldName = 'INTRA_VEH_TEXT'
      Size = 3
      Calculated = True
    end
    object tblBasicsDetailPAY_FLAG_TEXT: TStringField
      FieldKind = fkCalculated
      FieldName = 'PAY_FLAG_TEXT'
      Size = 3
      Calculated = True
    end
  end
end
