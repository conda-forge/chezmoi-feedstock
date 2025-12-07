@echo on
@setlocal EnableDelayedExpansion

go build -o="%LIBRARY_BIN%\%PKG_NAME%.exe" -ldflags="-s -X main.version=%PKG_VERSION%" || goto :error
go-licenses save . --save_path=license-files --ignore github.com/mattn/go-localereader || goto :error

goto :eof

:error
echo Failed with error #%errorlevel%.
exit 1
