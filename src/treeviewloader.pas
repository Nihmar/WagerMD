unit treeviewloader;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  ComCtrls,
  FileUtil;

procedure PopulateTreeView(TreeView: TTreeView; const RootPath: string);
procedure FreeTreeViewData(TreeView: TTreeView); // call before destroying the TreeView

implementation

type
  PStringData = ^string;

// Helper: store a string on the heap
function GetHeapString(const S: string): Pointer;
var
  P: PStringData;
begin
  New(P);
  P^ := S;
  Result := P;
end;

// Helper: retrieve string from pointer
function GetStringFromData(Data: Pointer): string;
begin
  if Data = nil then
    Result := ''
  else
    Result := PStringData(Data)^;
end;

// Recursive procedure that adds subfolders and files
procedure AddDirectoryContents(TreeView: TTreeView; ParentNode: TTreeNode;
  const Path: string);
var
  SearchRec: TSearchRec;
  SubNode: TTreeNode;
  FullPath: string;
begin
  if FindFirst(Path + DirectorySeparator + '*', faAnyFile, SearchRec) = 0 then
    begin
    repeat
      if (SearchRec.Name = '.') or (SearchRec.Name = '..') then
        Continue;

      FullPath := Path + DirectorySeparator + SearchRec.Name;

      if (SearchRec.Attr and faDirectory) = faDirectory then
        begin
        // Add folder node
        SubNode := TreeView.Items.AddChild(ParentNode, SearchRec.Name);
        SubNode.HasChildren := True;
        SubNode.Data := GetHeapString(FullPath);
        // Recurse into subfolder
        AddDirectoryContents(TreeView, SubNode, FullPath);
        end
      else
        begin
        // Add file node (optional – remove this block if you want folders only)
        SubNode := TreeView.Items.AddChild(ParentNode, SearchRec.Name);
        SubNode.HasChildren := False;
        SubNode.Data := GetHeapString(FullPath);
        end;
    until FindNext(SearchRec) <> 0;
    end;
  FindClose(SearchRec);
end;

// Main public procedure: clears and fills the TreeView
procedure PopulateTreeView(TreeView: TTreeView; const RootPath: string);
var
  RootNode: TTreeNode;
begin
  if not DirectoryExists(RootPath) then
    raise Exception.Create('Folder does not exist: ' + RootPath);

  TreeView.Items.BeginUpdate;
    try
    // Free any existing data stored in nodes
    FreeTreeViewData(TreeView);
    TreeView.Items.Clear;

    // Create root node (the folder itself)
    RootNode := TreeView.Items.Add(nil, ExtractFileName(RootPath));
    RootNode.HasChildren := True;
    RootNode.Data := GetHeapString(RootPath);

    // Fill subfolders and files
    AddDirectoryContents(TreeView, RootNode, RootPath);

    RootNode.Expand(False); // expand the root (optional)
    finally
    TreeView.Items.EndUpdate;
    end;
end;

// Frees all heap‑allocated strings stored in TreeView nodes
procedure FreeTreeViewData(TreeView: TTreeView);
var
  i: integer;
begin
  for i := 0 to TreeView.Items.Count - 1 do
    if TreeView.Items[i].Data <> nil then
      begin
      Dispose(PStringData(TreeView.Items[i].Data));
      TreeView.Items[i].Data := nil;
      end;
end;

end.
