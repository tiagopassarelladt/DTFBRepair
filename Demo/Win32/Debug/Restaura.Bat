cd\
CD D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -v -full C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -mend C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -mode read_only C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -m -i C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -shut -force 0 C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -rollback all C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gbak.exe -g -b -z -l -ignore C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey  C:\SUPERSYS10\Dados\BancoBack.fbk -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gbak.exe -g -c -z -v C:\SUPERSYS10\Dados\BancoBack.fbk C:\SUPERSYS10\Dados\BASERESTAURADA.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -online C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
START /WAIT D:\Dropbox\Componentes\DTFBRepair\Demo\Win32\Debug\gfix.exe -mode read_write C:\SUPERSYS10\Dados\LOG.FDB -USER SYSDBA -PASS masterkey 
timeout /t 3
