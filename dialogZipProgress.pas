unit dialogZipProgress;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics,  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  RzPanel, RzDlgBtn, RzPrgres, RzBorder,
  SBArcZip, SBArcBase, SBLicenseManager;

type
  TdlgZipStatus = class(TForm)
    btnBar: TRzDialogButtons;
    btnStart: TBitBtn;
    zipWriter: TElZipWriter;
    SSBLicMgr: TElSBLicenseManager;
    progBar: TProgressBar;
    txtCurrentFile: TStaticText;
    lblElapsed: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnBarClickOk(Sender: TObject);
    procedure zipWriterCompressionStart(Sender: TObject;
      Entry: TElZipArchiveDirectoryEntry; var Compress: Boolean);
    procedure zipWriterProgress(Sender: TObject; Processed, Total,
      OverallProcessed, OverallTotal: UInt64; var Cancel: Boolean);
    procedure zipWriterCompressionFinished(Sender: TObject;
      Entry: TElZipArchiveDirectoryEntry);
    procedure btnBarClickCancel(Sender: TObject);

  private
    { Private declarations }
    FCancelOperation : Boolean;
    TimeStart : TTime;
    TimeNow   : TTime;

  public
    { Public declarations }
    property CancelOperation : boolean read FCancelOperation write FCancelOperation;

  end;

var
  dlgZipStatus: TdlgZipStatus;
  SourceFile : String;
  ArchiveFile : String;
  DataDate : string;

implementation

{$R *.dfm}

uses formMain;

procedure TdlgZipStatus.btnBarClickCancel(Sender: TObject);
begin
  if zipWriter.Opened then begin             showmessage('cancel - zipwriter.opened');
    FCancelOperation := True;
    end
  else begin
    ModalResult := mrCancel;
    Close;
    end;
end;

procedure TdlgZipStatus.btnBarClickOk(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TdlgZipStatus.btnStartClick(Sender: TObject);
begin
  TimeStart := Now;
  try
    btnStart.Hide;
    txtCurrentFile.Caption := 'Compressing File: '+SourceFile;
    lblElapsed.Show;

    Application.ProcessMessages;
    if zipWriter.Opened then zipWriter.Close;
    zipWriter.CompressionLevel := 9;

    zipWriter.Add(SourceFile);
    try
      zipWriter.Compress(ArchiveFile);
      Application.ProcessMessages;
      ShowMessage('Complete!');
    except
      on E:Exception do begin
        MessageDlg('Error creating compressed archive: '#10#13+E.Message+#10#13,mtError,[mbOK],0);
        Application.ProcessMessages;

        Exit;
      end;
    end;
  finally
    btnBar.EnableOk := True;
  end;
end;

procedure TdlgZipStatus.FormShow(Sender: TObject);
begin
  progBar.Enabled := False;
  ModalResult := mrCancel;
end;

procedure TdlgZipStatus.zipWriterCompressionFinished(Sender: TObject;
  Entry: TElZipArchiveDirectoryEntry);
begin
  progBar.Enabled := False;
  Application.ProcessMessages;
  //zipWriter.Close;
end;

procedure TdlgZipStatus.zipWriterCompressionStart(Sender: TObject;
  Entry: TElZipArchiveDirectoryEntry; var Compress: Boolean);
begin
  progBar.Enabled := True;
  progBar.Max := 100000;
  Application.ProcessMessages;
end;

procedure TdlgZipStatus.zipWriterProgress(Sender: TObject; Processed, Total,
  OverallProcessed, OverallTotal: UInt64; var Cancel: Boolean);
var ProcessedNormalized : Int64;
    timeElapsed : TTime;
begin
  Application.ProcessMessages;
  Cancel := CancelOperation;
  //progBar.Max := OverallTotal;
  //progBar.Position := OverallProcessed;
  if Total > 0 then
    ProcessedNormalized := (Processed * 100000) div Total
  else
    ProcessedNormalized := 100000;
  if OverallTotal > 0 then
    ProcessedNormalized := (OverallProcessed * 100000 div OverallTotal)
  else
    ProcessedNormalized := 100000;

  progBar.Position := ProcessedNormalized;

  timeNow := Now;
  timeElapsed := timeNow - timeStart;
  lblElapsed.Caption := 'Time Elapsed: '+FormatDateTime('h:n:s',timeElapsed);
  lblElapsed.Refresh;

  Application.ProcessMessages;
end;



end.
