unit dialogSelectTable;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, RzPanel, RzDlgBtn, Vcl.Grids, vcl.wwdbigrd, vcl.wwdbgrid,
  RzButton, Vcl.ComCtrls;

type
  TdlgSelectDataSet = class(TForm)
    btnBar: TRzDialogButtons;
    btnCarrier: TRzBitBtn;
    btnISS: TRzBitBtn;
    btnLegalName: TRzBitBtn;
    btnDbaName: TRzBitBtn;
    btnInsurance: TRzBitBtn;
    btnBASICs: TRzBitBtn;
    btnHMpermit: TRzBitBtn;
    progBar: TProgressBar;
    btnUCR: TRzBitBtn;
    StatusBar: TStatusBar;
    procedure btnCarrierClick(Sender: TObject);
    procedure btnISSClick(Sender: TObject);
    procedure btnLegalNameClick(Sender: TObject);
    procedure btnDbaNameClick(Sender: TObject);
    procedure btnInsuranceClick(Sender: TObject);
    procedure btnBASICsClick(Sender: TObject);
    procedure btnHMpermitClick(Sender: TObject);
    procedure btnUCRClick(Sender: TObject);
  private
    { Private declarations }
    function DoCarrierLoad: Boolean;
    function DoLegalNameLoad: Boolean;
    function DoDbaNameLoad: Boolean;
    function DoISSLoad: Boolean;
    function DoHMLoad:  Boolean;
    function DoInsLoad: Boolean;
    function DoUcrLoad: Boolean;
    function DoBasicsLoad: Boolean;
    procedure UpdateProgress;
  public
    { Public declarations }
  end;

var
  dlgSelectDataSet: TdlgSelectDataSet;

implementation

{$R *.dfm}

uses formMain, dataModSAFER, dataModISS_Firebird, dataModReference;

procedure TdlgSelectDataSet.UpdateProgress;
var pct : double;
begin
  progBar.StepIt;
  pct := (progBar.Position div progBar.Max) * 100;
  StatusBar.Panels[4].Text := FloatToStr(pct)+'%';
  StatusBar.Panels[1].Text := IntToStr(progBar.Position);
  statusBar.Repaint;
  progBar.Repaint;
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------
  Function:  DoISSLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-15
  Comments:  Populate ISS Local table with ISS Score Values

             2017-12-12 JLV -
             added step to get the next USDOT num from the already-filled CARRIERS table.
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoISSLoad: Boolean;
var i, t : integer;
    sDot : string;
begin
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmISS_FB.dbISS_LOCAL.Connected then
    dmISS_FB.dbISS_LOCAL.Connect;
  Result := False;
  i := 0;
  t := 0;
  try
    with dmReference.qrySnapshot do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      //lblTotalRecords.Caption := IntToStr(progBarISS.Max);
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        //sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        //showmessage('sDot = '+sDot);
        //if Locate('USDOTNUM',sDot,[]) then begin

          if not dmPull.tblISS.Active then
            dmPull.tblISS.Open;
          dmPull.tblISS.Append;
          dmPull.tblISS.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          //dmPull.tblISS.FieldByName('USDOTNUM').AsString := sDot;
          dmPull.tblISS.FieldByName('TOTAL_INSPECTIONS').AsString := FloatToStr(FieldByName('QUANTITY_INSPECTIONS_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('VEHICLE_INSPECTIONS').AsString := FloatToStr(FieldByName('VEHICLE_INSPECTIONS_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('DRIVER_INSPECTIONS').AsString := FloatToStr(FieldByName('DRIVER_INSPECTIONS_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('HAZMAT_INSPECTIONS').AsString := FloatToStr(FieldByName('QUANTITY_HAZMAT_PRESENT_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('OOS_TOTAL').AsString := FloatToStr(FieldByName('OOS_ALL_TYPES_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('OOS_VEHICLE').AsString := FloatToStr(FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('OOS_DRIVER').AsString := FloatToStr(FieldByName('OOS_DRIVER_INSPECTIONS_LAST30').AsFloat);
          dmPull.tblISS.FieldByName('SAFETY_RATING').AsString := FieldByName('SAFETY_RATING').AsString;
          dmPull.tblISS.FieldByName('RATING_DATE').AsDateTime := FieldByName('RATING_DATE').AsDateTime;
          dmPull.tblISS.FieldByName('VIOL_BRAKES').AsString := FloatToStr(FieldByName('VIOLATION_BRAKES').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_WHEELS').AsString := FloatToStr(FieldByName('VIOLATION_WHEELS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_STEERING').AsString := FloatToStr(FieldByName('VIOLATION_STEERING').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_MEDICAL').AsString := FloatToStr(FieldByName('VIOLATION_MEDICAL_CERTIFICATE').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_LOGS').AsString := FloatToStr(FieldByName('VIOLATION_LOGS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HOURS').AsString := FloatToStr(FieldByName('VIOLATION_HOURS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_DISQUAL').AsString := FloatToStr(FieldByName('VIOLATION_LICENSE').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_DRUGS').AsString := FloatToStr(FieldByName('VIOLATION_DRUGS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_TRAFFIC').AsString := FloatToStr(FieldByName('VIOLATION_TRAFFIC').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HMPAPER').AsString := FloatToStr(FieldByName('VIOLATION_PAPERS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HMPLAC').AsString := FloatToStr(FieldByName('VIOLATION_PLACARDS').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HMOPER').AsString := FloatToStr(FieldByName('VIOLATION_OP_EMER_RESP').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HMTANK').AsString := FloatToStr(FieldByName('VIOLATION_TANK').AsFloat);
          dmPull.tblISS.FieldByName('VIOL_HMOTHR').AsString := FloatToStr(FieldByName('VIOLATION_OTHER').AsFloat);
          dmPull.tblISS.Post;
        //end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 ISS records and committed '+frmMain.TimeStamp,false);
          i := 0;
          end;
        dmISS_FB.tblCarriers.Next;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
      end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating ISS Scores table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating HM Scores Table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoHMLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-16
  Comments:  Populate ISS Local table with HM Violation data
             2017-12-12 JLV -
             added step to get the next USDOT num from the already-filled CARRIERS table.
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoHMLoad: Boolean;
var i, t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmPull.dbISS_LOCAL.Connected then
    dmPull.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmPull.qryHMPermit do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if Locate('USDOTNUM',sDot,[]) then begin           //qryHmPermit

          if not dmPull.tblHMPermit.Active then
            dmPull.tblHMPermit.Open;
          dmPull.tblHMPermit.Append;
          //dmPull.tblHMPermit.FieldByName('USDOTNUM').AsString    := FieldByName('USDOTNUM').AsString;
          dmPull.tblHMPermit.FieldByName('USDOTNUM').AsString := sDot;
          dmPull.tblHMPermit.FieldByName('PERMIT_TYPE').AsString := FieldByName('HM_PERMIT_TYPE').AsString;
          dmPull.tblHMPermit.FieldByName('PERMIT_STATUS').AsString := FieldByName('HM_PERMIT_STATUS').AsString;
          if FieldByName('HM_PERMIT_EFFECTIVE_DATE').AsString <> '' then
            dmPull.tblHMPermit.FieldByName('EFFECTIVE_DATE').AsDateTime  := FieldByName('HM_PERMIT_EFFECTIVE_DATE').AsDateTime;
          if FieldByName('HM_PERMIT_EXPIRATION_DATE').AsString <> '' then
            dmPull.tblHMPermit.FieldByName('EXPIRATION_DATE').AsDateTime := FieldByName('HM_PERMIT_EXPIRATION_DATE').AsDateTime;
          dmPull.tblHMPermit.FieldByName('OPERATING_UNDER_APPEAL').AsString := FieldByName('OPERATING_UNDER_APPEAL_FLAG').AsString;     dmPull.tblHMPermit.Post;
          dmPull.tblHMPermit.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 HM Permit records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        dmISS_FB.tblCarriers.Next;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating HM Permit table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating HM Permit Table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoCarrierLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with all Active Carriers
             Must be first step!
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoCarrierLoad: Boolean;
var i,t : integer;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmPull.dbISS_LOCAL.Connected then
    dmPull.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmPull.qryCarrier do begin
      if not Active then
        Open;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        if not dmISS_FB.tblCarriers.Active then
          dmISS_FB.tblCarriers.Open;
        dmISS_FB.tblCarriers.Append;
        dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
        dmISS_FB.tblCarriers.FieldByName('ADDRESS').AsString := FieldByName('ADDRESS').AsString;
        dmISS_FB.tblCarriers.FieldByName('ZIPCODE').AsString := FieldByName('ZIPCODE').AsString;
        dmISS_FB.tblCarriers.FieldByName('COUNTRY').AsString := FieldByName('COUNTRY').AsString;
        dmISS_FB.tblCarriers.FieldByName('PHONE').AsString := FieldByName('PHONE').AsString;
        dmISS_FB.tblCarriers.FieldByName('ICC_NUM').AsString := FieldByName('ICC_NUM').AsString;
        //dmISS_FB.tblCarriers.FieldByName('RFC_NUM').AsString := FieldByName('   {* there's no RFC_NUM in SAFER? *}
        dmISS_FB.tblCarriers.FieldByName('INSPECTION_VALUE').AsString := FieldByName('INSPECTION_VALUE').AsString;
        dmISS_FB.tblCarriers.FieldByName('INDICATOR').AsString := FieldByName('INDICATOR').AsString;
        dmISS_FB.tblCarriers.FieldByName('TOTAL_VEHICLES').AsInteger := FieldByName('TOTAL_VEHICLES').AsInteger;
        dmISS_FB.tblCarriers.FieldByName('TOTAL_DRIVERS').AsInteger := FieldByName('TOTAL_DRIVERS').AsInteger;
        dmISS_FB.tblCarriers.FieldByName('CARRIER_OPERATION').AsString := FieldByName('CARRIER_OPERATION').AsString;
        dmISS_FB.tblCarriers.FieldByName('NEW_ENTRANT_CODE').AsString := FieldByName('NEW_ENTRANT_CODE').AsString;
        dmISS_FB.tblCarriers.FieldByName('STATUS').AsString := FieldByName('STATUS').AsString;
        if FieldByName('LAST_UPDATE_DATE').AsString <> '' then
          dmISS_FB.tblCarriers.FieldByName('LAST_UPDATE_DATE').AsDateTime := FieldByName('LAST_UPDATE_DATE').AsDateTime;
        dmISS_FB.tblCarriers.FieldByName('ENTITY_TYPE').AsString := FieldByName('ENTITY_TYPE').AsString;
        dmISS_FB.tblCarriers.FieldByName('UNDELIVERABLE_PA').AsString := FieldByName('UNDELIVERABLE_PA').AsString;
        dmISS_FB.tblCarriers.FieldByName('UNDELIVERABLE_MA').AsString := FieldByName('UNDELIVERABLE_MA').AsString;
        dmISS_FB.tblCarriers.FieldByName('HAS_POWER_UNITS').AsString := FieldByName('HAS_POWER_UNITS').AsString;
        dmISS_FB.tblCarriers.FieldByName('OPER_AUTH_STATUS').AsString := FieldByName('OPER_AUTH_STATUS').AsString;
        if FieldByName('OOS_DATE').AsString <> '' then
          dmISS_FB.tblCarriers.FieldByName('OOS_DATE').AsDateTime := FieldByName('OOS_DATE').AsDateTime;
        dmISS_FB.tblCarriers.FieldByName('OOS_TEXT').AsString := FieldByName('OOS_TEXT').AsString;
        dmISS_FB.tblCarriers.FieldByName('OOS_REASON').AsString := FieldByName('OOS_REASON').AsString;
        dmISS_FB.tblCarriers.FieldByName('MCSIP_STATUS').AsString := FieldByName('MCSIP_STATUS').AsString;
        dmISS_FB.tblCarriers.Post;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 Carriers records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
       Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carriers table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carriers Table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoLegalNameLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Legal Name values
             2017-12-12 JLV -
             added step to get the next USDOT num from the already-filled CARRIERS table.
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoLegalNameLoad: Boolean;
var i,t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmPull.dbISS_LOCAL.Connected then
    dmPull.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmPull.qryName do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if Locate('USDOTNUM',sDot,[]) then begin

          if not dmPull.tblCarrName.Active then
            dmPull.tblCarrName.Open;
          dmPull.tblCarrName.Append;
          //dmPull.tblCarrName.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          dmPull.tblCarrName.FieldByName('USDOTNUM').AsString := sDOT;
          dmPull.tblCarrName.FieldByName('NAME').AsString := FieldByName('NAME').AsString;
          dmPull.tblCarrName.FieldByName('CITY').AsString := FieldByName('CITY').AsString;
          dmPull.tblCarrName.FieldByName('STATE').AsString := FieldByName('STATE').AsString;
          dmPull.tblCarrName.FieldByName('NAME_TYPE_ID').AsString := '1';
          dmPull.tblCarrName.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 Carrier Name records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        dmISS_FB.tblCarriers.Next;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carrier Name table (Legal Name) at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carrier Name table (Legal Name) at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoDbaNameLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Operating Name (DBA) values
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoDbaNameLoad: Boolean;
var i, t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmPull.dbISS_LOCAL.Connected then
    dmPull.dbISS_LOCAL.Connect;
  i := 0;
  t := 0;
  try
    with dmPull.qryName2 do begin
      if not Active then
        Open;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if Locate('USDOTNUM',sDot,[]) then begin

          if not dmPull.tblName2.Active then
            dmPull.tblName2.Open;
          dmPull.tblName2.Append;
          dmPull.tblName2.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          dmPull.tblName2.FieldByName('NAME').AsString := FieldByName('NAME').AsString;
          dmPull.tblName2.FieldByName('CITY').AsString := FieldByName('CITY').AsString;
          dmPull.tblName2.FieldByName('STATE').AsString := FieldByName('STATE').AsString;
          dmPull.tblName2.FieldByName('NAME_TYPE_ID').AsString := '2';
          dmPull.tblName2.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
         frmMain.WriteStatus('Inserted 10,000 Carrier Name records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carrier Name table (DBA Name) at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carrier Name table (DBA Name) at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoInsLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Insurance data
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoInsLoad:Boolean;
var i, t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmPull.dbISS_LOCAL.Connected then
    dmPull.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmPull.qryIns do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if dmISS_FB.tblCarriers.Locate('USDOTNUM',sDOT,[]) then begin
          if not dmPull.tblCarrIns.Active then
            dmPull.tblCarrIns.Open;
          dmPull.tblCarrIns.Append;
          dmPull.tblCarrIns.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          dmPull.tblCarrIns.FieldByName('LIABILITY_STATUS').AsString := FieldByName('LIABILITY_STATUS').AsString;
          dmPull.tblCarrIns.FieldByName('LIABILITY_REQUIRED').AsInteger := FieldByName('LIBILITY_REQUIRED').AsInteger;
          dmPull.tblCarrIns.FieldByName('CARGO_STATUS').AsString := FieldByName('CARGO_STATUS').AsString;
          dmPull.tblCarrIns.FieldByName('BOND_STATUS').AsString := FieldByName('BOND_STATUS').AsString;
          dmPull.tblCarrIns.FieldByName('MEX_TERRITORY').AsString := FieldByName('MEX_TERRITORY').AsString;
          dmPull.tblCarrIns.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 Carrier Name records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        dmISS_FB.tblCarriers.Next;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoUcrLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier UCR Payment data
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoUcrLoad: Boolean;
var i, t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmISS_FB.dbISS_LOCAL.Connected then
    dmISS_FB.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmSAFER.qryUCR do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if Locate('USDOTNUM',sDot,[]) then begin

          if not dmPull.tblUCR.Active then
            dmPull.tblUCR.Open;
          dmPull.tblUCR.Append;
          dmPull.tblUCR.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          dmPull.tblUCR.FieldByName('BASE_STATE').AsString := FieldByName('BASE_STATE').AsString;
          dmPull.tblUCR.FieldByName('PAYMENT_FLAG').AsString := FieldByName('PAYMENT_FLAG').AsString;
          dmPull.tblUCR.FieldByName('REGISTRATION_YEAR').AsString := FieldByName('REGISTRATION_YEAR').AsString;
          if FieldByName('PAYMENT_DATE').AsString <> '' then
            dmPull.tblUCR.FieldByName('PAYMENT_DATE').AsDateTime := FieldByName('PAYMENT_DATE').AsDateTime;
          dmPull.tblUCR.FieldByName('INTRASTATE_VEHICLES').AsString := FieldByName('INTRASTATE_VEHICLES').AsString;
          dmPull.tblUCR.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmPull.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 Carrier UCR records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      dmPull.dbISS_LOCAL.Commit;
      if dmPull.TransactionLocal.Active then
        dmPull.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoBasicsLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier BASICs values
-----------------------------------------------------------------------------}
function TdlgSelectDataSet.DoBasicsLoad: Boolean;
var i, t : integer;
    sDot : string;
begin
  Result := False;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not dmISS_FB.dbISS_LOCAL.Connected then
    dmISS_FB.dbISS_LOCAL.Connect;

  i := 0;
  t := 0;
  try
    with dmPull.qryBASICS do begin
      if not Active then
        Open;
      if not dmISS_FB.tblCarriers.Active then
        dmISS_FB.tblCarriers.Open;
      dmISS_FB.tblCarriers.First;
      progBar.Max := RecordCount;
      progBar.Position := 0;
      statusBar.Panels[3].Text := IntToStr(progBar.Max);
      statusBar.Panels[1].Text := '0';
      First;
      repeat
        sDot := dmISS_FB.tblCarriers.FieldByName('USDOTNUM').AsString;
        if Locate('USDOTNUM',sDot,[]) then begin
          if not dmISS_FB.tblBasicsDetail.Active then
            dmISS_FB.tblBasicsDetail.Open;
          dmISS_FB.tblBasicsDetail.Append;
          dmISS_FB.tblBasicsDetail.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
          dmISS_FB.tblBasicsDetail.FieldByName('BASIC').AsInteger := FieldByName('BASIC').AsInteger;
          dmISS_FB.tblBasicsDetail.FieldByName('BASICPERCENTILE').AsInteger := FieldByName('BASICPERCENTILE').AsInteger;
          dmISS_FB.tblBasicsDetail.FieldByName('BASICSDEFIND').AsString := FieldByName('BASICSDEFIND').AsString;
          if FieldByName('BASICSRUNDATE').AsString <> '' then
            dmISS_FB.tblBasicsDetail.FieldByName('BASICSRUNDATE').AsDateTime := FieldByName('BASICSRUNDATE').AsDateTime;
          if FieldByName('INVESTIGATIONDATE').AsString <> '' then
            dmISS_FB.tblBasicsDetail.FieldByName('INVESTIGATIONDATE').AsDateTime := FieldByName('INVESTIGATIONDATE').AsDateTime;
          dmISS_FB.tblBasicsDetail.FieldByName('ROAD_DISPLAY_TEXT').AsString := FieldByName('ROAD_DISPLAY_TEXT').AsString;
          dmISS_FB.tblBasicsDetail.FieldByName('INVEST_DISPLAY_TEXT').AsString := FieldByName('INVEST_DISPLAY_TEXT').AsString;
          dmISS_FB.tblBasicsDetail.FieldByName('OVERALL_DISPLAY_TEXT').AsString := FieldByName('OVERALL_DISPLAY_TEXT').AsString;
          dmISS_FB.tblBasicsDetail.Post;
          end;
        Inc(i);
        Inc(t);
        UpdateProgress;
        if i = 10000 then begin
          dmISS_FB.dbISS_LOCAL.Commit;
          frmMain.WriteStatus('Inserted 10,000 Carrier BASICs records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        dmISS_FB.tblCarriers.Next;
        Next;
      until EOF;
      dmISS_FB.dbISS_LOCAL.Commit;
      if dmISS_FB.TransactionLocal.Active then
        dmISS_FB.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    MessageDlg('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,mtError,[mbAbort],0);
    frmMain.WriteStatus('Error updating Carrier Insurance table at record '+IntToStr(t)+':'+#13#10+E.Message,True);
    Exit;
    end;
  end;
end;

procedure TdlgSelectDataSet.btnBASICsClick(Sender: TObject);
begin
  Screen.Cursor := crSqlWait;
  try
    btnBASICs.Enabled := not DoBasicsLoad;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnCarrierClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
    if DoCarrierLoad = True then
      btnCarrier.Enabled := false;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnDbaNameClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
  if DoDbaNameLoad = True then
    btnDbaName.Enabled := False;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnHMpermitClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
  btnHMpermit.Enabled := not doHMLoad;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnInsuranceClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
    btnInsurance.Enabled := not DoInsLoad;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnISSClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
  if DoIssLoad = True then
    btnIss.Enabled := False;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnLegalNameClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
    if DoLegalNameLoad = True then
      btnLegalName.Enabled := False;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TdlgSelectDataSet.btnUCRClick(Sender: TObject);
begin
  screen.Cursor := crSqlWait;
  try
    btnUCR.Enabled := not DoUcrLoad;
  finally
    Screen.Cursor := crDefault;
  end;
end;


end.
