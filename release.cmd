@cargo build --release
@if exist ..\bin\null copy target\release\*.exe ..\bin
@pause