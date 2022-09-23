unit DTFBRepair;

interface

uses
  System.SysUtils, System.Classes,Winapi.Windows,system.StrUtils,Winapi.ShellAPI, Vcl.Forms;

type
  TStatus = procedure(Msg:string) of object;

type
  TDTFBRepair = class(TComponent)
  private
    FCaminhoDataBase: string;
    FPathBaseRestaurada: string;
    FVendorLib: string;
    FPassword: string;
    FUser: string;
    FOnMigrate: TStatus;
    procedure SetCaminhoDataBase(const Value: string);
    function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
    procedure SetVendorLib(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUser(const Value: string);
    procedure SetOnMigrate(const Value: TStatus);
  protected

  public
    procedure Reparar;
  published
    property OnRepair           : TStatus read FOnMigrate       write SetOnMigrate;
    property CaminhoDataBase    : string  read FCaminhoDataBase write SetCaminhoDataBase;
    property User               : string  read FUser            write SetUser;
    property Password           : string  read FPassword        write SetPassword;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('DT Inovacao', [TDTFBRepair]);
end;

{ TDTFBRepair }

procedure TDTFBRepair.Reparar;
var
   arq                          : TextFile;
   Direct                       : string;
   NomeBase,localBat            : string;
   ExitCode                     : DWORD;
   I                            : integer;
   BaseRestaurada               : string;
   BaseAnterior                 : string;
   xBancoRest                   : string;
   PathAPP                      : string;
begin
   if FCaminhoDataBase = '' then
   begin
       raise Exception.Create('� necess�rio informar uma base de dados');
       Abort;
   end;

   OnRepair( timetostr(now) + ' Iniciando Restaura��o da base de dados' );
   if FCaminhoDataBase <> '' then
   begin
      PathAPP             := ExtractFilePath( Application.ExeName );
      Direct              := ExtractFilePath(FCaminhoDataBase);
      NomeBase            := ExtractFileName(FCaminhoDataBase) ;
      BaseRestaurada      := 'BASERESTAURADA.FDB';
      BaseAnterior        := 'OLD' + NomeBase;
      FPathBaseRestaurada := Direct;
      AssignFile(arq, PathAPP + 'Restaura.Bat');
      Rewrite(arq);
      Writeln(arq, 'cd\');
      Writeln(arq, 'CD ' + PathAPP);
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -v -full '                   + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -mend '                      + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -mode read_only '            + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -m -i '                      + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -shut -force 0 '             + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -rollback all '              + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gbak.exe -g -b -z -l -ignore '        + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + '  ' + FPathBaseRestaurada + 'BancoBack.fbk -USER ' + FUser + ' -PASS ' + FPassword + ' ');
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gbak.exe -g -c -z -v '                + FPathBaseRestaurada + 'BancoBack.fbk '  +  Direct   + BaseRestaurada   + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ');
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -online '                    + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'START /WAIT ' + PathAPP  + 'gfix.exe -mode read_write '           + FCaminhoDataBase    + ' -USER ' + FUser + ' -PASS ' + FPassword + ' ' );
      Writeln(arq, 'timeout /t 3');
      CloseFile(arq);
      xBancoRest := FPathBaseRestaurada + BaseRestaurada;
      OnRepair( timetostr(now) + ' Iniciando execu��o dos procedimentos de restaura��o ' );
      if FileExists(PathAPP + 'Restaura.Bat') then
      begin
           I := ShellExecuteAndWait('open', PathAPP + 'Restaura.Bat', '', PathAPP, 0, True);

           if I = 0 then
           begin
             OnRepair( timetostr(now) + ' Base restaurada com sucesso em: ' + xBancoRest );
           end else begin
             OnRepair( timetostr(now) + ' Base n�o pode ser restaurada ' );
           end;
      end;
   end;
end;

procedure TDTFBRepair.SetCaminhoDataBase(const Value: string);
begin
  FCaminhoDataBase := Value;
end;

procedure TDTFBRepair.SetOnMigrate(const Value: TStatus);
begin
  FOnMigrate := Value;
end;

procedure TDTFBRepair.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TDTFBRepair.SetUser(const Value: string);
begin
  FUser := Value;
end;

procedure TDTFBRepair.SetVendorLib(const Value: string);
begin
  FVendorLib := Value;
end;

function TDTFBRepair.ShellExecuteAndWait(Operation, FileName, Parameter,
  Directory: String; Show: Word; bWait: Boolean): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
begin
  FillChar(Info, SizeOf(Info), Chr(0));
  Info.cbSize := SizeOf(Info);
  Info.fMask := SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb := PChar(Operation);
  Info.lpFile := PChar(FileName);
  Info.lpParameters := PChar(Parameter);
  Info.lpDirectory := PChar(Directory);
  Info.nShow := Show;
  bOK := Boolean(ShellExecuteEx(@Info));
  if bOK then
  begin
    if bWait then
    begin
      while WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT do
        Application.ProcessMessages;
      bOK := GetExitCodeProcess(Info.hProcess, DWORD(Result));
    end else
      Result := 0;
  end;
  if not bOK then

end;

end.
