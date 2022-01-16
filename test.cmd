@echo off
cargo build --release
set prg=.\target\release\addproperties.exe
echo key1.1=val1> ori.properties
echo key1.2=val2>> ori.properties
echo key1.3=val3>> ori.properties
echo key2.1=val1>> ori.properties
echo key2.2=val2>> ori.properties
echo key2.3=val3>> ori.properties
echo original:
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
echo Expected: add key2.4
%prg%  /fic:ori.properties /key:"key2.4" /value:val4 
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: maj key1.1
%prg%  /fic:ori.properties /key:"key1.1" /value:val5 
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: maj key2.1
%prg%  /fic:ori.properties /key:"key2.1" /value:val6 
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: add key5.1
%prg%  /fic:ori.properties /key:"key5.1" /value:val7
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected:  value of key2.2 maj  and key stay key2.2
%prg%  /fic:ori.properties /key:"KEY2.2" /value:val8
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: key2.2 updated
%prg%  /fic:ori.properties /key:"key2.2" /value:val9 
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: key2.2 updated
%prg%  /fic:ori.properties /key:"KeY2.2" /value:val10
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: key2.2 updated
%prg%  /fic:ori.properties /key:"KeY2.2" /value:val10
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
echo .
echo .
echo Expected: key2.2 commented
%prg%  /fic:ori.properties /key:"KeY2.2"
echo -------------------------------------------
type ori.properties
echo -------------------------------------------
pause
