// -----------------------------------------------------------------------------
// ¼p/SpĻ·
//
// Copyright (c) Kuro. All Rights Reserved.
// e-mail: info@haijin-boys.com
// www:    http://www.haijin-boys.com/
// -----------------------------------------------------------------------------

library Conversion;

{$RTTI EXPLICIT METHODS([]) FIELDS([]) PROPERTIES([])}
{$WEAKLINKRTTI ON}

{$R 'mPlugin.res' 'mPlugin.rc'}


uses
  Windows,
  SysUtils,
  Controls,
  Themes,
  StringUnit,
  mCommon in 'mCommon.pas',
  mMain in 'mMain.pas' {MainForm},
  mPlugin in 'mPlugin.pas',
  mPerMonitorDpi in 'mPerMonitorDpi.pas';

resourcestring
  SName = '¼p/SpĻ·';
  SVersion = '2.1.0';

const
  IDS_MENU_TEXT = 1;
  IDS_STATUS_MESSAGE = 2;
  IDI_ICON = 101;

{$IFDEF DEBUG}
{$R *.res}
{$ENDIF}


procedure OnCommand(hwnd: HWND); stdcall;
const
  HalfWidthKana: array [0 .. 88] of string =
    (
    '¶Ž', '·Ž', 'øŽ', '¹Ž', 'ŗŽ',
    '»Ž', '¼Ž', '½Ž', '¾Ž', 'æŽ',
    'ĄŽ', 'ĮŽ', 'ĀŽ', 'ĆŽ', 'ÄŽ',
    'ŹŽ', 'ĖŽ', 'ĢŽ', 'ĶŽ', 'ĪŽ',
    'Źß', 'Ėß', 'Ģß', 'Ķß', 'Īß',
    '±', '²', '³', '“', 'µ',
    '¶', '·', 'ø', '¹', 'ŗ',
    '»', '¼', '½', '¾', 'æ',
    'Ą', 'Į', 'Ā', 'Ć', 'Ä',
    'Å', 'Ę', 'Ē', 'Č', 'É',
    'Ź', 'Ė', 'Ģ', 'Ķ', 'Ī',
    'Ļ', 'Š', 'Ń', 'Ņ', 'Ó',
    'Ō', 'Õ', 'Ö',
    '×', 'Ų', 'Ł', 'Ś', 'Ū',
    'Ü', '¦', 'Ż', '³Ž',
    '§', 'Ø', '©', 'Ŗ', '«',
    '¬', '­', '®',
    'Æ', 'Ž', 'ß', '°', '„', '¤', '”', '¢', '£');
  FullWidthKana: array [0 .. 88] of string =
    (
    'K', 'M', 'O', 'Q', 'S',
    'U', 'W', 'Y', '[', ']',
    '_', 'a', 'd', 'f', 'h',
    'o', 'r', 'u', 'x', '{',
    'p', 's', 'v', 'y', '|',
    'A', 'C', 'E', 'G', 'I',
    'J', 'L', 'N', 'P', 'R',
    'T', 'V', 'X', 'Z', '\',
    '^', '`', 'c', 'e', 'g',
    'i', 'j', 'k', 'l', 'm',
    'n', 'q', 't', 'w', 'z',
    '}', '~', '', '', '',
    '', '', '',
    '', '', '', '', '',
    '', '', '', '',
    '@', 'B', 'D', 'F', 'H',
    '', '', '',
    'b', 'J', 'K', '[', 'E', 'A', 'B', 'u', 'v');
  HalfWidthAlpha: array [0 .. 51] of string =
    ('A', 'B', 'C', 'D', 'E',
    'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y',
    'Z', 'a', 'b', 'c', 'd',
    'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's',
    't', 'u', 'v', 'w', 'x',
    'y', 'z');
  FullWidthAlpha: array [0 .. 51] of string =
    ('`', 'a', 'b', 'c', 'd',
    'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's',
    't', 'u', 'v', 'w', 'x',
    'y', '', '', '', '',
    '', '', '', '', '',
    '', '', '', '', '',
    '', '', '', '', '',
    '', '', '', '', '',
    '', '');
  HalfWidthNum: array [0 .. 9] of string =
    ('1', '2', '3', '4', '5',
    '6', '7', '8', '9', '0');
  FullWidthNum: array [0 .. 9] of string =
    ('P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'O');
  HalfWidthMarks: array [0 .. 31] of string =
    ('!', '"', '#', '$', '%',
    '&', '''', '(', ')', '*',
    '+', ',', '-', '.', '/',
    ':', ';', '<', '=', '>',
    '?', '@', '[', '\', ']',
    '^', '_', '`', '{', '|',
    '}', '~');
  FullWidthMarks: array [0 .. 31] of string =
    ('I', 'h', '', '', '',
    '', 'f', 'i', 'j', '',
    '{', 'C', '|', 'D', '^',
    'F', 'G', '', '', '',
    'H', '', 'm', '', 'n',
    'O', '_', 'M', 'o', 'b',
    'p', '`');
  HalfWidthSpaces: array [0 .. 0] of string =
    (' ');
  FullWidthSpaces: array [0 .. 0] of string =
    ('@');
var
  S: string;
  I, P, Len: NativeInt;
  Flags: NativeInt;
  OldPatterns, NewPatterns: array of string;
begin
  with TMainForm.CreateParented(hwnd) do
    try
      Flags := Editor_GetSelType(hwnd);
      SelRadioButton.Enabled := Boolean(Flags) and Boolean(SEL_TYPE_CHAR);
      SelRadioButton.Checked := SelRadioButton.Enabled;
      if ShowModal = mrOk then
      begin
        Editor_Redraw(hwnd, False);
        try
          if AllRadioButton.Checked then
            Editor_ExecCommand(hwnd, MEID_EDIT_SELECT_ALL);
          Len := Editor_GetSelText(hwnd, 0, nil);
          SetLength(S, Len - 1);
          Editor_GetSelText(hwnd, Len, @S[1]);
          SetLength(OldPatterns, 0);
          SetLength(NewPatterns, 0);
          case KanaComboBox.ItemIndex of
            0:
              ;
            1:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(HalfWidthKana));
                for I := 0 to High(HalfWidthKana) do
                  OldPatterns[I + P] := HalfWidthKana[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(FullWidthKana));
                for I := 0 to High(FullWidthKana) do
                  NewPatterns[I + P] := FullWidthKana[I];
              end;
            2:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(FullWidthKana));
                for I := 0 to High(FullWidthKana) do
                  OldPatterns[I + P] := FullWidthKana[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(HalfWidthKana));
                for I := 0 to High(HalfWidthKana) do
                  NewPatterns[I + P] := HalfWidthKana[I];
              end;
          end;
          case AlphaComboBox.ItemIndex of
            0:
              ;
            1:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(HalfWidthAlpha));
                for I := 0 to High(HalfWidthAlpha) do
                  OldPatterns[I + P] := HalfWidthAlpha[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(FullWidthAlpha));
                for I := 0 to High(FullWidthAlpha) do
                  NewPatterns[I + P] := FullWidthAlpha[I];
              end;
            2:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(FullWidthAlpha));
                for I := 0 to High(FullWidthAlpha) do
                  OldPatterns[I + P] := FullWidthAlpha[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(HalfWidthAlpha));
                for I := 0 to High(HalfWidthAlpha) do
                  NewPatterns[I + P] := HalfWidthAlpha[I];
              end;
          end;
          case NumComboBox.ItemIndex of
            0:
              ;
            1:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(HalfWidthNum));
                for I := 0 to High(HalfWidthNum) do
                  OldPatterns[I + P] := HalfWidthNum[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(FullWidthNum));
                for I := 0 to High(FullWidthNum) do
                  NewPatterns[I + P] := FullWidthNum[I];
              end;
            2:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(FullWidthNum));
                for I := 0 to High(FullWidthNum) do
                  OldPatterns[I + P] := FullWidthNum[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(HalfWidthNum));
                for I := 0 to High(HalfWidthNum) do
                  NewPatterns[I + P] := HalfWidthNum[I];
              end;
          end;
          case MarksComboBox.ItemIndex of
            0:
              ;
            1:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(HalfWidthMarks));
                for I := 0 to High(HalfWidthMarks) do
                  OldPatterns[I + P] := HalfWidthMarks[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(FullWidthMarks));
                for I := 0 to High(FullWidthMarks) do
                  NewPatterns[I + P] := FullWidthMarks[I];
              end;
            2:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(FullWidthMarks));
                for I := 0 to High(FullWidthMarks) do
                  OldPatterns[I + P] := FullWidthMarks[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(HalfWidthMarks));
                for I := 0 to High(HalfWidthMarks) do
                  NewPatterns[I + P] := HalfWidthMarks[I];
              end;
          end;
          case SpacesComboBox.ItemIndex of
            0:
              ;
            1:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(HalfWidthSpaces));
                for I := 0 to High(HalfWidthSpaces) do
                  OldPatterns[I + P] := HalfWidthSpaces[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(FullWidthSpaces));
                for I := 0 to High(FullWidthSpaces) do
                  NewPatterns[I + P] := FullWidthSpaces[I];
              end;
            2:
              begin
                P := Length(OldPatterns);
                SetLength(OldPatterns, Length(OldPatterns) + Length(FullWidthSpaces));
                for I := 0 to High(FullWidthSpaces) do
                  OldPatterns[I + P] := FullWidthSpaces[I];
                SetLength(NewPatterns, Length(NewPatterns) + Length(HalfWidthSpaces));
                for I := 0 to High(HalfWidthSpaces) do
                  NewPatterns[I + P] := HalfWidthSpaces[I];
              end;
          end;
          if (Length(OldPatterns) > 0) and (Length(NewPatterns) > 0) then
          begin
            S := StringsReplace(S, OldPatterns, NewPatterns);
            Editor_InsertString(hwnd, PChar(S));
          end;
        finally
          Editor_Redraw(hwnd, True);
        end;
        WriteIni;
      end;
    finally
      Free;
    end;
end;

function QueryStatus(hwnd: HWND; pbChecked: PBOOL): BOOL; stdcall;
begin
  pbChecked^ := False;
  Result := True;
end;

function GetMenuTextID: NativeInt; stdcall;
begin
  Result := IDS_MENU_TEXT;
end;

function GetStatusMessageID: NativeInt; stdcall;
begin
  Result := IDS_STATUS_MESSAGE;
end;

function GetIconID: NativeInt; stdcall;
begin
  Result := IDI_ICON;
end;

procedure OnEvents(hwnd: HWND; nEvent: NativeInt; lParam: LPARAM); stdcall;
begin
  if (nEvent and EVENT_CLOSE) <> 0 then
    ThemeServices.Free;
end;

function PluginProc(hwnd: HWND; nMsg: NativeInt; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  Result := 0;
  case nMsg of
    MP_GET_NAME:
      begin
        Result := Length(SName);
        if lParam <> 0 then
          lstrcpynW(PChar(lParam), PChar(SName), wParam);
      end;
    MP_GET_VERSION:
      begin
        Result := Length(SVersion);
        if lParam <> 0 then
          lstrcpynW(PChar(lParam), PChar(SVersion), wParam);
      end;
  end;
end;

exports
  OnCommand,
  QueryStatus,
  GetMenuTextID,
  GetStatusMessageID,
  GetIconID,
  OnEvents,
  PluginProc;

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF}

end.
