import mysql.connector
import pandas as pd
import os


def conectar_banco():
    """Estabelece a conexão com o banco de dados MySQL rodando no Docker""" 
    try:
        conexao = mysql.connector.connect(
            host="127.0.0.1",
            port=3307,   # A porta externa do configuração do Docker
            user="root",
            password="super_secreta",
            database="ecommerce_db"
        )
        return conexao
    except mysql.connector.Error as erro:
        print(f"❌ Erro ao conectar ao MySQL: {erro}")
        return None
    

def segmentar_publico_campanha(estado_alvo):
    """Extrai os clientes do banco e segmenta para uma campanha de marketing""" 
    print(f"🔍 Iniciando extração e segmentação para o estado: {estado_alvo}...")

    conexao = conectar_banco()
    if conexao is None:
        return  
    
    # Query SQL para buscar clientes do estado selecionado
    query_sql = """
        SELECT customer_id, customer_city, customer_state
        FROM olist_clientes
        WHERE customer_state =%s;
    """

    try:
        # Usando o Pandas para ler a query SQL diretamente do banco
        df_clientes = pd.read_sql(query_sql, conexao, params=(estado_alvo,))

        total_segmentado = len(df_clientes)
        print(f"✅ {total_segmentado} clientes encontrados em {estado_alvo}!")

        if total_segmentado > 0:
            # Criando a pasta para salvar os resultados, se não existir
            os.makedirs("outputs", exist_ok=True)

            # Savando o público segmentado em um arquivo CSV para o time de marketing
            caminho_arquivo = f"outputs/campanha_marketing_{estado_alvo}.csv"
            df_clientes.to_csv(caminho_arquivo, index=False)

            print(f"📦 Arquivo de campanha gerado com sucesso em: {caminho_arquivo}")
        else:
            print(f"⚠️ Nenhum registro encontrado para este estado.")

    except Exception as erro:
        print(f"❌ Erro durante o processamento: {erro}")
    
    finally:
        conexao.close()
        print("🔒 Conexão com o banco de dados encerrada.")

if __name__ == "__main__":
    # Vamos segmentar o maior mercado mapeado na sua análise anterior (SP)
    segmentar_publico_campanha("SP")
