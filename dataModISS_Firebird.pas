unit dataModISS_Firebird;

interface

uses
  System.SysUtils, System.Classes, Uni, Data.DB, DBAccess, VirtualTable,
  DAScript, UniScript, MemDS, UniProvider, InterBaseUniProvider,
  System.StrUtils, System.UITypes, Dialogs, Vcl.Forms;

type
  TdmISS_FB = class(TDataModule)
    dbISS_LOCAL: TUniConnection;
    providerISS_LOCAL: TInterBaseUniProvider;
    sqlDelete: TUniSQL;
    tblCarriers: TUniTable;
    tblCarriersUSDOTNUM: TWideStringField;
    tblCarriersADDRESS: TWideStringField;
    tblCarriersZIPCODE: TWideStringField;
    tblCarriersCOUNTRY: TWideStringField;
    tblCarriersPHONE: TWideStringField;
    tblCarriersICC_NUM: TWideStringField;
    tblCarriersRFC_NUM: TWideStringField;
    tblCarriersINSPECTION_VALUE: TWideStringField;
    tblCarriersINDICATOR: TWideStringField;
    tblCarriersTOTAL_VEHICLES: TIntegerField;
    tblCarriersTOTAL_DRIVERS: TIntegerField;
    tblCarriersCARRIER_OPERATION: TWideStringField;
    tblCarriersNEW_ENTRANT_CODE: TWideStringField;
    tblCarriersSTATUS: TWideStringField;
    tblCarriersLAST_UPDATE_DATE: TDateTimeField;
    tblCarriersENTITY_TYPE: TWideStringField;
    tblCarriersUNDELIVERABLE_PA: TWideStringField;
    tblCarriersUNDELIVERABLE_MA: TWideStringField;
    tblCarriersHAS_POWER_UNITS: TWideStringField;
    tblCarriersOPER_AUTH_STATUS: TWideStringField;
    tblCarriersOOS_DATE: TDateField;
    tblCarriersOOS_TEXT: TWideStringField;
    tblCarriersOOS_REASON: TWideStringField;
    tblCarriersMCSIP_STATUS: TWideStringField;
    tblCarriersCountryCalc: TStringField;
    tblDataDate: TUniTable;
    scriptInactivateIdx: TUniScript;
    tblISS: TUniTable;
    tblISSUSDOTNUM: TWideStringField;
    tblISSTOTAL_INSPECTIONS: TWideStringField;
    tblISSVEHICLE_INSPECTIONS: TWideStringField;
    tblISSDRIVER_INSPECTIONS: TWideStringField;
    tblISSHAZMAT_INSPECTIONS: TWideStringField;
    tblISSOOS_TOTAL: TWideStringField;
    tblISSOOS_VEHICLE: TWideStringField;
    tblISSOOS_DRIVER: TWideStringField;
    tblISSSAFETY_RATING: TWideStringField;
    tblISSRATING_DATE: TDateField;
    tblISSVIOL_BRAKES: TWideStringField;
    tblISSVIOL_WHEELS: TWideStringField;
    tblISSVIOL_STEERING: TWideStringField;
    tblISSVIOL_MEDICAL: TWideStringField;
    tblISSVIOL_LOGS: TWideStringField;
    tblISSVIOL_HOURS: TWideStringField;
    tblISSVIOL_DISQUAL: TWideStringField;
    tblISSVIOL_DRUGS: TWideStringField;
    tblISSVIOL_TRAFFIC: TWideStringField;
    tblISSVIOL_HMPAPER: TWideStringField;
    tblISSVIOL_HMPLAC: TWideStringField;
    tblISSVIOL_HMOPER: TWideStringField;
    tblISSVIOL_HMTANK: TWideStringField;
    tblISSVIOL_HMOTHR: TWideStringField;
    tblISSVehicleOOSRate: TFloatField;
    tblISSDriverOOSRate: TFloatField;
    tblISSVehicleOOSPercent: TFloatField;
    tblISSDriverOOSPercent: TFloatField;
    tblISSInspPerVehicle: TFloatField;
    tblISSInspPerDriver: TFloatField;
    tblISSv1BrakesRate: TFloatField;
    tblISSv1WheelRate: TFloatField;
    tblISSv1SteerRate: TFloatField;
    tblISSv1MedicalRate: TFloatField;
    tblISSv1LogsRate: TFloatField;
    tblISSv1HoursRate: TFloatField;
    tblISSv1DQRate: TFloatField;
    tblISSv1DrugsRate: TFloatField;
    tblISSv1TrafficRate: TFloatField;
    tblISSv1HMPaperRate: TFloatField;
    tblISSv1HMPlacRate: TFloatField;
    tblISSv1HMOperRate: TFloatField;
    tblISSv1HMTankRate: TFloatField;
    tblISSv1HMOthrRate: TFloatField;
    tblUpdateStatus: TVirtualTable;
    sqlDataDate: TUniSQL;
    tblCarrName: TUniTable;
    TransactionLocal: TUniTransaction;
    tblName2: TUniTable;
    srcUpdateStatus: TUniDataSource;
    scriptEnableIdx: TUniScript;
    tblHMPermit: TUniTable;
    sqlGenValue: TUniSQL;
    tblCarrIns: TUniTable;
    qryGenValue: TUniQuery;
    tblBasicsDetail: TUniTable;
    tblUCR: TUniTable;
    tblUCRUCR_SEQ_NUM: TIntegerField;
    tblUCRUSDOTNUM: TWideStringField;
    tblUCRBASE_STATE: TWideStringField;
    tblUCRPAYMENT_FLAG: TWideStringField;
    tblUCRREGISTRATION_YEAR: TWideStringField;
    tblUCRPAYMENT_DATE: TDateField;
    tblUCRINTRASTATE_VEHICLES: TWideStringField;
    tblUCRINTRA_VEH_TEXT: TStringField;
    tblUCRPAY_FLAG_TEXT: TStringField;
    qryV_CarrierInfo: TUniQuery;
    tblCarrNameUSDOTNUM: TWideStringField;
    tblCarrNameNAME: TWideStringField;
    tblCarrNameCITY: TWideStringField;
    tblCarrNameSTATE: TWideStringField;
    tblCarrNameNAME_TYPE_ID: TWideStringField;
    tblName2USDOTNUM: TWideStringField;
    tblName2NAME: TWideStringField;
    tblName2CITY: TWideStringField;
    tblName2STATE: TWideStringField;
    tblName2NAME_TYPE_ID: TWideStringField;
    tblHMPermitUSDOTNUM: TWideStringField;
    tblHMPermitPERMIT_TYPE: TWideStringField;
    tblHMPermitPERMIT_STATUS: TWideStringField;
    tblHMPermitEFFECTIVE_DATE: TDateField;
    tblHMPermitEXPIRATION_DATE: TDateField;
    tblHMPermitOPERATING_UNDER_APPEAL: TWideStringField;
    tblCarrInsUSDOTNUM: TWideStringField;
    tblCarrInsLIABILITY_STATUS: TWideStringField;
    tblCarrInsLIABILITY_REQUIRED: TFloatField;
    tblCarrInsCARGO_STATUS: TWideStringField;
    tblCarrInsBOND_STATUS: TWideStringField;
    tblCarrInsMEX_TERRITORY: TWideStringField;
    tblBasicsDetailUSDOTNUM: TWideStringField;
    tblBasicsDetailBASIC: TIntegerField;
    tblBasicsDetailBASICPERCENTILE: TFloatField;
    tblBasicsDetailBASICSDEFIND: TWideStringField;
    tblBasicsDetailBASICSRUNDATE: TDateField;
    tblBasicsDetailINVESTIGATIONDATE: TDateField;
    tblBasicsDetailROAD_DISPLAY_TEXT: TWideStringField;
    tblBasicsDetailINVEST_DISPLAY_TEXT: TWideStringField;
    tblBasicsDetailOVERALL_DISPLAY_TEXT: TWideStringField;
    tblDataDateDATABASEDATE: TWideStringField;
    dbReference: TUniConnection;
    qryISS_DOTNUM: TUniQuery;
    providerReference: TInterBaseUniProvider;
    procedure tblCarriersCalcFields(DataSet: TDataSet);
    procedure tblUCRCalcFields(DataSet: TDataSet);
    procedure tblISSCalcFields(DataSet: TDataSet);
    procedure tblUpdateStatusCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetCountryDesc(const CountryCode: string): string;
    function RebuildIdx: Boolean;
    procedure EmptyDatabase(tblname: string);
  end;

var
  dmISS_FB: TdmISS_FB;



implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dataModSAFER;

{$R *.dfm}

procedure TdmISS_FB.tblCarriersCalcFields(DataSet: TDataSet);
begin
  TblCarriersCountryCalc.AsString := GetCountryDesc(tblCarriers.FieldByName('COUNTRY').AsString);
end;

procedure TdmISS_FB.tblISSCalcFields(DataSet: TDataSet);
begin
  if (dmSAFER.qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger = 0) then
    tblIssVehicleOOSRate.AsInteger := dmSAFER.qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger
  else
    tblIssVehicleOOSRate.AsFloat := dmSAFER.qryIss.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsInteger / dmSAFER.qryIss.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsInteger;
  if (tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger = 0) then
    tblIssDriverOOSRate.Value := tblIss.FieldByName('OOS_DRIVER').AsFloat
  else
    tblIssDriverOOSRate.Value := tblIss.FieldByName('OOS_DRIVER').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat;

  tblIssVehicleOOSPercent.Value := tblIssVehicleOOSRate.AsFloat * 100;
  tblIssDriverOOSPercent.Value := tblIssDriverOOSRate.AsFLoat * 100;

  if (tblCarriers.FieldByName('TOTAL_VEHICLES').AsInteger = 0) then
    tblIssInspPerVehicle.Value := tblIss.FieldByName('VEHICLE_INSPECTIONS').AsFloat
  else
    tblIssInspPerVehicle.Value := tblIss.FieldByName('VEHICLE_INSPECTIONS').AsFloat / tblCarriers.FieldByName('TOTAL_VEHICLES').AsFloat;

  if (tblCarriers.FieldByName('TOTAL_DRIVERS').AsInteger = 0) then
    tblIssInspPerDriver.Value := tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat
  else
    tblIssInspPerDriver.Value := tblIss.FieldByName('DRIVER_INSPECTIONS').AsFloat / tblCarriers.FieldByName('TOTAL_DRIVERS').AsFloat;

  if (tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger = 0) then begin
    tblISSv1BrakesRate.AsFloat := tblIss.FieldByName('VIOL_BRAKES').AsFloat;
    tblIssv1WheelRate.AsFloat := tblIss.FieldByName('VIOL_WHEELS').AsFloat;
    tblIssv1SteerRate.AsFloat := tblIss.FieldByName('Viol_STEERING').AsFloat;
    end
  else begin
    tblISSv1BrakesRate.AsFloat := tblIss.FieldByName('VIOL_BRAKES').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
    tblIssv1WheelRate.AsFloat := tblIss.FieldByName('VIOL_WHEELS').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
    tblIssv1SteerRate.AsFloat := tblIss.FieldByName('VIOL_STEERING').AsFloat / tblIss.FieldByName('VEHICLE_INSPECTIONS').AsInteger;
  end;

  if (tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger = 0) then begin
    tblIssv1MedicalRate.AsFloat := tblIss.FieldByName('VIOL_MEDICAL').AsFloat;
    tblIssv1LogsRate.AsFloat    := tblIss.FieldByName('VIOL_LOGS').AsFloat;
    tblIssv1HoursRate.AsFloat   := tblIss.FieldByName('VIOL_HOURS').AsFloat;
    tblIssv1DQRate.AsFloat      := tblIss.FieldByName('VIOL_DISQUAL').AsFloat;
    tblIssv1DrugsRate.AsFloat   := tblIss.FieldByName('VIOL_DRUGS').AsFloat;
    tblIssv1TrafficRate.AsFloat := tblIss.FieldByName('VIOL_TRAFFIC').AsFloat;
    end
  else begin
    tblIssv1MedicalRate.AsFloat := tblIss.FieldByName('VIOL_MEDICAL').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1LogsRate.AsFloat    := tblIss.FieldByName('VIOL_LOGS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1HoursRate.AsFloat   := tblIss.FieldByName('VIOL_HOURS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1DQRate.AsFloat      := tblIss.FieldByName('VIOL_DISQUAL').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1DrugsRate.AsFloat   := tblIss.FieldByName('VIOL_DRUGS').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
    tblIssv1TrafficRate.AsFloat := tblIss.FieldByName('VIOL_TRAFFIC').AsFloat / tblIss.FieldByName('DRIVER_INSPECTIONS').AsInteger;
  end;

  if (tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger = 0) then begin
    tblIssv1HMPaperRate.asFloat := tblIss.FieldByName('VIOL_HMPAPER').AsFloat;
    tblIssv1HMPlacRate.AsFloat  := tblIss.FieldByName('VIOL_HMPLAC').AsFloat;
    tblIssv1HMOperRate.AsFloat  := tblIss.FieldByName('VIOL_HMOPER').AsFloat;
    tblIssv1HMTankRate.AsFloat  := tblIss.FieldByName('VIOL_HMTANK').AsFloat;
    tblIssv1HMOthrRate.AsFloat  := tblIss.FieldByName('VIOL_HMOTHR').AsFloat;
    end
  else begin
    tblIssv1HMPaperRate.AsFloat := tblIss.FieldByName('VIOL_HMPAPER').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMPlacRate.AsFloat  := tblIss.FieldByName('VIOL_HMPLAC').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMOperRate.AsFloat  := tblIss.FieldByName('VIOL_HMOPER').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMTankRate.AsFloat  := tblIss.FieldByName('VIOL_HMTANK').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
    tblIssv1HMOthrRate.AsFloat  := tblIss.FieldByName('VIOL_HMOTHR').AsFloat / tblIss.FieldByName('HAZMAT_INSPECTIONS').AsInteger;
  end;
end;

procedure TdmISS_FB.tblUCRCalcFields(DataSet: TDataSet);
begin
  if tblUCR.FieldByName('PAYMENT_FLAG').AsString = 'Y' then
    tblUCRPAY_FLAG_TEXT.AsString := 'YES'
  else if tblUCR.FieldByName('PAYMENT_FLAG').AsString = 'N' then
    tblUCRPAY_FLAG_TEXT.AsString := 'NO';

  if tblUCR.FieldByName('INTRASTATE_VEHICLES').AsString = 'Y' then
    tblUCRINTRA_VEH_TEXT.AsString := 'YES'
  else if tblUCR.FieldByName('INTRASTATE_VEHICLES').AsString = 'N' then
    tblUCRINTRA_VEH_TEXT.AsString := 'NO';
end;

{-----------------------------------------------------------------------------
  Function:  GetCountryDesc
  Author:    J. L. Vasser, FMCSA
  Date:      2017-08-05
  Arguments: const CountryCode: string
  Return:    string
  Comments:  Translates SAFER's strange country codes to the country name
-----------------------------------------------------------------------------}
function TdmISS_FB.GetCountryDesc(const CountryCode: string): string;
begin
  case IndexStr('CountryCode',['A','C','M','P','S']) of
    0 : Result := 'UNITED STATES';
    1 : Result := 'CANADA';
    2 : Result := 'MEXICO';
    3 : Result := 'UNITED STATES'; // Puerto Rico // Don't know why its separate
    4 : Result := 'Central America';
  else
    Result := CountryCode;
  end;
end;

procedure TdmISS_FB.tblUpdateStatusCalcFields(DataSet: TDataSet);
begin
  case tblUpdateStatus.FieldByName('UpdtStatus').asInteger of
    0 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Not Begun';
    1 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Pending';
    2 : tblUpdateStatus.FieldByName('StatusDesc').AsString := 'Complete';
  end;
end;

function TdmISS_FB.RebuildIdx: Boolean;
begin
  Result := False;
  try
    Result := True;
  except on E: Exception do
    ShowMessage('Reactivating and rebuilding Indexes Failed:'+#13#10+E.Message);
  end;
end;

procedure TdmISS_FB.EmptyDatabase(tblname: string);
begin
  with dbISS_LOCAL do begin
    if inTransaction then
      Rollback;
    StartTransaction;
    with sqlDelete do begin
      SQL.Clear;
      SQL.Text := 'delete from ' + tblname;
      Execute;
      end;
    try
      Commit;
    except on E: Exception do
      Rollback;
    end;
  end;
end;

end.
