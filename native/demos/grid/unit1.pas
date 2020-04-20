unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Menus,
  DBGrids, ntvGrids;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CloseBtn: TButton;
    ComboBox1: TComboBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ntvGrid1Click(Sender: TObject);
  private
    procedure OnColClick(Sender: TntvCustomGrid; Column: TntvColumn);
  public
    Grid: TntvGrid;
    NameCol: TntvColumn;
    PhoneCol: TntvColumn;
    EmailCol: TntvColumn;
    MobileCol: TntvColumn;
    PayCol: TntvColumn;
    AddressCol: TntvColumn;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CloseBtnClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Grid[5, 0] := 'test1';

  Grid.BeginUpdate;
  try
    Grid.Rows[6][0].Text := 'test2';
  finally
    Grid.EndUpdate;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if BiDiMode = bdLeftToRight then
    BiDiMode := bdRightToLeft
  else
    BiDiMode := bdLeftToRight
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Grid := TntvGrid.Create(Self);
  Grid.Parent := Self;
  Grid.SetBounds(10, 10 ,ClientWidth - 20, CloseBtn.Top - 10);
  Grid.Anchors := [akLeft, akRight, akTop, akBottom];
  Grid.Capacity := 3;
  Grid.OnColClick := @OnColClick;
  Grid.Footer := True;
  Grid.Fringe := True;
  Grid.PopupMenu := PopupMenu1;
  Grid.FullHeader := true;
  Grid.SettledCols := 1;
  Grid.BorderStyle := bsSingle;

  //Grid.RowHeight := 47;
  NameCol := TntvStandardColumn.Create(Grid, 'Name');
  PhoneCol := TntvStandardColumn.Create(Grid, 'Phone');
  MobileCol := TntvStandardColumn.Create(Grid, 'Mobile');
  EmailCol := TntvStandardColumn.Create(Grid, 'Email');
  EmailCol.Hint := 'example: email@domain.com';
  PayCol := TntvStandardColumn.Create(Grid, 'Pay');
  PayCol.IsTotal := True;
  //PayCol.AutoSize := True;
  AddressCol := TntvStandardColumn.Create(Grid, 'Address');
  Grid.TabOrder := 0;

  Grid.ActiveRow := 0;
  NameCol.AsString := 'zaher';
  AddressCol.AsString := 'syria';

  MobileCol.OrderIndex := PhoneCol.OrderIndex;
  EmailCol.Visible := False;

  Grid.Visible := True;
  ActiveControl := Grid;
end;

procedure TForm1.ntvGrid1Click(Sender: TObject);
begin

end;

procedure TForm1.OnColClick(Sender: TntvCustomGrid; Column: TntvColumn);
begin
  Grid.Values[Column.Index, 0] := 'Clicked';
end;

end.

