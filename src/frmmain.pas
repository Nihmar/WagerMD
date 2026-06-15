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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvFolderClick(Sender: TObject);
    procedure tvFolderDblClick(Sender: TObject);
  private
    FLastOpenedFile: string;
    FLastOpenedFolder: string;
    FLastSavedText: unicodestring;
    procedure HandleAfterEdit;
    procedure LoadFile(AFileName: string);
    procedure SetLastOpenedFile(AValue: string);
    procedure SetLastOpenedFolder(AValue: string);
    procedure SetLastSavedText(AValue: unicodestring);
  protected
    property LastSavedText: unicodestring read FLastSavedText write SetLastSavedText;
    property LastOpenedFile: string read FLastOpenedFile write SetLastOpenedFile;
    property LastOpenedFolder: string read FLastOpenedFolder write SetLastOpenedFolder;
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
    LoadFile(dlgOpenFile.FileName);
end;

procedure TMainForm.actOpenFolderExecute(Sender: TObject);
begin
  if dlgOpenFolder.Execute then
  begin
    LastOpenedFolder := dlgOpenFolder.FileName;
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  //to fill
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
  //do not touch
end;

procedure TMainForm.tvFolderDblClick(Sender: TObject);
var
  LFolder: string;
  LNode: TTreeNode;
  LList: TStrings;
  I: Integer;
begin
  LList := TStringList.Create;
  try
    LNode := tvFolder.Selected.Parent;
    while Assigned(LNode.Parent) do
      begin
        LList.Add(LNode.Text);
        LNode := LNode.Parent;
      end;
    LFolder := LastOpenedFolder;
    for I:=LList.Count-1 downto 0 do
      LFolder := LFolder + DirectorySeparator + LList[I];
    LoadFile(LFolder + DirectorySeparator + tvFolder.Selected.Text);
  finally
    LList.Free;
  end;
end;

procedure TMainForm.HandleAfterEdit;
begin
  atedMain.Modified := LastSavedText <> atedMain.Text;
  if (not EndsStr('*', Caption)) and atedMain.Modified then
    Caption := Caption + '*'
  else if EndsStr('*', Caption) and (not atedMain.Modified) then
    Caption := Copy(Caption, 1, Length(Caption) - 2);
end;

procedure TMainForm.LoadFile(AFileName: string);
begin
  atedMain.LoadFromFile(AFileName, [TATLoadStreamOption.FromUTF8]);
  LastSavedText := atedMain.Text;
  LastOpenedFile := AFileName;
  Caption := AFileName;
end;

procedure TMainForm.SetLastOpenedFile(AValue: string);
begin
  if FLastOpenedFile = AValue then Exit;
  FLastOpenedFile := AValue;
end;

procedure TMainForm.SetLastOpenedFolder(AValue: string);
begin
  if FLastOpenedFolder = AValue then Exit;
  FLastOpenedFolder := AValue;
end;

procedure TMainForm.SetLastSavedText(AValue: unicodestring);
begin
  if FLastSavedText = AValue then Exit;
  FLastSavedText := AValue;
end;

end.
