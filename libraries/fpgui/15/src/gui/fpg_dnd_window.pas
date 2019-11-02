{
    This unit is part of the fpGUI Toolkit project.

    Copyright (c) 2015 by Andrew Haines.

    See the file COPYING.modifiedLGPL, included in this distribution,
    for details about redistributing fpGUI.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

}
unit fpg_dnd_window;

{$I fpg_defines.inc}

interface

uses
  Classes, SysUtils,
  fpg_main,
  fpg_base,
  fpg_window;

type

  TfpgDNDWindow = class(TfpgWindow)
  private
    FDrag: TfpgDrag;
  protected
    procedure   HandlePaint; override;
  public
    constructor Create(AOwner: TComponent; ADrag: TfpgDrag); reintroduce;
    procedure   Show(ASize: TfpgSize);
    function    HasWidgetChildren: Boolean;
  end;


implementation


{ TfpgDNDWindow }

type
  TfpgDragAccess = class(TfpgDrag);

procedure TfpgDNDWindow.HandlePaint;
begin
  if Assigned(FDrag) then
    TfpgDragAccess(FDrag).DoOnPaintPreview(Canvas);
end;

constructor TfpgDNDWindow.Create(AOwner: TComponent; ADrag: TfpgDrag);
begin
  inherited Create(AOwner);
  WindowType := wtPopup;
  WindowOpacity := 0.4;
  Focusable := False;
  FDrag := ADrag;
end;

procedure TfpgDNDWindow.Show(ASize: TfpgSize);
begin
  FVisible:=True;
  HandleShow;
  SetPosition(Left, Top, ASize.W, ASize.H);
end;

function TfpgDNDWindow.HasWidgetChildren: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ComponentCount-1 do
    if Components[I].InheritsFrom(TfpgWidgetBase) then
      Exit(True);
end;

end.

