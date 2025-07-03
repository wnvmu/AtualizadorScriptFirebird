# 📚 Integração com a DLL AtualizadorFirebird

A `AtualizadorFirebird.dll` permite integração via COM com linguagens como Delphi, VB6, e C#.

---

## ✅ Informações Gerais

- **Nome da DLL**: `AtualizadorFirebird.dll`
- **Namespace**: `AtualizadorFirebird`
- **Classe Pública**: `Atualizador`
- **Framework**: .NET Framework 4.8
- **Banco de Dados**: Firebird (recomendado 3.0)
- **Tabela de controle**: `TABSCRIPTS`
- **Separador de comandos SQL**: `-- FIM --`

---

## 🧩 Interface Pública

- `Atualizador(string connectionString)`
  - Construtor com a string de conexão do Firebird.
- `void AtualizarBanco()`
  - Executa os scripts da pasta `Scripts` (um por um, separados por `-- FIM --`).
  - Verifica na tabela `TABSCRIPTS` se o script já foi executado com base na data e nome.

---

## 🔄 Registro da DLL

Abra o prompt de comando como administrador e execute:

```bat
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
```

---

## 🧾 Tabela TABSCRIPTS

```sql
CREATE GENERATOR GEN_TABSCRIPTS_ID;

CREATE TABLE TABSCRIPTS (
    ID            INTEGER NOT NULL,
    DATAEXECUCAO  TIMESTAMP NOT NULL,
    DESCRICAO     VARCHAR(255) NOT NULL
);

CREATE OR ALTER TRIGGER TABSCRIPTS_BI FOR TABSCRIPTS
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(GEN_TABSCRIPTS_ID, 1);
END;
```

---

## ✅ Teste com Delphi

```pascal
uses ComObj;

procedure Atualizar;
var
  Atualizador: Variant;
begin
  Atualizador := CreateOleObject('AtualizadorFirebird.Atualizador');
  Atualizador.Conectar('User=SYSDBA;Password=masterkey;Database=127.0.0.1:C:\DB\meubanco.fdb;');
  Atualizador.AtualizarBanco;
end;
```

---

## ⚠️ Observações

- Scripts duplicados (com mesma descrição e data anterior) não serão executados.
- Scripts devem usar `-- FIM --` como separador de comandos.
- Exemplo de batch para gerar scripts:

```bat
@echo off
set /p nome=Digite a descrição:
set hora=%TIME::=%
set data=%DATE:/=%
set filename=%data%%hora%_%nome:.=_%.sql
set filename=%filename: =_%
cd Scripts
echo -- novo script > %filename%
```

---

## 📄 Logs

Os scripts aplicados são registrados na tabela `TABSCRIPTS`.

---

## 👨‍💻 Contato

Para dúvidas sobre integração, utilize os exemplos na pasta `Exemplos\Delphi`.
