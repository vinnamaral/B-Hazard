unit ufrmDvd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, ExtCtrls, Grids, DBGrids, DBCtrls, DB,
  DBTables, jpeg;

type
  TFormDvd = class(TForm)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtTit: TEdit;
    edtGen: TEdit;
    edtAno: TEdit;
    edtEmp: TEdit;
    speCod: TSpinEdit;
    Label1: TLabel;
    sbtNovo: TSpeedButton;
    sbtAltera: TSpeedButton;
    sbtCancela: TSpeedButton;
    sbtSalva: TSpeedButton;
    GroupBox2: TGroupBox;
    dbgDvd: TDBGrid;
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
    procedure dbgDvdCellClick(Column: TColumn);
    procedure rgpPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDvd: TFormDvd;

implementation

uses
  dmConexoes, ufrmPrincipal;

{$R *.dfm}


procedure TFormDvd.FormActivate(Sender: TObject);
begin
  CarregaCampos;
  FormPrincipal.Visible:= False;
end;

procedure TFormDvd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesabilitaCampos;
  FormPrincipal.Visible:= True;
  Action:= caFree;
  FormDvd:= nil;
end;

procedure TFormDvd.HabilitaCampos;
begin
  edtTit.ReadOnly:= False;
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
  edtTit.Enabled:= True;
  edtAno.Enabled:= True;
  edtGen.Enabled:= True;
  edtEmp.Enabled:= True;
end;

procedure TFormDvd.DesabilitaCampos;
begin
  edtTit.ReadOnly:= True;
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
  edtTit.Enabled:= False;
  edtAno.Enabled:= False;
  edtGen.Enabled:= False;
  edtEmp.Enabled:= False;
end;

procedure TFormDvd.CarregaCampos;
begin
  speCod.Value := dm.cdsDvd.FieldByName('COD').AsInteger;
  edtTit.Text := dm.cdsDvd.FieldByName('DVD').AsString;
  edtAno.Text := dm.cdsDvd.FieldByName('ANO').AsString;
  edtGen.Text := dm.cdsDvd.FieldByName('GENERO').AsString;
  edtEmp.Text := dm.cdsDvd.FieldByName('EMPRESTIMO').AsString;
  speCod.SetFocus;
end;

procedure TFormDvd.CodigoNovo;
begin
  dm.cdsDvd.Last;
  speCod.Value:= dm.cdsDvd.FieldByName('COD').AsInteger + 1;
  HabilitaCampos;
  LimpaCampos;
  edtTit.SetFocus;
  //dm.cdsDvd.Append;
  dm.cdsDvd.Insert;
end;

procedure TFormDvd.LimpaCampos;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
      end;
end;

procedure TFormDvd.sbtAlteraClick(Sender: TObject);
begin
  if not dm.cdsDvd.IsEmpty
  then begin
    HabilitaCampos;
    dm.cdsDvd.Edit;
  end
  else
    MessageDlg('Banco de dados vazio! Nenhum registro a ser alterado!', mtError, [mbOk],0);
end;

procedure TFormDvd.sbtCancelaClick(Sender: TObject);
begin
  dm.cdsDvd.Cancel;
  DesabilitaCampos;
  speCod.Value:= dm.cdsDvd.FieldByName('COD').AsInteger;
end;

procedure TFormDvd.sbtNovoClick(Sender: TObject);
begin
  CodigoNovo;
end;

procedure TFormDvd.rgpPesquisaClick(Sender: TObject);
begin
  If rgpPesquisa.ItemIndex = 0 then
    dm.cdsDvd.IndexFieldNames := 'COD';
  If rgpPesquisa.ItemIndex = 1 then
    dm.cdsDvd.IndexFieldNames := 'DVD';
  edtPesq.SetFocus;
end;

procedure TFormDvd.edtPesqChange(Sender: TObject);
begin
{ Quando for Código temos que testar para o valor não ser nulo e ser um número }
If rgpPesquisa.ItemIndex = 0 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsDvd.Locate('COD', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O Código é composto apenas por números!', mtError, [mbOk],0);
  End;
If rgpPesquisa.ItemIndex = 1 Then
  dm.cdsDvd.Locate('DVD', edtPesq.Text, []);
end;

procedure TFormDvd.dbgDvdCellClick(Column: TColumn);
begin
  speCod.Value:= dm.cdsDvd.FieldbyName('COD').AsInteger;
  dbgDvd.SetFocus;
end;

procedure TFormDvd.sbtExcluiClick(Sender: TObject);
begin
  if not dm.cdsDvd.IsEmpty
  then begin
    if Application.MessageBox('Excluir o registro?', 'Atenção', mb_YesNo) = idYes
    then begin
      dm.cdsDvd.Delete;
      dbgDvd.Refresh;
      speCod.Value:= dm.cdsDvd.FieldByName('COD').AsInteger;
    end
  end
  else
    MessageDlg('Banco de dados vazio! Nenhum registro a ser excluído!', mtError, [mbOk],0);
end;

{ *** Inicio do processo salvar ***  }
procedure TFormDvd.sbtSalvaClick(Sender: TObject);
begin
  if edtTit.Text = ''
    then begin
        Application.MessageBox('O título do Dvd deve ser informado !', 'Atenção', mb_Ok);;
        edtTit.SetFocus;
    end
  else if edtGen.Text = ''
    then begin
        Application.MessageBox('O gênero do Dvd deve ser informado !', 'Atenção', mb_Ok);
        edtGen.SetFocus;
    end

else begin
  { Atributos para gravar }
  dm.cdsDvd.FieldByName('COD').Value:= speCod.Value;
  dm.cdsDvd.FieldByName('DVD').Value:= edtTit.Text;
  dm.cdsDvd.FieldByName('ANO').Value:= edtAno.Text;
  dm.cdsDvd.FieldByName('GENERO').Value:= edtGen.Text;
  dm.cdsDvd.FieldByName('EMPRESTIMO').Value:= edtEmp.Text;

  { Grava as alterações no registro atual }
  dm.cdsDvd.Post;
  dm.cdsDvd.SaveToFile(dm.cdsDvd.FileName);
  DesabilitaCampos;
  Application.MessageBox('Registro salvo com sucesso !', 'OK', mb_Ok);
  end;
end;
{ *** Fim do processo salvar ***  }

procedure TFormDvd.edtPesqKeyPress(Sender: TObject; var Key: Char);
begin
  If rgpPesquisa.ItemIndex = -1 Then
  begin
    Key:= #0;
    MessageDlg('Selecione um método de pesquisa!!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormDvd.speCodChange(Sender: TObject);
begin
  DesabilitaCampos;
  if dm.cdsDvd.FindKey([speCod.Value])
     then
        CarregaCampos
  else LimpaCampos;
end;

procedure TFormDvd.edtAnoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)])
  then begin
    Key:= #0;
    MessageDlg('O Ano é composto apenas por números!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormDvd.sbtRelatClick(Sender: TObject);
begin
if not dm.cdsDvd.Active then
  dm.cdsDvd.Open;

  dm.rvpDvd.ExecuteReport('rptDvd');
end;

procedure TFormDvd.sbtSaiClick(Sender: TObject);
begin
  FormDvd.Close;
end;

end.
