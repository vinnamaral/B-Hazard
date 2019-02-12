unit ufrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, Buttons, StdCtrls, Menus, ExtDlgs, ImgList;

type
  TFormPrincipal = class(TForm)
    SpeedButton2: TSpeedButton;
    sbtCd: TSpeedButton;
    sbtLivros: TSpeedButton;
    SpeedButton4: TSpeedButton;
    MainMenu1: TMainMenu;
    Arquivo: TMenuItem;
    Cds1: TMenuItem;
    Dvds1: TMenuItem;
    Livros1: TMenuItem;
    Jogos1: TMenuItem;
    Relatrio1: TMenuItem;
    Cds2: TMenuItem;
    Dvds2: TMenuItem;
    Livros2: TMenuItem;
    Jogos2: TMenuItem;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    S: TMenuItem;
    Sobre1: TMenuItem;
    procedure Sobre1Click(Sender: TObject);
    procedure SClick(Sender: TObject);
    procedure Dvds2Click(Sender: TObject);
    procedure Jogos2Click(Sender: TObject);
    procedure Livros2Click(Sender: TObject);
    procedure Cds2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure sbtCdClick(Sender: TObject);
    procedure sbtLivrosClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Jogos1Click(Sender: TObject);
    procedure Livros1Click(Sender: TObject);
    procedure Dvds1Click(Sender: TObject);
    procedure Cds1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  ufrmCd, ufrmLivros, ufrmJogos, ufrmDvd, dmConexoes, ufrmSobre;

{$R *.dfm}

{ *** Chamadas de form´s *** }
procedure TFormPrincipal.Cds1Click(Sender: TObject);
begin
  FormCd.ShowModal;
end;

procedure TFormPrincipal.Dvds1Click(Sender: TObject);
begin
  FormDvd.ShowModal;
end;

procedure TFormPrincipal.SpeedButton2Click(Sender: TObject);
begin
  FormDvd.ShowModal;
end;

procedure TFormPrincipal.SpeedButton4Click(Sender: TObject);
begin
  FormJogos.ShowModal;
end;

procedure TFormPrincipal.Jogos1Click(Sender: TObject);
begin
  FormJogos.ShowModal;
end;

procedure TFormPrincipal.Livros1Click(Sender: TObject);
begin
  FormLivros.ShowModal;
end;

procedure TFormPrincipal.sbtCdClick(Sender: TObject);
begin
  FormCd.ShowModal;
end;

procedure TFormPrincipal.sbtLivrosClick(Sender: TObject);
begin
  FormLivros.ShowModal;
end;

procedure TFormPrincipal.Sobre1Click(Sender: TObject);
begin
  FormSobre.ShowModal;
end;
{ *** Fim das chamadas dos form´s *** }


{ *** Gerar relatório do menu *** }
procedure TFormPrincipal.Cds2Click(Sender: TObject);
begin
if not dm.cdsCd.Active then
  dm.cdsCd.Open;

  dm.rvpCd.ExecuteReport('rptCd');
end;

procedure TFormPrincipal.Dvds2Click(Sender: TObject);
begin
if not dm.cdsDvd.Active then
  dm.cdsDvd.Open;

  dm.rvpDvd.ExecuteReport('rptDvd');
end;

procedure TFormPrincipal.Jogos2Click(Sender: TObject);
begin
if not dm.cdsJogo.Active then
  dm.cdsJogo.Open;

  dm.rvpJogo.ExecuteReport('rptJogo');
end;

procedure TFormPrincipal.Livros2Click(Sender: TObject);
begin
if not dm.cdsLivro.Active then
  dm.cdsLivro.Open;

  dm.rvpLivro.ExecuteReport('rptLivro');
end;
{ *** Fim dos relatorios do menu *** }


{ *** Desenho de fundo *** }
procedure TFormPrincipal.FormPaint(Sender: TObject);
var
  Jpge : TJPEGImage;
  i, j : Integer;
  Linhas, Colunas : Integer;
begin
  Jpge := TJPEGImage.Create;
  try
// carrega bitmap
    Jpge.LoadFromFile('biohazard8.jpg');
// calcula numero de linhas a desenhar
    Linhas := Height div Jpge.Height;
// se falta um pedaço a ser preenchido, incrementa linhas
    if Height mod Jpge.Height <> 0 then
      Inc(Linhas);
// calcula numero de colunas a desenhar
    Colunas := Width div Jpge.Width;
// se falta um pedaço a ser preenchido, incrementa colunas
    if Width mod Jpge.Width <> 0 then
      Inc(Colunas);
// desenha os bitmaps
    for i := 0 to Linhas-1 do
      for j := 0 to Colunas-1 do
        Canvas.Draw(j*Jpge.Width,i*Jpge.Height,Jpge);
  finally
    Jpge.Free;
  end;
end;
{ *** Fim do desenho de fundo *** }

{ *** Botoes de saida *** }
procedure TFormPrincipal.SClick(Sender: TObject);
begin
    if Application.MessageBox('Deseja encerar o programa ?', 'Atenção', mb_YesNo) = idYes
      then Halt;
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja encerar o programa ?', 'Atenção', mb_YesNo) = idYes
    then Application.Terminate;
end;
{ *** Fim dos botoes de saida *** }

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormPrincipal.Release;
  FormPrincipal := nil;
end;

end.
