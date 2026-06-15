unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, ExtCtrls, ShellCtrls, ComCtrls, Buttons, AnchorDockPanel, ATSynEdit,
  ATSynEdit_Adapter_EControl, econtrol_package, ec_LexerList, ec_syntax_format,
  ec_SyntAnal, editorcolors, treeviewloader, BGRABitmapTypes, BCSVGButton,
  BGRASVGImageList, BCImageButton, BGRASpeedButton, BGRACustomDrawn,
  BGRAImageList, BCSVGViewer, BCToolBar, ATFlatToolbar, ATStatusBar;

type

  { TMainForm }

  TMainForm = class(TForm)
    actSaveFile: TAction;
    actOpenFolder: TAction;
    actOpenFile: TAction;
    alMain: TActionList;
    atedMain: TATSynEdit;
    BCSVGButton1: TBCSVGButton;
    BCSVGButton10: TBCSVGButton;
    BCSVGButton11: TBCSVGButton;
    BCSVGButton12: TBCSVGButton;
    BCSVGButton13: TBCSVGButton;
    BCSVGButton14: TBCSVGButton;
    BCSVGButton15: TBCSVGButton;
    BCSVGButton16: TBCSVGButton;
    BCSVGButton17: TBCSVGButton;
    BCSVGButton18: TBCSVGButton;
    BCSVGButton2: TBCSVGButton;
    BCSVGButton20: TBCSVGButton;
    BCSVGButton21: TBCSVGButton;
    BCSVGButton22: TBCSVGButton;
    BCSVGButton23: TBCSVGButton;
    BCSVGButton24: TBCSVGButton;
    BCSVGButton25: TBCSVGButton;
    BCSVGButton26: TBCSVGButton;
    BCSVGButton27: TBCSVGButton;
    BCSVGButton28: TBCSVGButton;
    BCSVGButton29: TBCSVGButton;
    BCSVGButton3: TBCSVGButton;
    BCSVGButton4: TBCSVGButton;
    BCSVGButton5: TBCSVGButton;
    BCSVGButton6: TBCSVGButton;
    BCSVGButton7: TBCSVGButton;
    BCSVGButton8: TBCSVGButton;
    BCSVGButton9: TBCSVGButton;
    lv1File: TMenuItem;
    lv2OpenFile: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    pnEditorToolbar: TPanel;
    pnEditor: TPanel;
    pnTools: TPanel;
    Separator1: TMenuItem;
    mmEditor: TMainMenu;
    dlgOpenFile: TOpenDialog;
    dlgOpenFolder: TSelectDirectoryDialog;
    pnlMain: TPanel;
    StatusBar1: TStatusBar;
    tvFolder: TTreeView;
    procedure actOpenFileExecute(Sender: TObject);
    procedure actOpenFolderExecute(Sender: TObject);
    procedure actSaveFileExecute(Sender: TObject);
    procedure atedMainChange(Sender: TObject);
    procedure atedMainChangeDetailed(Sender: TObject;
      APos, APosEnd, AShift, APosAfter: TPoint);
    procedure atedMainChangeModified(Sender: TObject);
    procedure atedMainKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure atedMainUndoTooLongLine(Sender: TObject; ALineIndex: integer);
    procedure BCSVGButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tvFolderClick(Sender: TObject);
    procedure tvFolderDblClick(Sender: TObject);
  private
    FAdapter: TATAdapterEControl;
    FLastOpenedFile: string;
    FLastOpenedFolder: string;
    FLastSavedText: unicodestring;
    FLexer: TecSyntAnalyzer;
    FLexerManager: TecLexerList;
    procedure HandleAfterEdit;
    procedure LoadFile(AFileName: string);
    procedure SetAdapter(AValue: TATAdapterEControl);
    procedure SetLastOpenedFile(AValue: string);
    procedure SetLastOpenedFolder(AValue: string);
    procedure SetLastSavedText(AValue: unicodestring);
    procedure SetLexer(AValue: TecSyntAnalyzer);
    procedure SetLexerManager(AValue: TecLexerList);
  protected
    property LastSavedText: unicodestring read FLastSavedText write SetLastSavedText;
    property LastOpenedFile: string read FLastOpenedFile write SetLastOpenedFile;
    property LastOpenedFolder: string read FLastOpenedFolder write SetLastOpenedFolder;
    property Adapter: TATAdapterEControl read FAdapter write SetAdapter;
    property Lexer: TecSyntAnalyzer read FLexer write SetLexer;
    property LexerManager: TecLexerList read FLexerManager write SetLexerManager;
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

procedure TMainForm.actSaveFileExecute(Sender: TObject);
begin
  if atedMain.Modified then
  begin
    atedMain.SaveToFile(LastOpenedFile);
    LastSavedText := atedMain.Text;
    HandleAfterEdit;
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

procedure TMainForm.BCSVGButton1Click(Sender: TObject);
begin
  tvFolder.Visible := not tvFolder.Visible;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // 1. Create the adapter
  Adapter := TATAdapterEControl.Create(Self);
  Adapter.AddEditor(atedMain);

  // 2. Create a lexer manager and load the Markdown lexer
  LexerManager := TecLexerList.Create(Adapter);

  // Markdown
  Lexer := LexerManager.AddLexer;
  Lexer.LoadFromFile('lexers' + DirectorySeparator + 'Markdown' +
    DirectorySeparator + 'Markdown.lcf');

  // 3. Assign the loaded lexer to the adapter
  Adapter.Lexer := Lexer;
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
  I: integer;
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
    for I := LList.Count - 1 downto 0 do
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
  Caption := StringReplace(ExtractFileName(AFileName), ExtractFileExt(AFileName),
    '', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TMainForm.SetAdapter(AValue: TATAdapterEControl);
begin
  if FAdapter = AValue then Exit;
  FAdapter := AValue;
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

procedure TMainForm.SetLexer(AValue: TecSyntAnalyzer);
begin
  if FLexer = AValue then Exit;
  FLexer := AValue;
end;

procedure TMainForm.SetLexerManager(AValue: TecLexerList);
begin
  if FLexerManager = AValue then Exit;
  FLexerManager := AValue;
end;

end.
