unit uMenu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.SearchBox, FMX.StdCtrls, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.MultiView, System.ImageList, FMX.ImgList,
  FMX.TabControl, System.Actions, FMX.ActnList, System.Generics.Collections,
  FMX.Menus, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, uDM,
  FMX.Effects, FMX.DateTimeCtrls,Data.DB;

type
  TForm2 = class(TForm)
    AL: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    img: TImageList;
    mvMain: TMultiView;
    loMV: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    btnDashboard: TCornerButton;
    ListBoxItem2: TListBoxItem;
    btnItems: TCornerButton;
    SearchBox1: TSearchBox;
    Line1: TLine;
    btnSettings: TCornerButton;
    SB: TStyleBook;
    tcMain: TTabControl;
    TabItem1: TTabItem;
    Label4: TLabel;
    TabItem2: TTabItem;
    Label5: TLabel;
    TabItem3: TTabItem;
    Label6: TLabel;
    MenuBar: TMainMenu;
    Menu: TMenuItem;
    Exit: TMenuItem;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    Edit1: TEdit;
    ShadowEffect1: TShadowEffect;
    Panel2: TPanel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    DateEdit1: TDateEdit;
    Image2: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CornerButton1: TCornerButton;
    CornerButton2: TCornerButton;
    CornerButton3: TCornerButton;
    CornerButton4: TCornerButton;
    OpenDialog1: TOpenDialog;
    TimeEdit1: TTimeEdit;
    Label9: TLabel;
    Label10: TLabel;
    StringColumn5: TStringColumn;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    StringGrid2: TStringGrid;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    CornerButton5: TCornerButton;
    CornerButton6: TCornerButton;
    CornerButton7: TCornerButton;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    Rectangle9: TRectangle;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Rectangle12: TRectangle;
    GridPanelLayout1: TGridPanelLayout;
    Rectangle13: TRectangle;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Rectangle17: TRectangle;
    Rectangle18: TRectangle;
    Rectangle19: TRectangle;
    Rectangle20: TRectangle;
    Rectangle21: TRectangle;
    Rectangle22: TRectangle;
    Rectangle23: TRectangle;
    Rectangle24: TRectangle;
    Rectangle25: TRectangle;
    Rectangle26: TRectangle;
    Rectangle27: TRectangle;
    Rectangle28: TRectangle;
    Rectangle29: TRectangle;
    Rectangle30: TRectangle;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDashboardClick(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RefreshGrid;
    procedure RefreshUsersGrid;
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure CornerButton3Click(Sender: TObject);
    procedure CornerButton4Click(Sender: TObject);
    procedure StringGrid1CellClick(const Column: TColumn; const Row: Integer);
    procedure enablededitor;
    procedure disableeditor;
    procedure Edit1Change(Sender: TObject);
    procedure tcMainChange(Sender: TObject);
    procedure ClearImage;
  private
    { Private declarations }
    ListMenu : TList<TCornerButton>;
    procedure setMenu(B : TCornerButton); //ctrl + shift + c
    procedure SearchAndDisplayResults(const SearchTerm: string);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.btnDashboardClick(Sender: TObject);
begin
  setMenu(TCornerButton(Sender));

  mvMain.HideMaster;

  var TabIndex := StrToIntDef(TCornerButton(Sender).Hint, 0);
  //tcMain.TabIndex := TabIndex;
  AL.Actions[TabIndex].Execute;
end;

procedure TForm2.ClearImage;
begin
OpenDialog1.FileName := '';
Opendialog1.Files.Clear;
Image2.Bitmap.Clear(TAlphaColors.Null);
end;

procedure TForm2.CornerButton1Click(Sender: TObject);
var FileStream: TFileStream;
begin
if CornerButton1.Text = 'Tambah' then
begin
  EnabledEditor;
  CornerButton1.Text := 'Simpan';
  CornerButton3.Enabled := False;
  CornerButton2.Enabled := False;
  Edit2.text := '';
Edit3.text := '';
Edit4.text := '';
  end
else if CornerButton1.Text= 'Simpan' then
begin
with DataModule1 do
begin
FileStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead or fmShareDenyWrite);
try
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Text := 'INSERT INTO barang ( nama_barang, stok_barang, tanggal_masuk, waktu_masuk, gambar_barang) VALUES ( :nama, :stok, :tanggal, :waktu, :gambar)';
  FDQuery1.Params.ParamByName('nama').AsString := Edit3.Text;
  FDQuery1.Params.ParamByName('stok').AsString := Edit4.Text;
  FDQuery1.Params.ParamByName('tanggal').AsDate := DateEdit1.Date;
   FDQuery1.Params.ParamByName('waktu').AsTime := TimeEdit1.Time;
  FDQuery1.Params.ParamByName('gambar').LoadFromStream(FileStream, ftBlob);
  FDQuery1.ExecSQL;
finally

end;
end;
RefreshGrid;
CornerButton1.Text := 'Tambah';
CornerButton3.Enabled := True;
CornerButton2.Enabled := True;
DisableEditor;
Edit2.text := '';
Edit3.text := '';
Edit4.text := '';
ClearImage;
end;
end;

procedure TForm2.CornerButton2Click(Sender: TObject);
var
  SelectedRow: Integer;
  ID: Integer;
begin
  SelectedRow := StringGrid1.Row;

  if SelectedRow >= 0 then
  begin
    ID := StrToInt(StringGrid1.Cells[0, SelectedRow]);
   with DataModule1 do
   begin
    FDConnection1.Connected := True;
    FDQuery1.SQL.Text := 'DELETE FROM barang WHERE id_barang = :ID';
    FDQuery1.Params.ParamByName('ID').AsInteger := ID;
    FDQuery1.ExecSQL;
    FDConnection1.Connected := False;
    ClearImage;
    RefreshGrid;
    Edit2.text := '';
    Edit3.text := '';
    Edit4.text := '';
   end;
  end;
end;

procedure TForm2.CornerButton3Click(Sender: TObject);
var
 SelectedRow: Integer;
 ID: Integer;
begin
if Edit2.Text = '' then
begin
  ShowMessage('ID Tidak Ditemukan');
end
else
begin
  if CornerButton3.Text = 'Edit' then
  begin
  EnabledEditor;
  CornerButton3.Text := 'Simpan';
  CornerButton1.Enabled := False;
  CornerButton2.Enabled := False;
  end
else if CornerButton3.Text= 'Simpan' then
  begin
  SelectedRow := StringGrid1.Row;
  with DataModule1 do
  begin
  if (SelectedRow >= 0) then
    begin
    ID := StrToInt(StringGrid1.Cells[0, SelectedRow]);
    FDQuery1.SQL.Text := 'UPDATE barang SET nama_barang = :Nama, stok_barang = :Stok, tanggal_masuk =:tanggal, waktu_masuk =:waktu WHERE id_barang = :ID';
    FDQuery1.ParamByName('ID').AsInteger := StrToInt(Edit2.Text);
    FDQuery1.ParamByName('Nama').AsString := Edit3.Text;
    FDQuery1.ParamByName('Stok').AsString := Edit4.Text;
    FDQuery1.ParamByName('tanggal').AsDate := DateEdit1.Date;
    FDQuery1.ParamByName('waktu').AsTime := TimeEdit1.Time;
    FDQuery1.ExecSQL;
    end;
    RefreshGrid;
    DisableEditor;
    CornerButton3.Text := 'Edit';
    CornerButton1.Enabled := True;
    CornerButton2.Enabled := True;
    ClearImage;
    Edit2.text := '';
    Edit3.text := '';
    Edit4.text := '';

  end;
  end;

  end;
end;

procedure TForm2.CornerButton4Click(Sender: TObject);
begin
if OpenDialog1.Execute then
begin
  image2.Bitmap.LoadFromFile(OpenDialog1.FileName);
end;
end;

procedure TForm2.disableeditor;
begin
Edit2.Enabled := False;
Edit3.Enabled := False;
Edit4.Enabled := False;
DateEdit1.Enabled := False;
TimeEdit1.Enabled := False;
CornerButton4.Enabled := False;
Edit2.text := '';
Edit3.text := '';
Edit4.text := '';
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
SearchAndDisplayResults(Edit1.Text);
end;

procedure TForm2.enablededitor;
begin
Edit2.Enabled := True;
Edit3.Enabled := True;
Edit4.Enabled := True;
DateEdit1.Enabled := True;
TimeEdit1.Enabled := True;
CornerButton4.Enabled := true;
end;

procedure TForm2.ExitClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//Items Tab
  ListMenu := TList<TCornerButton>.Create;
  ListMenu.Add(btnDashboard);
  ListMenu.Add(btnItems);
  ListMenu.Add(btnSettings);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
ListMenu.DisposeOf;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  with DataModule1 do Begin
  FDQuery1.SQL.Text := 'SELECT * FROM barang';
  FDQuery1.Open;
  End;

end;

procedure TForm2.MenuClick(Sender: TObject);
begin
mvMain.ShowMaster;
end;

procedure TForm2.RefreshGrid;
var
  RowIndex: Integer;
begin
  With DataModule1 do begin
  FDConnection1.Connected := True;
  FDQuery1.SQL.Text := 'SELECT id_barang, nama_barang, stok_barang, tanggal_masuk, waktu_masuk, gambar_barang FROM barang';
  FDQuery1.Open;

  // Bersihkan StringGrid sebelum memuat data baru
  StringGrid1.RowCount := 1; // Set ke 1 untuk menjaga header
  RowIndex := 0;

  while not FDQuery1.Eof do
  begin
    StringGrid1.RowCount := RowIndex + 1;
    StringGrid1.Cells[0, RowIndex] := FDQuery1.FieldByName('id_barang').AsString;
    StringGrid1.Cells[1, RowIndex] := FDQuery1.FieldByName('nama_barang').AsString;
    StringGrid1.Cells[2, RowIndex] := FDQuery1.FieldByName('stok_barang').AsString;
    StringGrid1.Cells[3, RowIndex] := FDQuery1.FieldByName('tanggal_masuk').AsString;
    StringGrid1.Cells[4, RowIndex] := FDQuery1.FieldByName('waktu_masuk').AsString;
    Inc(RowIndex);
    FDQuery1.Next;
  end;
  end;
end;
procedure TForm2.RefreshUsersGrid;
var RowIndex: Integer;
begin
With DataModule1 do begin
  FDConnection1.Connected := True;
  FDQuery1.SQL.Text := 'SELECT id_user, username, password FROM users';
  FDQuery1.Open;

  // Bersihkan StringGrid sebelum memuat data baru
  StringGrid1.RowCount := 1; // Set ke 1 untuk menjaga header
  RowIndex := 0;

  while not FDQuery1.Eof do
  begin
    StringGrid2.RowCount := RowIndex + 1;
    StringGrid2.Cells[0, RowIndex] := FDQuery1.FieldByName('id_user').AsString;
    StringGrid2.Cells[1, RowIndex] := FDQuery1.FieldByName('username').AsString;
    StringGrid2.Cells[2, RowIndex] := FDQuery1.FieldByName('password').AsString;
    Inc(RowIndex);
    FDQuery1.Next;
  end;
  end;
end;
procedure TForm2.SearchAndDisplayResults(const SearchTerm: string);
var
  RowIndex: Integer;
begin
  With DataModule1 do
  begin
    FDConnection1.Connected := True;

    // Use SQL LIKE clause to search for the term in relevant fields
    FDQuery1.SQL.Text := 'SELECT id_barang, nama_barang, stok_barang, tanggal_masuk, waktu_masuk ' +
                         'FROM barang ' +
                         'WHERE id_barang LIKE :SearchTerm OR ' +
                         'nama_barang LIKE :SearchTerm OR ' + 'stok_barang LIKE :SearchTerm';

    FDQuery1.ParamByName('SearchTerm').AsString := '%' + SearchTerm + '%';
    FDQuery1.Open;

    // Clear existing rows in the StringGrid
    StringGrid1.RowCount := 0;
    RowIndex := 0;

    while not FDQuery1.Eof do
    begin
      StringGrid1.RowCount := RowIndex + 1;
      StringGrid1.Cells[0, RowIndex] := FDQuery1.FieldByName('id_barang').AsString;
      StringGrid1.Cells[1, RowIndex] := FDQuery1.FieldByName('nama_barang').AsString;
      StringGrid1.Cells[2, RowIndex] := FDQuery1.FieldByName('stok_barang').AsString;
      StringGrid1.Cells[3, RowIndex] := FDQuery1.FieldByName('tanggal_masuk').AsString;
      StringGrid1.Cells[4, RowIndex] := FDQuery1.FieldByName('waktu_masuk').AsString;
      Inc(RowIndex);
      FDQuery1.Next;
    end;
  end;
end;
procedure TForm2.setMenu(B: TCornerButton);
begin
   var LB : TCornerButton;
  for LB in ListMenu do begin
    LB.ImageIndex := LB.Tag;
    LB.StyleLookup := 'btnSidebarI';
    LB.Font.Style := [];
    LB.FontColor := $FF5E5E5E;
    LB.StyledSettings := [];
  end;

  B.ImageIndex := B.Tag + 1;
  B.Font.Style := [TFontStyle.fsBold];
  B.FontColor := $FFFFFFFF;
  B.StyleLookup := 'btnSidebarS';
end;

procedure TForm2.StringGrid1CellClick(const Column: TColumn;
  const Row: Integer);
var
  SelectedRow: Integer;
  ID: Integer;
  MemoryStream: TMemoryStream;
begin
SelectedRow := StringGrid1.Row;
if SelectedRow >= 0 then
begin
  ID := StrToInt(StringGrid1.Cells[0, SelectedRow]);

  with DataModule1 do
  begin
    FDQuery1.SQL.Text := 'SELECT gambar_barang FROM barang WHERE id_barang = :ID';
    FDQuery1.Params.ParamByName('ID').AsInteger := ID;
    FDQuery1.Open;

  if not FDQuery1.Eof then
    begin
      MemoryStream := TMemoryStream.Create;
      try
        TBlobField(FDQuery1.FieldByName('gambar_barang')).SaveToStream(MemoryStream);
        MemoryStream.Position := 0; // Reset posisi stream ke awal


        // Tampilkan gambar di TImage
        Image2.Bitmap.LoadFromStream(MemoryStream);

        //Menampilkan Data yang diklik
        Edit2.Text := StringGrid1.Cells[0,SelectedRow];
        Edit3.Text := StringGrid1.Cells[1,SelectedRow];
        Edit4.Text := StringGrid1.Cells[2,SelectedRow];
        DateEdit1.Text := StringGrid1.Cells[3,SelectedRow];
        TimeEdit1.Text := StringGrid1.Cells[4,SelectedRow];
      finally
        MemoryStream.Free;
      end;
    end;

    FDQuery1.Close;
  end;
end;
end;
procedure TForm2.tcMainChange(Sender: TObject);
begin
  if (tcMain.ActiveTab = TabItem2) then
  begin
  StringGrid1.Columns[0].Header := 'ID';
  StringGrid1.Columns[1].Header := 'Nama Barang';
  StringGrid1.Columns[2].Header := 'Stok Barang';
  StringGrid1.Columns[3].Header := 'Tanggal Masuk';
  StringGrid1.Columns[4].Header := 'Waktu Masuk';
  RefreshGrid;
  end else
  if (tcMain.ActiveTab = TabItem3) then
  begin
//Setting Users Tab
  StringGrid2.Columns[0].Header := 'ID';
  StringGrid2.Columns[1].Header := 'Nama';
  StringGrid2.Columns[2].Header := 'Password';
  RefreshUsersGrid;
  end;
end;

end.
