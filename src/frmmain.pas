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
  ShellCtrls,
  ComCtrls,
  ATSynEdit,
  editorcolors,
  treeviewloader, BGRABitmapTypes;

type

  { TMainForm }

  TMainForm = class(TForm)
    actOpenFolder: TAction;
    actOpenFile: TAction;
    alMain: TActionList;
    atedMain: TATSynEdit;
    lv1File: TMenuItem;
    lv2OpenFile: TMenuItem;
    MenuItem1: TMenuItem;
    mmEditor: TMainMenu;
    dlgOpenFile: TOpenDialog;
    dlgOpenFolder: TSelectDirectoryDialog;
    pnlMain: TPanel;
    tvFolder: TTreeView;
    procedure actOpenFileExecute(Sender: TObject);
    procedure actOpenFolderExecute(Sender: TObject);
    procedure atedMainChange(Sender: TObject);
    procedure atedMainChangeDetailed(Sender: TObject;
      APos, APosEnd, AShift, APosAfter: TPoint);
    procedure atedMainChangeModified(Sender: TObject);
    procedure atedMainKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure atedMainUndoTooLongLine(Sender: TObject; ALineIndex: integer);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvFolderClick(Sender: TObject);
    procedure tvFolderDblClick(Sender: TObject);
  private
    FLastSavedText: unicodestring;
    procedure HandleAfterEdit;
    procedure SetLastSavedText(AValue: unicodestring);
  protected
    property LastSavedText: unicodestring read FLastSavedText write SetLastSavedText;
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
    LastSavedText := atedMain.Text;
    Caption := dlgOpenFile.FileName;
    end;
end;

procedure TMainForm.actOpenFolderExecute(Sender: TObject);
begin
  if dlgOpenFolder.Execute then
    begin
    PopulateTreeView(tvFolder, dlgOpenFolder.FileName);
    end;
end;

procedure TMainForm.atedMainChange(Sender: TObject);
begin
  HandleAfterEdit;
end;

procedure TMainForm.atedMainChangeDetailed(Sender: TObject;
  APos, APosEnd, AShift, APosAfter: TPoint);
begin
  HandleAfterEdit;
end;

procedure TMainForm.atedMainChangeModified(Sender: TObject);
begin
  HandleAfterEdit;
end;

procedure TMainForm.atedMainKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  HandleAfterEdit;
end;

procedure TMainForm.atedMainUndoTooLongLine(Sender: TObject; ALineIndex: integer);
begin
  HandleAfterEdit;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeTreeViewData(tvFolder);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ApplyEditorColorsFromTheme(atedMain);
end;

procedure TMainForm.tvFolderClick(Sender: TObject);
begin
  //
end;

procedure TMainForm.tvFolderDblClick(Sender: TObject);
begin
  //
end;

procedure TMainForm.HandleAfterEdit;
begin
  atedMain.Modified := LastSavedText <> atedMain.Text;
  if (not EndsStr('*', Caption)) and atedMain.Modified then
    Caption := Caption + '*'
  else if EndsStr('*', Caption) and (not atedMain.Modified) then
      Caption := Copy(Caption, 1, Length(Caption) - 2);
end;

procedure TMainForm.SetLastSavedText(AValue: unicodestring);
begin
  if FLastSavedText = AValue then Exit;
  FLastSavedText := AValue;
end;

end.
