@echo off
pushd %~dp0

:: Registra a DLL com suporte a COM
regasm AtualizadorFirebird.dll

:: Verifica se houve erro
if %errorlevel% neq 0 (
    echo Erro ao registrar a DLL.
    pause
) else (
    echo DLL registrada com sucesso.
    pause
)

popd
