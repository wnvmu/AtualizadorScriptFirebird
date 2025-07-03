@echo off
setlocal EnableDelayedExpansion

:: Obtem data (formato DD MM AAAA)
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set dia=0%%a
    set mes=0%%b
    set ano=%%c
)

set dia=!dia:~-2!
set mes=!mes:~-2!
set ano=!ano!

:: Obtem hora, minuto e segundo
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set hora=0%%a
    set minuto=0%%b
    set segundo=0%%c
)

set hora=!hora:~-2!
set minuto=!minuto:~-2!
set segundo=!segundo:~-2!

:: Solicita a descrição
set /p DESCRICAO=Digite a descrição do script: 

:: Substitui espaços por underlines
set "DESCRICAO=%DESCRICAO: =_%"

:: Cria nome do arquivo no formato: DDMMYYYYHHMMSS_DESCRICAO.sql
set NOME_ARQUIVO=%dia%%mes%%ano%%hora%%minuto%%segundo%_%DESCRICAO%.sql

:: Cria pasta Scripts se não existir
if not exist Scripts (
    mkdir Scripts
)

:: Cria o arquivo e abre no bloco de notas
echo -- Script gerado em %date% às %time% > Scripts\%NOME_ARQUIVO%
start notepad Scripts\%NOME_ARQUIVO%

echo Arquivo criado: Scripts\%NOME_ARQUIVO%
pause
