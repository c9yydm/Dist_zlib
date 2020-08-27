@echo off
rem --------------------------------------------------------------------
rem A script to generate NMake command line and execute it 
rem Usage build.cmd <platform> <configuration>
rem        platform: either 'amd64' or 'X64' or 'x86'
rem        configuration: either 'debug' or 'release'
rem --------------------------------------------------------------------

IF "%1"=="x86" (
  SET NMake_options=OBJA="inffas32.obj match686.obj"
) ELSE (
IF "%1"=="X64" (
  SET NMake_options=AS=ml64 OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
) ELSE (
IF "%1"=="amd64" (
  SET NMake_options=AS=ml64 OBJA="inffasx64.obj gvmat64.obj inffas8664.obj"
) ELSE (
  echo Platform "%1" was not recognized
  exit -1 
)
)
)

IF "%2"=="release" (
  SET CFLAGS=-nologo -W3 -Oy- -Zi -Fd"zlib" -MD -I. -O2
  SET NMake_options=%NMake_options% LOC="-DASMV -DASMINF"
) ELSE (
IF "%2"=="debug" (
  SET CFLAGS=-nologo -W3 -Oy- -Zi -Fd"zlib"  -MDd -I. -Od
  SET NMake_options=%NMake_options% LOC="-DASMV -DASMINF"
) ELSE (
  echo Configuration "%2" was not recognized
  exit -1 
)
)

echo NMake_options: ^<%NMake_options%^>

@echo on
cd zlib
nmake -e -f win32\Makefile.msc %NMake_options%
cd ..

