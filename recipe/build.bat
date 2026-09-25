@echo on
@setlocal EnableDelayedExpansion

go build -o="%LIBRARY_BIN%\%PKG_NAME%.exe" -ldflags="-s -X main.version=%PKG_VERSION%" || goto :error
go-licenses save . --save_path=license-files --ignore github.com/mattn/go-localereader --ignore filippo.io/nistec || goto :error

:: Manually copy licenses that go-licenses could not download
xcopy /s %RECIPE_DIR%\license-files\* %SRC_DIR%\license-files || goto :error

goto :eof

:error
echo Failed with error #%errorlevel%.
exit 1
