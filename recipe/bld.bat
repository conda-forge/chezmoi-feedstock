go build -buildmode=pie -trimpath -o="%LIBRARY_BIN%\%PKG_NAME%.exe" -ldflags="-s -X main.version=%PKG_VERSION%" || goto :error
go-licenses save --ignore github.com/mattn/go-localereader --save_path=license-files . || goto :error

goto :EOF

:error
echo Failed with error #%errorlevel%.
exit 1
