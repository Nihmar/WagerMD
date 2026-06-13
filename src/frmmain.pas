unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  StrUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  Menus,
  ActnList,
  ExtCtrls,
  ATSynEdit,
  editorcolors;

type

  { TMainForm }

  TMainForm = class(TForm)
    actOpenFile: TAction;
    alMain: TActionList;
    atedMain: TATSynEdit;
    lv1File: TMenuItem;
    lv2OpenFile: TMenuItem;
    mmEditor: TMainMenu;
    dlgOpenFile: TOpenDialog;
    procedure actOpenFileExecute(Sender: TObject);
    procedure atedMainChange(Sender: TObject);
    procedure atedMainChangeModified(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  MainForm: TMainForm;

implementation

uses
  ATStrings;

  {$R *.lfm}

  { TMainForm }

procedure TMainForm.actOpenFileExecute(Sender: TObject);
begin
  if dlgOpenFile.Execute then
    begin
      atedMain.LoadFromFile(dlgOpenFile.FileName, [TATLoadStreamOption.FromUTF8]);
      Caption := dlgOpenFile.FileName;
    end;
end;

procedure TMainForm.atedMainChange(Sender: TObject);
begin
  //
end;

procedure TMainForm.atedMainChangeModified(Sender: TObject);
begin
  if not EndsStr('*', Caption) then
    Caption := Caption + '*';
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  LColor: TColor;
  LRGB: TRGB;
begin
  LColor := Self.Color;
  LRGB := ColorToRGBRec(LColor);
  ApplyEditorColorsFromTheme(atedMain);
end;

end.
