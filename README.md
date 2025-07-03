# 🔥 AtualizadorFirebird

Uma DLL .NET para atualização automatizada de banco de dados Firebird via scripts SQL com controle de execução. Suporta integração com sistemas Delphi, C# e outros via COM.

## 📦 Estrutura do Projeto

```
Atualizador Firebird
├── Projeto/
│   ├── AtualizadorFirebird.dll
│   ├── AtualizadorFirebird.pdb
│   ├── AtualizadorFirebird.tlb
│   ├── CriarScript.bat
│   ├── RegAsm.exe
│   ├── registrarDLL.bat
│   ├── EXEMPLO.FDB
├── Exemplos/
│   └── Delphi/
│       ├── Bin/
│       │   ├── AtualizadorFirebird.dll
│       │   ├── FirebirdSql.Data.FirebirdClient.dll
│       │   ├── registrar_DLL.bat
│       │   ├── Exemplo.exe
│       │   ├── Scripts/
│       │   │   ├── <data>_<descricao>.sql
│       ├── Exemplo.dpr
│       ├── UntExemplo.pas
```

## ⚙️ Requisitos

- .NET Framework 4.8
- Firebird Client instalado
- Delphi (para integração com exemplo)
- Scripts `.sql` com separador `-- FIM --`
- Tabela de controle `TABSCRIPTS`

## 🛠 Instalação

### Registre a DLL via linha de comando:

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

> ⚠️ Requer permissões de administrador

---

## 🧪 Exemplo de uso

### Delphi

```pascal
uses ComObj;

procedure TForm1.Button1Click(Sender: TObject);
var
  Atualizador: Variant;
begin
  Atualizador := CreateOleObject('AtualizadorFirebird.Atualizador');
  Atualizador.Conectar('User=SYSDBA;Password=masterkey;Database=127.0.0.1:/caminho/banco.fdb;');
  Atualizador.AtualizarBanco;
end;
```

---

## 📋 Scripts de exemplo

```sql
INSERT INTO TABTESTE (ID, NOME, TELEFONE) VALUES (1, 'João da Silva', '(28) 99999-1111');
-- FIM --
CREATE OR ALTER PROCEDURE INSERE_TESTE (...) AS BEGIN ... END;
-- FIM --
```

---

## 📁 Scripts

Os scripts devem estar na pasta `Scripts` com nome padrão:
```
DDMMYYYYHHMMSS_Descricao.sql
```
E conter comandos separados por:
```
-- FIM --
```

---

## 🧩 Tabela de Controle

```sql
CREATE TABLE TABSCRIPTS (
  ID           INTEGER NOT NULL,
  DATAEXECUCAO TIMESTAMP NOT NULL,
  DESCRICAO    VARCHAR(255) NOT NULL
);
```

---

## 📞 Suporte

Para dúvidas ou melhorias, entre em contato com o desenvolvedor responsável.

**Wellington N. Verzola**  
📞 Telefone/Whatsapp: +55 28 999126625  
✉️ E-mail: wellingtonnunesverzola@gmail.com  
🌐 GitHub: [github.com/wellingtonverzola](https://github.com/wellingtonverzola)
