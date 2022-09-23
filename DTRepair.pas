unit DTRepair;

interface

uses
  System.SysUtils, System.Classes;

type
  TDTFBRepair = class(TComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DT Inovacao', [TDTFBRepair]);
end;

end.
