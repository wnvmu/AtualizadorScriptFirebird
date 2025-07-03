using System;
using System.IO;
using System.Runtime.InteropServices;
using FirebirdSql.Data.FirebirdClient;

namespace AtualizadorFirebird
{
    [ComVisible(true)]
    [Guid("ABDEBE0E-EC9E-474F-BEF9-84338BB0A69F")]
    [ProgId("AtualizadorFirebird.Atualizador")]
    [ClassInterface(ClassInterfaceType.AutoDual)]
    public class Atualizador
    {
        private string _connectionString;

        public Atualizador()
        {
            // Construtor sem parâmetros obrigatório para COM
        }

        public void Conectar(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void AtualizarBanco()
        {
            if (string.IsNullOrWhiteSpace(_connectionString))
                throw new InvalidOperationException("A conexão não foi definida. Chame o método Conectar.");

            if (!Directory.Exists("Scripts"))
                throw new DirectoryNotFoundException("Pasta 'Scripts' não encontrada.");

            using (var conn = new FbConnection(_connectionString))
            {
                conn.Open();

                foreach (var caminhoCompleto in Directory.GetFiles("Scripts", "*.sql"))
                {
                    var nomeScript = Path.GetFileName(caminhoCompleto);
                    var dataModificacao = File.GetLastWriteTime(caminhoCompleto);

                    if (ScriptJaExecutado(conn, nomeScript, dataModificacao))
                        continue;

                    string conteudo = File.ReadAllText(caminhoCompleto);
                    ExecutarScript(conn, conteudo);

                    RegistrarScript(conn, nomeScript);
                }
            }
        }

        private void ExecutarScript(FbConnection conn, string conteudo)
        {
            var comandos = conteudo.Split(new[] { "-- FIM --" }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var comando in comandos)
            {
                var sql = comando.Trim();
                if (!string.IsNullOrWhiteSpace(sql))
                {
                    using (var cmd = new FbCommand(sql, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        private bool ScriptJaExecutado(FbConnection conn, string descricao, DateTime dataArquivo)
        {
            using (var cmd = new FbCommand(@"
                SELECT COUNT(*) 
                FROM TABSCRIPTS 
                WHERE DESCRICAO = @descricao 
                AND DATAEXECUCAO >= @dataArquivo", conn))
            {
                cmd.Parameters.AddWithValue("descricao", descricao);
                cmd.Parameters.AddWithValue("dataArquivo", dataArquivo);
                var count = Convert.ToInt32(cmd.ExecuteScalar());
                return count > 0;
            }
        }

        private void RegistrarScript(FbConnection conn, string descricao)
        {
            using (var cmd = new FbCommand(@"
                INSERT INTO TABSCRIPTS (DESCRICAO, DATAEXECUCAO) 
                VALUES (@descricao, CURRENT_TIMESTAMP)", conn))
            {
                cmd.Parameters.AddWithValue("descricao", descricao);
                cmd.ExecuteNonQuery();
            }
        }
    }
}
