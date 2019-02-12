unit ufrmSobre;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TFormSobre = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSobre: TFormSobre;

implementation

{$R *.dfm}

procedure TFormSobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  FormSobre:= nil;
end;

procedure TFormSobre.OKButtonClick(Sender: TObject);
begin
  FormSobre.Close;
end;

end.

