unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DTFBRepair;

type
  TForm5 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Button2: TButton;
    Memo1: TMemo;
    DTFBRepair1: TDTFBRepair;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure DTFBRepair1Repair(Msg: string);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin
        Memo1.Lines.Clear;
        DTFBRepair1.CaminhoDataBase := Edit1.Text;
        DTFBRepair1.user            := 'SYSDBA';
        DTFBRepair1.PASSWORD        := 'masterkey';

        DTFBRepair1.Reparar;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
      if OpenDialog1.Execute then
         Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm5.DTFBRepair1Repair(Msg: string);
begin
     Memo1.Lines.Add( msg );
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
