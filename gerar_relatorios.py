import os
import mysql.connector
import pandas as pd
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib import colors

# Garantir que a pasta de exportação exista
os.makedirs('exports', exist_ok=True)

# Conectar ao banco de dados MySQL do Docker
print("🔄 Conectando ao MySQL do Docker...")
conexao = mysql.connector.connect(
    host="127.0.0.1",
    port=3307,
    user="root",
    password="super_secreta",
    database="ecommerce_db"
)

# Ler as consultas analíticas usando o Pandas
print("📊 Extraindo dados das consultas...")
query_estados = """
    SELECT
        customer_state AS estado,
        COUNT(customer_id) AS total_clientes,
        ROUND((COUNT(customer_id) / 99441) * 100, 2) AS porcentagem_total
    FROM
        olist_clientes   
    GROUP BY
        customer_state
    ORDER BY
        total_clientes DESC;
"""

df_estados = pd.read_sql(query_estados, conexao)

# EXPORTAÇÃO 1: Gerando o arquivo CSV
print("💾 Salvando arquivo CSV...")
df_estados.to_csv('exports/distribuicao_estados.csv', index=False)

# EXPORTAÇÃO 2: Gerando a planilha Avançada do Excel (.xlsx) com abas
print("🟢 Gerando planilha multi-abas do Excel (.xlsx)...")
with pd.ExcelWriter('exports/relatorio_ecommerce.xlsx', engine='openpyxl') as writer:
    df_estados.to_excel(writer, sheet_name='Clientes por Estado', index=False)
    # Aqui pode adicionar outras queries em abas separadas aqui

# EXPORTAÇÃO 3: Gerando um relatório Executivo em PDF
print("📄 Gerando relatório executivo em PDF formatado...")
pdf_path = "exports/relatorio_executivo.pdf"
doc = SimpleDocTemplate(pdf_path, pagesize=letter, rightMargin=30, leftMargin=30, topMargin=30, bottomMargin=30)
story = []
styles = getSampleStyleSheet()

# Estilização do PDF (Padrão corporativo)
title_style = ParagraphStyle('Title', parent=styles['Heading1'], fontSize=18, spaceAfter=15, textColor=colors.HexColor('#1A365D'))
story.append(Paragraph("🛒 Relatório Executivo de E-Commerce", title_style))
story.append(Paragraph("Gerado automaticamente via automação Python conectada ao banco MySQL.", styles['BodyText']))
story.append(Spacer(1, 15))

# Montar tabela para o PDF com o Top 5 estados do Pandas
dados_tabela = [["Estado", "Total de Clientes", "Participação %"]]
for _, row in df_estados.head(5).iterrows():
    dados_tabela.append([str(row['estado']), str(row['total_clientes']), f"{row['porcentagem_total']}%"])

tabela_pdf = Table(dados_tabela, colWidths=[100, 120, 100])
tabela_pdf.setStyle(TableStyle([
    ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#2B6CB0')),
    ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
    ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
    ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
    ('FONTSIZE', (0, 0), (-1, 0), 12),
    ('GRID', (0, 0), (-1, -1), 1, colors.black),
    ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#F7FAFC')])
]))
story.append(tabela_pdf)

# Finalizar e fechar o PDF e a conexão
doc.build(story)
conexao.close()

print("✨ Todos os relatórios (.csv, .xlsx, .pdf) foram gerados com sucesso na pasta exports/!")
