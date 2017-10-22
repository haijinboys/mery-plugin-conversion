unit mMain;

interface

uses
{$IF CompilerVersion > 22.9}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
{$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
{$IFEND}
  mPerMonitorDpi;

type
  TCenterForm = class(TScaledForm)
  private
    { Private �錾 }
    FWndParent: THandle;
  protected
    { Protected �錾 }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoShow; override;
  public
    { Public �錾 }
    constructor Create(AOwner: TComponent; AParent: THandle); reintroduce;
  end;

  TMainForm = class(TCenterForm)
    KanaLabel: TLabel;
    KanaComboBox: TComboBox;
    AlphaLabel: TLabel;
    AlphaComboBox: TComboBox;
    NumLabel: TLabel;
    NumComboBox: TComboBox;
    MarksLabel: TLabel;
    MarksComboBox: TComboBox;
    SpacesLabel: TLabel;
    SpacesComboBox: TComboBox;
    RangeGroupBox: TGroupBox;
    AllRadioButton: TRadioButton;
    SelRadioButton: TRadioButton;
    OKButton: TButton;
    CancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
    procedure ReadIni;
    procedure WriteIni;
  end;

var
  MainForm: TMainForm;

implementation

uses
{$IF CompilerVersion > 22.9}
  System.IniFiles, Winapi.MultiMon,
{$ELSE}
  IniFiles, MultiMon,
{$IFEND}
  mCommon;

{$R *.dfm}

{ TCenterForm }

constructor TCenterForm.Create(AOwner: TComponent; AParent: THandle);
var
  AppMon, WinMon: HMONITOR;
  I, J: Integer;
  LLeft, LTop: Integer;
begin
  FWndParent := AParent;
  inherited Create(AOwner);
  AppMon := Screen.MonitorFromWindow(GetParent(Handle), mdNearest).Handle;
  WinMon := Monitor.Handle;
  for I := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[I].Handle = AppMon then
      if AppMon <> WinMon then
        for J := 0 to Screen.MonitorCount - 1 do
          if Screen.Monitors[J].Handle = WinMon then
          begin
            LLeft := Screen.Monitors[I].Left + Left - Screen.Monitors[J].Left;
            if LLeft + Width > Screen.Monitors[I].Left + Screen.Monitors[I].Width then
              LLeft := Screen.Monitors[I].Left + Screen.Monitors[I].Width - Width;
            LTop := Screen.Monitors[I].Top + Top - Screen.Monitors[J].Top;
            if LTop + Height > Screen.Monitors[I].Top + Screen.Monitors[I].Height then
              LTop := Screen.Monitors[I].Top + Screen.Monitors[I].Height - Height;
            SetBounds(LLeft, LTop, Width, Height);
          end;
end;

procedure TCenterForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WndParent := FWndParent;
end;

procedure TCenterForm.DoShow;
var
  H: THandle;
  R1, R2: TRect;
begin
  H := GetParent(Handle);
  if (H = 0) or IsIconic(H) then
    H := GetDesktopWindow;
  if GetWindowRect(H, R1) and GetWindowRect(Handle, R2) then
    SetWindowPos(Handle, 0,
      R1.Left + (((R1.Right - R1.Left) - (R2.Right - R2.Left)) div 2),
      R1.Top + (((R1.Bottom - R1.Top) - (R2.Bottom - R2.Top)) div 2),
      0, 0, SWP_NOSIZE or SWP_NOZORDER or SWP_NOACTIVATE);
  inherited;
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TScaledForm.DefaultFont.Assign(Font);
  ReadIni;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  //
end;

procedure TMainForm.ReadIni;
var
  S: string;
begin
  if not GetIniFileName(S) then
    Exit;
  with TMemIniFile.Create(S, TEncoding.UTF8) do
    try
      with TScaledForm.DefaultFont do
        if ValueExists('MainForm', 'FontName') then
        begin
          Name := ReadString('MainForm', 'FontName', Name);
          Size := ReadInteger('MainForm', 'FontSize', Size);
        end
        else if CheckWin32Version(6, 2) then
          Assign(Screen.IconFont);
      KanaComboBox.ItemIndex := ReadInteger('Conversion', 'Kana', KanaComboBox.ItemIndex);
      AlphaComboBox.ItemIndex := ReadInteger('Conversion', 'Alpha', AlphaComboBox.ItemIndex);
      NumComboBox.ItemIndex := ReadInteger('Conversion', 'Num', NumComboBox.ItemIndex);
      MarksComboBox.ItemIndex := ReadInteger('Conversion', 'Marks', MarksComboBox.ItemIndex);
      SpacesComboBox.ItemIndex := ReadInteger('Conversion', 'Spaces', SpacesComboBox.ItemIndex);
    finally
      Free;
    end;
end;

procedure TMainForm.WriteIni;
var
  S: string;
begin
  if FIniFailed or (not GetIniFileName(S)) then
    Exit;
  try
    with TMemIniFile.Create(S, TEncoding.UTF8) do
      try
        WriteInteger('Conversion', 'Kana', KanaComboBox.ItemIndex);
        WriteInteger('Conversion', 'Alpha', AlphaComboBox.ItemIndex);
        WriteInteger('Conversion', 'Num', NumComboBox.ItemIndex);
        WriteInteger('Conversion', 'Marks', MarksComboBox.ItemIndex);
        WriteInteger('Conversion', 'Spaces', SpacesComboBox.ItemIndex);
        UpdateFile;
      finally
        Free;
      end;
  except
    FIniFailed := True;
  end;
end;

end.
