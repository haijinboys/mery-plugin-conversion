unit mMain;

interface

uses
{$IF CompilerVersion > 22.9}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls;
{$ELSE}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;
{$IFEND}


type
  TMainForm = class(TForm)
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
  private
    { Private éŒ¾ }
  public
    { Public éŒ¾ }
    procedure ReadIni;
    procedure WriteIni;
  end;

var
  MainForm: TMainForm;
  FFontName: string;
  FFontSize: NativeInt;

implementation

uses
{$IF CompilerVersion > 22.9}
  System.IniFiles,
{$ELSE}
  IniFiles,
{$IFEND}
  mCommon;

{$R *.dfm}


procedure TMainForm.FormCreate(Sender: TObject);
begin
  if Win32MajorVersion < 6 then
    with Font do
    begin
      Name := 'Tahoma';
      Size := 8;
    end;
  ReadIni;
  with Font do
  begin
    ChangeScale(FFontSize, Size);
    Name := FFontName;
    Size := FFontSize;
  end;
end;

procedure TMainForm.ReadIni;
var
  S: string;
begin
  if not GetIniFileName(S) then
    Exit;
  with TMemIniFile.Create(S, TEncoding.UTF8) do
    try
      FFontName := ReadString('MainForm', 'FontName', Font.Name);
      FFontSize := ReadInteger('MainForm', 'FontSize', Font.Size);
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
