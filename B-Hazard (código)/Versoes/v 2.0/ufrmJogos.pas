unit ufrmJogos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, ExtCtrls, Grids, DBGrids, DBCtrls, DB,
  DBTables, jpeg;

type
  TFormJogos = class(TForm)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtJogo: TEdit;
    edtGen: TEdit;
    edtAno: TEdit;
    edtPlat: TEdit;
    edtEmp: TEdit;
    speCod: TSpinEdit;
    Label1: TLabel;
    sbtNovo: TSpeedButton;
    sbtAltera: TSpeedButton;
    sbtCancela: TSpeedButton;
    sbtSalva: TSpeedButton;
    GroupBox2: TGroupBox;
    dbgJogo: TDBGrid;
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
    procedure dbgJogoCellClick(Column: TColumn);
    procedure rgpPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormJogos: TFormJogos;

implementation

uses
  dmConexoes, ufrmPrincipal;

{$R *.dfm}

procedure TFormJogos.FormActivate(Sender: TObject);
begin
  CarregaCampos;
  FormPrincipal.Visible:= False;
end;

procedure TFormJogos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesabilitaCampos;
  FormPrincipal.Visible:= True;
  Action:= caFree;
  FormJogos:= nil;
end;

procedure TFormJogos.CarregaCampos;
begin
  speCod.Value := dm.cdsJogo.FieldByName('COD').AsInteger;
  edtJogo.Text := dm.cdsJogo.FieldByName('JOGO').AsString;
  edtPlat.Text := dm.cdsJogo.FieldByName('PLATAFORMA').AsString;
  edtAno.Text := dm.cdsJogo.FieldByName('ANO').AsString;
  edtGen.Text := dm.cdsJogo.FieldByName('GENERO').AsString;
  edtEmp.Text := dm.cdsJogo.FieldByName('EMPRESTIMO').AsString;
  speCod.SetFocus;
end;

procedure TFormJogos.HabilitaCampos;
begin
  edtJogo.ReadOnly:= False;
  edtPlat.ReadOnly:= False;
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
  edtJogo.Enabled:= True;
  edtPlat.Enabled:= True;
  edtAno.Enabled:= True;
  edtGen.Enabled:= True;
  edtEmp.Enabled:= True;
end;

procedure TFormJogos.DesabilitaCampos;
begin
  edtJogo.ReadOnly:= True;
  edtPlat.ReadOnly:= True;
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
  edtJogo.Enabled:= False;
  edtPlat.Enabled:= False;
  edtAno.Enabled:= False;
  edtGen.Enabled:= False;
  edtEmp.Enabled:= False;
end;

procedure TFormJogos.CodigoNovo;
begin
  dm.cdsJogo.Last;
  speCod.Value:= dm.cdsJogo.FieldByName('COD').AsInteger + 1;
  HabilitaCampos;
  LimpaCampos;
  edtJogo.SetFocus;
  //dm.cdsJogo.Append;
  dm.cdsJogo.Insert;
end;

procedure TFormJogos.LimpaCampos;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
      end;
end;

procedure TFormJogos.sbtNovoClick(Sender: TObject);
begin
  CodigoNovo;
end;

procedure TFormJogos.edtAnoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)])
  then begin
    Key:= #0;
    MessageDlg('O Ano é composto apenas por números!', mtWarning, [mbOk],0);
  end;
end;


procedure TFormJogos.edtPesqKeyPress(Sender: TObject; var Key: Char);
begin
  If rgpPesquisa.ItemIndex = -1 Then
  begin
    Key:= #0;
    MessageDlg('Selecione um método de pesquisa!!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormJogos.edtPesqChange(Sender: TObject);
begin
{ Quando for Código temos que testar para o valor não ser nulo e ser um número }
If rgpPesquisa.ItemIndex = 0 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsJogo.Locate('COD', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O Código é composto apenas por números!', mtError, [mbOk],0);
  End;
If rgpPesquisa.ItemIndex = 1 Then
  dm.cdsJogo.Locate('JOGO', edtPesq.Text, []);
end;

procedure TFormJogos.rgpPesquisaClick(Sender: TObject);
begin
  If rgpPesquisa.ItemIndex = 0 then
    dm.cdsJogo.IndexFieldNames := 'COD';
  If rgpPesquisa.ItemIndex = 1 then
    dm.cdsJogo.IndexFieldNames := 'JOGO';
  edtPesq.SetFocus;
end;

procedure TFormJogos.dbgJogoCellClick(Column: TColumn);
begin
  speCod.Value:= dm.cdsJogo.FieldbyName('COD').AsInteger;
  dbgJogo.SetFocus;
end;

procedure TFormJogos.sbtAlteraClick(Sender: TObject);
begin
  if not dm.cdsJogo.IsEmpty
  then begin
    HabilitaCampos;
    dm.cdsJogo.Edit;
  end
  else
    MessageDlg('Banco de dados vazio! Nenhum registro a ser alterado!', mtError, [mbOk],0);
end;

procedure TFormJogos.sbtCancelaClick(Sender: TObject);
begin
  dm.cdsJogo.Cancel;
  DesabilitaCampos;
  speCod.Value:= dm.cdsJogo.FieldByName('COD').AsInteger;
end;

procedure TFormJogos.sbtExcluiClick(Sender: TObject);
begin
  if not dm.cdsJogo.IsEmpty
  then begin
    if Application.MessageBox('Excluir o registro?', 'Atenção', mb_YesNo) = idYes
      then begin
      dm.cdsJogo.Delete;
      dbgJogo.Refresh;
      speCod.Value:= dm.cdsJogo.FieldByName('COD').AsInteger;
      end
  end
  else
    MessageDlg('Banco de dados vazio! Nenhum registro a ser excluído!', mtError, [mbOk],0);
end;

procedure TFormJogos.sbtSalvaClick(Sender: TObject);
begin
  if edtJogo.Text = ''
    then begin
        Application.MessageBox('O nome do jogo deve ser informado !', 'Atenção', mb_Ok);;
        edtJogo.SetFocus;
    end
  else if edtGen.Text = ''
    then begin
        Application.MessageBox('O gênero do jogo deve ser informado !', 'Atenção', mb_Ok);
        edtGen.SetFocus;
    end
  else if edtPlat.Text = ''
    then begin
        Application.MessageBox('A plataforma do jogo deve ser informada !', 'Atenção', mb_Ok);
        edtPlat.SetFocus;
    end

else begin
  { Atributos para gravar }
  dm.cdsJogo.FieldByName('COD').Value:= speCod.Value;
  dm.cdsJogo.FieldByName('JOGO').Value:= edtJogo.Text;
  dm.cdsJogo.FieldByName('PLATAFORMA').Value:= edtPlat.Text;
  dm.cdsJogo.FieldByName('ANO').Value:= edtAno.Text;
  dm.cdsJogo.FieldByName('GENERO').Value:= edtGen.Text;
  dm.cdsJogo.FieldByName('EMPRESTIMO').Value:= edtEmp.Text;

  { Grava as alterações no registro atual }
  dm.cdsJogo.Post;
  dm.cdsJogo.SaveToFile(dm.cdsJogo.FileName);
  DesabilitaCampos;
  Application.MessageBox('Registro salvo com sucesso !', 'OK', mb_Ok);
  end;
end;

procedure TFormJogos.speCodChange(Sender: TObject);
begin
  DesabilitaCampos;
  if dm.cdsJogo.FindKey([speCod.Value])
     then
        CarregaCampos
  else LimpaCampos;
end;

procedure TFormJogos.sbtRelatClick(Sender: TObject);
begin
if not dm.cdsJogo.Active then
  dm.cdsJogo.Open;

  dm.rvpJogo.ExecuteReport('rptJogo');
end;

procedure TFormJogos.sbtSaiClick(Sender: TObject);
begin
  FormJogos.Close;
end;

end.
