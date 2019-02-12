program ProjControle;

uses
  Forms,
  ufrmPrincipal in 'ufrmPrincipal.pas' {FormPrincipal},
  ufrmCd in 'ufrmCd.pas' {FormCd},
  dmConexoes in 'dmConexoes.pas' {dm: TDataModule},
  ufrmLivros in 'ufrmLivros.pas' {FormLivros},
  ufrmJogos in 'ufrmJogos.pas' {FormJogos},
  ufrmDvd in 'ufrmDvd.pas' {FormDvd},
  ufrmSobre in 'ufrmSobre.pas' {FormSobre};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormCd, FormCd);
  Application.CreateForm(TFormLivros, FormLivros);
  Application.CreateForm(TFormJogos, FormJogos);
  Application.CreateForm(TFormDvd, FormDvd);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFormSobre, FormSobre);
  Application.Run;
end.
