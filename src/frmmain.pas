unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
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
    atedMain.LoadFromFile(dlgOpenFile.FileName, [TATLoadStreamOption.FromUTF8]);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  LColor: TColor;
  LRGB: TRGB;
begin
  // ApplyEditorColors(atedMain, PaletteMocha);
  LColor := Self.Color;
  LRGB := ColorToRGBRec(LColor);
  ApplyEditorColorsFromTheme(atedMain);
end;

end.
