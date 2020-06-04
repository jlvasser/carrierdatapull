{-----------------------------------------------------------------------------
 Application: DataPullWizard.exe
 Unit Name: formWizard
 Author:    J. L. Vasser
 Date:      2019-06-10
 Purpose:   Derived from "New Data Pull" utility, FMCSA, October 2017.
            "This utility reads data from the Production SAFER database schema
            to create a Carrier Data database for Aspen 3.x (and future ISS 4.x)
            This utility requires the user to be connected to the AWS environment,
            either by VPN or by running this from a server within the AWS cloud.
            The Aspen ISS_FED_DATA.FDB Firebird data file must be present and
            accessible to the utility.  An Oracle TNSNAMES.ORA file with the
            connection information for production SAFER must be in the same
            directory with the application."
            This version derived from "NewDataPull" incorporates much of the same
            code but uses a wizard-style input screen.
            For Aspen 3.0 this utility will create a Firebird database file.
            For Aspen 3.2 and beyond, the file will be SQLite format.
            This wizard has been developed as both a test of the components used
            and also to make the steps more clear to a new user.  (This utility
            is intended for a technical user, not for general distribution.)
 History:   This is based on code and concept of Dottie West, UGPTI (NDSU)
            The utility was modified to use Devart UniDAC components for faster
            response.
            Additionally, the GUI was modified some to provide progress feedback.

             2018-02-05 JLV -
             Changes to SAFER Queries.  See data module.

             2018-02-07 JLV -
             Modifed query on UCR to limit the amount of (useless) data returned.
             See DoUCRLoad function.

             2018-02-14 JLV -
             Removed unused procedures and functions.  General code clean-up

             2018-08-13 JLV -
             Added Secure BlackBox Zip component to dlgZipProgess.
             File compression within this utility now works

             2019-02-03 JLV -
             Modifications to also create ISS data in SQLite format for speed
             and smaller size. The Firebird database is being maintained for
             compatibility with Aspen 3.0.  The SQLite version will be for Aspen
             versions 3.2 and later.  (There is no 3.1).

             2019-02-04 JLV -
             Added global variable "dbSelected".  Set by radio buttons on the
             main form, 0 indicates the user has selected the Firebird database
             while 1 indicates the user has selected the SQLite database.

             2019-04-16 JLV -
             Added short code snippet and dialog to allow for quick changing
             between AWS and ADDOT

             2019-04-24 JLV -
             Due to issues with starting the application, renamed data module
             "dmPull" to "dmSAFER" and recreated the Oracle UniDAC connection.

             2019-04-29 JLV -
             Added new data module "dmReference" [dataModReference.pas] to
             have a static USDOT# set for creating all child table

             2019-06-10 JLV -
             New Wizard-style interface using Developer Express components

             2019-07-15 JLV -
             Added new procedure "writeExcept" to both display errors and
             write them to the log
-----------------------------------------------------------------------------}
unit formWizard;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  VCL.Graphics, VCL.Controls, VCL.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Menus, Vcl.ComCtrls, RzShellDialogs,

  Uni, Data.DB, MemDS, DBAccess,

  cxControls, cxGraphics, cxLookAndFeelPainters, cxLookAndFeels,
  dxCustomWizardControl, dxWizardControl, dxWizardControlForm,
  cxContainer, cxEdit, cxTextEdit, cxLabel, cxMemo, cxGroupBox,
  cxRadioGroup, cxMaskEdit, cxButtonEdit, cxRichEdit, cxProgressBar, cxButtons,

  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkroom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinOffice2019Colorful, RzPrgres;

type
  TfrmMain = class(TdxWizardControlForm)
    wizCtrl: TdxWizardControl;
    WizPage_DataDate: TdxWizardControlPage;
    btnGetMonthYear: TSpeedButton;
    lblPage1: TcxLabel;
    lblDate: TcxLabel;
    edtDataDate: TcxTextEdit;
    WizPage_Home: TdxWizardControlPage;
    cxMemo1: TcxMemo;
    WizPage_DataLocation: TdxWizardControlPage;
    WizPage_Target: TdxWizardControlPage;
    grpTargetSystem: TcxRadioGroup;
    lblTargetSystem: TcxLabel;
    lblDataLocation: TcxLabel;
    edtDataPath: TcxButtonEdit;
    WizPage_StartProcess: TdxWizardControlPage;
    WizPage_Processing: TdxWizardControlPage;
    lblOverallProgress: TcxLabel;
    lblTableProgress: TcxLabel;
    lblTotalRecords: TcxLabel;
    lblConfirmTarget: TcxLabel;
    lblTargetDataDate: TcxLabel;
    lblDataPath: TcxLabel;
    radBtnConfirmFB: TcxRadioButton;
    radBtnConfirmSQLite: TcxRadioButton;
    edtConfirmDate: TcxTextEdit;
    edtConfirmDataPath: TcxTextEdit;
    dlgDataPath: TRzOpenDialog;
    btnConfirmed: TcxButton;
    memoLog: TMemo;
    progBarTable: TRzProgressBar;
    progBarOverall: TRzProgressBar;
    edtRefDataPath: TcxButtonEdit;
    lblRefData: TcxLabel;
    lblRefDataPath: TcxLabel;
    edtConfirmRefPath: TcxTextEdit;
    procedure btnGetMonthYearClick(Sender: TObject);
    procedure grpTargetSystemClick(Sender: TObject);
    procedure edtDataPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCreate(Sender: TObject);
    procedure wizCtrlPageChanged(Sender: TObject);
    procedure edtDataDatePropertiesChange(Sender: TObject);
    procedure wizCtrlButtonClick(Sender: TObject;
      AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure btnConfirmedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtRefDataPathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

  private
    { Private declarations }
    function MakeDataDate: string;
    function TimeStamp: string;
    function GetTimeElapsed(TotalTime: Boolean): string;
    //function CreateZipFile: Boolean;
    function SetGenId: Boolean;
    function DoRefLoad: Boolean;
    function DoCarrierLoad: Boolean;
    function DoIssLoad: Boolean;
    function DoLegalNameLoad: Boolean;
    function DoDbaNameLoad: Boolean;
    function DoHmLoad: Boolean;
    function DoInsLoad: Boolean;
    function DoUcrLoad: Boolean;
    function DoBasicsLoad: Boolean;
    function CheckSnapshot: string;
    procedure BetweenSteps;
    procedure ResetProgBarTable(RecCount: integer);

  public
    { Public declarations }
    StartTime: TDateTime;
    EndTime: TDateTime;
    ZipComplete: Boolean;
    dbSelected: integer;              //dbSelected 0 := Firebird, 1 := SQLite;
    dmSelected: TDataModule;          // sets the selected data module
    LogPath: string;
    procedure ClearData(tblname: string);
    procedure WriteStatus(msg: string; XtraLine: Boolean);
    procedure StartProcessing;
    procedure ShowProgress;
    procedure TableProgress;
    procedure ProcessBatch;
    procedure writeExcept(errMsg: string);
    //procedure CallActivateIndex;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses dataModISS_Firebird, dataModISS_SQLite, dataModReference, dataModSAFER,
     dialogEnvironment, dialogZipProgress;

{-----------------------------------------------------------------------------
  Procedure: writeExcept
  Author:    J. L. Vasser, FMCSA, 2019-07-15
  Comments:  Display error message and write the error to the log.
-----------------------------------------------------------------------------}
procedure TfrmMain.writeExcept(errMsg: string);
begin
  MessageDlg(errMsg,mtError,[mbAbort],0);
  WriteStatus(errMsg,True);
end;

{-----------------------------------------------------------------------------
  Function:  MakeDataDate
  Author:    J. L. Vasser, FMCSA
  Date:      2017-11-13
  Arguments: None
  Return:    string
  Comments:  Creates the default Data Date label of MonthYear
-----------------------------------------------------------------------------}
function TfrmMain.MakeDataDate: string;
var monthYear : string ;
begin
  Result := '';
  DateTimeToString(monthYear,'mmmmyyyy',now);
  Result := monthYear;
end;

{-----------------------------------------------------------------------------
  Procedure: btnGetMonthYearClick
  Author:    J. L. Vasser, FMCSA, 2019-06-13
  Comments:  Calls MakeDataDate then returns value to UI

             2019-06-26 JLV -
             Added call to wizCtrlPageChanged procedure
-----------------------------------------------------------------------------}
procedure TfrmMain.btnGetMonthYearClick(Sender: TObject);
begin
  edtDataDate.Text := MakeDataDate;
  wizCtrlPageChanged(self);
  edtConfirmDate.Text := edtDataDate.Text;
end;

{-----------------------------------------------------------------------------
  Procedure: btnConfirmedClick
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Calls the wizCtrlPageChanged procedure
-----------------------------------------------------------------------------}
procedure TfrmMain.btnConfirmedClick(Sender: TObject);
begin
  wizCtrl.Buttons.Next.Enabled := True;
end;

{-----------------------------------------------------------------------------
  Procedure: wizCtrlButtonClick
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Closes the wizard application after user confirmation

             2019-06-27 JLV -
             Added code to check if back button clicked,
             then ensure Next button caption reads "Next"
-----------------------------------------------------------------------------}
procedure TfrmMain.wizCtrlButtonClick(Sender: TObject;
  AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  if AKind = wcbkCancel then begin
    if MessageDlg('Exit DataPull Wizard?',mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
      // maybe add close database routines
      Close;
    end;
  end;

  if AKind = wcbkBack then
    if wizCtrl.Buttons.Next.Caption = '&Start' then
      wizCtrl.Buttons.Next.Caption := '&Next';
  if (AKind = wcbkNext) and (wizCtrl.Buttons.Next.Caption = 'Finish') then begin
    // do stuff to check zip file and close database
    Close;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: wizCtrlPageChanged
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Enables the "Next" button when specified parameters are complete for each page.
-----------------------------------------------------------------------------}
procedure TfrmMain.wizCtrlPageChanged(Sender: TObject);
var BtnEnabled : Boolean;
begin
  BtnEnabled := False;
  case wizCtrl.ActivePageIndex of
    0 : BtnEnabled := True;                               // starting page
    1 : BtnEnabled := grpTargetSystem.ItemIndex <> -1;    // target system page
    2 : BtnEnabled := edtDataDate.Text <> '';             // date selected page
    3 : BtnEnabled := edtDataPath.Text <> '';             // data path page
    4 : begin
          wizCtrl.Buttons.Next.Caption := '&Start';       // confirmation page

        end;
    5 : begin
          BtnEnabled := False;
          memoLog.Repaint;
          StartProcessing;
        end;
  end;
  wizCtrl.InfoPanel.Caption := 'Carrier Data Pull Wizard - Page '+IntToStr(wizCtrl.ActivePageIndex);
  wizCtrl.Buttons.Next.Enabled := BtnEnabled;
end;

{-----------------------------------------------------------------------------
  Function:  TimeStamp
  Author:    J. L. Vasser, FMCSA
  Date:      2017-11-14
  Arguments: None
  Return:    string
  Comments:  Returns the current time in ISO format
-----------------------------------------------------------------------------}
function TfrmMain.TimeStamp: string;
var TimeNow : TDateTime;
    TimeStr : string;
begin
  TimeNow := now;                             // Need this for the following function
  DateTimeToString(TimeStr,'yyyy-mm-dd_hh-mm-ss',TimeNow);   // this statement wouldn't work with the function "now"
  Result := TimeStr;
end;

{-----------------------------------------------------------------------------
  Function:  GetTimeElapsed
  Author:    J. L. Vasser, FMCSA, 2017-10-12
  Comments:  Returns string of elapsed time since process started.

             2019-06-13 JLV -
             Added parameter "TotalTime".
             If true, calculates from StartTime to EndTime.
             If False, calculates from StartTime to NOW.
-----------------------------------------------------------------------------}
function TfrmMain.GetTimeElapsed(TotalTime:Boolean): string;
var DeltaTime : TDateTime;
    Hrs, Min, Sec, mSec : word;
begin
  Result := '';
  if TotalTime = True then
    DeltaTime := EndTime - StartTime
  else
    DeltaTime := Now - StartTime;
  DecodeTime(DeltaTime,Hrs,Min,Sec,mSec);
  if TotalTime = True then
    Result := 'TOTAL TIME ELAPSED: '+IntToStr(Hrs)+' hours, '+IntToStr(Min)+' minutes, '+IntToStr(Sec)+' seconds.'
  else
    Result := 'Time Elapsed: '+IntToStr(Hrs)+' hours, '+IntToStr(Min)+' minutes, '+IntToStr(Sec)+' seconds.';
end;

{-----------------------------------------------------------------------------
  Procedure: grpTargetSystemClick
  Author:    J. L. Vasser, FMCSA, 2019-02-04
  Comments:  Sets the value of the global variable "dbSelected".
             This variable indicates to produce a Firedbird or SQLIte output

             2019-06-13 JLV -
             Now using DevExpress progress bars.
             Made necessary property setting changes for these components

             2019-07-08 JLV -
             Changed to Raize Progress Bar compoents.
             Too many issues with Dev Express and insufficient documentation
-----------------------------------------------------------------------------}
procedure TfrmMain.grpTargetSystemClick(Sender: TObject);
var dmISS_FB : TdmISS_FB;
    dmISS_SQLite : TdmISS_SQLite;
begin
  dbSelected := grpTargetSystem.ItemIndex;
  if dbSelected = 0 then begin
    lblDataPath.Caption := 'Local Data Path (Firebird database)';
    WriteStatus('User selected Aspen 3.0 target (Firebird)',True);
    dmSelected := dmISS_FB;
    radBtnConfirmFB.Checked := True;
    end
  else begin
    lblDataPath.Caption := 'Local Data Path (SQLite database)';
    dmSelected := dmISS_SQLite;
    WriteStatus('User selected Aspen 3.2 target (SQLite)',True);
    radBtnConfirmSQLite.Checked := True;
    end;
  {if progBarOverall.Position > 0 then begin
    progBarOverall.Position := 0;
    progBarTable.Position := 0;
  end;}
  if progBarOverall.PartsComplete > 0 then begin
    progBarOverall.PartsComplete := 0;
    progBarTable.PartsComplete := 0;
    end;
  wizCtrlPageChanged(self);
end;

{-----------------------------------------------------------------------------
  Function:  SetGenId
  Author:    J. L. Vasser, FMCSA
  Date:      2018-02-20
  Arguments: None
  Return:    Boolean
  Comments:  Sets the UCR table sequence (generator) ahead by 10 after completion.
             Having the next value was causing a conflict in Aspen.

             2019-02-05 j -
             Is this needed for SQLite?
-----------------------------------------------------------------------------}
function TfrmMain.SetGenId: Boolean;
var i : integer;
begin
  Result := False;
  try
    with dmISS_FB.qryGenValue do begin
      SQL.Clear;
      SQL.add('select GEN_ID(UCR_UCR_SEQ_NUM_GEN,0) from RDB$DATABASE');
      ExecSql;
      i := FieldByName('GEN_ID').AsInteger;
      SQL.Clear;
      SQL.Add('set generator UCR_UCR_SEQ_NUM_GEN to '+IntToStr(i+10));
      ExecSQL;
      Result := True;
    end;
  except on E: Exception do begin
    MessageDlg('Unable to advance UCR table Generator.'+#13#10+'Set this value manually',mtError,[mbOK],0);
    WriteStatus('Unable to advance UCR table Generator.'+#13#10+'Set this value manually',True);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: ClearData
  Author:    J. L. Vasser, FMCSA
  Date:      2017-10-13
  Arguments: tblname: string
  Result:    None
  Comments:  Deletes all data from existing database

             2019-02-04 JLV -
             Moved the body to the data module for each database target

-----------------------------------------------------------------------------}
procedure TfrmMain.ClearData(tblname: string);
begin
  if dbSelected = 0 then
    dmISS_FB.EmptyDatabase(tblname)
  else
    dmISS_SQLite.EmptyDatabase(tblname);
end;

{-----------------------------------------------------------------------------
  Procedure: edtDataDatePropertiesChange
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Fires the wizCtrlPageChanged procuedure
-----------------------------------------------------------------------------}
procedure TfrmMain.edtDataDatePropertiesChange(Sender: TObject);
begin
  wizCtrlPageChanged(self);
end;

{-----------------------------------------------------------------------------
  Procedure: edtDataPathPropertiesButtonClick
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Gets the path for the user-selected target database
-----------------------------------------------------------------------------}
procedure TfrmMain.edtDataPathPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var db : string;
begin
  dlgDataPath.InitialDir := GetCurrentDir;
  if dbSelected = 0 then
    dlgDataPath.Filter := 'Firebird Database|ISS_FED_DATA.FDB|All Files|*.*'
  else
    dlgDataPath.Filter := 'SQLite Database|ISS_FED_DATA.db|All Files|*.*';
  dlgDataPath.Execute;
  db := dlgDataPath.FileName;
  if db = '' then begin
    MessageDlg('You must select the local data path!',mtError,[mbRetry],0);
    Exit;
    end;
  edtDataPath.Text := db;
  WriteStatus('User selected database at "'+edtDataPath.Text+'"',True);
  if dbSelected = 0 then
    try
      with dmISS_FB.dbISS_LOCAL do begin
        if Connected then Disconnect;
        ConnectString := '';
        Server := '';
        ProviderName := 'Interbase';
        SpecificOptions.Values['ClientLibrary'] := 'fbclient.dll';
        //Database := edtDataPath.Text;
        Database := db;
        UserName := 'SYSDBA';
        Password := 'masterkey';
        Connect;
        //dmISS_FB.dbISS_LOCAL.Open;
        wizCtrlPageChanged(self);
      end;
    except on E: Exception do begin
      MessageDlg('Database not found. "'+E.Message+'".  Please try again',mtError,[mbRetry],0);
      if edtDataPath.CanFocus then
        edtDataPath.SetFocus;
      end;
    end
  else                      // SQLite database (Aspen 3.2)
    try
      dmISS_SQLite.dbISS_LOCAL.Database := edtDataPath.Text;
      dmISS_SQLite.dbISS_LOCAL.Connect;
      wizCtrlPageChanged(self);
      //btnStart.Enabled := dmISS_SQLite.dbISS_LOCAL.Connected;
    except on E: Exception do begin
      MessageDlg('Database not found.  Please try again',mtError,[mbRetry],0);
      if edtDataPath.CanFocus then
        edtDataPath.SetFocus;
      end;
    end;
  edtConfirmDataPath.Text := edtDataPath.Text;
end;

{-----------------------------------------------------------------------------
  Procedure: edtRefDataPathPropertiesButtonClick
  Author:    J. L. Vasser, FMCSA, 2019-07-10
  Comments:  User selects the location of the Reference database.
             This database is used to load all USDOT numbers 1 time to
             ensure a static snapshot of data.
-----------------------------------------------------------------------------}
procedure TfrmMain.edtRefDataPathPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var db : string;
begin
  dlgDataPath.InitialDir := GetCurrentDir;
  dlgDataPath.Filter := 'Reference Database|DataPullRef.db|All Files|*.*';
  dlgDataPath.Execute;
  db := dlgDataPath.FileName;
  if db = '' then begin
    MessageDlg('You must select the local data path!',mtError,[mbRetry],0);
    Exit;
    end;
  edtRefDataPath.Text := db;
  try
    dmReference.dbReference.Database := edtRefDataPath.Text;
    dmReference.dbReference.Connect;
  except on E: Exception do begin
    MessageDlg('ERROR! Unable to open Wizard Reference Database!',mtError,[mbAbort],0);
    Exit;
    end;
  end;
  edtConfirmRefPath.Text := edtRefDataPath.Text;
end;

{-----------------------------------------------------------------------------
  Procedure: FormCreate
  Author:    J. L. Vasser, FMCSA, 2019-06-26
  Comments:  Ensures the wizard starts on the start page
-----------------------------------------------------------------------------}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  wizCtrl.ActivePageIndex := 0;
end;

{-----------------------------------------------------------------------------
  Procedure: WriteStatus
  Author:    J. L. Vasser, FMCSA
  Date:      2017-10-12
  Arguments: msg: string;XtraLine: Boolean
  Comments:  Writes status information to window, for optional save to log.

             2018-02-13 JLV -
             Added lines to move cursor to end.  This updates the display to show the latest line.
-----------------------------------------------------------------------------}
procedure TfrmMain.WriteStatus(msg: string; XtraLine: Boolean);
var //lin, col : integer;                     // cursor position variables
    pt : TPoint;
begin
  memoLog.Lines.Add(msg);
  if XtraLine = True then
    memoLog.Lines.Add('');
  if wizCtrl.ActivePageIndex = 5 then begin     // only forces repaint if control is visible
    pt := memoLog.CaretPos;
    //lin := memoLog.Line;                      // cursor line position
    //col := memoLog.Column;                    // cursor column position
    //memoLog.JumpTo(lin,col);                  // force the cursor to that position

    memoLog.Repaint;                          // force the display to refresh

    memoLog.CaretPos := pt;                   // force the cursor to that position
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: StartProcessing (formerly btnStartClick)
  Author:    J. L. Vasser, FMCSA
  Date:      2017-10-12
  Arguments: Sender: TObject
  Result:    None
  Comments:  The actual data extract process begins here

             2017-11-20 JLV -
             Replaced the LoadData function with specific functions for each dataset.

             2017-11-22 JLV -
             Added "OneByOne" variable.  For unknown reason, the process can't find
             a USDOT number when running sequentially.  Running one-by-one doesn't
             have that issue.

             2018-01-30 JLV -
             Commented "OneByOne" variable and related procedures now that
             the data generation is working correctly.

             2018-02-14 JLV -
             Remove the one-by-one option entirely.  Batch process now working as intended.

             2019-07-02 JLV -
             Copied this procedure over from the old version (non Wizard version)
             and renamed from "btnStartClick" to "StartProcessing"
-----------------------------------------------------------------------------}
procedure TfrmMain.StartProcessing;
var sNow : string;
    db : TUniConnection;
begin
    (*  Don't think this is necessary any longer.  The wizard should catch this. **
    if edtDataDate.Text = '' then begin
        MessageDlg('Please enter a "Data Date"',mtError,[mbRetry],0);
        if edtDataDate.CanFocus then
          edtDataDate.SetFocus;
        Exit;
      end;
  *)

  sNow := '';
  StartTime := Now;

  { set the target database via its data module }
  if dbSelected = 0 then
    db := dmISS_FB.dbISS_LOCAL
  else
    db := dmISS_SQLite.dbISS_Local;

  try
    DateTimeToString(sNow, 'dddd, mmm d, yyyy, hh:mm:ss',StartTime);
    WriteStatus('Starting Data Pull '+sNow, true);
    //step 1.0
    try
      if not db.Connected then db.Connect;
      ShowProgress;
    except on E: Exception do begin
      MessageDlg('Unable to connect to LOCAL ISS data',mtError,[mbAbort],0);
      Exit;
      end;
    end;
    // step 1.1
    try
      //dmSAFER.dbSAFER.Server := '10.75.161.103:1526/safer.safersys.org';  //development connection
      dmSAFER.dbSAFER.Server := 'safer.safersys.org:1526/safer.safersys.org';   //production connection
      dmSAFER.dbSAFER.Connect;
      ShowProgress;
      Application.ProcessMessages;
    except on E: Exception do begin
      MessageDlg('Unable to connect to SAFER database.'+#13#10+
      'Ensure you are connected to the AWS VPN'+#13#10+
      'App will now exit.  Check VPN and restart.',mtError,[mbAbort],0);
      WriteStatus('Unable to connect to SAFER database',False);
      WriteStatus('Ensure you are connected to the AWS VPN',False);
      WriteStatus('Check VPN and restart.',True);
      DateTimeToString(sNow, 'dddd, mmm d, yyyy, hh:mm:ss',Now);
      WriteStatus('Application terminated '+sNow,False);
      memoLog.Lines.SaveToFile(LogPath);
      Application.ProcessMessages;
      Application.Terminate;
      Exit;
      end;
    end;
    //step 2.0
    WriteStatus('Clearing Tables.................'+DateTimeToStr(now), false);
    WriteStatus('     Carriers', false);
    ClearData('CARRIERS');
    Application.ProcessMessages;
    ShowProgress;
    //step 3
    WriteStatus('     ISS', false);
    ClearData('ISS');
    Application.ProcessMessages;
    ShowProgress;
    //step 4
    WriteStatus('     Insurance', false);
    ClearData('CARRINS');
    Application.ProcessMessages;
    ShowProgress;
    Application.ProcessMessages;
    //step 5
    WriteStatus('     UCR', false);
    ClearData('UCR');
    Application.ProcessMessages;
    ShowProgress;
    //step 6
    WriteStatus('     HM Permit', false);
    ClearData('HMPERMIT');
    Application.ProcessMessages;
    ShowProgress;
    // step 7
    WriteStatus('     Carrier Names', false);
    ClearData('CARRNAME');
    Application.ProcessMessages;
    ShowProgress;
    // step 8
    WriteStatus('     BASICs', false);
    ClearData('BASICSDETAIL');
    Application.ProcessMessages;
    ShowProgress;
    // step 9
    Application.ProcessMessages;
    WriteStatus('..... Tables emptied', true);

    //inactivate the indexes//
    frmMain.Repaint;
    WriteStatus('Inactivating Indexes..............', false);

    if dbSelected = 0 then
      dmISS_FB.scriptInactivateIdx.Execute   // also resets the UCR Table generator to zero //
    else
      dmISS_SQLite.scriptInactivateIndex.Execute;

    ShowProgress;
    Application.ProcessMessages;

    WriteStatus('..... DONE', true);
    ShowProgress;

    // step 10.0
    if MessageDlg('Ready to begin loading data. Continue?',mtConfirmation,[mbOK,mbCancel],0) = mrCancel then begin
      WriteStatus('User aborted operation at '+TimeStamp,true);
      Exit;
      end;
    frmMain.Repaint;
    Application.ProcessMessages;

    // step 10.1
    WriteStatus('Updating Data Date...............', false);
    if dbSelected = 0 then begin
      with dmISS_FB.sqlDataDate do begin
        ParamByName('newDate').Clear;
        ParamByName('newDate').AsString := edtDataDate.Text;
        Execute;
        dmISS_FB.dbISS_LOCAL.Commit;
        end;
      end
    else begin
      with dmISS_SQLite.sqlDataDate do begin
        dmISS_SQLite.dbISS_Local.StartTransaction;
        ParamByName('newDate').Clear;
        ParamByName('newDate').AsString := edtDataDate.Text;
        Execute;
        dmISS_SQLite.dbISS_Local.Commit;
        end;
      end;


    Application.ProcessMessages;
    WriteStatus('...............DONE', true);

    { --------- This is where the data loading finally starts --------- }
    //step 10.2  -- This loads the reference table with a set of USDOT numbers.
    //              This provides a static list so that both versions of the output
    //              contain the same data.

    ShowProgress;
    if not DoRefLoad then begin
      MessageDlg('An error occurred loading the SNAPSHOT QUERY table',mtError,[mbAbort],0);
      Exit;
    end;
    BetweenSteps;


    //step 11  --  Now we go through each table of the database.
    ProcessBatch;

    // step 19
    WriteStatus('Process Complete!  '+ DateTimeToStr(now), true);
    frmMain.Repaint;
  finally
    dmSAFER.dbSAFER.Close;  // step 20
    //ShowProgress;

    if dmISS_FB.dbISS_LOCAL.Connected then
      dmISS_FB.dbISS_LOCAL.Close;
    if dmISS_SQLite.dbISS_LOCAL.Connected then
      dmIss_SQLite.dbISS_Local.Close;

    ShowProgress;
    EndTime := Now;
    WriteStatus(GetTimeElapsed(true),true);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: ProcessBatch
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Call procedures to load datasets
-----------------------------------------------------------------------------}
procedure TfrmMain.ProcessBatch;
begin                                                   // step 11 continued
  // step 11 (continued)
  WriteStatus('Loading Carrier data ............'+DateTimeToStr(now), false);
  if not DoCarrierLoad then begin
    WriteStatus('Carrier data load FAILED', false);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // Step 12
  WriteStatus('Loading ISS Score data...........'+DateTimeToStr(now), false);
  if not DoIssLoad then begin
    WriteStatus('ISS Score data load FAILED', true);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 13
  WriteStatus('Loading Carrier Name data .......'+DateTimeToStr(now), false);
  if not DoLegalNameLoad then begin
    WriteStatus('Carrier Name data load FAILED', false);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 14
  WriteStatus('Loading Carrier DBA Name data...'+DateTimeToStr(now), false);
  if not DoDbaNameLoad then begin
    WriteStatus('Carrier DBA Name data load FAILED', false);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 15
  WriteStatus('Loading HM Permit data...........'+DateTimeToStr(now), false);
  if not DoHMLoad then begin
    WriteStatus('HM Permit data load FAILED', true);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 16
  WriteStatus('Loading Insurance data...........'+DateTimeToStr(now), false);
  if not DoInsLoad then begin
    WriteStatus('Insurance data load FAILED', false);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 17
  WriteStatus('Loading UCR data.................'+DateTimeToStr(now), false);
  if not DoUcrLoad then begin
    WriteStatus('UCR data load FAILED', true);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;

  // step 18
  WriteStatus('Loading BASICs Score data........'+DateTimeToStr(now), false);
  if not DoBasicsLoad then begin
    WriteStatus('BASICs Score data load FAILED', false);
    WriteStatus(DateTimeToStr(now),true);
    Exit;
    end;
  BetweenSteps;
end;

{-----------------------------------------------------------------------------
  Function:  DoRefLoad
  Author:    J. L. Vasser, FMCSA, 2019-05-07
  Comments:  Loads basic data in the Reference DB "Snapshot" table.
             This is then used for building all other datasets.
-----------------------------------------------------------------------------}
function TfrmMain.DoRefLoad: Boolean;
var i,t : integer;
begin
  Result := False;
  if CheckSnapshot = 'KEEP' then begin              //check for existing data.
    Result := True;
    Exit;                                     // If user elects to keep, exit procedure
    end;
  i := 1;                                     // counter of records processed.  Commits every 10,000
  t := 0;                                     // counter of total records processed.

  Result := False;
  Application.ProcessMessages;

  try
    Screen.Cursor := crSqlWait;
    if not dmSAFER.dbSAFER.Connected then
      dmSAFER.dbSAFER.Connect;
    if not dmSAFER.qryCensus.Active then
      dmSAFER.qryCensus.Open;
    dmSAFER.qryCensus.First;

    if not dmReference.dbReference.Connected then
      dmReference.dbReference.Connect;
    if dmReference.refTransaction.Active then
      dmReference.refTransaction.Rollback;
  finally
    Screen.Cursor := crDefault;
  end;
  with dmSAFER.qryCensus do begin
    if not dmReference.qrySnapshot.Active then
      dmReference.qrySnapshot.Open;
    WriteStatus('Loading Reference Table ......',False);
    //ProgBarTable.Properties.Max := RecordCount;
    //ProgBarTable.Position := 0;
    //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max);   // was IntToStr, but the Max property is a double
    ResetProgBarTable(RecordCount);

    lblTotalRecords.Caption := IntToStr(progBarTable.TotalParts);
    First;
    Application.ProcessMessages;
    repeat
      if not dmReference.refTransaction.Active then
        dmReference.refTransaction.StartTransaction;
      dmReference.qrySnapshot.Append;
      dmReference.qrySnapshot.FieldByName('CARRIER_ID_NUMBER').AsInteger := FieldByName('CARRIER_ID_NUMBER').AsInteger;
      dmReference.qrySnapshot.FieldByName('USDOTNUM').AsString := FieldByName('USDOTNUM').AsString;
      dmReference.qrySnapshot.FieldByName('STATUS').AsString := FieldByName('STATUS').AsString;
      dmReference.qrySnapshot.FieldByName('LAST_UPDATE_DATE').AsString := FieldByName('LAST_UPDATE_DATE').AsString;
      dmReference.qrySnapshot.Post;
      Inc(i);
      Inc(t);
      if i = 10000 then begin
        if dmReference.refTransaction.Active then
          dmReference.refTransaction.Commit;
        WriteStatus('Loaded 10,000 Census records and committed.',False);
        WriteStatus(IntToStr(t)+' total records processed.  '+DateTimeToStr(now),True);
        i := 1;
        end;
      TableProgress;
      Next;
    until EOF;
    try
      WriteStatus('Saving reference table data ...',False);
      if dmReference.refTransaction.Active then
        dmReference.refTransaction.Commit;
      Result := True;
      WriteStatus('Successfully saved reference data.',True);
    except on E: Exception do begin
      MessageDlg('Error commiting dbReference: "'+E.Message+'"',mtError,[mbAbort],0);
      WriteStatus('Error commiting dbReference: "'+E.Message+'"',True);
      end;
    end;
  end;
  dmSAFER.qryCensus.Close;
end;

{-----------------------------------------------------------------------------
  Function:  DoCarrierLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with all Active Carriers

             2018-01-18 JLV -
             Programming note:  The underlying query left-pads the USDOT number
             with zeroes.  This hampers use of the USDOTNUM field as a variable
             to search other SOURCE tables.  Keep this in mind.

             2019-07-15 JLV -
             Implemented writeExcept procedure
-----------------------------------------------------------------------------}
function TfrmMain.DoCarrierLoad: Boolean;
var i,t : integer;
    db, ref : TUniConnection;
    qry : TUniQuery;
    tbl : TUniTable;
    sfr : TUniQuery;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblCarriers;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblCarriers;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  sfr := dmSAFER.qryCarrier;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  if not qry.Active then
    qry.Open;
  Result := False;
  i := 0;                               // counter of records processed.  Commits every 10,000
  t := 0;                               // counter of total records processed.
  try
    with qry do begin
      ResetProgBarTable(RecordCount);
      lblTotalRecords.Caption := IntToStr(progBarTable.TotalParts);

      First;
      repeat
        {sfr.Close;
        sfr.ParamByName('dot').Clear;
        sfr.ParamByName('dot').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end; }
        sfr.Filtered := False;
        sfr.Filter := '';
        sfr.Filter := 'CARRIER_ID_NUMBER = '+IntToStr(qry.FieldByName('CARRIER_ID_NUMBER').AsInteger);
        sfr.Filtered := True;
        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;
        if not tbl.Active then
          tbl.Open;
        tbl.Append;
        tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;
        tbl.FieldByName('ADDRESS').AsString  := sfr.FieldByName('ADDRESS').AsString;
        tbl.FieldByName('ZIPCODE').AsString  := sfr.FieldByName('ZIPCODE').AsString;
        tbl.FieldByName('COUNTRY').AsString  := sfr.FieldByName('COUNTRY').AsString;
        tbl.FieldByName('PHONE').AsString    := sfr.FieldByName('PHONE').AsString;

        { to allow for Aspen 3.0 not accepting longer docket numbers   ---------}
        if dbSelected = 0 then begin
          if length(sfr.FieldByName('ICC_NUM').AsString) > 6 then
            tbl.FieldByName('ICC_NUM').AsString := '';
          end
        else
          tbl.FieldByName('ICC_NUM').AsString := trim(sfr.FieldByName('ICC_NUM').AsString);
        {-----------------------------------------------------------------------}

        //tblCarriers.FieldByName('RFC_NUM').AsString := FieldByName('   {* there's no RFC_NUM in SAFER? *}

        tbl.FieldByName('INSPECTION_VALUE').AsString  := sfr.FieldByName('INSPECTION_VALUE').AsString;
        tbl.FieldByName('INDICATOR').AsString         := sfr.FieldByName('INDICATOR').AsString;
        tbl.FieldByName('TOTAL_VEHICLES').AsInteger   := sfr.FieldByName('TOTAL_VEHICLES').AsInteger;
        tbl.FieldByName('TOTAL_DRIVERS').AsInteger    := sfr.FieldByName('TOTAL_DRIVERS').AsInteger;
        tbl.FieldByName('CARRIER_OPERATION').AsString := sfr.FieldByName('CARRIER_OPERATION').AsString;
        tbl.FieldByName('NEW_ENTRANT_CODE').AsString  := sfr.FieldByName('NEW_ENTRANT_CODE').AsString;
        tbl.FieldByName('STATUS').AsString            := sfr.FieldByName('STATUS').AsString;
        if sfr.FieldByName('LAST_UPDATE_DATE').AsString <> '' then
          tbl.FieldByName('LAST_UPDATE_DATE').AsDateTime := sfr.FieldByName('LAST_UPDATE_DATE').AsDateTime;
        tbl.FieldByName('ENTITY_TYPE').AsString       := sfr.FieldByName('ENTITY_TYPE').AsString;
        tbl.FieldByName('UNDELIVERABLE_PA').AsString  := sfr.FieldByName('UNDELIVERABLE_PA').AsString;
        tbl.FieldByName('UNDELIVERABLE_MA').AsString  := sfr.FieldByName('UNDELIVERABLE_MA').AsString;
        tbl.FieldByName('HAS_POWER_UNITS').AsString   := sfr.FieldByName('HAS_POWER_UNITS').AsString;
        tbl.FieldByName('OPER_AUTH_STATUS').AsString  := sfr.FieldByName('OPER_AUTH_STATUS').AsString;
        if sfr.FieldByName('OOS_DATE').AsString <> '' then
          tbl.FieldByName('OOS_DATE').AsDateTime      := sfr.FieldByName('OOS_DATE').AsDateTime;
        tbl.FieldByName('OOS_TEXT').AsString          := sfr.FieldByName('OOS_TEXT').AsString;
        tbl.FieldByName('OOS_REASON').AsString        := sfr.FieldByName('OOS_REASON').AsString;
        tbl.FieldByName('MCSIP_STATUS').AsString      := sfr.FieldByName('MCSIP_STATUS').AsString;
        tbl.Post;
        Inc(i);
        Inc(t);
        TableProgress;
        if i = 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carriers records and committed.'+#10#13+'Total '+IntToStr(t)+' records '+DateTimeToStr(now),True);
          i := 0;
          end;
       Next;
      until EOF;
      //until t = 10000;
      if db.InTransaction then
        db.Commit;
      if dbSelected = 0 then begin
        if dmISS_FB.TransactionLocal.Active then
          dmISS_FB.TransactionLocal.Commit;
        end
      else begin
        if dmISS_SQLite.transactionLocal.Active then
          dmISS_SQLite.transactionLocal.Commit;
      end;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carriers Table at record '+IntToStr(t)+':'+#13#10+'"'+E.Message+'"');
    Exit;
    end;
  end;
end;


{-----------------------------------------------------------------------------
  Function:  DoLegalNameLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Legal Name values

             2019-07-15 JLV -
             implemented writeExcept procedure
-----------------------------------------------------------------------------}
function TfrmMain.DoLegalNameLoad: Boolean;
var d,i,t : integer;
    dot, dPad : string;
    db, ref : TUniConnection;
    qry : TUniQuery;
    sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblCarriers;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblCarriers;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryNAME;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;      // commit counter:  issue a database commit when counter reaches 10K
  t := 0;      // progress counter:  shows progress of iterating through the table
   try
      with qry do begin
      if not Active then Open;
      //progBarTable.Properties.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max);   //was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;

        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;
        if sfr.RecordCount > 0 then begin
          if not tbl.Active then
            tbl.Open;
          tbl.Append;
          tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;
          tbl.FieldByName('NAME').AsString := sfr.FieldByName('NAME').AsString;
          tbl.FieldByName('CITY').AsString := sfr.FieldByName('CITY').AsString;
          tbl.FieldByName('STATE').AsString := sfr.FieldByName('STATE').AsString;
          tbl.FieldByName('NAME_TYPE_ID').AsString := '1';
          tbl.Post;
          Inc(i);
          end
        else begin
          WriteStatus('LEGAL NAME value not found for USDOT # '+dot+' at record '+IntToStr(t),False);
          end;
        Inc(t);
        TableProgress;
        if i = 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carrier Name records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
      if dbSelected = 0 then begin
        if dmISS_FB.TransactionLocal.Active then
          dmISS_FB.TransactionLocal.Commit;
        end
      else begin
        if dmISS_SQLite.transactionLocal.Active then
          dmISS_SQLite.transactionLocal.Commit;
      end;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carrier Name table (Legal Name)for USDOT # '+dot+'  at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoDbaNameLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Operating Name (DBA) values

             2019-05-07 JLV -
             Added variable "sfr" for dmSAFER.qryNAME2

             2019-07-15 JLV -
             implemented writeExcept procedure
-----------------------------------------------------------------------------}
function TfrmMain.DoDbaNameLoad: Boolean;
var d,i,t : integer;
    dot, dPad : string;
    db, ref : TUniConnection;
    qry,sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblName2;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblName2;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryNAME2;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  try
    with qry do begin
      if not Active then Open;
      //progBarTable.Properties.Max := RecordCount;
     // progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max);  //was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;

        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;

        if qry.RecordCount > 0 then begin    (* While each USDOT# must have a LEGAL NAME, many will not have a "DBA" name *)
          if not tbl.Active then
            tbl.Open;
          tbl.Append;
          tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;
          tbl.FieldByName('NAME').AsString := sfr.FieldByName('NAME').AsString;
          tbl.FieldByName('CITY').AsString := sfr.FieldByName('CITY').AsString;
          tbl.FieldByName('STATE').AsString := sfr.FieldByName('STATE').AsString;
          tbl.FieldByName('NAME_TYPE_ID').AsString := '2';
          tbl.Post;
          Inc(i);
          end;
        Inc(t);
        TableProgress;
        if i = 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carrier DBA Name records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carrier Name table (DBA Name) for USDOT # '+dot+' at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoISSLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-15
  Comments:  Populate ISS Local table with ISS Score Values

             2018-01-16 JLV -
             Changed to use the already-populated CARRIERS table USDOT number
             as the parameter for selecting the ISS data to load.

             2018-01-24 JLV -
             Moved "qryISS_DOTNUM" to new "dbReference" connection.
             Commits to the dbISS_Local connection were closing the qryReference
             not allowing it to loop to the next record.
-----------------------------------------------------------------------------}
function TfrmMain.DoISSLoad: Boolean;
var d, i, t : integer;
    dPad, dot : string;
    db, ref : TUniConnection;
    qry, sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblISS;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblISS;
    end;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryISS;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  if not qry.Active then
    qry.Open;
  qry.First;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  //dot := '';
  //dPad := '';
  try
    with qry do begin
      if not Active then
        Open;
      //progBarTable.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := IntToStr(progBarTable.Max);
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;

        {
        d := 0;
        dPad := FieldByName('USDOTNUM').AsString;
        TryStrToInt(dPad, d);
        dot := IntToStr(d);
        if dmSAFER.qryISS.Active then begin
          dmSAFER.qryISS.Close;
          end;
        dmSAFER.qryISS.ParamByName('sDOT').Clear;
        dmSAFER.qryISS.ParamByName('sDOT').AsString := dot;
        dmSAFER.qryISS.Open;
        }
        if qry.RecordCount > 0 then begin
          if not tbl.Active then
            tbl.Open;
          tbl.Append;
          tbl.FieldByName('USDOTNUM').AsString := dPad;
          tbl.FieldByName('TOTAL_INSPECTIONS').AsString   := FloatToStr(sfr.FieldByName('QUANTITY_INSPECTIONS_LAST30').AsFloat);
          tbl.FieldByName('VEHICLE_INSPECTIONS').AsString := FloatToStr(sfr.FieldByName('VEHICLE_INSPECTIONS_LAST30').AsFloat);
          tbl.FieldByName('DRIVER_INSPECTIONS').AsString  := FloatToStr(sfr.FieldByName('DRIVER_INSPECTIONS_LAST30').AsFloat);
          tbl.FieldByName('HAZMAT_INSPECTIONS').AsString  := FloatToStr(sfr.FieldByName('QUANTITY_HAZMAT_PRESENT_LAST30').AsFloat);
          tbl.FieldByName('OOS_TOTAL').AsString     := FloatToStr(sfr.FieldByName('OOS_ALL_TYPES_LAST30').AsFloat);
          tbl.FieldByName('OOS_VEHICLE').AsString   := FloatToStr(sfr.FieldByName('OOS_VEHICLE_INSPECTIONS_LAST30').AsFloat);
          tbl.FieldByName('OOS_DRIVER').AsString    := FloatToStr(sfr.FieldByName('OOS_DRIVER_INSPECTIONS_LAST30').AsFloat);
          tbl.FieldByName('SAFETY_RATING').AsString := sfr.FieldByName('SAFETY_RATING').AsString;
          tbl.FieldByName('RATING_DATE').AsDateTime := sfr.FieldByName('RATING_DATE').AsDateTime;
          tbl.FieldByName('VIOL_BRAKES').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_BRAKES').AsFloat);
          tbl.FieldByName('VIOL_WHEELS').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_WHEELS').AsFloat);
          tbl.FieldByName('VIOL_STEERING').AsString := FloatToStr(sfr.FieldByName('VIOLATION_STEERING').AsFloat);
          tbl.FieldByName('VIOL_MEDICAL').AsString  := FloatToStr(sfr.FieldByName('VIOLATION_MEDICAL_CERTIFICATE').AsFloat);
          tbl.FieldByName('VIOL_LOGS').AsString     := FloatToStr(sfr.FieldByName('VIOLATION_LOGS').AsFloat);
          tbl.FieldByName('VIOL_HOURS').AsString    := FloatToStr(sfr.FieldByName('VIOLATION_HOURS').AsFloat);
          tbl.FieldByName('VIOL_DISQUAL').AsString  := FloatToStr(sfr.FieldByName('VIOLATION_LICENSE').AsFloat);
          tbl.FieldByName('VIOL_DRUGS').AsString    := FloatToStr(sfr.FieldByName('VIOLATION_DRUGS').AsFloat);
          tbl.FieldByName('VIOL_TRAFFIC').AsString  := FloatToStr(sfr.FieldByName('VIOLATION_TRAFFIC').AsFloat);
          tbl.FieldByName('VIOL_HMPAPER').AsString  := FloatToStr(sfr.FieldByName('VIOLATION_PAPERS').AsFloat);
          tbl.FieldByName('VIOL_HMPLAC').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_PLACARDS').AsFloat);
          tbl.FieldByName('VIOL_HMOPER').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_OP_EMER_RESP').AsFloat);
          tbl.FieldByName('VIOL_HMTANK').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_TANK').AsFloat);
          tbl.FieldByName('VIOL_HMOTHR').AsString   := FloatToStr(sfr.FieldByName('VIOLATION_OTHER').AsFloat);
          tbl.Post;
          Inc(i);
          end;
        Inc(t);
        TableProgress;
        if i = 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 ISS records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;                 //dmSAFER.qryISS_DOTNUM.Next;
      until EOF;
      db.Commit;
      //if dmSAFER.TransactionLocal.Active then
      //  dmSAFER.TransactionLocal.Commit;
      end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating ISS Scores Table at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoHMLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-16
  Comments:  Populate ISS Local table with HM Violation data
-----------------------------------------------------------------------------}
function TfrmMain.DoHMLoad: Boolean;
var d, i, t : integer;
    dPad, dot : string;
    db, ref : TUniConnection;
    qry, sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblHMPermit;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblHMPermit;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  //dot := '';
  //dPad := '';
  try
    with qry do begin
      if not Active then
        Open;
      ///progBarTable.Properties.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max); // was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          MessageDlg('Error opening SAFER Carrier table: "'+E.Message+'"',mtError,[mbAbort],0);
          WriteStatus('Error opening SAFER Carrier table: "'+E.Message+'"',True);
          Exit;
          end;
        end;
        {
        d := 0;
        dPad := FieldByName('USDOTNUM').AsString;
        TryStrToInt(dPad, d);
        dot := IntToStr(d);
        if dmSAFER.qryHMPermit.Active then
          dmSAFER.qryHMPermit.Close;
        dmSAFER.qryHMPermit.ParamByName('sDOT').Clear;
        dmSAFER.qryHMPermit.ParamByName('sDOT').AsString := dot;
        dmSAFER.qryHMPermit.Open;
        }
        if dmSAFER.qryHMPermit.RecordCount > 0 then begin
          if not tbl.Active then
            tbl.Open;
          tbl.Append;
          tbl.FieldByName('USDOTNUM').AsString    := sfr.FieldByName('USDOTNUM').AsString;
          tbl.FieldByName('PERMIT_TYPE').AsString := sfr.FieldByName('HM_PERMIT_TYPE').AsString;
          tbl.FieldByName('PERMIT_STATUS').AsString := sfr.FieldByName('HM_PERMIT_STATUS').AsString;
          if not tbl.FieldByName('HM_PERMIT_EFFECTIVE_DATE').IsNull then
            tbl.FieldByName('EFFECTIVE_DATE').AsDateTime  := sfr.FieldByName('HM_PERMIT_EFFECTIVE_DATE').AsDateTime;
          if not tbl.FieldByName('HM_PERMIT_EXPIRATION_DATE').IsNull then
            tbl.FieldByName('EXPIRATION_DATE').AsDateTime := sfr.FieldByName('HM_PERMIT_EXPIRATION_DATE').AsDateTime;
          tbl.FieldByName('OPERATING_UNDER_APPEAL').AsString := sfr.FieldByName('OPERATING_UNDER_APPEAL_FLAG').AsString;
          tbl.Post;
          if tbl.State in [dsEdit,dsInsert] then
            tbl.Post;
          Inc(i);
          end;
        Inc(t);
        TableProgress;
        if i = 1000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 HM Permit records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
      //if dmSAFER.TransactionLocal.Active then
      //  dmSAFER.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating HM Permit Table at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;


{-----------------------------------------------------------------------------
  Function:  DoInsLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier Insurance data
-----------------------------------------------------------------------------}
function TfrmMain.DoInsLoad:Boolean;
var d,i,t : integer;
    dot, dPad : string;
    db, ref : TUniConnection;
    qry,sfr : TUniQuery;
    tbl : TUniTable;

begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblCarrIns;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblCarrIns;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryINS;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  //dot := '';
  //dPad := '';
  try
    with qry do begin
      if not Active then Open;
      //progBarTable.Properties.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max); // was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;

        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;
        {
        dPad := FieldByName('USDOTNUM').AsString;
        TryStrToInt(dPad, d);
        dot := IntToStr(d);
        if dmSAFER.qryIns.Active then
          dmSAFER.qryIns.Close;
        dmSAFER.qryIns.ParamByName('sDOT').Clear;
        dmSAFER.qryIns.ParamByName('sDOT').AsString := dot;
        dmSAFER.qryIns.Open;
        }
        if sfr.RecordCount > 0 then begin
          if not tbl.Active then
            tbl.Open;
          tbl.Append;
          tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;
          tbl.FieldByName('LIABILITY_STATUS').AsString := sfr.FieldByName('LIABILITY_STATUS').AsString;
          tbl.FieldByName('LIABILITY_REQUIRED').AsInteger := sfr.FieldByName('LIABILITY_REQUIRED').AsInteger;
          tbl.FieldByName('CARGO_STATUS').AsString := sfr.FieldByName('CARGO_STATUS').AsString;
          tbl.FieldByName('BOND_STATUS').AsString := sfr.FieldByName('BOND_STATUS').AsString;
          tbl.FieldByName('MEX_TERRITORY').AsString := sfr.FieldByName('MEX_TERRITORY').AsString;
          tbl.Post;
          Inc(i);
          end;
        Inc(t);
        TableProgress;
        if i = 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carrier Insurance records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
      //if dmSAFER.TransactionLocal.Active then
      //  dmSAFER.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carrier Insurance table for USDOT # '+dot+' at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Function:  DoUcrLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier UCR Payment data

             2018-01-30 JLV -
             Added repeat loop around the insert statements.
             USDOT# to UCR is a one-to-many relationship.

             2018-02-07 JLV -
             Changed dmSAFER.qryUCR to accept a parameter for "and REGISTRATION_YEAR > :iRegYear" clause.
             The query has been running as "> 2011" since inception and this was
             generating millions of records not used.  The new query variable "iRegYear"
             will be passed the result of a variable "iRgYr" which is calcualted
             in this function as (current year - 3).  This will then make the query
             clause equivelent to "and REGISTRATION_YEAR > [current year - 3]"
             For example, current year is 2018.  iRgYr would calculate to 2015.
             The query clause would interpret as "and REGISTRATION_YEAR > 2015"
             resulting in UCR records for 2016, 2017, and 2018.
             This concept was concurred upon by SMEs Mike Wilson (Indiana State Police),
             Holly Skaar (Idaho State police), Ken Keiper (Washington State Patrol),
             Renee Hill (Arkansas Highway Police), and Tom Kelly (FMCSA).

             2018-02-12 JLV -
             Made changes to fix the looping of adding records.  What a mess.
-----------------------------------------------------------------------------}
function TfrmMain.DoUcrLoad: Boolean;
var d,i,t, ct, lp : integer;
    dot, dPad : string;
    iRgYr : integer;
    db, ref : TUniConnection;
    qry, sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblUCR;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblName2;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryUCR;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  //dot := '';
  //dPad := '';
  { get current year value as integer }
  iRgYr := (CurrentYear - 3);                  //System.SysUtils.CurrentYear
  { --------------------------------- }
  try
    with qry do begin
      if not Active then
        Open;
      //progBarTable.Properties.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max); // was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;
        d := 0;
        lp := 1;                                   // itteration through loop
        ct := 0;                                   // count of matching records

        {
        dPad := FieldByName('USDOTNUM').AsString;
        TryStrToInt(dPad, d);
        dot := IntToStr(d);
        if dmSAFER.qryUCR.Active then begin
          dmSAFER.qryUCR.Close;
          end;
        dmSAFER.qryUCR.ParamByName('sDot').Clear;
        dmSAFER.qryUCR.ParamByName('sDOT').AsString := dot;
        // narrow down year selection
        dmSAFER.qryUCR.ParamByName('iRegYear').AsInteger := iRgYr;
        //
        dmSAFER.qryUCR.Open;
        }
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('iRegYear').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        sfr.ParamByName('iRegYear').AsInteger := iRgYr;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;
        ct := sfr.RecordCount;         //how many UCR records exist for this USDOT#?
        if ct > 0 then begin                     // if more than Zero,
          for lp := lp to ct do begin            // loop this code once for each UCR record

            if sfr.FieldByName('USDOTNUM').AsString <> '' then begin  //double check that there is a valid record.
              if not tbl.Active then tbl.Open;

              tbl.Append;
              tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;
              tbl.FieldByName('BASE_STATE').AsString := sfr.FieldByName('BASE_STATE').AsString;
              tbl.FieldByName('PAYMENT_FLAG').AsString := sfr.FieldByName('PAYMENT_FLAG').AsString;
              tbl.FieldByName('REGISTRATION_YEAR').AsString := sfr.FieldByName('REGISTRATION_YEAR').AsString;
              if sfr.FieldByName('PAYMENT_DATE').AsString <> '' then
                tbl.FieldByName('PAYMENT_DATE').AsDateTime := sfr.FieldByName('PAYMENT_DATE').AsDateTime;
              tbl.FieldByName('INTRASTATE_VEHICLES').AsString := sfr.FieldByName('INTRASTATE_VEHICLES').AsString;
              end;
            tbl.Post;
            sfr.Next;
            Inc(i);
            end;                                   // if dot <> '' begin
          end;                                     // if count > zero
        Inc(t);
        TableProgress;
        if i >= 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carrier UCR records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
      //if dmSAFER.TransactionLocal.Active then
      //  dmSAFER.TransactionLocal.Commit;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carrier UCR table for USDOT # '+dot+' at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;


{-----------------------------------------------------------------------------
  Function:  DoBasicsLoad
  Author:    J. L. Vasser, FMCSA, 2017-11-20
  Comments:  Populate ISS Local table with Carrier BASICs values
             Primary key is USDOT # + BASIC

             2018-01-30 JLV -
             Added repeat loop around the insert statements.
             USDOT# to BASICS is a one-to-many relationship.
-----------------------------------------------------------------------------}
function TfrmMain.DoBasicsLoad: Boolean;
var d,i,t, ct, lp : integer;
    dot, dPad : string;
    db, ref : TUniConnection;
    qry,sfr : TUniQuery;
    tbl : TUniTable;
begin
  if dbSelected = 0 then begin
    db := dmISS_FB.dbISS_LOCAL;
    tbl := dmISS_FB.tblBasicsDetail;
    end
  else begin
    db := dmISS_SQLite.dbISS_Local;
    tbl := dmISS_SQLite.tblBasicsDetail;
    end;
  ref := dmReference.dbReference;
  qry := dmReference.qrySnapshot;
  sfr := dmSAFER.qryBASICS;
  if not dmSAFER.dbSAFER.Connected then
    dmSAFER.dbSAFER.Connect;
  if not db.Connected then
    db.Connect;
  if not ref.Connected then
    ref.Connect;
  Result := False;
  i := 0;
  t := 0;
  //d := 0;
  //dot := '';
  //dPad := '';
  try
    with qry do begin
      if not Active then Open;
      //progBarTable.Properties.Max := RecordCount;
      //progBarTable.Position := 0;
      //lblTotalRecords.Caption := FloatToStr(progBarTable.Properties.Max); // was IntToStr
      ResetProgBarTable(RecordCount);

      First;
      repeat
        sfr.Close;
        sfr.ParamByName('sDOT').Clear;
        sfr.ParamByName('sDOT').AsInteger := qry.FieldByName('CARRIER_ID_NUMBER').AsInteger;
        try
          sfr.Open;
        except on E: Exception do begin
          writeExcept('Error opening SAFER Carrier table: "'+E.Message+'"');
          Exit;
          end;
        end;
        if dbSelected = 1 then
          dmISS_SQLite.dbISS_Local.StartTransaction;

        //d := 0;
        lp := 1;                //set the loop counter to 1, otherwise change the loop to "lp to (ct -1)"
        ct := 0;
        {
        dPad := FieldByName('USDOTNUM').AsString;                               //showmessage('dPad = '+dPad);
        TryStrToInt(dPad, d);
        dot := IntToStr(d);                                                     //showmessage('dot = '+dot);
        if dmSAFER.qryBASICS.Active then begin
          dmSAFER.qryBASICS.Close;
          end;
        dmSAFER.qryBASICS.ParamByName('sDOT').Clear;
        dmSAFER.qryBASICS.ParamByName('sDOT').AsString := dot;
        dmSAFER.qryBASICS.Open;
        }
        //if dmSAFER.qryBASICS.RecordCount > 0 then begin
        ct := dmSAFER.qryBASICS.RecordCount;                                     //showmessage('ct = '+inttostr(ct));
        if ct > 0 then begin                                                    //showmessage('ct > zero');
          for lp := lp to ct do begin                                           //showmessage('start for ... loop');
          //repeat
            if not tbl.Active then
              tbl.Open;
            tbl.Append;
            tbl.FieldByName('USDOTNUM').AsString := sfr.FieldByName('USDOTNUM').AsString;  //showmessage('BASIC = '+inttostr(dmSAFER.qryBASICS.FieldByName('BASIC').AsInteger));
            tbl.FieldByName('BASIC').AsInteger := sfr.FieldByName('BASIC').AsInteger;
            tbl.FieldByName('BASICPERCENTILE').AsInteger := sfr.FieldByName('BASICPERCENTILE').AsInteger;
            tbl.FieldByName('BASICSDEFIND').AsString := sfr.FieldByName('BASICSDEFIND').AsString;
            if dmSAFER.qryBASICS.FieldByName('BASICSRUNDATE').AsString <> '' then
              tbl.FieldByName('BASICSRUNDATE').AsDateTime := sfr.FieldByName('BASICSRUNDATE').AsDateTime;
            if dmSAFER.qryBASICS.FieldByName('INVESTIGATIONDATE').AsString <> '' then
              tbl.FieldByName('INVESTIGATIONDATE').AsDateTime := sfr.FieldByName('INVESTIGATIONDATE').AsDateTime;
            tbl.FieldByName('ROAD_DISPLAY_TEXT').AsString := sfr.FieldByName('ROAD_DISPLAY_TEXT').AsString;
            tbl.FieldByName('INVEST_DISPLAY_TEXT').AsString := sfr.FieldByName('INVEST_DISPLAY_TEXT').AsString;
            tbl.FieldByName('OVERALL_DISPLAY_TEXT').AsString := sfr.FieldByName('OVERALL_DISPLAY_TEXT').AsString;
            tbl.Post;
            sfr.Next;
            Inc(i);
            end;
          //until EOF;
          end;
        Inc(t);
        TableProgress;
        if i >= 10000 then begin
          db.Commit;
          WriteStatus('Inserted 10,000 Carrier BASICs records and committed '+DateTimeToStr(now),false);
          i := 0;
          end;
        Next;
      until EOF;
      db.Commit;
      if dbSelected = 0 then begin
        if dmISS_FB.TransactionLocal.Active then
          dmISS_FB.TransactionLocal.Commit;
        end
      else begin
        if dmISS_SQLite.transactionLocal.Active then
          dmISS_SQLite.transactionLocal.Commit;
      end;
    end;
    Result := True;
  except on E: Exception do begin
    writeExcept('Error updating Carrier BASICS table for USDOT # '+dot+' at record '+IntToStr(t)+':'+#13#10+E.Message);
    Exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CheckSnapshot
  Author:    J. L. Vasser, FMCSA, 2019-05-07
  Comments:  Checks for data in the snapshot file, shows date.
             Allows user to clear the table and start fresh, or reuse the data.
-----------------------------------------------------------------------------}
function TfrmMain.CheckSnapshot: string;
var d : string;
    c : integer;
begin
  Result := '';
  d := '';
  c := 0;
  WriteStatus('Checking Snapshot Reference table',True);
  if not dmReference.dbReference.Connected then
    dmReference.dbReference.Connect;
  with dmReference.qrySnapshot do begin
    if not Active then Open;
    c := RecordCount;
    if c > 0 then begin
      //First;    in theory, the date of the last record should have the latest Last Update Date
      Last;
      d := DateTimeToStr(FieldByName('LAST_UPDATE_DATE').AsDateTime);
      writestatus('Reference table contains '+IntToStr(c)+' records dated '+d,False);
      if MessageDlg('Snapshot contains '+IntToStr(c)+' records dated '+d+'. Empty the Snapshot table?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        dmReference.sqlDelete.Execute;
        writestatus('User selected to purge table',true);
        Result := 'PURGE';
        end
      else begin
        WriteStatus('User selected to retain records',true);
        ShowMessage('Snapshot records retained');
        Result := 'KEEP';
        end;
      end
    else
      WriteStatus('Reference table is empty.  Process continues',True);
    if Active then Close;
    end;
end;

{-----------------------------------------------------------------------------
  Procedure: TableProgress
  Author:    J. L. Vasser, FMCSA, 2017-10-12
  Comments:  Shows progress on the current table being imported
-----------------------------------------------------------------------------}
procedure TfrmMain.TableProgress;
begin
  progBarTable.IncPartsByOne;
  progBarTable.Repaint;
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------
  Procedure: ShowProgress
  Author:    J. L. Vasser, FMCSA, 2019-07-02
  Comments:  Increments the overall progress indicator.
-----------------------------------------------------------------------------}
procedure TfrmMain.ShowProgress;
begin
  progBarOverAll.IncPartsByOne;
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------
  Procedure: BetweenSteps
  Author:    J. L. Vasser, FMCSA, 2018-02-14
  Comments:  Repetitive code  between loading table steps
-----------------------------------------------------------------------------}
procedure TfrmMain.BetweenSteps;
begin
  WriteStatus('..........DONE  '+DateTimeToStr(now), true);
  ShowProgress;
  memoLog.Repaint;
  Application.ProcessMessages;
end;

{-----------------------------------------------------------------------------
  Procedure: ResetProgBarTable
  Author:    J. L. Vasser, FMCSA, 2019-07-08
  Comments:  Resets the progress bar to zero and label to the total record count
-----------------------------------------------------------------------------}
procedure TfrmMain.ResetProgBarTable(RecCount: integer);
begin
  progBarTable.TotalParts := RecCount;
  progBarTable.PartsComplete := 0;
  lblTotalRecords.Caption := IntToStr(progBarTable.TotalParts);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  wizCtrl.InfoPanel.Caption := 'Carrier Data Pull Wizard - Page '+IntToStr(wizCtrl.ActivePageIndex+1);
end;

end.
