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
  ATSynEdit,
  CatpuccinColors;

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
    procedure ApplyEditorColors(Ed: TATSynEdit; ADark: boolean);
    function IsDarkTheme: boolean;
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
begin
  { #todo : Make a function which retrieves colors from current app theme and applies them correctly to ATSynEdit }
  ApplyEditorColors(atedMain, IsDarkTheme);
end;

procedure TMainForm.ApplyEditorColors(Ed: TATSynEdit; ADark: boolean);
begin
  with Ed.Colors do
  begin
    if ADark then
    begin
      TextFont := Mocha_Text;
      TextBG := Mocha_Base;
      TextSelFont := Mocha_Text;
      TextSelBG := Mocha_Surface2;
      TextDisabledFont := Mocha_Overlay0;
      TextDisabledBG := Mocha_Surface0;
      Caret := Mocha_Lavender;
      Markers := Mocha_Lavender;
      CurrentLineBG := Mocha_Surface0;
      IndentVertLines := Mocha_Surface1;
      UnprintedFont := Mocha_Overlay0;
      UnprintedBG := Mocha_Base;
      UnprintedHexFont := Mocha_Overlay0;
      MinimapBorder := Mocha_Surface1;
      MinimapTooltipBG := Mocha_Surface0;
      MinimapTooltipBorder := Mocha_Surface1;
      StateChanged := Mocha_Yellow;
      StateAdded := Mocha_Green;
      StateSaved := Mocha_Teal;
      BlockStaple := Mocha_Surface1;
      BlockSepLine := Mocha_Surface1;
      Links := Mocha_Lavender;
      LockedBG := Mocha_Surface0;
      ComboboxArrow := Mocha_Lavender;
      ComboboxArrowBG := Mocha_Base;
      CollapseLine := Mocha_Surface1;
      CollapseMarkFont := Mocha_Lavender;
      CollapseMarkBorder := Mocha_Surface1;
      CollapseMarkBG := Mocha_Surface0;
      GutterFont := Mocha_Overlay0;
      GutterBG := Mocha_Mantle;
      GutterCaretFont := Mocha_Lavender;
      GutterCaretBG := Mocha_Surface0;
      BookmarkBG := Mocha_Green;
      RulerFont := Mocha_Overlay0;
      RulerBG := Mocha_Mantle;
      GutterFoldLine := Mocha_Overlay0;
      GutterFoldLine2 := Mocha_Lavender;
      GutterFoldBG := Mocha_Mantle;
      MarginRight := Mocha_Surface1;
      MarginCaret := Mocha_Surface2;
      MarginUser := Mocha_Surface2;
      MarkedLinesBG := Mocha_Yellow;
      BorderLine := Mocha_Surface1;
      BorderLineFocused := Mocha_Lavender;
    end
    else
    begin
      TextFont := Latte_Text;
      TextBG := Latte_Base;
      TextSelFont := Latte_Text;
      TextSelBG := Latte_Surface2;
      TextDisabledFont := Latte_Overlay0;
      TextDisabledBG := Latte_Surface0;
      Caret := Latte_Lavender;
      Markers := Latte_Lavender;
      CurrentLineBG := Latte_Surface0;
      IndentVertLines := Latte_Surface1;
      UnprintedFont := Latte_Overlay0;
      UnprintedBG := Latte_Base;
      UnprintedHexFont := Latte_Overlay0;
      MinimapBorder := Latte_Surface1;
      MinimapTooltipBG := Latte_Surface0;
      MinimapTooltipBorder := Latte_Surface1;
      StateChanged := Latte_Yellow;
      StateAdded := Latte_Green;
      StateSaved := Latte_Teal;
      BlockStaple := Latte_Surface1;
      BlockSepLine := Latte_Surface1;
      Links := Latte_Lavender;
      LockedBG := Latte_Surface0;
      ComboboxArrow := Latte_Lavender;
      ComboboxArrowBG := Latte_Base;
      CollapseLine := Latte_Surface1;
      CollapseMarkFont := Latte_Lavender;
      CollapseMarkBorder := Latte_Surface1;
      CollapseMarkBG := Latte_Surface0;
      GutterFont := Latte_Overlay0;
      GutterBG := Latte_Mantle;
      GutterCaretFont := Latte_Lavender;
      GutterCaretBG := Latte_Surface0;
      BookmarkBG := Latte_Green;
      RulerFont := Latte_Overlay0;
      RulerBG := Latte_Mantle;
      GutterFoldLine := Latte_Overlay0;
      GutterFoldLine2 := Latte_Lavender;
      GutterFoldBG := Latte_Mantle;
      MarginRight := Latte_Surface1;
      MarginCaret := Latte_Surface2;
      MarginUser := Latte_Surface2;
      MarkedLinesBG := Latte_Yellow;
      BorderLine := Latte_Surface1;
      BorderLineFocused := Latte_Lavender;
    end;
  end;
  Ed.Update;
end;

function TMainForm.IsDarkTheme: boolean;

  function Lum(C: TColor): double;
  begin
    Result := Red(ColorToRGB(C)) * 0.3 + Green(ColorToRGB(C)) * 0.59 +
      Blue(ColorToRGB(C)) * 0.11;
  end;

begin
  Result := Lum(clWindow) < Lum(clWindowText);
end;

end.
