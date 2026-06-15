unit EditorColors;

{$mode objfpc}{$H+}

interface

uses
  Themes,
  Forms,
  ExtCtrls,
  Graphics,
  ATSynEdit,
  ATSynEdit_Colors;

type
  TRGB = record
    R, G, B: byte;
  end;

  TEditorPalette = record
    Base, Mantle, Surface0, Surface1, Surface2,
    Overlay0, Text, Accent,
    Red, Green, Yellow, Blue: TColor;
  end;

const
  // ---- Catppuccin Mocha (dark), accent = Lavender ----
  PaletteMocha: TEditorPalette = (
    Base: $2E1E1E; Mantle: $251818;
    Surface0: $443231; Surface1: $5A4745; Surface2: $705B58;
    Overlay0: $86706C; Text: $F4D6CD; Accent: $FEBEB4;
    Red: $A88BF3; Green: $A1E3A6; Yellow: $AFE2F9; Blue: $FAB489;
    );

  // ---- Catppuccin Latte (light), accent = Lavender ----
  PaletteLatte: TEditorPalette = (
    Base: $F5F1EF; Mantle: $EFE9E6;
    Surface0: $DAD0CC; Surface1: $CCC0BC; Surface2: $BEB0AC;
    Overlay0: $B0A09C; Text: $694F4C; Accent: $FD8772;
    Red: $390FD2; Green: $2BA040; Yellow: $1D8EDF; Blue: $F5661E;
    );

  // ---- Breeze Light (KDE/breeze) ----
  PaletteBreezeLight: TEditorPalette = (
    Base: $FFFFFF; Mantle: $F1F0EF;
    Surface0: $F7F7F7; Surface1: $E7E5E3; Surface2: $F5E1BF;
    Overlay0: $8A7D70; Text: $292623; Accent: $E9AE3D;
    Red: $5344DA; Green: $60AE27; Yellow: $0074F6; Blue: $B98029;
    );

  // ---- Breeze Dark (KDE/breeze) ----
  PaletteBreezeDark: TEditorPalette = (
    Base: $181614; Mantle: $262320;
    Surface0: $221F1D; Surface1: $302C29; Surface2: $634A2E;
    Overlay0: $B1A9A1; Text: $FCFCFC; Accent: $E9AE3D;
    Red: $5344DA; Green: $60AE27; Yellow: $0074F6; Blue: $F3991D;
    );

  // ---- Darkly (Bali10050/Darkly) ----
  PaletteDarkly: TEditorPalette = (
    Base: $2C2C2C; Mantle: $222222;
    Surface0: $363636; Surface1: $4D4D4D; Surface2: $D5911B;
    Overlay0: $C7C7C7; Text: $F1F1F1; Accent: $DA7834;
    Red: $5344DA; Green: $59AD24; Yellow: $0074F6; Blue: $FF6400;
    );

  // ---- Nord (dark) ----
  PaletteNord: TEditorPalette = (
    Base: $40342E; Mantle: $40342E;
    Surface0: $52423B; Surface1: $5E4C43; Surface2: $6A564C;
    Overlay0: $6A564C; Text: $E9DED8; Accent: $D0C088;
    Red: $6A61BF; Green: $8CBEA3; Yellow: $8BCBEB; Blue: $AC815E;
    );

  // ---- Gruvbox Dark ----
  PaletteGruvboxDark: TEditorPalette = (
    Base: $282828; Mantle: $21201D;
    Surface0: $36383C; Surface1: $454950; Surface2: $545C66;
    Overlay0: $748392; Text: $B2DBEB; Accent: $1980FE;
    Red: $3449FB; Green: $26BBB8; Yellow: $2FBDFA; Blue: $98A583;
    );

  // ---- Gruvbox Light ----
  PaletteGruvboxLight: TEditorPalette = (
    Base: $C7F1FB; Mantle: $D7F5F9;
    Surface0: $B2DBEB; Surface1: $A1C4D5; Surface2: $93AEBD;
    Overlay0: $748392; Text: $36383C; Accent: $0E5DD6;
    Red: $1D24CC; Green: $1A9798; Yellow: $2199D7; Blue: $888545;
    );

  // ---- Tokyo Night ----
  PaletteTokyoNight: TEditorPalette = (
    Base: $261B1A; Mantle: $1E1616;
    Surface0: $422E29; Surface1: $61423B; Surface2: $684841;
    Overlay0: $895F56; Text: $F5CAC0; Accent: $F7A27A;
    Red: $8E76F7; Green: $6ACE9E; Yellow: $68AFE0; Blue: $FFCF7D;
    );

  // ---- Dracula ----
  PaletteDracula: TEditorPalette = (
    Base: $362A28; Mantle: $2C2221;
    Surface0: $5A4744; Surface1: $5A4744; Surface2: $66504D;
    Overlay0: $A47262; Text: $F2F8F8; Accent: $F993BD;
    Red: $5555FF; Green: $7BFA50; Yellow: $8CFAF1; Blue: $FDE98B;
    );

  // ---- Solarized Dark ----
  PaletteSolarizedDark: TEditorPalette = (
    Base: $362B00; Mantle: $423607;
    Surface0: $756E58; Surface1: $837B65; Surface2: $969483;
    Overlay0: $A1A193; Text: $D5E8EE; Accent: $98A12A;
    Red: $2F32DC; Green: $009985; Yellow: $0089B5; Blue: $D28B26;
    );

  // ---- Solarized Light ----
  PaletteSolarizedLight: TEditorPalette = (
    Base: $E3F6FD; Mantle: $D5E8EE;
    Surface0: $A1A193; Surface1: $969483; Surface2: $837B65;
    Overlay0: $756E58; Text: $423607; Accent: $98A12A;
    Red: $2F32DC; Green: $009985; Yellow: $0089B5; Blue: $D28B26;
    );

  // ---- One Dark (Atom) ----
  PaletteOneDark: TEditorPalette = (
    Base: $342C28; Mantle: $2B2521;
    Surface0: $3A312C; Surface1: $52443E; Surface2: $63524B;
    Overlay0: $70635C; Text: $BFB2AB; Accent: $EFAF61;
    Red: $756CE0; Green: $79C398; Yellow: $7BC0E5; Blue: $FF81AE;
    );

  // ---- Monokai ----
  PaletteMonokai: TEditorPalette = (
    Base: $222827; Mantle: $1C1F1E;
    Surface0: $272E2D; Surface1: $293B37; Surface2: $3C4E49;
    Overlay0: $5E7175; Text: $F2F8F8; Accent: $2EE2A6;
    Red: $7226F9; Green: $EFD966; Yellow: $74DBE6; Blue: $FF81AE;
    );

  // ---- Rosé Pine ----
  PaletteRosePine: TEditorPalette = (
    Base: $241719; Mantle: $201315;
    Surface0: $2E1D1F; Surface1: $3A2326; Surface2: $3F272A;
    Overlay0: $866A6E; Text: $F4DEE0; Accent: $D8CF9C;
    Red: $926FEB; Green: $8F7431; Yellow: $77C1F6; Blue: $E7A7C4;
    );

  // ---- Everforest (dark) ----
  PaletteEverforest: TEditorPalette = (
    Base: $3B352D; Mantle: $332E27;
    Surface0: $443F34; Surface1: $4D483D; Surface2: $585247;
    Overlay0: $726A5C; Text: $AAC6D3; Accent: $80C0A7;
    Red: $807EE6; Green: $92C083; Yellow: $7FBCDB; Blue: $B3BB7F;
    );

  // ---- Horizon (VSCode theme) ----
  PaletteHorizon: TEditorPalette = (
    Base: $2E1E1E; Mantle: $261818;
    Surface0: $3A2525; Surface1: $442D2D; Surface2: $533636;
    Overlay0: $936F6C; Text: $E8D8D5; Accent: $D9BB26;
    Red: $7856E9; Green: $98D329; Yellow: $95B7FA; Blue: $A370D3;
    );

function GetRValue(Color: TColor): byte; inline;
function GetGValue(Color: TColor): byte; inline;
function GetBValue(Color: TColor): byte; inline;
function ColorToRGBRec(Color: TColor): TRGB;
function GetColorFromMainForm: TColor;
function GetThemeColorFromPanel: TColor;
function ColorDistance(const C1, C2: TRGB): double;
function FindBestPalette(TitleColor: TColor): TEditorPalette;
procedure ApplyEditorColors(Ed: TATSynEdit; const APalette: TEditorPalette);
procedure ApplyEditorColorsFromTheme(Ed: TATSynEdit);

implementation

function GetRValue(Color: TColor): byte; inline;
begin
  Result := Color and $FF;
end;

function GetGValue(Color: TColor): byte; inline;
begin
  Result := (Color shr 8) and $FF;
end;

function GetBValue(Color: TColor): byte; inline;
begin
  Result := (Color shr 16) and $FF;
end;

function ColorToRGBRec(Color: TColor): TRGB;
begin
  Result.R := GetRValue(Color);
  Result.G := GetGValue(Color);
  Result.B := GetBValue(Color);
end;

function ColorDistance(const C1, C2: TRGB): double;
begin
  Result := Sqrt(Sqr(C1.R - C2.R) + Sqr(C1.G - C2.G) + Sqr(C1.B - C2.B));
end;

function GetThemeColorFromPanel: TColor;
var
  Panel: TPanel;
begin
  Panel := TPanel.Create(nil);
    try
    Panel.Parent := Application.MainForm; // Imposta un parent per ereditare il tema
    Panel.ParentColor := True;            // Forza l'ereditarietà del colore
    Result := Panel.GetRGBColorResolvingParent; // Risolve il colore reale
    finally
    Panel.Free;
    end;
end;

function FindBestPalette(TitleColor: TColor): TEditorPalette;
var
  Palettes: array[0..16] of TEditorPalette;
  i, BestIdx: integer;
  BestDist, Dist: double;
  TargetRGB, CurrentRGB: TRGB;
begin
  Palettes[0] := PaletteMocha;
  Palettes[1] := PaletteLatte;
  Palettes[2] := PaletteBreezeLight;
  Palettes[3] := PaletteBreezeDark;
  Palettes[4] := PaletteDarkly;
  Palettes[5] := PaletteNord;
  Palettes[6] := PaletteGruvboxDark;
  Palettes[7] := PaletteGruvboxLight;
  Palettes[8] := PaletteTokyoNight;
  Palettes[9] := PaletteDracula;
  Palettes[10] := PaletteSolarizedDark;
  Palettes[11] := PaletteSolarizedLight;
  Palettes[12] := PaletteOneDark;
  Palettes[13] := PaletteMonokai;
  Palettes[14] := PaletteRosePine;
  Palettes[15] := PaletteEverforest;
  Palettes[16] := PaletteHorizon;

  TargetRGB := ColorToRGBRec(TitleColor);
  BestDist := MaxInt;
  BestIdx := 0;
  for i := Low(Palettes) to High(Palettes) do
    begin
    CurrentRGB := ColorToRGBRec(Palettes[i].Mantle);
    Dist := ColorDistance(TargetRGB, CurrentRGB); // o .Mantle
    if Dist < BestDist then
      begin
      BestDist := Dist;
      BestIdx := i;
      end;
    end;
  Result := Palettes[BestIdx];
end;

procedure ApplyEditorColors(Ed: TATSynEdit; const APalette: TEditorPalette);
begin
  with Ed.Colors do
    begin
    TextFont := APalette.Text;
    TextBG := APalette.Base;
    TextSelFont := APalette.Text;
    TextSelBG := APalette.Surface2;
    TextDisabledFont := APalette.Overlay0;
    TextDisabledBG := APalette.Surface0;
    Caret := APalette.Accent;
    Markers := APalette.Accent;
    CurrentLineBG := APalette.Surface0;
    IndentVertLines := APalette.Surface1;
    UnprintedFont := APalette.Overlay0;
    UnprintedBG := APalette.Base;
    UnprintedHexFont := APalette.Overlay0;
    MinimapBorder := APalette.Surface1;
    MinimapTooltipBG := APalette.Surface0;
    MinimapTooltipBorder := APalette.Surface1;
    StateChanged := APalette.Yellow;
    StateAdded := APalette.Green;
    StateSaved := APalette.Blue;
    BlockStaple := APalette.Surface1;
    BlockSepLine := APalette.Surface1;
    Links := APalette.Accent;
    LockedBG := APalette.Surface0;
    ComboboxArrow := APalette.Accent;
    ComboboxArrowBG := APalette.Base;
    CollapseLine := APalette.Surface1;
    CollapseMarkFont := APalette.Accent;
    CollapseMarkBorder := APalette.Surface1;
    CollapseMarkBG := APalette.Surface0;
    GutterFont := APalette.Overlay0;
    GutterBG := APalette.Mantle;
    GutterCaretFont := APalette.Accent;
    GutterCaretBG := APalette.Surface0;
    BookmarkBG := APalette.Green;
    RulerFont := APalette.Overlay0;
    RulerBG := APalette.Mantle;
    GutterFoldLine := APalette.Overlay0;
    GutterFoldLine2 := APalette.Accent;
    GutterFoldBG := APalette.Mantle;
    MarginRight := APalette.Surface1;
    MarginCaret := APalette.Surface2;
    MarginUser := APalette.Surface2;
    MarkedLinesBG := APalette.Yellow;
    BorderLine := APalette.Surface1;
    BorderLineFocused := APalette.Accent;
    end;
  Ed.Update;
end;

function GetColorFromMainForm: TColor;
begin
  Result := Application.MainForm.GetDefaultColor(dctBrush);
end;

procedure ApplyEditorColorsFromTheme(Ed: TATSynEdit);
var
  TitleColor: TColor;
  SelectedPalette: TEditorPalette;
begin
  TitleColor := GetThemeColorFromPanel;
  SelectedPalette := FindBestPalette(TitleColor);
  ApplyEditorColors(Ed, SelectedPalette);
end;

end.
