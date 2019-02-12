unit ufrmCd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, ExtCtrls, Grids, DBGrids, DBCtrls, DB,
  DBTables, jpeg, Menus;

type
  TFormCd = class(TForm)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtArt: TEdit;
    edtGen: TEdit;
    edtAno: TEdit;
    edtAlb: TEdit;
    edtEmp: TEdit;
    speCod: TSpinEdit;
    Label1: TLabel;
    sbtNovo: TSpeedButton;
    sbtAltera: TSpeedButton;
    sbtCancela: TSpeedButton;
    sbtSalva: TSpeedButton;
    GroupBox2: TGroupBox;
    dbgCd: TDBGrid;
    sbtExclui: TSpeedButton;
    sbtSai: TSpeedButton;
    sbtRelat: TSpeedButton;
    GroupBox4: TGroupBox;
    edtPesquisa: TEdit;
    rgpPesquisa: TRadioGroup;
    edtPesq: TEdit;
    Image1: TImage;
    Label2: TLabel;
    Image2: TImage;
    Image3: TImage;
    procedure sbtRelatClick(Sender: TObject);
    procedure CodigoNovo;
    procedure LimpaCampos;
    procedure HabilitaCampos;
    procedure DesabilitaCampos;
    procedure CarregaCampos;
    procedure sbtNovoClick(Sender: TObject);
    procedure sbtSalvaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure sbtAlteraClick(Sender: TObject);
    procedure speCodChange(Sender: TObject);
    procedure sbtCancelaClick(Sender: TObject);
    procedure sbtExcluiClick(Sender: TObject);
    procedure sbtSaiClick(Sender: TObject);
    procedure edtPesqChange(Sender: TObject);
    procedure edtAnoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesqKeyPress(Sender: TObject; var Key: Char);
    procedure dbgCdCellClick(Column: TColumn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure rgpPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCd: TFormCd;

implementation

uses
  dmConexoes;

{$R *.dfm}

procedure TFormCd.FormActivate(Sender: TObject);
begin
  CarregaCampos;
end;


procedure TFormCd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesabilitaCampos;
end;

procedure TFormCd.HabilitaCampos;
begin
  edtArt.ReadOnly:= False;
  edtAlb.ReadOnly:= False;
  edtAno.ReadOnly:= False;
  edtGen.ReadOnly:= False;
  edtEmp.ReadOnly:= False;
  sbtAltera.Enabled:= False;
  sbtNovo.Enabled:= False;
  sbtSalva.Enabled:= False;
  sbtSai.Enabled:= False;
  sbtRelat.Enabled:= False;
  sbtExclui.Enabled:= False;
  rgpPesquisa.Enabled:= False;
  sbtSalva.Enabled:= True;
  sbtCancela.Enabled:= True;
  edtArt.Enabled:= True;
  edtAlb.Enabled:= True;
  edtAno.Enabled:= True;
  edtGen.Enabled:= True;
  edtEmp.Enabled:= True;
end;

procedure TFormCd.DesabilitaCampos;
begin
  edtArt.ReadOnly:= True;
  edtAlb.ReadOnly:= True;
  edtAno.ReadOnly:= True;
  edtGen.ReadOnly:= True;
  edtEmp.ReadOnly:= True;
  sbtAltera.Enabled:= True;
  sbtNovo.Enabled:= True;
  sbtSai.Enabled:= True;
  sbtExclui.Enabled:= True;
  rgpPesquisa.Enabled:= True;
  sbtRelat.Enabled:= True;
  sbtSalva.Enabled:= False;
  sbtCancela.Enabled:= False;
  edtArt.Enabled:= False;
  edtAlb.Enabled:= False;
  edtAno.Enabled:= False;
  edtGen.Enabled:= False;
  edtEmp.Enabled:= False;
end;

procedure TFormCd.CarregaCampos;
begin
  speCod.Value := dm.cdsCd.FieldByName('COD').AsInteger;
  edtArt.Text := dm.cdsCd.FieldByName('ARTISTA').AsString;
  edtAlb.Text := dm.cdsCd.FieldByName('ALBUM').AsString;
  edtAno.Text := dm.cdsCd.FieldByName('ANO').AsString;
  edtGen.Text := dm.cdsCd.FieldByName('GENERO').AsString;
  edtEmp.Text := dm.cdsCd.FieldByName('EMPRESTIMO').AsString;
  speCod.SetFocus;
end;

procedure TFormCd.LimpaCampos;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
      end;
end;

procedure TFormCd.CodigoNovo;
begin
  dm.cdsCd.Last;
  speCod.Value:= dm.cdsCd.FieldByName('COD').AsInteger + 1;
  HabilitaCampos;
  LimpaCampos;
  edtArt.SetFocus;
  dm.cdsCd.Insert;
end;

procedure TFormCd.sbtNovoClick(Sender: TObject);
begin
  CodigoNovo;
end;

procedure TFormCd.rgpPesquisaClick(Sender: TObject);
begin
  If rgpPesquisa.ItemIndex = 0 then
    dm.cdsCD.IndexFieldNames := 'COD';
  If rgpPesquisa.ItemIndex = 1 then
    dm.cdsCd.IndexFieldNames := 'ARTISTA';
  If rgpPesquisa.ItemIndex = 2 then
    dm.cdsCd.IndexFieldNames := 'ALBUM';
  edtPesq.SetFocus;
end;

procedure TFormCd.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFormCd.edtAnoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)])
  then begin
    Key:= #0;
    MessageDlg('O Ano é composto apenas por números!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormCd.edtPesqKeyPress(Sender: TObject; var Key: Char);
begin
  If rgpPesquisa.ItemIndex = -1 Then
  begin
    Key:= #0;
    MessageDlg('Selecione um método de pesquisa!!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormCd.edtPesqChange(Sender: TObject);
begin
{ Quando for Código temos que testar para o valor não ser nulo e ser um número }
If rgpPesquisa.ItemIndex = 0 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsCd.Locate('COD', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O Código é composto apenas por números!', mtError, [mbOk],0);
  End;
If rgpPesquisa.ItemIndex = 1 Then
  dm.cdsCd.Locate('ARTISTA', edtPesq.Text, []);
If rgpPesquisa.ItemIndex = 2 Then
    dm.cdsCd.Locate('ALBUM', edtPesq.Text, []);
If rgpPesquisa.ItemIndex = 3 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsCd.Locate('ANO', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O Ano é composto apenas por números!', mtError, [mbOk],0);
  End;
end;


procedure TFormCd.dbgCdCellClick(Column: TColumn);
begin
  speCod.Value:= dm.cdsCd.FieldbyName('COD').AsInteger;
  dbgCd.SetFocus;
end;

procedure TFormCd.sbtAlteraClick(Sender: TObject);
begin
  HabilitaCampos;
  dm.cdsCd.Edit;
end;

procedure TFormCd.sbtCancelaClick(Sender: TObject);
begin
  dm.cdsCd.Cancel;
  DesabilitaCampos;
  speCod.Value:= dm.cdsCd.FieldByName('COD').AsInteger;
end;

procedure TFormCd.sbtExcluiClick(Sender: TObject);
begin
  if Application.MessageBox('Excluir o registro?', 'Atenção', mb_YesNo) = idYes
  then begin
    dm.cdsCd.Delete;
    dbgCd.Refresh;
    speCod.Value:= dm.cdsCd.FieldByName('COD').AsInteger;
  end;
end;

procedure TFormCd.sbtSalvaClick(Sender: TObject);
begin
  if edtArt.Text = ''
    then begin
        Application.MessageBox('O nome do artista deve ser informado !', 'Atenção', mb_Ok);;
        edtArt.SetFocus;
    end
  else if edtAlb.Text = ''
    then begin
        Application.MessageBox('O nome do álbum deve ser informado !', 'Atenção', mb_Ok);
        edtAlb.SetFocus;
    end
  else if edtAno.Text = ''
    then begin
        Application.MessageBox('O ano deve ser informado !', 'Atenção', mb_Ok);
        edtAno.SetFocus;
    end
  else if edtGen.Text = ''
    then begin
        Application.MessageBox('O gênero musical deve ser informado !', 'Atenção', mb_Ok);
        edtGen.SetFocus;
    end

else begin
  { Atributos para gravar }
  dm.cdsCd.FieldByName('COD').Value:= speCod.Value;
  dm.cdsCd.FieldByName('ARTISTA').Value:= edtArt.Text;
  dm.cdsCd.FieldByName('ALBUM').Value:= edtAlb.Text;
  dm.cdsCd.FieldByName('ANO').Value:= edtAno.Text;
  dm.cdsCd.FieldByName('GENERO').Value:= edtGen.Text;
  dm.cdsCd.FieldByName('EMPRESTIMO').Value:= edtEmp.Text;

  { Grava as alterações no registro atual }
  dm.cdsCd.Post;
  dm.cdsCd.SaveToFile(dm.cdsCd.FileName);
  DesabilitaCampos;
  Application.MessageBox('Registro salvo com sucesso !', 'OK', mb_Ok);
  end;
end;

procedure TFormCd.speCodChange(Sender: TObject);
begin
  DesabilitaCampos;
  if dm.cdsCd.FindKey([speCod.Value])
     then
        CarregaCampos
  else LimpaCampos;
end;

procedure TFormCd.sbtRelatClick(Sender: TObject);
begin
if not dm.cdsCd.Active then
  dm.cdsCd.Open;

  dm.rvpCd.ExecuteReport('rptCd');
end;

procedure TFormCd.sbtSaiClick(Sender: TObject);
begin
  FormCd.Close;
end;

end.
