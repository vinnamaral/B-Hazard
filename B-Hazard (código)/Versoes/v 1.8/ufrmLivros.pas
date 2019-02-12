unit ufrmLivros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Spin, ExtCtrls, Grids, DBGrids, DBCtrls, DB,
  DBTables, jpeg;

type
  TFormLivros = class(TForm)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtLivro: TEdit;
    edtAutor: TEdit;
    edtEdicao: TEdit;
    edtEditora: TEdit;
    edtEmp: TEdit;
    speCod: TSpinEdit;
    Label1: TLabel;
    sbtNovo: TSpeedButton;
    sbtAltera: TSpeedButton;
    sbtCancela: TSpeedButton;
    sbtSalva: TSpeedButton;
    GroupBox2: TGroupBox;
    dbgLivro: TDBGrid;
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
    Label3: TLabel;
    edtISBN: TEdit;
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
    procedure edtEdicaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesqKeyPress(Sender: TObject; var Key: Char);
    procedure dbgLivroCellClick(Column: TColumn);
    procedure edtISBNKeyPress(Sender: TObject; var Key: Char);
    procedure rgpPesquisaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLivros: TFormLivros;

implementation

uses
  dmConexoes;

{$R *.dfm}

procedure TFormLivros.FormActivate(Sender: TObject);
begin
  CarregaCampos;
end;

procedure TFormLivros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DesabilitaCampos;
end;

procedure TFormLivros.HabilitaCampos;
begin
  edtLivro.ReadOnly:= False;
  edtAutor.ReadOnly:= False;
  edtEdicao.ReadOnly:= False;
  edtEditora.ReadOnly:= False;
  edtISBN.ReadOnly:= False;
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
  edtLivro.Enabled:= True;
  edtAutor.Enabled:= True;
  edtEdicao.Enabled:= True;
  edtEditora.Enabled:= True;
  edtISBN.Enabled:= True;
  edtEmp.Enabled:= True;
end;

procedure TFormLivros.DesabilitaCampos;
begin
  edtLivro.ReadOnly:= True;
  edtAutor.ReadOnly:= True;
  edtEditora.ReadOnly:= True;
  edtEdicao.ReadOnly:= True;
  edtISBN.ReadOnly:= True;
  edtEmp.ReadOnly:= True;
  sbtAltera.Enabled:= True;
  sbtNovo.Enabled:= True;
  sbtSai.Enabled:= True;
  sbtExclui.Enabled:= True;
  rgpPesquisa.Enabled:= True;
  sbtRelat.Enabled:= True;
  sbtSalva.Enabled:= False;
  sbtCancela.Enabled:= False;
  edtLivro.Enabled:= False;
  edtAutor.Enabled:= False;
  edtEdicao.Enabled:= False;
  edtEditora.Enabled:= False;
  edtISBN.Enabled:= False;
  edtEmp.Enabled:= False;
end;

procedure TFormLivros.CarregaCampos;
begin
  speCod.Value := dm.cdsLivro.FieldByName('COD').AsInteger;
  edtLivro.Text := dm.cdsLivro.FieldByName('LIVRO').AsString;
  edtAutor.Text := dm.cdsLivro.FieldByName('AUTOR').AsString;
  edtEdicao.Text := dm.cdsLivro.FieldByName('EDICAO').AsString;
  edtEditora.Text := dm.cdsLivro.FieldByName('EDITORA').AsString;
  edtISBN.Text:= dm.cdsLivro.FieldByName('ISBN').AsString;
  edtEmp.Text := dm.cdsLivro.FieldByName('EMPRESTIMO').AsString;
  speCod.SetFocus;
end;

procedure TFormLivros.CodigoNovo;
begin
  dm.cdsLivro.Last;
  speCod.Value:= dm.cdsLivro.FieldByName('COD').AsInteger + 1;
  HabilitaCampos;
  LimpaCampos;
  edtLivro.SetFocus;
  //dm.cdsLivro.Append;
  dm.cdsLivro.Insert;
end;

procedure TFormLivros.LimpaCampos;
var i : Integer;
begin
  for i := 0 to ComponentCount -1 do
    if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
      end;
end;

procedure TFormLivros.edtEdicaoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)])
  then begin
    Key:= #0;
    MessageDlg('A Edição é composta apenas por números!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormLivros.edtISBNKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)])
  then begin
    Key:= #0;
    MessageDlg('O ISBN é composto apenas por números!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormLivros.rgpPesquisaClick(Sender: TObject);
begin
  If rgpPesquisa.ItemIndex = 0 then
    dm.cdsLivro.IndexFieldNames := 'COD';
  If rgpPesquisa.ItemIndex = 1 then
    dm.cdsLivro.IndexFieldNames := 'LIVRO';
  If rgpPesquisa.ItemIndex = 2 then
    dm.cdsLivro.IndexFieldNames := 'ISBN';
  edtPesq.SetFocus;
end;

procedure TFormLivros.edtPesqChange(Sender: TObject);
begin
{ Quando for Código temos que testar para o valor não ser nulo e ser um número }
If rgpPesquisa.ItemIndex = 0 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsLivro.Locate('COD', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O Código é composto apenas por números!', mtError, [mbOk],0);
  End;
If rgpPesquisa.ItemIndex = 1 Then
  dm.cdsLivro.Locate('LIVRO', edtPesq.Text, []);
If rgpPesquisa.ItemIndex = 2 Then
If edtPesq.Text <> '' Then
  Try
    dm.cdsLivro.Locate('ISBN', StrToInt(edtPesq.Text), [])
    Except on EConvertError do
    MessageDlg(edtPesq.Text+' é inválido. O ISBN é composto apenas por números!', mtError, [mbOk],0);
  End;
end;

procedure TFormLivros.dbgLivroCellClick(Column: TColumn);
begin
  speCod.Value:= dm.cdsLivro.FieldbyName('COD').AsInteger;
  dbgLivro.SetFocus;
end;

procedure TFormLivros.edtPesqKeyPress(Sender: TObject; var Key: Char);
begin
  If rgpPesquisa.ItemIndex = -1 Then
  begin
    Key:= #0;
    MessageDlg('Selecione um método de pesquisa!!', mtWarning, [mbOk],0);
  end;
end;

procedure TFormLivros.sbtAlteraClick(Sender: TObject);
begin
  HabilitaCampos;
  dm.cdsLivro.Edit;
end;

procedure TFormLivros.sbtCancelaClick(Sender: TObject);
begin
  dm.cdsLivro.Cancel;
  DesabilitaCampos;
  speCod.Value:= dm.cdsLivro.FieldByName('COD').AsInteger;
end;

procedure TFormLivros.sbtExcluiClick(Sender: TObject);
begin
  if Application.MessageBox('Excluir o registro?', 'Atenção', mb_YesNo) = idYes
  then begin
  dm.cdsLivro.Delete;
  dbgLivro.Refresh;
  speCod.Value:= dm.cdsLivro.FieldByName('COD').AsInteger;
  end;
end;

procedure TFormLivros.sbtNovoClick(Sender: TObject);
begin
  CodigoNovo;
end;

procedure TFormLivros.sbtSalvaClick(Sender: TObject);
begin
  if edtLivro.Text = ''
    then begin
        Application.MessageBox('O nome do livro deve ser informado !', 'Atenção', mb_Ok);;
        edtLivro.SetFocus;
    end
  else if edtAutor.Text = ''
    then begin
        Application.MessageBox('O nome do autor deve ser informado !', 'Atenção', mb_Ok);
        edtAutor.SetFocus;
    end
  else if edtEditora.Text = ''
    then begin
        Application.MessageBox('A editora deve ser informada !', 'Atenção', mb_Ok);
        edtEditora.SetFocus;
    end
  else if edtEdicao.Text = ''
    then begin
        Application.MessageBox('A edição deve ser informada !', 'Atenção', mb_Ok);
        edtEdicao.SetFocus;
    end
  else if edtISBN.Text = ''
    then begin
        Application.MessageBox('O ISBN deve ser informado !', 'Atenção', mb_Ok);
        edtISBN.SetFocus;
    end

else begin
  { Atributos para gravar }
  dm.cdsLivro.FieldByName('COD').Value:= speCod.Value;
  dm.cdsLivro.FieldByName('LIVRO').Value:= edtLivro.Text;
  dm.cdsLivro.FieldByName('AUTOR').Value:= edtAutor.Text;
  dm.cdsLivro.FieldByName('EDITORA').Value:= edtEditora.Text;
  dm.cdsLivro.FieldByName('EDICAO').Value:= edtEdicao.Text;
  dm.cdsLivro.FieldByName('ISBN').Value:= edtISBN.Text;
  dm.cdsLivro.FieldByName('EMPRESTIMO').Value:= edtEmp.Text;
  { Grava as alterações no registro atual }
  dm.cdsLivro.Post;
  dm.cdsLivro.SaveToFile(dm.cdsLivro.FileName);
  DesabilitaCampos;
  Application.MessageBox('Registro salvo com sucesso !', 'OK', mb_Ok);
  end;
end;

procedure TFormLivros.speCodChange(Sender: TObject);
begin
  DesabilitaCampos;
  if dm.cdsLivro.FindKey([speCod.Value])
     then
        CarregaCampos
  else LimpaCampos;
end;

procedure TFormLivros.sbtRelatClick(Sender: TObject);
begin
if not dm.cdsLivro.Active then
  dm.cdsLivro.Open;

  dm.rvpLivro.ExecuteReport('rptLivro');
end;

procedure TFormLivros.sbtSaiClick(Sender: TObject);
begin
  FormLivros.Close;
end;

end.
