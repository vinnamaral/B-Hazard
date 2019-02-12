unit dmConexoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Registry, DBClient, ImgList, RpCon, RpConDS, RpBase, RpSystem,
  RpDefine, RpRave, Provider, MidasLib, DBExpint;

type
  Tdm = class(TDataModule)
    dsCd: TDataSource;
    dsLivro: TDataSource;
    dsJogo: TDataSource;
    dsDvd: TDataSource;
    cdsCd: TClientDataSet;
    cdsLivro: TClientDataSet;
    cdsDvd: TClientDataSet;
    cdsJogo: TClientDataSet;
    cdsCdARTISTA: TStringField;
    cdsCdALBUM: TStringField;
    cdsCdANO: TStringField;
    cdsCdGENERO: TStringField;
    cdsCdEMPRESTIMO: TStringField;
    cdsLivroCOD: TIntegerField;
    cdsLivroLIVRO: TStringField;
    cdsLivroAUTOR: TStringField;
    cdsLivroEDITORA: TStringField;
    cdsLivroEDICAO: TStringField;
    cdsLivroISBN: TStringField;
    cdsLivroEMPRESTIMO: TStringField;
    cdsJogoCOD: TIntegerField;
    cdsJogoJOGO: TStringField;
    cdsJogoANO: TStringField;
    cdsJogoGENERO: TStringField;
    cdsJogoPLATAFORMA: TStringField;
    cdsJogoEMPRESTIMO: TStringField;
    cdsDvdCOD: TIntegerField;
    cdsDvdDVD: TStringField;
    cdsDvdANO: TStringField;
    cdsDvdGENERO: TStringField;
    cdsDvdEMPRESTIMO: TStringField;
    cdsCdCOD: TIntegerField;
    rvpCd: TRvProject;
    rvsCd: TRvSystem;
    rvdsCd: TRvDataSetConnection;
    rvpLivro: TRvProject;
    rvpJogo: TRvProject;
    rvpDvd: TRvProject;
    rvsLivro: TRvSystem;
    rvsJogo: TRvSystem;
    rvsDvd: TRvSystem;
    rvdsLivro: TRvDataSetConnection;
    rvdsJogo: TRvDataSetConnection;
    rvdsDvd: TRvDataSetConnection;
    cdsLivroANO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}


procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  cdsCd.Open;
  dsCd.Enabled:= True;
  cdsLivro.Open;
  dsLivro.Enabled:= True;
  cdsJogo.Open;
  dsJogo.Enabled:= True;
  cdsDvd.Open;
  dsDvd.Enabled:= True;
end;



end.
