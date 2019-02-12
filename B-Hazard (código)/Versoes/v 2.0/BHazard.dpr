program BHazard;

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
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
